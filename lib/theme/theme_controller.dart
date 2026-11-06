import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends ChangeNotifier {
  ThemeController._();
  static final ThemeController instance = ThemeController._();

  static const String _key = 'dark_mode';
  bool _dark = false;

  bool get isDark => _dark;

  Future<void> load() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      _dark = prefs.getBool(_key) ?? false;
    } catch (e) {
      // Prefs na parh sakein to light mode par chalo, crash nahi
      if (kDebugMode) debugPrint('ThemeController.load: $e');
    }
    // FIX: load ke baad listeners ko batana
    notifyListeners();
  }

  Future<void> setDark(bool value) async {
    if (_dark == value) return;
    _dark = value;
    notifyListeners(); // UI pehle badalta hai, disk ka intezaar nahi
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_key, value);
    } catch (e) {
      if (kDebugMode) debugPrint('ThemeController.setDark: $e');
    }
  }
}