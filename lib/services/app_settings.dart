import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings extends ChangeNotifier {
  AppSettings._();
  static final AppSettings instance = AppSettings._();

  static const MethodChannel _channel = MethodChannel('native_log');
  static const String _saveAvatarsKey = 'save_avatars';

  bool _saveAvatars = true;
  bool get saveAvatars => _saveAvatars;

  Future<void> load() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _saveAvatars = prefs.getBool(_saveAvatarsKey) ?? true;
    await _syncToNative();
  }

  Future<void> setSaveAvatars(bool value) async {
    _saveAvatars = value;
    notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_saveAvatarsKey, value);
    await _syncToNative();
  }

  // Kotlin ki service ko bhi batana parta hai, kyunke tasveer wahi save karti hai
  Future<void> _syncToNative() async {
    try {
      await _channel.invokeMethod('setSaveAvatars', {'value': _saveAvatars});
    } catch (_) {}
  }
}