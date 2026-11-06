import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Saare uncaught errors ek hi jagah se guzarte hain.
///
/// Teen raaste band kiye gaye hain:
///  1. FlutterError.onError          -> build / layout / paint ke errors
///  2. PlatformDispatcher.onError    -> framework ke bahar ke async errors
///  3. runZonedGuarded (main.dart)   -> zone ke andar ke baqi errors
///
/// NOTE: Privacy Policy kehti hai ke koi data bahar nahi jata, is liye yahan
/// Crashlytics waghera nahi lagaya. Release mein error chupchap pakra jata hai,
/// debug mein console par dikhta hai.
class AppErrorHandler {
  AppErrorHandler._();

  static void init() {
    FlutterError.onError = (FlutterErrorDetails details) {
      if (kDebugMode) FlutterError.presentError(details);
      report(details.exception, details.stack);
    };

    PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
      report(error, stack);
      return true; // "handle ho gaya": app band nahi hogi
    };

    // Release mein widget fail ho to bhaddi grey/laal screen ki jagah chhota message
    ErrorWidget.builder = (FlutterErrorDetails details) {
      if (kDebugMode) return ErrorWidget(details.exception);
      return const _FallbackError();
    };
  }

  /// runZonedGuarded ka onError
  static void onZoneError(Object error, StackTrace stack) =>
      report(error, stack);

  /// Kahin se bhi manual report ke liye (try/catch ke andar)
  static void report(Object error, StackTrace? stack) {
    if (kDebugMode) debugPrint('Unhandled error: $error\n$stack');
  }
}

class _FallbackError extends StatelessWidget {
  const _FallbackError();

  @override
  Widget build(BuildContext context) {
    // Yahan Directionality/Theme maujood nahi bhi ho sakti, is liye khud di hai
    return const Directionality(
      textDirection: TextDirection.ltr,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Something went wrong',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF6B7F78),
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }
}