// Flutter Material
import 'package:flutter/material.dart';

// Lucide icons
import 'package:lucide_icons_flutter/lucide_icons.dart';

// =====================================================
// RATE US DIALOG
// =====================================================

class RateUsDialog extends StatefulWidget {
  const RateUsDialog({super.key});

  // Easy call method
  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => const RateUsDialog(),
    );
  }

  @override
  State<RateUsDialog> createState() => _RateUsDialogState();
}

class _RateUsDialogState extends State<RateUsDialog> {
  // Kitne stars selected hain (0 = koi nahi)
  int _rating = 0;

  // Kya submit ho chuka hai (thank you screen)
  bool _submitted = false;

  // =====================================================
  // STAR LABELS
  // =====================================================
  String get _ratingLabel {
    switch (_rating) {
      case 1:
        return 'We will try to improve';
      case 2:
        return 'Sorry to hear that';
      case 3:
        return 'Thanks for the feedback';
      case 4:
        return 'Glad you liked it!';
      case 5:
        return 'Awesome! Thank you ❤️';
      default:
        return 'Tap a star to rate';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
        child: _submitted ? _buildThankYou() : _buildRatingContent(),
      ),
    );
  }

  // =====================================================
  // RATING CONTENT
  // =====================================================
  Widget _buildRatingContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ---------------------------------------------
        // TOP ICON
        // ---------------------------------------------
        Container(
          width: 68,
          height: 68,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xffFEF3C7), Color(0xffFDE68A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            LucideIcons.sparkles,
            size: 32,
            color: Color(0xffF59E0B),
          ),
        ),

        const SizedBox(height: 18),

        // ---------------------------------------------
        // TITLE
        // ---------------------------------------------
        const Text(
          'Enjoying the app?',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xff111827),
          ),
        ),

        const SizedBox(height: 6),

        // ---------------------------------------------
        // SUBTITLE
        // ---------------------------------------------
        const Text(
          'Your rating helps us improve and recover better for you.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            color: Color(0xff6B7280),
            height: 1.45,
          ),
        ),

        const SizedBox(height: 22),

        // ---------------------------------------------
        // 5 STARS
        // ---------------------------------------------
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            final int starValue = index + 1;
            final bool filled = starValue <= _rating;
            return GestureDetector(
              onTap: () => setState(() => _rating = starValue),
              child: AnimatedScale(
                scale: filled ? 1.15 : 1.0,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutBack,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Icon(
                    filled ? LucideIcons.star : LucideIcons.star,
                    size: 38,
                    color: filled
                        ? const Color(0xffF59E0B)
                        : const Color(0xffD1D5DB),
                  ),
                ),
              ),
            );
          }),
        ),

        const SizedBox(height: 12),

        // ---------------------------------------------
        // RATING LABEL
        // ---------------------------------------------
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: Text(
            _ratingLabel,
            key: ValueKey(_rating),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xff374151),
            ),
          ),
        ),

        const SizedBox(height: 24),

        // ---------------------------------------------
        // SUBMIT BUTTON
        // ---------------------------------------------
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: _rating == 0
                ? null
                : () {
                    // Yahan apni rating save/log kar sakte ho
                    setState(() => _submitted = true);
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff00A86B),
              disabledBackgroundColor: const Color(0xffE5E7EB),
              foregroundColor: Colors.white,
              disabledForegroundColor: const Color(0xff9CA3AF),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              'Submit',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),

        const SizedBox(height: 6),

        // ---------------------------------------------
        // MAYBE LATER
        // ---------------------------------------------
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'Maybe later',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xff6B7280),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  // =====================================================
  // THANK YOU CONTENT
  // =====================================================
  Widget _buildThankYou() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ---------------------------------------------
        // SUCCESS ICON
        // ---------------------------------------------
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xffD1FAE5), Color(0xffA7F3D0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            LucideIcons.check,
            size: 40,
            color: Color(0xff00A86B),
          ),
        ),

        const SizedBox(height: 20),

        // ---------------------------------------------
        // THANK YOU TITLE
        // ---------------------------------------------
        const Text(
          'Thank You!',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Color(0xff111827),
          ),
        ),

        const SizedBox(height: 8),

        // ---------------------------------------------
        // THANK YOU MESSAGE
        // ---------------------------------------------
        Text(
          _rating >= 4
              ? 'Your ${_rating}-star rating means a lot to us. '
                'We will keep improving!'
              : 'Thanks for your feedback. '
                'We will work hard to do better.',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 13.5,
            color: Color(0xff6B7280),
            height: 1.5,
          ),
        ),

        const SizedBox(height: 24),

        // ---------------------------------------------
        // DONE BUTTON
        // ---------------------------------------------
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff00A86B),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              'Done',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}