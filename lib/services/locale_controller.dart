import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguage {
  final String code;
  final String name; // English naam (language screen par dikhta hai)
  final String nativeName; // Apni zabaan mein naam (search aur Settings ke liye)
  final String flag;

  const AppLanguage(this.code, this.name, this.nativeName, this.flag);
}

class LocaleController extends ChangeNotifier {
  LocaleController._();
  static final LocaleController instance = LocaleController._();

  static const String _key = 'app_language';

  static const List<AppLanguage> languages = [
    AppLanguage('en', 'English', 'English', '🇬🇧'),
    AppLanguage('ur', 'Urdu', 'اردو', '🇵🇰'),
    AppLanguage('ar', 'Arabic', 'العربية', '🇸🇦'),
    AppLanguage('hi', 'Hindi', 'हिन्दी', '🇮🇳'),
    AppLanguage('es', 'Spanish', 'Español', '🇪🇸'),
    AppLanguage('fr', 'French', 'Français', '🇫🇷'),
    AppLanguage('de', 'German', 'Deutsch', '🇩🇪'),
    AppLanguage('pt', 'Portuguese', 'Português', '🇵🇹'),
    AppLanguage('ru', 'Russian', 'Русский', '🇷🇺'),
    AppLanguage('zh', 'Chinese (Simplified)', '简体中文', '🇨🇳'),
  ];

  // null = user ne kuch nahi chuna, phone ki zabaan chalegi
  String? _code;

  String? get code => _code;

  Locale? get locale => _code == null ? null : Locale(_code!);

  static String nativeNameFor(String code) {
    for (final AppLanguage l in languages) {
      if (l.code == code) return l.nativeName;
    }
    return code;
  }

  Future<void> load() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? saved = prefs.getString(_key);
      _code = languages.any((l) => l.code == saved) ? saved : null;
    } catch (e) {
      // Prefs na parh sakein to phone ki zabaan chalegi
      debugPrint('LocaleController.load: $e');
    }
    // FIX: pehle yahan notifyListeners nahi tha
    notifyListeners();
  }

  Future<void> setLanguage(String? code) async {
    if (_code == code) return;
    _code = code;
    notifyListeners();
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if (code == null) {
        await prefs.remove(_key);
      } else {
        await prefs.setString(_key, code);
      }
    } catch (e) {
      debugPrint('LocaleController.setLanguage: $e');
    }
  }
}