// Flutter ki Material library
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Lucide icons
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../app_config.dart';
import '../theme/app_colors.dart';
import '../theme/theme_controller.dart';

// =====================================================
// COLORS: light mein aap ke asli rang, dark mein unke dark roop
// =====================================================
class _DP {
  final bool dark;
  const _DP(this.dark);

  // static const Color green = Color(0xff00A86B);
  static const Color green = Color(0xFF388E3C);
  static const Color amber = Color(0xffF59E0B);

  Color get bg => dark ? const Color(0xFF0E1513) : const Color(0xffFFFFFF);
  Color get cardBg => dark ? const Color(0xFF18221F) : const Color(0xffF9FAFB);
  Color get border => dark ? const Color(0xFF2E3E38) : const Color(0xffE5E7EB);
  Color get title => dark ? const Color(0xFFF1F6F3) : const Color(0xff111827);
  Color get body => dark ? const Color(0xFFC3D3CC) : const Color(0xff374151);
  Color get muted => dark ? const Color(0xFF93A8A0) : const Color(0xff6B7280);
  Color get heroStart =>
      dark ? const Color(0xFF16271F) : const Color(0xffE8F5EF);
  Color get heroEnd => dark ? const Color(0xFF1B2D25) : const Color(0xffF1FBF6);
  Color get heroBorder =>
      dark ? const Color(0xFF2A4A3A) : const Color(0xffD1EFE0);
  Color get warnBg => dark ? const Color(0xFF2B2113) : const Color(0xffFFF7ED);
  Color get warnBorder =>
      dark ? const Color(0xFF5A4320) : const Color(0xffFED7AA);
  Color get warnText =>
      dark ? const Color(0xFFF5C27A) : const Color(0xff92400E);
}

// =====================================================
// DISCLAIMER SCREEN
// =====================================================

class DisclaimerScreen extends StatelessWidget {
  const DisclaimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dark mode badle to ye screen khud dobara bane
    return ListenableBuilder(
      listenable: ThemeController.instance,
      builder: (context, _) => _buildScreen(context),
    );
  }

  Widget _buildScreen(BuildContext context) {
    final _DP p = _DP(AppColors.current.isDark);

    return Scaffold(
      backgroundColor: p.bg,

      // -------------------------------------------------
      // APP BAR
      // -------------------------------------------------
      appBar: AppBar(
        backgroundColor: p.bg,
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle:
            p.dark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
        leading: IconButton(
          icon: Icon(LucideIcons.arrowLeft, color: p.title),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Disclaimer',
          style: TextStyle(
            color: p.title,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      // -------------------------------------------------
      // BODY
      // -------------------------------------------------
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
          children: [
            // =================================================
            // TOP HERO CARD (icon + heading)
            // =================================================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 24,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [p.heroStart, p.heroEnd],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: p.heroBorder),
              ),
              child: Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: _DP.green.withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      LucideIcons.shieldAlert,
                      size: 32,
                      color: _DP.green,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Please Read Carefully',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: p.title,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'By using this app you agree to the terms below.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: p.muted,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // =================================================
            // SECTION: Purpose
            // =================================================
            _buildSection(
              p: p,
              icon: LucideIcons.target,
              iconColor: _DP.green,
              title: 'Purpose of This App',
              body:
                  'This application is designed to help users keep a copy of '
                  'the messages that arrive as notifications on their phone, '
                  'so they can read them later even if the sender deletes '
                  'them. It saves message text only, and it reads only the '
                  'notifications of the supported apps through the system '
                  'notification access permission that you grant. Some '
                  'messages may not be saved, for example when notifications '
                  'are muted or the phone stops the app, so recovery is not '
                  'guaranteed.',
            ),

            const SizedBox(height: 14),

            // =================================================
            // SECTION: No Affiliation
            // =================================================
            _buildSection(
              p: p,
              icon: LucideIcons.unlink,
              iconColor: const Color(0xff2563EB),
              title: 'No Affiliation',
              body:
                  'This app is an independent tool. It is not affiliated, '
                  'associated, authorised, endorsed by, or in any way '
                  'officially connected with WhatsApp, Messenger, Instagram, '
                  'or any other messaging platform mentioned in the app.',
            ),

            const SizedBox(height: 14),

            // =================================================
            // SECTION: User Responsibility
            // =================================================
            _buildSection(
              p: p,
              icon: LucideIcons.userCheck,
              iconColor: const Color(0xff7C3AED),
              title: 'User Responsibility',
              body:
                  'You are solely responsible for how you use this app and '
                  'the data it recovers. Please make sure that your use of '
                  'the app complies with the laws of your country and with '
                  'the terms of service of any messaging platform you use.',
            ),

            const SizedBox(height: 14),

            // =================================================
            // SECTION: Data & Privacy
            // =================================================
            _buildSection(
              p: p,
              icon: LucideIcons.lock,
              iconColor: const Color(0xff0891B2),
              title: 'Data & Privacy',
              body:
                  'All saved messages are stored locally on your device. '
                  'We do not upload, transmit, or share your messages with '
                  'any external server. You can delete saved messages or '
                  'clear all stored data at any time from the app settings.',
            ),

            const SizedBox(height: 14),

            // =================================================
            // SECTION: Limitation of Liability
            // =================================================
            _buildSection(
              p: p,
              icon: LucideIcons.scale,
              iconColor: _DP.amber,
              title: 'Limitation of Liability',
              body:
                  'This app is provided "as is" without any warranty, '
                  'express or implied. The developers are not liable for '
                  'any loss of data, misuse, or damages that may arise '
                  'from using this application.',
            ),

            const SizedBox(height: 20),

            // =================================================
            // WARNING BOX
            // =================================================
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: p.warnBg,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: p.warnBorder),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    LucideIcons.alertTriangle,
                    size: 22,
                    color: _DP.amber,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'If you do not agree with any part of this disclaimer, '
                      'please uninstall the app immediately.',
                      style: TextStyle(
                        fontSize: 13,
                        color: p.warnText,
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // =================================================
            // FOOTER
            // =================================================
            Center(
              child: Text(
                'Last updated: ${AppConfig.policyUpdated}',
                style: TextStyle(
                  fontSize: 12,
                  color: p.muted,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =====================================================
  // SECTION BUILDER
  // =====================================================

  Widget _buildSection({
    required _DP p,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String body,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: p.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: p.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row (icon + title)
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 20, color: iconColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: p.title,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Body
          Text(
            body,
            style: TextStyle(
              fontSize: 13.5,
              color: p.body,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}