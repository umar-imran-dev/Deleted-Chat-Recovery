import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class AvatarService {
  AvatarService._();
  static final AvatarService instance = AvatarService._();

  static const MethodChannel _channel = MethodChannel('native_log');

  // Sirf mil chuki tasveeren cache hoti hain
  final Map<String, String> _cache = {};

  // FIX: "tasveer nahi mili" ko hamesha ke liye cache nahi karte (pehle karte the, to
  // baad mein tasveer save hone par bhi nazar nahi aati thi). Sirf thori der ke liye
  // yaad rakhte hain, taake har rebuild par native channel baar baar na bulana paray.
  final Map<String, DateTime> _missUntil = {};
  static const Duration _missTtl = Duration(seconds: 20);

  String _k(String app, String sender) => '$app|$sender';

  /// Foran jawab (FutureBuilder ka initialData), taake rebuild par flicker na ho
  String? cachedPathSync(String app, String sender) => _cache[_k(app, sender)];

  /// Sirf wo path deta hai jo sach mein maujood file ho, is liye UI ko
  /// build ke andar File.existsSync() nahi chalana parta.
  Future<String?> pathFor(String app, String sender) async {
    final String key = _k(app, sender);

    final String? cached = _cache[key];
    if (cached != null) return cached;

    final DateTime? until = _missUntil[key];
    if (until != null && DateTime.now().isBefore(until)) return null;

    try {
      final String? path = await _channel.invokeMethod<String>(
        'getAvatarPath',
        {'app': app, 'sender': sender},
      );
      if (path != null && await File(path).exists()) {
        _cache[key] = path;
        _missUntil.remove(key);
        return path;
      }
    } on PlatformException catch (e) {
      if (kDebugMode) debugPrint('AvatarService.pathFor: ${e.code}');
    } on FileSystemException catch (e) {
      if (kDebugMode) debugPrint('AvatarService.pathFor: ${e.message}');
    } catch (e) {
      if (kDebugMode) debugPrint('AvatarService.pathFor: $e');
    }

    _missUntil[key] = DateTime.now().add(_missTtl);
    return null;
  }

  Future<void> clearAll() async {
    try {
      await _channel.invokeMethod('clearAvatars');
    } catch (e) {
      if (kDebugMode) debugPrint('AvatarService.clearAll: $e');
    }
    _cache.clear();
    _missUntil.clear();
  }
}