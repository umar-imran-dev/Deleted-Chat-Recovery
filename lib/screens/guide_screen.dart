import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../app_config.dart';
import '../l10n/app_localizations.dart';
import '../services/service_control.dart';
import '../theme/app_colors.dart';
import '../theme/theme_controller.dart';
import 'disclaimer_screen.dart';

class _StepAction {
  final String label;
  final VoidCallback onPressed;
  const _StepAction(this.label, this.onPressed);
}

class _GuideStep {
  final IconData icon;
  final String title;
  final String text;
  final List<String> bullets;
  final List<_StepAction> actions;

  const _GuideStep({
    required this.icon,
    required this.title,
    required this.text,
    this.bullets = const [],
    this.actions = const [],
  });
}

class GuideScreen extends StatelessWidget {
  const GuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ThemeController.instance,
      builder: (context, _) {
        final AppColors c = AppColors.current;
        final AppLocalizations t = AppLocalizations.of(context)!;

        final List<_GuideStep> steps = [
          _GuideStep(
            icon: LucideIcons.smartphone,
            title: t.guideStep1Title,
            // Doosre labels placeholder se aate hain, taake app ke labels se mel khaaye
            text: t.guideStep1Text(t.otherApps, t.addMore),
          ),
          _GuideStep(
            icon: LucideIcons.bell,
            title: t.guideStep2Title,
            text: t.guideStep2Text,
            actions: [
              _StepAction(
                t.guideOpenNotificationAccess,
                ServiceControl.openNotificationAccess,
              ),
            ],
          ),
          _GuideStep(
            icon: LucideIcons.battery,
            title: t.guideStep3Title,
            text: t.guideStep3Text,
            actions: [
              _StepAction(t.battery, ServiceControl.openBatterySettings),
              _StepAction(t.autoStart, ServiceControl.openAutoStart),
            ],
          ),
          _GuideStep(
            icon: LucideIcons.info,
            title: t.guideStep4Title,
            text: t.guideStep4Text,
            bullets: [t.guideSaved1, t.guideSaved2, t.guideSaved3],
          ),
          _GuideStep(
            icon: LucideIcons.messageCircle,
            title: t.guideStep5Title,
            text: t.guideStep5Text(t.navMessages, t.unreadMessages),
          ),
          _GuideStep(
            icon: LucideIcons.trash2,
            title: t.guideStep6Title,
            text: t.guideStep6Text(
              t.selectAll,
              t.delete,
              t.settings,
              t.clearAllData,
            ),
          ),
          _GuideStep(
            icon: LucideIcons.refreshCw,
            title: t.guideStep7Title,
            text: t.guideStep7Text,
            bullets: [t.guideFix1, t.guideFix2, t.guideFix3, t.guideFix4],
            actions: [
              _StepAction(
                t.restartService,
                () => ServiceControl.restartWithUi(context),
              ),
            ],
          ),
        ];

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
                  t.guide,
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
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: c.highlight,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: c.surface,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(LucideIcons.helpCircle, color: c.accent, size: 22),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        t.guideIntro(AppConfig.appName),
                        style: TextStyle(fontSize: 13.5, height: 1.5, color: c.body),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              for (int i = 0; i < steps.length; i++)
                _stepCard(c, t, i + 1, steps[i]),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Center(
                  child: TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const DisclaimerScreen()),
                    ),
                    child: Text(
                      t.readDisclaimer,
                      style: TextStyle(
                        color: c.accent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _stepCard(AppColors c, AppLocalizations t, int number, _GuideStep step) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: c.card,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: c.grey(100),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(step.icon, size: 20, color: c.iconOnPale),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.guideStep(number),
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: c.accent,
                      ),
                    ),
                    Text(
                      step.title,
                      style: TextStyle(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w700,
                        color: c.heading,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            step.text,
            style: TextStyle(fontSize: 13.5, height: 1.5, color: c.body),
          ),
          for (final String b in step.bullets)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 7),
                    child: Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        color: c.accent,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      b,
                      style: TextStyle(fontSize: 13.5, height: 1.5, color: c.body),
                    ),
                  ),
                ],
              ),
            ),
          if (step.actions.isNotEmpty) ...[
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final _StepAction a in step.actions)
                  ElevatedButton(
                    onPressed: a.onPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: c.accent,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      minimumSize: const Size(0, 36),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      a.label,
                      style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}