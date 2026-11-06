import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../l10n/app_localizations.dart';
import '../services/app_actions.dart';
import '../services/app_settings.dart';
import '../services/avatar_service.dart';
import '../services/locale_controller.dart';
import '../services/messages_store.dart';
import '../services/seen_chats_service.dart';
import '../services/service_control.dart';
import '../theme/app_colors.dart';
import '../theme/theme_controller.dart';
import 'about_us_screen.dart';
import 'disclaimer_screen.dart';
import 'guide_screen.dart';
import 'language_screen.dart';
import 'rate_us_dialog.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void showClearDataDialog() {
    final AppColors c = AppColors.current;
    showDialog(
      context: context,
      builder: (dialogContext) {
        final AppLocalizations t = AppLocalizations.of(dialogContext)!;
        return AlertDialog(
          backgroundColor: c.dialog,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            t.clearAllData,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: c.heading,
            ),
          ),
          content: Text(
            t.clearAllDataText,
            style: TextStyle(fontSize: 14, color: c.muted),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(t.cancel, style: TextStyle(color: c.muted)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                _clearAllData();
              },
              child: Text(t.delete, style: const TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _clearAllData() async {
    // await se pehle le lo, taake context ka masla na ho
    final AppLocalizations t = AppLocalizations.of(context)!;
    try {
      await MessagesStore.instance.clearAll();
      await AvatarService.instance.clearAll();
      await SeenChatsService.instance.clear();
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(t.allSavedMessagesDeleted)));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t.couldNotClearData(e.toString()))),
      );
    }
  }

  // ---------------- helpers ----------------
  Widget _sectionTitle(AppColors c, String text) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 22,
          decoration: BoxDecoration(
            color: c.accent,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: c.heading,
          ),
        ),
      ],
    );
  }

  Widget _card(AppColors c, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: c.card,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(children: children),
    );
  }

  Widget _chevron(AppColors c) {
    return Icon(LucideIcons.chevronRight, size: 20, color: c.muted);
  }

  Widget _switch(AppColors c, bool value, ValueChanged<bool> onChanged) {
    return Transform.scale(
      scale: 0.7,
      child: Switch(
        value: value,
        activeColor: Colors.white,
        activeTrackColor: c.accent,
        inactiveThumbColor: c.isDark ? c.muted : null,
        inactiveTrackColor: c.isDark ? c.line : null,
        trackOutlineColor: c.isDark
            ? WidgetStateProperty.all(Colors.transparent)
            : null,
        onChanged: onChanged,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Dark mode ya koi setting badle to ye screen khud dobara bane
    return ListenableBuilder(
      listenable: Listenable.merge([
        ThemeController.instance,
        AppSettings.instance,
        LocaleController.instance,
      ]),
      builder: (context, _) {
        final AppColors c = AppColors.current;
        final AppLocalizations t = AppLocalizations.of(context)!;

        // Ab kaunsi zabaan chal rahi hai, uska apna naam
        final String currentLanguage = LocaleController.nativeNameFor(
          Localizations.localeOf(context).languageCode,
        );

        return Scaffold(
          backgroundColor: c.background,

          // ---------- AppBar: back arrow + Settings ----------
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
            automaticallyImplyLeading: false,
            titleSpacing: 16,
            systemOverlayStyle: c.isDark
                ? SystemUiOverlayStyle.light
                : SystemUiOverlayStyle.dark,
            title: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.maybePop(context),
                  child: Icon(
                    LucideIcons.chevronLeft,
                    size: 22,
                    color: c.heading,
                  ),
                ),
                const SizedBox(width: 14),
                Text(
                  t.settings,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: c.heading,
                  ),
                ),
              ],
            ),
          ),

          // ---------- Body ----------
          body: ListView(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
            children: [
              _sectionTitle(c, t.general),
              const SizedBox(height: 12),
              _card(c, [
                SettingsTile(
                  icon: LucideIcons.languages,
                  title: t.language,
                  subtitle: currentLanguage,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LanguageScreen()),
                  ),
                  trailing: _chevron(c),
                ),
                SettingsTile(
                  icon: LucideIcons.moon,
                  title: t.darkMode,
                  subtitle: t.darkModeSub,
                  trailing: _switch(
                    c,
                    ThemeController.instance.isDark,
                    ThemeController.instance.setDark,
                  ),
                ),
                SettingsTile(
                  icon: LucideIcons.image,
                  title: t.saveProfilePictures,
                  subtitle: t.saveProfilePicturesSub,
                  trailing: _switch(
                    c,
                    AppSettings.instance.saveAvatars,
                    AppSettings.instance.setSaveAvatars,
                  ),
                ),
                SettingsTile(
                  icon: LucideIcons.trash2,
                  title: t.clearAllData,
                  subtitle: t.clearAllDataSub,
                  onTap: showClearDataDialog,
                  trailing: _chevron(c),
                ),
                SettingsTile(
                  icon: LucideIcons.refreshCw,
                  title: t.restartService,
                  subtitle: t.restartServiceSub,
                  onTap: () => ServiceControl.restartWithUi(context),
                  trailing: _chevron(c),
                ),
                SettingsTile(
                  icon: LucideIcons.helpCircle,
                  title: t.guide,
                  subtitle: t.guideSub,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const GuideScreen()),
                  ),
                  showDivider: false,
                  trailing: _chevron(c),
                ),
              ]),
              const SizedBox(height: 24),

              _sectionTitle(c, t.other),
              const SizedBox(height: 12),
              _card(c, [
                SettingsTile(
                  icon: LucideIcons.shieldCheck,
                  title: t.privacyPolicy,
                  subtitle: t.privacyPolicySub,
                  onTap: () => AppActions.openPrivacyPolicy(context),
                  trailing: _chevron(c),
                ),
                SettingsTile(
                  icon: LucideIcons.star,
                  title: t.rateUs,
                  subtitle: t.rateUsSub,
                  onTap: () => RateUsDialog.show(context),
                  trailing: _chevron(c),
                ),
                SettingsTile(
                  icon: LucideIcons.share2,
                  title: t.shareApp,
                  subtitle: t.shareAppSub,
                  onTap: () => AppActions.shareApp(context),
                  trailing: _chevron(c),
                ),
                SettingsTile(
                  icon: LucideIcons.info,
                  title: t.disclaimer,
                  subtitle: t.disclaimerSub,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const DisclaimerScreen()),
                  ),
                  trailing: _chevron(c),
                ),
                SettingsTile(
                  icon: LucideIcons.messageCircle,
                  title: t.feedback,
                  subtitle: t.feedbackSub,
                  onTap: () => AppActions.sendFeedback(context),
                  trailing: _chevron(c),
                ),
                SettingsTile(
                  icon: LucideIcons.users,
                  title: t.aboutUs,
                  subtitle: t.aboutUsSub,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AboutUsScreen()),
                  ),
                  showDivider: false,
                  trailing: _chevron(c),
                ),
              ]),
            ],
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------
// Reusable row: icon dibba + title + subtitle + trailing
// ---------------------------------------------------------------
class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget trailing;
  final VoidCallback? onTap;
  final bool showDivider;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.trailing,
    this.onTap,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    final AppColors c = AppColors.current;

    return Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                // Icon dibba
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: c.grey(100),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(icon, size: 20, color: c.iconOnPale),
                ),
                const SizedBox(width: 16),

                // Title + subtitle
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
                      const SizedBox(height: 1),
                      Text(
                        subtitle,
                        style: TextStyle(fontSize: 10, color: c.muted),
                      ),
                    ],
                  ),
                ),

                // Right side
                trailing,
              ],
            ),
          ),
        ),
        if (showDivider) Divider(height: 1, color: c.line),
      ],
    );
  }
}
