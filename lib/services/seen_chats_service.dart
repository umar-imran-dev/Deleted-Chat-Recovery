import 'package:shared_preferences/shared_preferences.dart';

class SeenChatsService {
  SeenChatsService._();
  static final SeenChatsService instance = SeenChatsService._();

  static const String _key = 'seen_chats_v2';
  Map<String, int> _lastSeenAt = {};
  bool _loaded = false;

  String _k(String app, String sender) => '$app|$sender';

  Future<void> preload() async {
    if (_loaded) return;
    final prefs = await SharedPreferences.getInstance();
    final List<String> raw = prefs.getStringList(_key) ?? [];
    final Map<String, int> map = {};
    for (final line in raw) {
      final int sep = line.lastIndexOf('=');
      if (sep == -1) continue;
      final String key = line.substring(0, sep);
      final int? value = int.tryParse(line.substring(sep + 1));
      if (value != null) map[key] = value;
    }
    _lastSeenAt = map;
    _loaded = true;
  }

  // Is chat ko aakhri baar kab dekha gaya (milliseconds), ya kabhi nahi to null
  int? lastSeenAtSync(String app, String sender) =>
      _lastSeenAt[_k(app, sender)];

  bool isSeenSync(String app, String sender) =>
      _lastSeenAt.containsKey(_k(app, sender));

  Future<void> markSeen(String app, String sender) async {
    await preload();
    _lastSeenAt[_k(app, sender)] = DateTime.now().millisecondsSinceEpoch;
    final prefs = await SharedPreferences.getInstance();
    final List<String> lines = _lastSeenAt.entries
        .map((e) => '${e.key}=${e.value}')
        .toList();
    await prefs.setStringList(_key, lines);
  }

  Future<void> clear() async {
    _lastSeenAt = {};
    _loaded = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
