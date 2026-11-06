import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../models/saved_message.dart';
import 'message_database.dart';
import 'message_processor.dart';

class MessagesStore extends ChangeNotifier {
  MessagesStore._();
  static final MessagesStore instance = MessagesStore._();

  static const EventChannel _events = EventChannel('native_events');
  static const List<SavedMessage> _none = <SavedMessage>[];

  /// Sab messages, naya pehle
  List<SavedMessage> messages = [];

  // FIX (performance): reload par ek hi baar index banta hai. Pehle forSender()
  // aur chatSummariesFor() har call par poori list scan karte the, aur har chat
  // row ke liye call hote the (messages hazaron hon to scroll atakta tha).
  Map<String, List<SavedMessage>> _byChat = {}; // 'app|sender' -> naya pehle
  Map<String, List<SavedMessage>> _summaries = {}; // app -> har sender ka naya message

  final MessageProcessor _processor = MessageProcessor();
  StreamSubscription<dynamic>? _subscription;
  bool _started = false;

  Future<void>? _inflight;
  bool _reloadAgain = false;

  Future<void> start() async {
    if (_started) return;
    _started = true;
    await reload();
    _subscription = _events.receiveBroadcastStream().listen(
      _onNativeEvent,
      onError: (Object e) {
        if (kDebugMode) debugPrint('MessagesStore stream error: $e');
      },
    );
  }

  /// FIX: tez raftaar events par kai reload ek saath nahi chalte. Chalta hua reload
  /// khatam hone ke baad sirf ek aur reload hota hai. Jo bhi await kare, use poora
  /// nateeja milne par hi jawab milta hai.
  Future<void> reload() {
    final Future<void>? running = _inflight;
    if (running != null) {
      _reloadAgain = true;
      return running;
    }
    final Future<void> run = _reloadLoop().whenComplete(() => _inflight = null);
    _inflight = run;
    return run;
  }

  Future<void> _reloadLoop() async {
    do {
      _reloadAgain = false;
      try {
        messages = await MessageDatabase.instance.getAll();
        _rebuildIndex();
        notifyListeners();
      } catch (e) {
        // DB masla kare to purani list dikhti rahe, app crash na ho
        if (kDebugMode) debugPrint('MessagesStore.reload: $e');
      }
    } while (_reloadAgain);
  }

  void _rebuildIndex() {
    final Map<String, List<SavedMessage>> byChat = {};
    final Map<String, Map<String, SavedMessage>> latest = {};

    for (final SavedMessage m in messages) {
      (byChat['${m.app}|${m.sender}'] ??= <SavedMessage>[]).add(m);
      (latest[m.app] ??= <String, SavedMessage>{}).putIfAbsent(m.sender, () => m);
    }

    _byChat = byChat;
    _summaries = {
      for (final MapEntry<String, Map<String, SavedMessage>> e in latest.entries)
        e.key: List<SavedMessage>.unmodifiable(e.value.values),
    };
  }

  // Errors yahan se UI tak jate hain, taake UI user ko snackbar dikha sake
  Future<void> deleteMessages(List<SavedMessage> items) async {
    await MessageDatabase.instance.deleteMessages(items);
    await reload();
  }

  Future<void> clearAll() async {
    await MessageDatabase.instance.clearAll();
    await reload();
  }

  Future<void> _onNativeEvent(dynamic raw) async {
    try {
      if (raw is! Map) return;
      final String type = raw['type'] as String? ?? '';
      final String app = (raw['app'] as String? ?? 'WhatsApp').trim();
      final String sender = (raw['sender'] as String? ?? '').trim();
      if (sender.isEmpty) return;

      if (type == 'removed') {
        final int reason = (raw['reason'] as int?) ?? 0;
        final bool idle = (raw['idle'] as bool?) ?? false;
        final bool appVisible =
            WidgetsBinding.instance.lifecycleState == AppLifecycleState.resumed;
        await _processor.onRemoved(app, sender, reason, idle, appVisible);
        await reload();
        return;
      }

      final String text = (raw['text'] as String? ?? '').trim();
      final List<dynamic> rawItems = raw['messages'] as List<dynamic>? ?? [];
      final List<Map<dynamic, dynamic>> items =
          rawItems.whereType<Map<dynamic, dynamic>>().toList();

      await _processor.handlePosted(app, sender, text, items);
      await reload();
    } catch (e) {
      // FIX: ek kharab event poori stream ko ya app ko nahi girata
      if (kDebugMode) debugPrint('MessagesStore._onNativeEvent: $e');
    }
  }

  /// Ek chat ke saare messages, naya pehle (list ko badalna nahi)
  List<SavedMessage> forSender(String app, String sender) =>
      _byChat['$app|$sender'] ?? _none;

  /// Ek app ke andar har sender ka sab se naya message (list ko badalna nahi)
  List<SavedMessage> chatSummariesFor(String app) => _summaries[app] ?? _none;

  @override
  void dispose() {
    _subscription?.cancel();
    _subscription = null;
    _processor.dispose();
    super.dispose();
  }
}