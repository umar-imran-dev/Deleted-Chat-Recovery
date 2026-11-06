import 'package:flutter/material.dart';

import '../app_config.dart';
import '../l10n/app_localizations.dart';
import '../services/app_actions.dart';
import '../theme/app_colors.dart';

class RateUsDialog extends StatefulWidget {
  const RateUsDialog({super.key});

  // Popup dikhao. Submit hone par Google Play khulta hai.
  static Future<void> show(BuildContext context) async {
    final int? rating = await showDialog<int>(
      context: context,
      barrierDismissible: true,
      builder: (_) => const RateUsDialog(),
    );

    // rating null ho to user ne "Maybe later" ya bahar tap kiya
    if (rating == null || !context.mounted) return;
    await AppActions.openPlayStore(context);
  }

  @override
  State<RateUsDialog> createState() => _RateUsDialogState();
}

class _RateUsDialogState extends State<RateUsDialog> {
  // Kitne stars select hain (0 = koi nahi)
  int _rating = 0;

  static const Color _amber = Color(0xFFF59E0B);
  static const Color _starOff = Color(0xFFD1D5DB);

  static const List<String> _emojis = ['⭐', '😞', '😕', '🙂', '😊', '🤩'];

  // Index 0 = koi star nahi, 1..5 = stars
  List<String> _labels(AppLocalizations t) => [
        t.rateTapStar,
        t.ratePoor,
        t.rateFair,
        t.rateGood,
        t.rateVeryGood,
        t.rateExcellent,
      ];

  Color _labelColor(AppColors c) {
    switch (_rating) {
      case 1:
      case 2:
        return const Color(0xFFEF4444);
      case 3:
        return _amber;
      case 4:
      case 5:
        return c.accent;
      default:
        return c.muted;
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppColors c = AppColors.current;
    final AppLocalizations t = AppLocalizations.of(context)!;
    final List<String> labels = _labels(t);

    return Dialog(
      backgroundColor: c.dialog,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ---------- Emoji (rating ke hisaab se badalta hai) ----------
            Container(
              width: 72,
              height: 72,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: c.isDark ? c.accentPale : const Color(0xFFFEF3C7),
                shape: BoxShape.circle,
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, animation) =>
                    ScaleTransition(scale: animation, child: child),
                child: Text(
                  _emojis[_rating],
                  key: ValueKey<int>(_rating),
                  style: const TextStyle(fontSize: 34),
                ),
              ),
            ),

            const SizedBox(height: 18),

            Text(
              t.rateEnjoying(AppConfig.appName),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: c.heading,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              t.rateSubtitle,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, height: 1.45, color: c.muted),
            ),

            const SizedBox(height: 22),

            // ---------- 5 stars ----------
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                final int starValue = index + 1;
                final bool filled = starValue <= _rating;
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => setState(() => _rating = starValue),
                  child: AnimatedScale(
                    scale: filled ? 1.12 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOutBack,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        filled
                            ? Icons.star_rounded
                            : Icons.star_border_rounded,
                        size: 40,
                        color: filled ? _amber : _starOff,
                      ),
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 12),

            // ---------- Rating label ----------
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Text(
                labels[_rating],
                key: ValueKey<int>(_rating),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _labelColor(c),
                ),
              ),
            ),

            const SizedBox(height: 22),

            // ---------- Submit ----------
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed:
                    _rating == 0 ? null : () => Navigator.pop(context, _rating),
                style: ElevatedButton.styleFrom(
                  backgroundColor: c.accent,
                  disabledBackgroundColor: c.grey(200),
                  foregroundColor: Colors.white,
                  disabledForegroundColor: c.grey(500),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  t.submit,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 4),

            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                t.maybeLater,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: c.muted,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}