import 'package:shared_preferences/shared_preferences.dart';

class ConnectedAppsService {
  ConnectedAppsService._();
  static final ConnectedAppsService instance = ConnectedAppsService._();

  static const String _key = 'connected_apps';

  Future<List<String>> getConnectedApps() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }

  Future<void> addApps(List<String> apps) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> current = prefs.getStringList(_key) ?? [];
    final List<String> merged = {...current, ...apps}.toList();
    await prefs.setStringList(_key, merged);
  }
}