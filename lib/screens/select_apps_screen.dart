import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app_catalog.dart';
import '../l10n/app_localizations.dart';
import '../services/connected_apps_service.dart';
import '../theme/app_colors.dart';
import '../theme/theme_controller.dart';
import 'connected_apps_screen.dart';

class SelectAppsScreen extends StatefulWidget {
  const SelectAppsScreen({super.key});

  @override
  State<SelectAppsScreen> createState() => _SelectAppsScreenState();
}

class _SelectAppsScreenState extends State<SelectAppsScreen> {
  final Set<String> _selected = {};

  String _query = '';

  // FIX: ab sirf app_catalog.dart wali list istemal hoti hai (pehle yahan alag list thi,
  // aur asset paths bhi alag the). Sirf supported apps dikhti hain.
  List<AppCatalogEntry> get _filtered {
    final String q = _query.trim().toLowerCase();
    final List<AppCatalogEntry> supported =
        kAppCatalog.where((a) => a.supported).toList();
    if (q.isEmpty) return supported;
    return supported.where((a) => a.name.toLowerCase().contains(q)).toList();
  }

  void _toggle(String name) {
    setState(() {
      if (_selected.contains(name)) {
        _selected.remove(name);
      } else {
        _selected.add(name);
      }
    });
  }

  Future<void> _onNext() async {
    // await se pehle le lo, taake context ka masla na ho
    final AppLocalizations t = AppLocalizations.of(context)!;

    if (_selected.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t.pickAtLeastOneApp)),
      );
      return;
    }

    // FIX: save fail ho to unhandled error nahi, user dobara Next dabaa sakta hai
    try {
      await ConnectedAppsService.instance.addApps(_selected.toList());
    } catch (e) {
      if (kDebugMode) debugPrint('SelectApps addApps: $e');
      return;
    }
    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const ConnectedAppsScreen()),
      (route) => false,
    );
  }

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
    final List<AppCatalogEntry> apps = _filtered;

    return Scaffold(
      backgroundColor: c.background,
      appBar: AppBar(
        backgroundColor: c.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle:
            c.isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: c.title),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          t.selectApps,
          style: TextStyle(
            color: c.title,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
            child: TextField(
              onChanged: (value) => setState(() => _query = value),
              style: TextStyle(color: c.title),
              decoration: InputDecoration(
                hintText: t.searchApps,
                hintStyle: TextStyle(color: c.grey(400), fontSize: 15),
                prefixIcon: Icon(Icons.search, color: c.grey(500), size: 20),
                filled: true,
                fillColor: c.fieldFill,
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                t.appsHeading,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: c.grey(800),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 10),
              itemCount: apps.length,
              itemBuilder: (context, index) {
                final AppCatalogEntry app = apps[index];
                final bool checked = _selected.contains(app.name);
                return _buildAppCard(c: c, app: app, checked: checked);
              },
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
              child: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: SizedBox(
                  height: 44,
                  child: ElevatedButton(
                    onPressed: _onNext,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: c.brandButton,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      t.next,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppCard({
    required AppColors c,
    required AppCatalogEntry app,
    required bool checked,
  }) {
    return Container(
      key: ValueKey<String>(app.name),
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: checked ? c.green(200) : c.grey(200),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _toggle(app.name),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    app.imagePath,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    // FIX: fallback ka size image jitna (pehle 30x30 tha)
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: c.grey(200),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Icons.apps, color: c.grey(500)),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    app.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: c.title,
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: checked ? c.green(600) : Colors.transparent,
                    border: Border.all(
                      color: checked ? c.green(600) : c.grey(300),
                      width: checked ? 0 : 2,
                    ),
                  ),
                  // FIX: tick ka size 10 se 16 (pehle bohot chhota tha)
                  child: checked
                      ? const Icon(Icons.check, color: Colors.white, size: 16)
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}