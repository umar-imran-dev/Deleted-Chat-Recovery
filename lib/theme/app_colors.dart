import 'package:flutter/material.dart';

import 'theme_controller.dart';

// Har screen ke rang yahin se aayenge. Dark ya light, sab ek jagah badalte hain.
class AppColors {
  final bool isDark;

  // Aam rang
  final Color background;
  final Color card;
  final Color dialog;
  final Color heading;
  final Color title;
  final Color body;
  final Color muted;
  final Color accent;
  final Color accentPale;
  final Color iconOnPale;
  final Color highlight;
  final Color surface;
  final Color border;
  final Color line;

  // Chat aur form ke rang
  final Color appBar;
  final Color bubble;
  final Color dateChip;
  final Color fieldFill;
  final Color warning;
  final Color brandButton;
  final Color avatarBg;
  final Color avatarBgStrong;
  final Color dangerSoft;

  final Map<int, Color> _greys;
  final Map<int, Color> _greens;

  // Light mein ye bilkul Colors.grey.shade100..800 hain
  Color grey(int shade) => _greys[shade]!;

  // Light mein ye bilkul Colors.green.shade50/200/600/700/800 hain
  Color green(int shade) => _greens[shade]!;

  const AppColors._({
    required this.isDark,
    required this.background,
    required this.card,
    required this.dialog,
    required this.heading,
    required this.title,
    required this.body,
    required this.muted,
    required this.accent,
    required this.accentPale,
    required this.iconOnPale,
    required this.highlight,
    required this.surface,
    required this.border,
    required this.line,
    required this.appBar,
    required this.bubble,
    required this.dateChip,
    required this.fieldFill,
    required this.warning,
    required this.brandButton,
    required this.avatarBg,
    required this.avatarBgStrong,
    required this.dangerSoft,
    required Map<int, Color> greys,
    required Map<int, Color> greens,
  })  : _greys = greys,
        _greens = greens;

  static const Map<int, Color> _lightGreys = {
    100: Color(0xFFF5F5F5),
    200: Color(0xFFEEEEEE),
    300: Color(0xFFE0E0E0),
    400: Color(0xFFBDBDBD),
    500: Color(0xFF9E9E9E),
    600: Color(0xFF757575),
    700: Color(0xFF616161),
    800: Color(0xFF424242),
  };

  static const Map<int, Color> _lightGreens = {
    50: Color(0xFFE8F5E9),
    200: Color(0xFFA5D6A7),
    600: Color(0xFF388E3C), // brand green (header ke barabar)
    700: Color(0xFF388E3C),
    800: Color(0xFF2E7D32),
  };

  static const Map<int, Color> _darkGreys = {
    100: Color(0xFF1F2B27),
    200: Color(0xFF26352F),
    300: Color(0xFF2E3E38),
    400: Color(0xFF3B4A44),
    500: Color(0xFF7D918A),
    600: Color(0xFF93A8A0),
    700: Color(0xFFA9BBB4),
    800: Color(0xFFC3D3CC),
  };

  static const Map<int, Color> _darkGreens = {
    50: Color(0xFF16271F),
    200: Color(0xFF2E5C45),
    600: Color(0xFF2E9E57),
    700: Color(0xFF5FD38D),
    800: Color(0xFF9BE8BC),
  };

  static const AppColors light = AppColors._(
    isDark: false,
    background: Colors.white,
    card: Color.fromARGB(94, 218, 217, 217),
    dialog: Colors.white,
    heading: Color(0xFF0B3D2E),
    title: Color.fromARGB(255, 13, 14, 13),
    body: Color(0xFF3F514B),
    muted: Color(0xFF6B7F78),
    accent: Color(0xFF388E3C), // brand green: header, buttons, switch sab yahi
    accentPale: Color(0xFFE8F5E9),
    iconOnPale: Colors.black,
    highlight: Color(0xFFE8F5E9),
    surface: Colors.white,
    border: Color(0xFFDDE5E1),
    line: Color(0x269E9E9E),
    appBar: Color.fromARGB(255, 252, 253, 252),
    bubble: Color.fromARGB(255, 236, 232, 232),
    dateChip: Color.fromARGB(255, 230, 231, 230),
    fieldFill: Color(0xFFF5F8F8),
    warning: Color(0xFFFFE0B2),
    brandButton: Color(0xFF388E3C),
    avatarBg: Color(0xFFC8E6C9),
    avatarBgStrong: Color(0xFFA5D6A7),
    dangerSoft: Color(0xFFFFCDD2),
    greys: _lightGreys,
    greens: _lightGreens,
  );

  static const AppColors dark = AppColors._(
    isDark: true,
    background: Color(0xFF0E1513),
    card: Color(0xFF18221F),
    dialog: Color(0xFF18221F),
    heading: Color(0xFFD7F5E6),
    title: Color(0xFFF1F6F3),
    body: Color(0xFFC3D3CC),
    muted: Color(0xFF93A8A0),
    accent: Color(0xFF2E9E57), // brandButton ke barabar
    accentPale: Color(0xFF1E3A2D),
    iconOnPale: Color(0xFFD7F5E6),
    highlight: Color(0xFF16271F),
    surface: Color(0xFF22322C),
    border: Color(0xFF2E3E38),
    line: Color(0x1FFFFFFF),
    appBar: Color(0xFF0E1513),
    bubble: Color(0xFF22302A),
    dateChip: Color(0xFF1B2723),
    fieldFill: Color(0xFF1B2723),
    warning: Color(0xFF3B2F1A),
    brandButton: Color(0xFF2E9E57),
    avatarBg: Color(0xFF1E3A2D),
    avatarBgStrong: Color(0xFF2E5C45),
    dangerSoft: Color(0xFF4A2626),
    greys: _darkGreys,
    greens: _darkGreens,
  );

  // Abhi kaunsa mode chal raha hai, us ke hisaab se rang
  static AppColors get current =>
      ThemeController.instance.isDark ? dark : light;
}