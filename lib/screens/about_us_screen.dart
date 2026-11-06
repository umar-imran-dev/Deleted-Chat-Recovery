import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../app_catalog.dart';
import '../app_config.dart';
import '../l10n/app_localizations.dart';
import '../services/app_actions.dart';
import '../theme/app_colors.dart';
import '../theme/theme_controller.dart';
import 'disclaimer_screen.dart';


class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  String _version = '';

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    try {
      final PackageInfo info = await PackageInfo.fromPlatform();
      if (!mounted) return;
      setState(() => _version = '${info.version} (${info.buildNumber})');
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ThemeController.instance,
      builder: (context, _) {
        final AppColors c = AppColors.current;
        final AppLocalizations t = AppLocalizations.of(context)!;
        final List<AppCatalogEntry> supported =
            kAppCatalog.where((e) => e.supported).toList();

        return Scaffold(
          backgroundColor: c.background,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
            automaticallyImplyLeading: false,
            titleSpacing: 16,
            systemOverlayStyle:
                c.isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
            title: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.maybePop(context),
                  child: Icon(LucideIcons.chevronLeft, size: 22, color: c.heading),
                ),
                const SizedBox(width: 14),
                Text(
                  t.aboutUs,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: c.heading,
                  ),
                ),
              ],
            ),
          ),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
            children: [
              _hero(c, t),
              const SizedBox(height: 22),

              _sectionTitle(c, t.ourStory),
              const SizedBox(height: 12),
              _card(
                c,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.aboutStory1(AppConfig.appName),
                      style: TextStyle(fontSize: 13.5, height: 1.55, color: c.body),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      t.aboutStory2,
                      style: TextStyle(fontSize: 13.5, height: 1.55, color: c.body),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),

              _sectionTitle(c, t.highlights),
              const SizedBox(height: 12),
              _card(
                c,
                child: Column(
                  children: [
                    _featureRow(
                      c,
                      LucideIcons.users,
                      t.featureOrganizedTitle,
                      t.featureOrganizedText,
                    ),
                    Divider(height: 1, color: c.line),
                    _featureRow(
                      c,
                      LucideIcons.shieldCheck,
                      t.featurePrivateTitle,
                      t.featurePrivateText,
                    ),
                    Divider(height: 1, color: c.line),
                    _featureRow(
                      c,
                      LucideIcons.refreshCw,
                      t.featureBackgroundTitle,
                      t.featureBackgroundText,
                    ),
                    Divider(height: 1, color: c.line),
                    _featureRow(
                      c,
                      LucideIcons.trash2,
                      t.featureControlTitle,
                      t.featureControlText,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),

              _sectionTitle(c, t.worksWith),
              const SizedBox(height: 12),
              _card(
                c,
                padding: const EdgeInsets.all(14),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: supported.map((e) => _appChip(c, e)).toList(),
                ),
              ),
              const SizedBox(height: 22),

              _sectionTitle(c, t.legalSupport),
              const SizedBox(height: 12),
              _card(
                c,
                child: Column(
                  children: [
                    // _linkTile(
                    //   c,
                    //   LucideIcons.shieldCheck,
                    //   t.privacyPolicy,
                    //   () => Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (_) => const PrivacyPolicyScreen(),
                    //     ),
                    //   ),
                    // ),
                    // Divider(height: 1, color: c.line),
                    _linkTile(
                      c,
                      LucideIcons.info,
                      t.disclaimer,
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const DisclaimerScreen(),
                        ),
                      ),
                    ),
                    Divider(height: 1, color: c.line),
                    _linkTile(
                      c,
                      LucideIcons.mail,
                      t.contactUs,
                      () => AppActions.sendFeedback(context),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              _footer(c, t),
            ],
          ),
        );
      },
    );
  }

  // ---------------- HERO ----------------
  Widget _hero(AppColors c, AppLocalizations t) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
      decoration: BoxDecoration(
        color: c.highlight,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        children: [
          // Yahan apna logo lagana ho to Icon ki jagah Image.asset('assets/images/...') rakho
          Container(
            width: 84,
            height: 84,
            decoration: BoxDecoration(
              color: c.surface,
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                  color: Color(0x1A16B864),
                  blurRadius: 18,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Icon(LucideIcons.messageCircle, size: 38, color: c.accent),
          ),
          const SizedBox(height: 16),
          Text(
            AppConfig.appName,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: c.heading,
            ),
          ),
          const SizedBox(height: 6),
          // Tagline abhi English mein hai (AppConfig.tagline). Zaroorat ho to isay bhi
          // arb mein daal sakte hain.
          Text(
            AppConfig.tagline,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13.5, height: 1.4, color: c.muted),
          ),
          if (_version.isNotEmpty) ...[
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: c.surface,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                t.versionLabel(_version),
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: c.heading,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ---------------- HELPERS ----------------
  Widget _sectionTitle(AppColors c, String text) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 22,
          decoration: BoxDecoration(
            color: c.grey(100),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: c.heading,
            ),
          ),
        ),
      ],
    );
  }

  Widget _card(
    AppColors c, {
    required Widget child,
    EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
  }) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: c.card,
        borderRadius: BorderRadius.circular(24),
      ),
      child: child,
    );
  }

  Widget _iconBox(AppColors c, IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: c.accentPale,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(icon, size: 20, color: c.iconOnPale),
    );
  }

  Widget _featureRow(AppColors c, IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _iconBox(c, icon),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: c.title,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12, height: 1.4, color: c.muted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _linkTile(AppColors c, IconData icon, String title, VoidCallback onTap) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            _iconBox(c, icon),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: c.title,
                ),
              ),
            ),
            Icon(LucideIcons.chevronRight, size: 20, color: c.muted),
          ],
        ),
      ),
    );
  }

  Widget _appChip(AppColors c, AppCatalogEntry entry) {
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(6, 6, 12, 6),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              entry.imagePath,
              width: 26,
              height: 26,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Icon(LucideIcons.messageCircle, size: 22, color: c.accent),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            entry.name,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: c.heading,
            ),
          ),
        ],
      ),
    );
  }

  Widget _footer(AppColors c, AppLocalizations t) {
    return Column(
      children: [
        Text(
          t.allRightsReserved('${DateTime.now().year}', AppConfig.developerName),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 11.5, color: c.muted),
        ),
        const SizedBox(height: 6),
        Text(
          t.notAffiliated,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 11, height: 1.4, color: c.muted),
        ),
      ],
    );
  }
}