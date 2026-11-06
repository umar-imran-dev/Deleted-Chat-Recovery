import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../l10n/app_localizations.dart';
import '../models/saved_message.dart';
import '../services/avatar_service.dart';
import '../services/messages_store.dart';
import '../services/seen_chats_service.dart';
import '../theme/app_colors.dart';
import '../theme/theme_controller.dart';

// Ek row: ya message, ya tareekh ka chip
class _Entry {
  final SavedMessage? message;
  final DateTime? day;

  const _Entry.message(SavedMessage m) : message = m, day = null;
  const _Entry.header(DateTime d) : message = null, day = d;
}

class ChatDetailScreen extends StatefulWidget {
  final String app;
  final String sender;

  const ChatDetailScreen({super.key, required this.app, required this.sender});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  bool _selecting = false;
  final Set<String> _selected = {};

  // FIX: list upar se shuru hoti hai (pehla message upar), aur jab messages zyada
  // hon to is controller se sab se naye message par pohanchte hain.
  final ScrollController _scroll = ScrollController();

  int _lastCount = 0;

  // Rows ek hi dafa banti hain, jab tak messages ki list na badle
  List<SavedMessage>? _entriesSource;
  List<_Entry> _entriesCache = const [];

  @override
  void initState() {
    super.initState();
    MessagesStore.instance.addListener(_onStoreChanged);
    _lastCount =
        MessagesStore.instance.forSender(widget.app, widget.sender).length;
    // FIX: prefs fail hon to unhandled error nahi
    unawaited(
      SeenChatsService.instance
          .markSeen(widget.app, widget.sender)
          .catchError((Object _) {}),
    );
    // Chat khulte hi sab se naye message par
    _jumpToBottom();
  }

  @override
  void dispose() {
    MessagesStore.instance.removeListener(_onStoreChanged);
    _scroll.dispose();
    super.dispose();
  }

  // ---------------- SCROLL ----------------

  // User neeche ke qareeb hai? (naya message aane par hi neeche le jana hai)
  bool get _nearBottom {
    if (!_scroll.hasClients) return true;
    final ScrollPosition p = _scroll.position;
    return p.maxScrollExtent - p.pixels < 150;
  }

  // List ki lambai andaze se nikalti hai, is liye kuch frames tak dobara jump karte hain
  void _jumpToBottom([int pass = 0]) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scroll.hasClients) return;
      final double target = _scroll.position.maxScrollExtent;
      _scroll.jumpTo(target);
      if (pass < 3) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted || !_scroll.hasClients) return;
          if (_scroll.position.maxScrollExtent != target) {
            _jumpToBottom(pass + 1);
          }
        });
      }
    });
  }

  void _animateToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scroll.hasClients) return;
      _scroll.animateTo(
        _scroll.position.maxScrollExtent,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
      );
    });
  }

  void _onStoreChanged() {
    if (!mounted) return;
    // rebuild se PEHLE dekho ke user neeche tha ya nahi
    final bool stick = _nearBottom;
    setState(() {});

    final int count =
        MessagesStore.instance.forSender(widget.app, widget.sender).length;
    if (count > _lastCount && stick && !_selecting) _animateToBottom();
    _lastCount = count;
  }

  // ---------------- SELECTION ----------------
  void _startSelecting([String? key]) {
    setState(() {
      _selecting = true;
      if (key != null) _selected.add(key);
    });
  }

  void _exitSelection() {
    setState(() {
      _selecting = false;
      _selected.clear();
    });
  }

  void _toggle(String key) {
    setState(() {
      if (_selected.contains(key)) {
        _selected.remove(key);
      } else {
        _selected.add(key);
      }
    });
  }

  void _toggleSelectAll(List<SavedMessage> messages) {
    setState(() {
      final bool all = messages.every((m) => _selected.contains(m.key));
      _selected.clear();
      if (!all) {
        _selected.addAll(messages.map((m) => m.key));
      }
    });
  }

  Future<void> _deleteSelected(List<SavedMessage> messages) async {
    final List<SavedMessage> toDelete =
        messages.where((m) => _selected.contains(m.key)).toList();
    if (toDelete.isEmpty) return;

    final AppColors c = AppColors.current;
    // await se pehle le lo, taake context ka masla na ho
    final AppLocalizations t = AppLocalizations.of(context)!;
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: c.dialog,
        title: Text(t.deleteMessagesTitle, style: TextStyle(color: c.heading)),
        content: Text(
          t.deleteMessagesText,
          style: TextStyle(color: c.body),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(t.cancel, style: TextStyle(color: c.grey(600))),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(t.delete, style: TextStyle(color: Colors.red.shade600)),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    // delete fail ho to error dikhao, screen atki na rahe
    try {
      await MessagesStore.instance.deleteMessages(toDelete);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t.couldNotClearData(e.toString()))),
        );
      }
      return;
    }
    if (!mounted) return;

    setState(() {
      _selecting = false;
      _selected.clear();
    });

    // Chat ke saare messages chale gaye to wapas chat list par chalo
    final bool empty =
        MessagesStore.instance.forSender(widget.app, widget.sender).isEmpty;
    if (empty) Navigator.of(context).pop();
  }

  // ---------------- APP BARS ----------------

  Widget _buildAppBarAvatar() {
    final AppColors c = AppColors.current;
    final Widget fallback = CircleAvatar(
      radius: 14,
      backgroundColor: c.avatarBgStrong,
      child: Text(
        widget.sender.isNotEmpty ? widget.sender[0].toUpperCase() : '?',
        style: TextStyle(fontSize: 11, color: c.title),
      ),
    );

    return FutureBuilder<String?>(
      initialData: AvatarService.instance.cachedPathSync(
        widget.app,
        widget.sender,
      ),
      future: AvatarService.instance.pathFor(widget.app, widget.sender),
      builder: (context, snapshot) {
        final String? path = snapshot.data;
        if (path == null) return fallback;
        return ClipOval(
          child: Image(
            image: ResizeImage(FileImage(File(path)), width: 64, height: 64),
            width: 28,
            height: 28,
            fit: BoxFit.cover,
            gaplessPlayback: true,
            errorBuilder: (context, error, stackTrace) => fallback,
          ),
        );
      },
    );
  }

  AppBar _normalAppBar() {
    final AppColors c = AppColors.current;
    final AppLocalizations t = AppLocalizations.of(context)!;
    return AppBar(
      titleSpacing: 0,
      backgroundColor: c.appBar,
      foregroundColor: c.title,
      scrolledUnderElevation: 0,
      systemOverlayStyle:
          c.isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      title: Row(
        children: [
          _buildAppBarAvatar(),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              widget.sender,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 17, color: c.title),
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          tooltip: t.selectTooltip,
          icon: Icon(Icons.check_box_outlined, color: c.title),
          onPressed: () => _startSelecting(),
        ),
      ],
    );
  }

  AppBar _selectionAppBar(List<SavedMessage> messages, bool allSelected) {
    final AppColors c = AppColors.current;
    final AppLocalizations t = AppLocalizations.of(context)!;
    return AppBar(
      backgroundColor: c.appBar,
      foregroundColor: c.title,
      scrolledUnderElevation: 0,
      systemOverlayStyle:
          c.isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      leading: IconButton(
        icon: Icon(Icons.close, color: c.title),
        onPressed: _exitSelection,
      ),
      title: Text(
        t.selectedCount(_selected.length),
        style: TextStyle(fontSize: 17, color: c.title),
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: c.isDark ? c.green(700) : null,
          ),
          onPressed: () => _toggleSelectAll(messages),
          child: Text(allSelected ? t.clearSelection : t.selectAll),
        ),
      ],
    );
  }

  Widget _deleteBar(List<SavedMessage> messages) {
    final AppColors c = AppColors.current;
    final AppLocalizations t = AppLocalizations.of(context)!;
    final int count = _selected.length;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: SizedBox(
          height: 48,
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: count == 0 ? null : () => _deleteSelected(messages),
            icon: const Icon(Icons.delete_outline),
            label: Text(count == 0 ? t.delete : t.deleteWithCount(count)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade600,
              foregroundColor: Colors.white,
              disabledBackgroundColor: c.dangerSoft,
              disabledForegroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- TIMELINE ----------------
  String _dateLabel(AppLocalizations t, DateTime d) {
    final DateTime now = DateTime.now();
    final int diff = DateTime(
      now.year,
      now.month,
      now.day,
    ).difference(DateTime(d.year, d.month, d.day)).inDays;
    if (diff == 0) return t.today;
    if (diff == 1) return t.yesterday;
    return '${d.day}/${d.month}/${d.year}';
  }

  bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  // Purana pehle: har naye din ke pehle message se pehle tareekh ka chip
  List<_Entry> _buildEntries(List<SavedMessage> newestFirst) {
    final List<_Entry> out = [];
    DateTime? prev;
    for (final SavedMessage m in newestFirst.reversed) {
      if (prev == null || !_sameDay(prev, m.receivedAt)) {
        out.add(_Entry.header(m.receivedAt));
      }
      out.add(_Entry.message(m));
      prev = m.receivedAt;
    }
    return out;
  }

  // Cache: selection toggle jaisi cheezon par rows dobara nahi banti
  List<_Entry> _entriesFor(List<SavedMessage> newestFirst) {
    if (!identical(_entriesSource, newestFirst)) {
      _entriesSource = newestFirst;
      _entriesCache = _buildEntries(newestFirst);
    }
    return _entriesCache;
  }

  Widget _dateChip(AppColors c, AppLocalizations t, DateTime day) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: c.dateChip,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            _dateLabel(t, day),
            style: TextStyle(fontSize: 12, color: c.grey(700)),
          ),
        ),
      ),
    );
  }

  Widget _buildMessage(BuildContext context, SavedMessage m) {
    final AppColors c = AppColors.current;
    final bool selected = _selected.contains(m.key);
    final String time = TimeOfDay.fromDateTime(m.receivedAt).format(context);

    // GestureDetector: koi splash/hover nahi, sirf tap aur long-press
    return GestureDetector(
      onTap: _selecting ? () => _toggle(m.key) : null,
      onLongPress: _selecting ? null : () => _startSelecting(m.key),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_selecting)
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 8, top: 10),
                child: Icon(
                  selected ? Icons.check_circle : Icons.circle_outlined,
                  size: 22,
                  color: selected ? c.green(600) : c.grey(400),
                ),
              ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.sizeOf(context).width * 0.78,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: selected ? c.green(50) : c.bubble,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: selected ? c.green(200) : Colors.transparent,
                      ),
                    ),
                    child: Text(
                      m.text,
                      style: TextStyle(fontSize: 15, color: c.title),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: TextStyle(fontSize: 11, color: c.grey(600)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ThemeController.instance,
      builder: (context, _) => _buildScreen(context),
    );
  }

  Widget _buildScreen(BuildContext context) {
    final AppColors c = AppColors.current;
    final AppLocalizations t = AppLocalizations.of(context)!;
    final List<SavedMessage> newestFirst = MessagesStore.instance.forSender(
      widget.app,
      widget.sender,
    );
    final bool allSelected =
        newestFirst.isNotEmpty &&
        newestFirst.every((m) => _selected.contains(m.key));
    final List<_Entry> entries = _entriesFor(newestFirst);

    // Selection mode mein back dabane par pehle selection band ho, screen nahi
    return PopScope(
      canPop: !_selecting,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) _exitSelection();
      },
      child: Scaffold(
        // Light mein pehle wala default rang, dark mein dark background
        backgroundColor: c.isDark ? c.background : null,
        appBar: _selecting
            ? _selectionAppBar(newestFirst, allSelected)
            : _normalAppBar(),
        body: newestFirst.isEmpty
            ? Center(
                child: Text(
                  t.chatEmpty,
                  style: TextStyle(color: c.grey(600)),
                ),
              )
            : SafeArea(
                top: false,
                // Purana message upar, naya neeche. Kam messages hon to list upar se
                // shuru hoti hai, zyada hon to khulte hi sab se naye par.
                child: ListView.builder(
                  controller: _scroll,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  itemCount: entries.length,
                  itemBuilder: (context, i) {
                    final _Entry e = entries[i];
                    final SavedMessage? m = e.message;
                    if (m == null) return _dateChip(c, t, e.day!);
                    return KeyedSubtree(
                      key: ValueKey<String>(m.key),
                      child: _buildMessage(context, m),
                    );
                  },
                ),
              ),
        bottomNavigationBar: _selecting ? _deleteBar(newestFirst) : null,
      ),
    );
  }
}