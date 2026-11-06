import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Tablet / foldable / landscape par content itna hi chauda rahega.
const double kMaxContentWidth = 640;

/// Phone ki font setting bohot barhi ho to bhi layout nahi tootega.
const double kMinTextScale = 0.85;
const double kMaxTextScale = 1.3;

/// MaterialApp.builder mein lagta hai. Do kaam karta hai:
///  1. Text scale ko [0.85, 1.3] mein rokta hai (RenderFlex overflow ki sab se
///     badi wajah barhi system font hoti hai).
///  2. Bari screens par content ko beech mein, max 640dp chauda rakhta hai.
///
/// Widget tree ki shakal hamesha ek jaisi rehti hai (phone ho ya tablet), taake
/// fold / unfold / rotate par Navigator ki state (khuli screens) gum na ho.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mq = MediaQuery.of(context);
    final double width = math.min(mq.size.width, kMaxContentWidth);
    final bool narrowed = width < mq.size.width;

    // Content chhota kiya to side ke notch wale insets bhi hata do
    final EdgeInsets padding =
        narrowed ? mq.padding.copyWith(left: 0, right: 0) : mq.padding;
    final EdgeInsets viewPadding =
        narrowed ? mq.viewPadding.copyWith(left: 0, right: 0) : mq.viewPadding;

    return ColoredBox(
      color: AppColors.current.background,
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: width,
          height: mq.size.height,
          child: MediaQuery(
            data: mq.copyWith(
              size: Size(width, mq.size.height),
              padding: padding,
              viewPadding: viewPadding,
              textScaler: mq.textScaler.clamp(
                minScaleFactor: kMinTextScale,
                maxScaleFactor: kMaxTextScale,
              ),
            ),
            child: child ?? const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}

class Responsive {
  Responsive._();

  /// Chhoti screen (< 360dp) par kam padding, baqi par 20
  static double pagePadding(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 360 ? 14 : 20;

  static bool isCompact(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 360;
}