import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  // FIX (jank): ThemeData ek hi baar banta hai. Pehle har rebuild par
  // ColorScheme.fromSeed dobara chalta tha, jo dark mode toggle par mehnga parta hai.
  static final ThemeData _light = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.teal,
      brightness: Brightness.light,
    ),
  );

  static final ThemeData _dark = _buildDark();

  static ThemeData light() => _light;

  static ThemeData dark() => _dark;

  // Dark: AppColors.dark ke rang, taake dialog, switch waghera bhi match karein
  static ThemeData _buildDark() {
    const AppColors c = AppColors.dark;
    final ColorScheme base = ColorScheme.fromSeed(
      seedColor: Colors.teal,
      brightness: Brightness.dark,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: base.copyWith(
        primary: c.accent,
        onPrimary: Colors.white,
        surface: c.background,
        surfaceContainerHigh: c.dialog, // dialogs ka background
        surfaceContainerHighest: c.surface, // switch ka band track waghera
      ),
      scaffoldBackgroundColor: c.background,
    );
  }
}