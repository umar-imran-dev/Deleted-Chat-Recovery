import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'app_config.dart';
import 'core/error_handler.dart';
import 'core/responsive.dart';
import 'l10n/app_localizations.dart';
import 'screens/splash_screen.dart';
import 'services/ads_service.dart';
import 'services/app_settings.dart';
import 'services/billing_service.dart';
import 'services/locale_controller.dart';
import 'theme/app_theme.dart';
import 'theme/theme_controller.dart';

void main() {
  // FIX: ensureInitialized aur runApp ek hi zone mein, aur har uncaught error pakra jata hai
  runZonedGuarded<Future<void>>(() async {
    final WidgetsBinding binding = WidgetsFlutterBinding.ensureInitialized();
    AppErrorHandler.init();
    FlutterNativeSplash.preserve(widgetsBinding: binding);

    // FIX: dark mode aur language runApp se PEHLE load hoti hain (ye SharedPreferences
    // ka tez kaam hai). Pehle runApp ke baad load hoti thi aur MaterialApp dobara
    // build nahi hota tha, is liye saved language / dark mode shuru mein lagti hi nahi thi.
    await _loadLocalSettings();

    runApp(const MyApp());

    // Slow cheezein (Firebase, Play Billing) UI ko nahi rokti
    unawaited(_initSlowServices());
  }, AppErrorHandler.onZoneError);
}

Future<void> _safe(String name, Future<void> Function() task) async {
  try {
    await task();
  } catch (e, s) {
    // Ek service fail ho to baqi app phir bhi chale
    if (kDebugMode) debugPrint('Init failed ($name): $e');
    AppErrorHandler.report(e, s);
  }
}

Future<void> _loadLocalSettings() async {
  await _safe('theme', ThemeController.instance.load);
  await _safe('locale', LocaleController.instance.load);
  await _safe('settings', AppSettings.instance.load);
}

Future<void> _initSlowServices() async {
  await _safe('firebase', () async {
    await Firebase.initializeApp();
  });
  await _safe('billing', BillingService.instance.init);
  // Ads: pehle consent (UMP), phir SDK initialize. Koi masla ho to app phir bhi chale.
  await _safe('ads', AdsService.instance.init);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Sirf theme / language badalne par MaterialApp dobara banta hai
    return ListenableBuilder(
      listenable: Listenable.merge([
        ThemeController.instance,
        LocaleController.instance,
      ]),
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateTitle: (_) => AppConfig.appName,
          // FIX (jank): ThemeData ab cache hota hai (har toggle par ColorScheme.fromSeed
          // dobara nahi chalta), aur MaterialApp ki 200ms theme animation band hai.
          // Screens apne AppColors se turant badalti hain, is liye dono animation
          // ek saath chalne se jo atakna aata tha wo khatam.
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode:
              ThemeController.instance.isDark ? ThemeMode.dark : ThemeMode.light,
          themeAnimationDuration: Duration.zero,
          locale: LocaleController.instance.locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          // Text scale clamp + tablet par content width limit
          builder: (context, child) => AppShell(child: child),
          home: const SplashScreen(),
        );
      },
    );
  }
}