import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../core/responsive.dart';
import '../l10n/app_localizations.dart';
import '../services/interstitial_ad_manager.dart';
import '../services/status_service.dart';
import '../theme/app_colors.dart';
import '../theme/theme_controller.dart';
import 'status_preview_screen.dart';

enum _Phase { loading, needFolder, ready }

class StatusTab extends StatefulWidget {
  const StatusTab({super.key});

  @override
  State<StatusTab> createState() => _StatusTabState();
}

class _StatusTabState extends State<StatusTab> with WidgetsBindingObserver {
  String _kind = StatusService.whatsapp;
  _Phase _phase = _Phase.loading;
  List<StatusItem> _items = [];
  Set<String> _saved = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Interstitial pehle se tayyar rakho
    InterstitialAdManager.instance.preload();
    _load();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // WhatsApp mein status dekh kar wapas aao to list khud taaza ho
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _phase == _Phase.ready) {
      _load(silent: true);
    }
  }

  Future<void> _load({bool silent = false}) async {
    if (!silent) setState(() => _phase = _Phase.loading);

    final String kind = _kind;
    Set<String> saved = {};
    List<StatusItem>? list;
    // FIX: koi bhi call fail ho to loading par atki na rahe
    try {
      saved = await StatusService.instance.savedNames();
      list = await StatusService.instance.list(kind);
    } catch (_) {
      list = null;
    }

    // Is dauran user ne dusra tab chun liya ho to purana nateeja na dikhao
    if (!mounted || kind != _kind) return;

    setState(() {
      _saved = saved;
      if (list == null) {
        _items = [];
        _phase = _Phase.needFolder;
      } else {
        _items = list;
        _phase = _Phase.ready;
      }
    });
  }

  void _selectKind(String kind) {
    if (kind == _kind) return;
    setState(() {
      _kind = kind;
      _phase = _Phase.loading;
    });
    _load();
  }

  Future<void> _pickFolder() async {
    final AppLocalizations t = AppLocalizations.of(context)!;
    // FIX: folder picker fail ho to snackbar, crash nahi
    try {
      final String result = await StatusService.instance.pickFolder(_kind);
      if (!mounted) return;

      if (result == 'ok') {
        await _load();
      } else if (result == 'wrong_folder') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(t.statusWrongFolder)));
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(t.statusSaveFailed)));
      }
    }
  }

  Future<void> _save(StatusItem item) async {
    final AppLocalizations t = AppLocalizations.of(context)!;
    final bool ok = await StatusService.instance.save(item);
    // Kamyab save par ginti barhao, har 3rd save par kabhi kabhi ad dikhegi
    if (ok) unawaited(InterstitialAdManager.instance.onStatusSaved());
    if (!mounted) return;

    if (ok) setState(() => _saved = {..._saved, item.name});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(ok ? t.statusSaved : t.statusSaveFailed)),
    );
  }

  Future<void> _open(StatusItem item) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => StatusPreviewScreen(item: item)),
    );
    final Set<String> saved = await StatusService.instance.savedNames();
    if (mounted) setState(() => _saved = saved);
  }

  @override
  Widget build(BuildContext context) {
    // Dark mode badle to ye tab khud dobara bane
    return ListenableBuilder(
      listenable: ThemeController.instance,
      builder: (context, _) => _buildTab(),
    );
  }

  Widget _buildTab() {
    final AppColors c = AppColors.current;
    final AppLocalizations t = AppLocalizations.of(context)!;

    return Padding(
      // FIX: chhoti screen par kam padding
      padding: EdgeInsets.all(Responsive.pagePadding(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  t.navStatus,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: c.green(700),
                  ),
                ),
              ),
              if (_phase == _Phase.ready)
                IconButton(
                  tooltip: t.statusChangeFolder,
                  icon: Icon(Icons.folder_open_rounded, color: c.title),
                  onPressed: _pickFolder,
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _kindChip(c, 'WhatsApp', StatusService.whatsapp)),
              const SizedBox(width: 10),
              Expanded(
                child: _kindChip(
                  c,
                  'WhatsApp Business',
                  StatusService.business,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(child: _body(c, t)),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: Text(
              t.statusViewedNote,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, height: 1.4, color: c.muted),
            ),
          ),
        ],
      ),
    );
  }

  Widget _body(AppColors c, AppLocalizations t) {
    switch (_phase) {
      case _Phase.loading:
        return Center(child: CircularProgressIndicator(color: c.accent));

      case _Phase.needFolder:
        return _info(
          c,
          icon: Icons.folder_open_rounded,
          title: t.statusAllowTitle,
          text: t.statusAllowText,
          button: SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: _pickFolder,
              style: ElevatedButton.styleFrom(
                backgroundColor: c.accent,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                t.statusChooseFolder,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        );

      case _Phase.ready:
        // Khali ho tab bhi neeche kheench kar refresh ho sake
        return RefreshIndicator(
          color: c.accent,
          onRefresh: () => _load(silent: true),
          child: _items.isEmpty
              ? ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    SizedBox(
                      height: 360,
                      child: _info(
                        c,
                        icon: Icons.motion_photos_on_outlined,
                        title: t.statusEmptyTitle,
                        text: t.statusEmptyText,
                      ),
                    ),
                  ],
                )
              : GridView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  cacheExtent: 300,
                  // FIX: har screen par sahi columns (phone par 3, tablet par 5-6)
                  gridDelegate:
                      const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 130,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    final StatusItem item = _items[index];
                    // FIX: har tile apni layer mein, scroll par dobara paint nahi
                    return RepaintBoundary(
                      key: ValueKey<String>(item.uri),
                      child: _tile(c, item),
                    );
                  },
                ),
        );
    }
  }

  Widget _kindChip(AppColors c, String label, String kind) {
    final bool selected = _kind == kind;
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => _selectKind(kind),
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
            fontSize: 13,
            color: selected ? c.green(800) : c.grey(600),
          ),
        ),
      ),
    );
  }

  Widget _info(
    AppColors c, {
    required IconData icon,
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
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: c.accentPale,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 44, color: c.accent),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
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
            if (button != null) ...[const SizedBox(height: 24), button],
          ],
        ),
      ),
    );
  }

  Widget _tile(AppColors c, StatusItem item) {
    final bool saved = _saved.contains(item.name);

    return GestureDetector(
      onTap: () => _open(item),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Audio ka koi picture nahi hota, to music ka icon dikhao
            if (item.isAudio)
              Container(
                color: c.grey(200),
                child: Center(
                  child: Icon(
                    Icons.music_note_rounded,
                    color: c.accent,
                    size: 36,
                  ),
                ),
              )
            else
              FutureBuilder<Uint8List?>(
                future: StatusService.instance.thumbnail(item),
                builder: (context, snapshot) {
                  final Uint8List? bytes = snapshot.data;
                  if (bytes != null) {
                    return Image.memory(
                      bytes,
                      fit: BoxFit.cover,
                      gaplessPlayback: true,
                      // FIX: kharab bytes par red error box nahi
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: c.grey(200),
                        child: Icon(
                          Icons.broken_image_rounded,
                          color: c.grey(500),
                        ),
                      ),
                    );
                  }
                  return Container(
                    color: c.grey(200),
                    child: Icon(
                      item.isVideo ? LucideIcons.video : LucideIcons.image,
                      color: c.grey(500),
                    ),
                  );
                },
              ),

            // Video ka nishan
            if (item.isVideo)
              Positioned(
                left: 6,
                bottom: 6,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),

            // Save ka button (save ho chuka ho to tick)
            Positioned(
              right: 6,
              bottom: 6,
              child: GestureDetector(
                onTap: saved ? null : () => _save(item),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: saved ? c.accent : Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    saved ? Icons.check_rounded : Icons.download_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}