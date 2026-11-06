import 'dart:async';

import '../models/saved_message.dart';
import 'message_database.dart';

class MessageProcessor {
  static const String deletedText = 'This message was deleted';

  // "Pehle kaunse messages the" ab DB mein hai (known_state table), yahan nahi.
  // Neeche ke teen maps sirf kuch second ki timing ke liye hain, unhe save
  // karne ki zaroorat nahi.
  final Map<String, DateTime> _lastPostAt = {};
  final Map<String, DateTime> _lastShrinkAt = {};
  final Map<String, Timer> _pendingNotice = {};

  // Events ek ek karke chalte hain, taake DB ki state par race na ho
  Future<void> _queue = Future<void>.value();

  Future<void> _serial(Future<void> Function() task) {
    final Future<void> run = _queue.then((_) => task());
    _queue = run.catchError((Object _) {});
    return run;
  }

  String _k(String app, String sender) => '$app|$sender';

  Future<void> handlePosted(
    String app,
    String sender,
    String text,
    List<Map<dynamic, dynamic>> items,
  ) => _serial(() => _handlePosted(app, sender, text, items));

  Future<void> onRemoved(
    String app,
    String sender,
    int reason,
    bool idle,
    bool appVisible,
  ) => _serial(() => _onRemoved(app, sender, reason, idle, appVisible));

  Future<void> _handlePosted(
    String app,
    String sender,
    String text,
    List<Map<dynamic, dynamic>> items,
  ) async {
    final String key = _k(app, sender);

    if (items.isEmpty) {
      if (text == deletedText) _onNotice(app, sender);
      return;
    }

    _lastPostAt[key] = DateTime.now();
    _pendingNotice.remove(key)?.cancel();

    final List<String> oldKeys = await MessageDatabase.instance.getKnownKeys(
      app,
      sender,
    );
    final List<String> newKeys = [];
    bool addedNew = false;
    int realCount = 0;
    int noticeCount = 0;

    for (final item in items) {
      final String itemText = ((item['text'] as String?) ?? '').trim();
      final int time = (item['time'] as int?) ?? 0;
      if (itemText.isEmpty) continue;

      if (itemText == deletedText) {
        noticeCount++;
        await MessageDatabase.instance.markDeletedByTime(app, sender, time);
        continue;
      }

      realCount++;
      final String itemKey = '$time|$itemText';
      newKeys.add(itemKey);

      final bool alreadySaved =
          await MessageDatabase.instance.existsKey(app, sender, time, itemText);
      if (!alreadySaved) {
        addedNew = true;
        await MessageDatabase.instance.insert(
          SavedMessage(
            app: app,
            sender: sender,
            text: itemText,
            time: time,
            receivedAt: DateTime.now(),
          ),
        );
      }
    }

    if (realCount == 0 && noticeCount > 0) {
      await _markAllGone(app, sender);
      return;
    }

    if (!addedNew) {
      bool anyGone = false;
      for (final oldKey in oldKeys) {
        if (!newKeys.contains(oldKey)) {
          await _markItemKey(app, sender, oldKey);
          anyGone = true;
        }
      }
      if (anyGone) _lastShrinkAt[key] = DateTime.now();
    }

    await MessageDatabase.instance.setKnownKeys(app, sender, newKeys);
  }

  Future<void> _onRemoved(
    String app,
    String sender,
    int reason,
    bool idle,
    bool appVisible,
  ) async {
    final String key = _k(app, sender);
    final bool userAction = reason == 1 || reason == 2 || reason == 3;

    final DateTime? lastShrink = _lastShrinkAt[key];
    final bool afterDeletions = lastShrink != null &&
        DateTime.now().difference(lastShrink).inSeconds < 3;

    final bool maybeDeleted =
        !userAction && (idle || appVisible || afterDeletions);

    if (maybeDeleted) {
      _scheduleGone(app, sender);
    } else {
      _pendingNotice.remove(key)?.cancel();
      await MessageDatabase.instance.clearKnownKeys(app, sender);
    }
  }

  void _onNotice(String app, String sender) {
    final String key = _k(app, sender);
    final DateTime? lastPost = _lastPostAt[key];
    if (lastPost != null &&
        DateTime.now().difference(lastPost).inMilliseconds < 1500) {
      return;
    }
    _scheduleGone(app, sender);
  }

  void _scheduleGone(String app, String sender) {
    final String key = _k(app, sender);
    if (_pendingNotice.containsKey(key)) return;

    _pendingNotice[key] = Timer(const Duration(seconds: 2), () {
      _pendingNotice.remove(key);
      _serial(() => _markAllGone(app, sender));
    });
  }

  Future<void> _markAllGone(String app, String sender) async {
    final String key = _k(app, sender);
    final List<String> keys = await MessageDatabase.instance.getKnownKeys(
      app,
      sender,
    );
    if (keys.isEmpty) {
      await MessageDatabase.instance.markLatestUndeleted(app, sender);
    } else {
      for (final itemKey in keys) {
        await _markItemKey(app, sender, itemKey);
      }
    }
    await MessageDatabase.instance.clearKnownKeys(app, sender);
    _lastShrinkAt.remove(key);
  }

  Future<void> _markItemKey(String app, String sender, String itemKey) async {
    final int sep = itemKey.indexOf('|');
    if (sep == -1) return;
    final int? time = int.tryParse(itemKey.substring(0, sep));
    final String text = itemKey.substring(sep + 1);
    if (time == null) return;
    await MessageDatabase.instance.markDeletedExact(app, sender, time, text);
  }

  void dispose() {
    for (final Timer t in _pendingNotice.values) {
      t.cancel();
    }
  }
}