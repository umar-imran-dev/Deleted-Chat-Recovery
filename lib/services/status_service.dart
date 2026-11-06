

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatusItem {
  final String uri;
  final String name;
  final String mime;
  final int modified;

  const StatusItem({
    required this.uri,
    required this.name,
    required this.mime,
    required this.modified,
  });

  bool get isVideo => mime.startsWith('video/');
  bool get isAudio => mime.startsWith('audio/');
}

class StatusService {
  StatusService._();
  static final StatusService instance = StatusService._();

  static const String whatsapp = 'whatsapp';
  static const String business = 'business';

  static const MethodChannel _channel = MethodChannel('status_channel');
  static const String _savedKey = 'saved_status_names';

  // Thumbnail dobara dobara na banani paren
  final Map<String, Future<Uint8List?>> _thumbs = {};

  // "ok", "cancelled" ya "wrong_folder"
  Future<String> pickFolder(String kind) async {
    try {
      return await _channel.invokeMethod<String>('pickFolder', {'kind': kind}) ??
          'cancelled';
    } catch (_) {
      return 'cancelled';
    }
  }

  // null = folder abhi chuna nahi gaya (ya permission chali gayi)
  Future<List<StatusItem>?> list(String kind) async {
    try {
      final List<Map<dynamic, dynamic>>? raw =
          await _channel.invokeListMethod<Map<dynamic, dynamic>>('list', {
        'kind': kind,
      });
      if (raw == null) return null;
      return raw
          .map(
            (m) => StatusItem(
              uri: m['uri'] as String,
              name: m['name'] as String,
              mime: m['mime'] as String,
              modified: (m['modified'] as num).toInt(),
            ),
          )
          .toList();
    } catch (e) {
      if (kDebugMode) debugPrint('StatusService.list: $e');
      return null;
    }
  }

  Future<Uint8List?> thumbnail(StatusItem item) {
    if (_thumbs.length > 300) _thumbs.clear();
    return _thumbs.putIfAbsent(item.uri, () async {
      final Uint8List? bytes = await _bytes(item, 360);
      // FIX: fail hui thumbnail cache mein na reh jaye, dobara koshish ho sake
      if (bytes == null) _thumbs.remove(item.uri);
      return bytes;
    });
  }

  Future<Uint8List?> image(StatusItem item) => _bytes(item, 2048);

  Future<Uint8List?> _bytes(StatusItem item, int maxPx) async {
    try {
      return await _channel.invokeMethod<Uint8List>('bytes', {
        'uri': item.uri,
        'mime': item.mime,
        'maxPx': maxPx,
      });
    } catch (_) {
      return null;
    }
  }

  Future<bool> save(StatusItem item) async {
    try {
      final bool ok = await _channel.invokeMethod<bool>('save', {
            'uri': item.uri,
            'name': item.name,
            'mime': item.mime,
          }) ??
          false;
      if (ok) await _markSaved(item.name);
      return ok;
    } catch (_) {
      return false;
    }
  }

  // Jo status save ho chuke, unke naam (tile par tick dikhane ke liye)
  Future<Set<String>> savedNames() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return (prefs.getStringList(_savedKey) ?? <String>[]).toSet();
    } catch (_) {
      // FIX: prefs na parh sakein to khali set, crash nahi
      return <String>{};
    }
  }

  Future<void> _markSaved(String name) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final List<String> names = List<String>.from(
        prefs.getStringList(_savedKey) ?? <String>[],
      );
      if (!names.contains(name)) names.add(name);
      // Purane naam hata do, list barhti na jaye
      final List<String> trimmed =
          names.length > 500 ? names.sublist(names.length - 500) : names;
      await prefs.setStringList(_savedKey, trimmed);
    } catch (e) {
      if (kDebugMode) debugPrint('StatusService._markSaved: $e');
    }
  }
}