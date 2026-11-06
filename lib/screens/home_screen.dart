import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../app_catalog.dart';
import '../app_config.dart';
import '../core/responsive.dart';
import '../l10n/app_localizations.dart';
import '../services/connected_apps_service.dart';
import '../theme/app_theme.dart';
import 'connected_apps_screen.dart';
import 'select_apps_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _connectAndOpen(String appName) async {
    // FIX: save fail ho to unhandled error nahi
    try {
      await ConnectedAppsService.instance.addApps([appName]);
    } catch (e) {
      if (kDebugMode) debugPrint('HomeScreen addApps: $e');
      return;
    }
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const ConnectedAppsScreen()),
      (route) => false,
    );
  }

  // Search icon tap karne pe SelectAppsScreen open hoga
  void _openSelectApps() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SelectAppsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations t = AppLocalizations.of(context)!;

    // Home screen jaan bujh kar hamesha light rakhi hai:
    // Theme light karta hai, aur status bar ke icons kaale rakhta hai.
    // FIX: pehle yahan IndexedStack mein do "Coming soon" tabs the jinka koi button nahi tha
    // (dead code), wo hata diye.
    return Theme(
      data: AppTheme.light(),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(body: SafeArea(child: _buildAppsGrid(t))),
      ),
    );
  }

  Widget _buildAppsGrid(AppLocalizations t) {
    // Catalog ki apps + aakhir mein "Other apps" ka card
    final int total = kAppCatalog.length + 1;

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
                  AppConfig.appName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade700,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  LucideIcons.search,
                  color: Colors.black87,
                  size: 24,
                ),
                onPressed: _openSelectApps,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            t.suggestedApps,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Expanded(
            // FIX: fixed 2 columns aur aspect ratio ki jagah screen ke hisaab se columns
            // (phone par 2, tablet par 3+), aur card ki height fix, taake text overflow na ho
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 240,
                mainAxisExtent: 72,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemCount: total,
              itemBuilder: (context, index) {
                if (index == kAppCatalog.length) {
                  return _buildOtherAppsCard(t);
                }
                return _buildAppCard(kAppCatalog[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppCard(AppCatalogEntry app) {
    final bool enabled = app.supported;
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: enabled ? () => _connectAndOpen(app.name) : null,
      child: Opacity(
        // Jo app abhi supported nahi, wo halki dikhe
        opacity: enabled ? 1.0 : 0.5,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  app.imagePath,
                  width: 42,
                  height: 42,
                  fit: BoxFit.cover,
                  // FIX: asset na mile to icon toot kar red box na bane
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 42,
                    height: 42,
                    color: Colors.green.shade100,
                    child: Icon(Icons.apps, color: Colors.green.shade700),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  app.name,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOtherAppsCard(AppLocalizations t) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: _openSelectApps,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.apps, color: Colors.green.shade700),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                t.otherApps,
                style: const TextStyle(fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}