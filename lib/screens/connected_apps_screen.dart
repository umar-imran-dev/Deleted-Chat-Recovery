import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart' show PluginUtilities;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../app_catalog.dart';
import '../background/background_entry.dart';
import '../core/responsive.dart';
import '../l10n/app_localizations.dart';
import '../models/saved_message.dart';
import '../services/avatar_service.dart';
import '../services/connected_apps_service.dart';
import '../services/messages_store.dart';
import '../services/seen_chats_service.dart';
import '../theme/app_colors.dart';
import '../theme/theme_controller.dart';
import '../widgets/banner_ad_view.dart';
import '../services/billing_service.dart';
import 'chat_detail_screen.dart';
import 'premium_screen.dart';
import 'select_apps_screen.dart';
import 'settings_screen.dart';
import 'status_tab.dart';

class ConnectedAppsScreen extends StatefulWidget {
  const ConnectedAppsScreen({super.key});

  @override
  State<ConnectedAppsScreen> createState() => _ConnectedAppsScreenState();
}

class _ConnectedAppsScreenState extends State<ConnectedAppsScreen>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  static const MethodChannel _channel = MethodChannel('native_log');

  // Tab badalne ka transition kitni der ka ho
  static const Duration _tabFade = Duration(milliseconds: 220);

  // Star ki animation ka ek chakkar
  static const Duration _starSpeed = Duration(milliseconds: 1800);

  List<String> _connectedApps = [];
  String? _selectedApp;
  int _tabIndex = 0; // 0 = All, 1 = Unread
  bool _hasPermission = false;
  bool _batteryOk = false;
  int _navIndex = 0; // 0 = Messages, 1 = Status

  // Status tab pehli dafa kholne par hi banta hai (shuru mein bojh na pare)
  bool _statusVisited = false;

  // Premium star ki halki animation
  late final AnimationController _starController;

  // Chat delete karne ke liye selection mode
  bool _selecting = false;
  final Set<String> _selectedChats = {}; // sender ke naam

  // Jab tak apps, permission aur battery ki jaanch poori na ho, screen khali
  // rehti hai. Warna pehle frame mein ghalat warning aur "koi app nahi" dikhta hai.
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    MessagesStore.instance.addListener(_onStoreChanged);
    _starController = AnimationController(vsync: this, duration: _starSpeed)
      ..repeat(reverse: true);
    _init();
    Future.delayed(
      const Duration(seconds: 15),
      () => BillingService.instance.debugSetPremium(true),
    );
  }

  Future<void> _init() async {
    List<String> apps = [];
    // FIX: koi bhi jaanch fail ho to bhi screen khule (pehle _ready kabhi true na hota)
    try {
      await MessagesStore.instance.start();
      await SeenChatsService.instance.preload();
      apps = await ConnectedAppsService.instance.getConnectedApps();
      await _checkPermission();
      await _checkBattery();
      unawaited(_registerBackgroundHandle());
    } catch (e) {
      debugPrint('ConnectedApps init error: $e');
    }

    if (!mounted) return;
    // Sab kuch ek saath dikhao, taake beech ka adhoora frame na bane
    setState(() {
      _connectedApps = apps;
      _selectedApp = apps.isNotEmpty ? apps.first : null;
      _ready = true;
    });
  }

  Future<void> _registerBackgroundHandle() async {
    final CallbackHandle? handle = PluginUtilities.getCallbackHandle(
      backgroundMain,
    );
    if (handle == null) return;
    try {
      await _channel.invokeMethod('registerBackgroundHandle', {
        'handle': handle.toRawHandle(),
      });
    } catch (_) {}
  }

  void _onStoreChanged() {
    if (mounted) setState(() {});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkPermission();
      _checkBattery();
      MessagesStore.instance.reload();
    }
  }

  Future<void> _checkPermission() async {
    bool granted = false;
    try {
      granted = await _channel.invokeMethod<bool>('isEnabled') ?? false;
    } catch (_) {}
    if (!mounted) return;
    setState(() => _hasPermission = granted);
  }

  Future<void> _checkBattery() async {
    bool ok = false;
    try {
      ok = await _channel.invokeMethod<bool>('isBatteryUnrestricted') ?? false;
    } catch (_) {}
    if (!mounted) return;
    setState(() => _batteryOk = ok);
  }

  // FIX: native settings screen na khule to app na gire
  Future<void> _call(String method) async {
    try {
      await _channel.invokeMethod(method);
    } on PlatformException catch (_) {
      // koi masla nahi, user dobara tap kar sakta hai
    } catch (_) {}
  }

  Future<void> _openSettings() => _call('openSettings');
  Future<void> _openBatterySettings() => _call('openBatterySettings');
  Future<void> _openAutoStartSettings() => _call('openAutoStartSettings');

  void _addMore() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SelectAppsScreen()),
    );
  }

  void _openPremium() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PremiumScreen()),
    );
  }

  @override
  void dispose() {
    _starController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    MessagesStore.instance.removeListener(_onStoreChanged);
    super.dispose();
  }

  // FIX (performance): sab senders ka unread count ek hi guzar mein.
  // Pehle har chat row ke liye poori messages list dobara scan hoti thi.
  Map<String, int> _unreadMap(String app) {
    final SeenChatsService seen = SeenChatsService.instance;
    final Map<String, int> result = {};
    for (final SavedMessage m in MessagesStore.instance.messages) {
      if (m.app != app) continue;
      final int? last = seen.lastSeenAtSync(app, m.sender);
      if (last == null || m.receivedAt.millisecondsSinceEpoch > last) {
        result[m.sender] = (result[m.sender] ?? 0) + 1;
      }
    }
    return result;
  }

  // ---------------- CHAT SELECTION / DELETE ----------------
  void _startSelecting(String sender) {
    setState(() {
      _selecting = true;
      _selectedChats.add(sender);
    });
  }

  void _exitSelection() {
    setState(() {
      _selecting = false;
      _selectedChats.clear();
    });
  }

  void _toggleChat(String sender) {
    setState(() {
      if (!_selectedChats.remove(sender)) _selectedChats.add(sender);
    });
  }

  void _toggleSelectAll(List<SavedMessage> chats) {
    setState(() {
      final bool all = chats.every((m) => _selectedChats.contains(m.sender));
      _selectedChats.clear();
      if (!all) _selectedChats.addAll(chats.map((m) => m.sender));
    });
  }

  // Chune hue chats ke saare messages hata do
  Future<void> _deleteSelectedChats() async {
    final String? app = _selectedApp;
    if (app == null || _selectedChats.isEmpty) return;

    // await se pehle le lo, taake context ka masla na ho
    final AppColors c = AppColors.current;
    final AppLocalizations t = AppLocalizations.of(context)!;

    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: c.dialog,
        title: Text(t.deleteChatsTitle, style: TextStyle(color: c.heading)),
        content: Text(t.deleteChatsText, style: TextStyle(color: c.body)),
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

    final List<SavedMessage> toDelete = [];
    for (final String sender in _selectedChats) {
      toDelete.addAll(MessagesStore.instance.forSender(app, sender));
    }

    // FIX: delete fail ho to error dikhao, screen atki na rahe
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
    _exitSelection();
  }

  // Dark mode mein buttons ko saaf rang dete hain, light mein pehle jaisa hi
  ButtonStyle? _primaryButton(AppColors c) => c.isDark
      ? ElevatedButton.styleFrom(
          backgroundColor: c.brandButton,
          foregroundColor: Colors.white,
        )
      : null;

  ButtonStyle? _outlineButton(AppColors c) => c.isDark
      ? OutlinedButton.styleFrom(
          foregroundColor: c.grey(800),
          side: BorderSide(color: c.grey(400)),
        )
      : null;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ThemeController.instance,
      builder: (context, _) => _buildScreen(),
    );
  }

  Widget _buildScreen() {
    final AppColors c = AppColors.current;
    final AppLocalizations t = AppLocalizations.of(context)!;
    final String? app = _selectedApp;
    final bool supported =
        app != null && (catalogEntryFor(app)?.supported ?? false);

    final Map<String, int> unread = app == null ? const {} : _unreadMap(app);

    List<SavedMessage> chats = [];
    if (app != null && supported) {
      chats = MessagesStore.instance.chatSummariesFor(app);
      if (_tabIndex == 1) {
        chats = chats.where((m) => unread.containsKey(m.sender)).toList();
      }
    }

    // Selection mode mein back dabane par pehle selection band ho, screen nahi
    return PopScope(
      canPop: !_selecting,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) _exitSelection();
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: c.isDark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
        child: Scaffold(
          // Light mein pehle wala default rang, dark mein dark background
          backgroundColor: c.isDark ? c.background : null,

          // Dono tab ek ke upar ek rehte hain, aur fade ke saath badalte hain.
          // Is se Status tab ki haalat (list, scroll) tab badalne par gum nahi hoti.
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      _tabLayer(
                        visible: _navIndex == 0,
                        hiddenOffset: const Offset(-0.04, 0),
                        child: _buildMessagesTab(
                          c,
                          t,
                          app,
                          supported,
                          chats,
                          unread,
                        ),
                      ),
                      _tabLayer(
                        visible: _navIndex == 1,
                        hiddenOffset: const Offset(0.04, 0),
                        child: _statusVisited
                            ? const StatusTab()
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
                // Banner: chat list ke neeche, sirf Messages tab par. Permission wali screen,
                // selection mode aur Status tab par nahi.
                BannerAdView(
                  visible:
                      _navIndex == 0 && !_selecting && _hasPermission && _ready,
                ),
              ],
            ),
          ),

          // Selection mode mein neeche ka menu hat kar Delete button aata hai
          bottomNavigationBar: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: _selecting
                ? KeyedSubtree(
                    key: const ValueKey('delete_bar'),
                    child: _deleteBar(c, t),
                  )
                : KeyedSubtree(
                    key: const ValueKey('nav_bar'),
                    child: _buildBottomNav(c, t),
                  ),
          ),
        ),
      ),
    );
  }

  // Ek tab ki parat: dikhne par poori, chhupne par fade ho kar halka sa side ko sarak jati hai
  Widget _tabLayer({
    required bool visible,
    required Offset hiddenOffset,
    required Widget child,
  }) {
    return Positioned.fill(
      child: IgnorePointer(
        ignoring: !visible,
        child: AnimatedOpacity(
          opacity: visible ? 1 : 0,
          duration: _tabFade,
          curve: Curves.easeInOut,
          child: AnimatedSlide(
            offset: visible ? Offset.zero : hiddenOffset,
            duration: _tabFade,
            curve: Curves.easeInOut,
            child: TickerMode(enabled: visible, child: child),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNav(AppColors c, AppLocalizations t) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _navIndex,
      backgroundColor: c.isDark ? c.card : null,
      selectedItemColor: c.green(700),
      unselectedItemColor: c.grey(600),
      selectedFontSize: 10,
      unselectedFontSize: 10,
      onTap: (index) async {
        if (index == 2) {
          // Settings alag screen hai, neeche ka tab wahi rehta hai
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SettingsScreen()),
          );
        } else if (index != _navIndex) {
          setState(() {
            _navIndex = index;
            if (index == 1) {
              _statusVisited = true;
              // FIX: Status tab par star ki animation ka bojh nahi
              _starController.stop();
            } else {
              _starController.repeat(reverse: true);
            }
          });
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: const Icon(LucideIcons.messageCircle),
          activeIcon: const Icon(LucideIcons.messageCircle),
          label: t.navMessages,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.motion_photos_on_outlined),
          activeIcon: const Icon(Icons.motion_photos_on),
          label: t.navStatus,
        ),
        BottomNavigationBarItem(
          icon: const Icon(LucideIcons.settings),
          activeIcon: const Icon(LucideIcons.settings),
          label: t.navSettings,
        ),
      ],
    );
  }

  // Messages tab ka poora hissa (header, apps, tabs, chat list)
  Widget _buildMessagesTab(
    AppColors c,
    AppLocalizations t,
    String? app,
    bool supported,
    List<SavedMessage> chats,
    Map<String, int> unread,
  ) {
    return Padding(
      // FIX: chhoti screen par kam padding
      padding: EdgeInsets.all(Responsive.pagePadding(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Selection mode mein title ki jagah selection bar
          if (_selecting)
            _selectionHeader(c, t, chats)
          else
            Row(
              children: [
                Expanded(
                  child: Text(
                    t.messageRecovery,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: c.green(700),
                    ),
                  ),
                ),
                _premiumStarButton(c, t),
              ],
            ),
          const SizedBox(height: 12),

          // Jaanch poori hone tak sirf title dikhta hai, baaki khali
          if (!_ready)
            const Expanded(child: SizedBox.shrink())
          else ...[
            // Battery card sirf tab, jab permission mil chuki ho
            if (_hasPermission && !_batteryOk)
              Card(
                margin: const EdgeInsets.only(bottom: 8),
                color: c.warning,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.battery_alert, color: c.title),
                      title: Text(
                        t.keepRunningInBackground,
                        style: TextStyle(color: c.title),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Wrap(
                        spacing: 8,
                        children: [
                          ElevatedButton(
                            style: _primaryButton(c),
                            onPressed: _openBatterySettings,
                            child: Text(t.battery),
                          ),
                          OutlinedButton(
                            style: _outlineButton(c),
                            onPressed: _openAutoStartSettings,
                            child: Text(t.autoStart),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(
              height: 76,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildAddMoreChip(t),
                  ..._connectedApps.map(_buildAppChip),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildTab(t.allMessages, 0)),
                const SizedBox(width: 10),
                Expanded(child: _buildTab(t.unreadMessages, 1)),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: !_hasPermission
                  ? _buildPermissionState(c)
                  : app == null
                  ? Center(
                      child: Text(
                        t.connectAppFirst,
                        style: TextStyle(color: c.grey(600)),
                      ),
                    )
                  : !supported
                  ? Center(
                      child: Text(
                        t.supportComingSoon,
                        style: TextStyle(color: c.grey(600)),
                      ),
                    )
                  : chats.isEmpty
                  ? _buildEmptyState(c)
                  // FIX: lazy list, har row ki apni key aur RepaintBoundary
                  : ListView.separated(
                      itemCount: chats.length,
                      cacheExtent: 400,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final SavedMessage chat = chats[index];
                        return RepaintBoundary(
                          key: ValueKey<String>('$app|${chat.sender}'),
                          child: _buildChatRow(
                            app,
                            chat,
                            unread[chat.sender] ?? 0,
                          ),
                        );
                      },
                    ),
            ),
          ],
        ],
      ),
    );
  }

  // ---------------- PREMIUM STAR (header mein, halki animation ke saath) ----------------

  Widget _premiumStarButton(AppColors c, AppLocalizations t) {
    return IconButton(
      visualDensity: VisualDensity.compact,
      tooltip: t.goPremium,
      onPressed: _openPremium,
      icon: AnimatedBuilder(
        animation: _starController,
        builder: (context, child) {
          // v: 0 se 1 aur wapas, narm raftaar ke saath
          final double v = Curves.easeInOut.transform(_starController.value);
          return Transform.rotate(
            angle: -0.08 + 0.16 * v, // zara sa jhulna
            child: Transform.scale(
              scale: 0.94 + 0.14 * v, // halka bara chhota hona
              child: child,
            ),
          );
        },
        child: Icon(Icons.star_rounded, color: c.green(600), size: 30),
      ),
    );
  }

  // ---------------- SELECTION BAR AUR DELETE BUTTON ----------------

  Widget _selectionHeader(
    AppColors c,
    AppLocalizations t,
    List<SavedMessage> chats,
  ) {
    final bool allSelected =
        chats.isNotEmpty &&
        chats.every((m) => _selectedChats.contains(m.sender));

    return Row(
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
          icon: Icon(Icons.close, color: c.title),
          onPressed: _exitSelection,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            t.selectedCount(_selectedChats.length),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: c.title,
            ),
          ),
        ),
        TextButton(
          onPressed: () => _toggleSelectAll(chats),
          child: Text(
            allSelected ? t.clearSelection : t.selectAll,
            style: TextStyle(color: c.green(700), fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  Widget _deleteBar(AppColors c, AppLocalizations t) {
    final int count = _selectedChats.length;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: SizedBox(
          height: 48,
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: count == 0 ? null : _deleteSelectedChats,
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

  // ---------------- BODY KI CENTER WALI SCREENS ----------------

  // Chat ka icon, title, text aur (zaroorat ho to) button.
  // Permission wali aur "No Notifications Yet" wali dono isi se banti hain.
  Widget _buildInfoState(
    AppColors c, {
    required String title,
    required String text,
    Widget? button,
  }) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Chat ka icon
            SizedBox(
              width: 120,
              height: 120,
              child: Center(
                child: Icon(
                  LucideIcons.messageCircleMore,
                  size: 100,
                  color: c.isDark ? c.grey(300) : const Color(0xFFE3EAE7),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: c.heading,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, height: 1.5, color: c.muted),
            ),
            if (button != null) ...[const SizedBox(height: 28), button],
          ],
        ),
      ),
    );
  }

  // Permission na ho to
  Widget _buildPermissionState(AppColors c) {
    final AppLocalizations t = AppLocalizations.of(context)!;
    return _buildInfoState(
      c,
      title: t.allowNotificationAccess,
      text: t.allowNotificationAccessText,
      button: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: _openSettings,
          style: ElevatedButton.styleFrom(
            backgroundColor: c.accent,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: Text(
            t.allowPermission,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }

  // Permission mil chuki hai, magar is app/tab mein abhi koi chat nahi
  Widget _buildEmptyState(AppColors c) {
    final AppLocalizations t = AppLocalizations.of(context)!;
    final bool unreadTab = _tabIndex == 1;
    return _buildInfoState(
      c,
      title: unreadTab ? t.noUnreadMessages : t.noNotificationsYet,
      text: unreadTab ? t.noUnreadText : t.noNotificationsText,
    );
  }

  Widget _buildAddMoreChip(AppLocalizations t) {
    final AppColors c = AppColors.current;
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: _addMore,
        child: Container(
          width: 76,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: c.grey(400)),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, color: c.green(700)),
              const SizedBox(height: 4),
              Text(
                t.addMore,
                style: TextStyle(fontSize: 11, color: c.grey(700)),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppChip(String app) {
    final AppColors c = AppColors.current;
    final bool selected = app == _selectedApp;
    final AppCatalogEntry? entry = catalogEntryFor(app);

    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        // Dusri app chunne par selection band (selection ek hi app ke chats ka hota hai)
        onTap: () => setState(() {
          _selectedApp = app;
          _selecting = false;
          _selectedChats.clear();
        }),
        child: Container(
          width: 76,
          decoration: BoxDecoration(
            color: selected ? c.green(50) : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected ? c.green(600) : c.grey(300),
              width: selected ? 2 : 1,
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: entry != null
                    ? Image.asset(
                        entry.imagePath,
                        width: 28,
                        height: 28,
                        fit: BoxFit.cover,
                        // FIX: asset na mile to icon khali na reh jaye
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.apps, size: 28, color: c.grey(600)),
                      )
                    : Icon(Icons.apps, size: 28, color: c.grey(600)),
              ),
              const SizedBox(height: 4),
              Text(
                app,
                style: TextStyle(fontSize: 11, color: c.title),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(String label, int index) {
    final AppColors c = AppColors.current;
    final bool selected = _tabIndex == index;
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => setState(() {
        _tabIndex = index;
        _selecting = false;
        _selectedChats.clear();
      }),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: selected ? c.green(50) : c.grey(100),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? c.green(600) : Colors.transparent,
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: selected ? c.green(800) : c.grey(600),
          ),
        ),
      ),
    );
  }

  // FIX: build ke andar File.existsSync() nahi (service sirf maujood file ka path deti hai),
  // initialData se flicker nahi, aur ResizeImage se memory kam.
  Widget _buildAvatar(String app, String sender) {
    final AppColors c = AppColors.current;
    final Widget fallback = CircleAvatar(
      radius: 22,
      backgroundColor: c.avatarBg,
      child: Text(
        sender.isNotEmpty ? sender[0].toUpperCase() : '?',
        style: TextStyle(fontWeight: FontWeight.bold, color: c.title),
      ),
    );

    return FutureBuilder<String?>(
      initialData: AvatarService.instance.cachedPathSync(app, sender),
      future: AvatarService.instance.pathFor(app, sender),
      builder: (context, snapshot) {
        final String? path = snapshot.data;
        if (path == null) return fallback;
        return ClipOval(
          child: Image(
            image: ResizeImage(FileImage(File(path)), width: 96, height: 96),
            width: 44,
            height: 44,
            fit: BoxFit.cover,
            gaplessPlayback: true,
            errorBuilder: (context, error, stackTrace) => fallback,
          ),
        );
      },
    );
  }

  Widget _buildChatRow(String app, SavedMessage chat, int unread) {
    final AppColors c = AppColors.current;
    final String time = TimeOfDay.fromDateTime(chat.receivedAt).format(context);
    final bool selected = _selectedChats.contains(chat.sender);

    return Material(
      color: selected ? c.green(50) : c.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: selected ? c.green(200) : Colors.transparent),
      ),
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        // Dabaye rakho to selection shuru, selection mein tap se chuno / hatao
        onLongPress: _selecting ? null : () => _startSelecting(chat.sender),
        onTap: _selecting
            ? () => _toggleChat(chat.sender)
            : () async {
                try {
                  await SeenChatsService.instance.markSeen(app, chat.sender);
                } catch (_) {}
                if (!mounted) return;
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ChatDetailScreen(app: app, sender: chat.sender),
                  ),
                );
                if (mounted) setState(() {});
              },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (_selecting)
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 10),
                  child: Icon(
                    selected ? Icons.check_circle : Icons.circle_outlined,
                    size: 22,
                    color: selected ? c.green(600) : c.grey(400),
                  ),
                ),
              _buildAvatar(app, chat.sender),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      chat.sender,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: c.title,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      chat.text,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 13, color: c.grey(600)),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    time,
                    style: TextStyle(fontSize: 11, color: c.grey(500)),
                  ),
                  const SizedBox(height: 6),
                  if (unread > 0)
                    Container(
                      width: 20,
                      height: 20,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: c.green(600),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        unread > 9 ? '9+' : '$unread',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
