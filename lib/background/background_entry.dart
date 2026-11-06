import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/message_processor.dart';

const MethodChannel _channel = MethodChannel('background_channel');

// Log mein message ka text ya sender ka naam nahi likhte, sirf halat
void _log(String line) {
  try {
    _channel.invokeMethod('log', {'line': line});
  } catch (_) {
    // log fail hone se kuch nahi rukna chahiye
  }
}

final MessageProcessor _processor = MessageProcessor();

@pragma('vm:entry-point')
void backgroundMain() {
  WidgetsFlutterBinding.ensureInitialized();
  // FIX: background isolate mein plugins (shared_preferences waghera) register hon
  DartPluginRegistrant.ensureInitialized();

  _channel.setMethodCallHandler((call) async {
    // FIX: ek event kharab ho to error native service tak na jaye
    try {
      switch (call.method) {
        case 'ping':
          return 'pong from dart background isolate';

        case 'posted':
          final Map<dynamic, dynamic> args =
              call.arguments as Map<dynamic, dynamic>;
          final String app = (args['app'] as String? ?? 'WhatsApp').trim();
          final String sender = (args['sender'] as String? ?? '').trim();
          final String text = (args['text'] as String? ?? '').trim();
          final List<dynamic> rawItems =
              args['messages'] as List<dynamic>? ?? [];
          final List<Map<dynamic, dynamic>> items =
              rawItems.whereType<Map<dynamic, dynamic>>().toList();
          _log('DART: posted app=$app count=${items.length}');
          if (sender.isNotEmpty) {
            await _processor.handlePosted(app, sender, text, items);
          }
          return true;

        case 'removed':
          final Map<dynamic, dynamic> args =
              call.arguments as Map<dynamic, dynamic>;
          final String app = (args['app'] as String? ?? 'WhatsApp').trim();
          final String sender = (args['sender'] as String? ?? '').trim();
          final int reason = (args['reason'] as int?) ?? 0;
          final bool idle = (args['idle'] as bool?) ?? false;
          _log('DART: removed app=$app reason=$reason idle=$idle');
          if (sender.isNotEmpty) {
            await _processor.onRemoved(app, sender, reason, idle, false);
          }
          return true;

        default:
          return null;
      }
    } catch (e) {
      _log('DART: ${call.method} error=${e.runtimeType}');
      return false;
    }
  });

  _channel.invokeMethod('ready');
}