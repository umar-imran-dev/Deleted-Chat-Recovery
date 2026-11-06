import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'billing_service.dart';

/// Ads ka consent (Google UMP) aur AdMob SDK ka initialize.
/// Banner aur interstitial ka code Step 5 mein aayega.
///
/// Tarteeb (Google ki hidayat ke mutabiq):
///  1. Har app launch par consent ki maloomat update karo.
///  2. Zaroorat ho (EU/UK jaise ilaqe) to consent form dikhao.
///  3. Sirf tab SDK initialize karo jab canRequestAds() true ho.
class AdsService extends ChangeNotifier {
  AdsService._();
  static final AdsService instance = AdsService._();

  // Sirf test ke liye: true karne se (debug build mein) phone aisa behave karega jaise EU mein ho
  // aur consent form dikhega. Release se pehle false hi rehne dein.
  static const bool _testEeaConsent = false;

  // Logcat mein "addTestDeviceHashedId(...)" wali ID yahan daalein (sirf _testEeaConsent ke liye)
  static const List<String> _testDeviceIds = <String>[];

  bool _started = false;
  bool _sdkInitialized = false;
  bool _lastCanShow = false;
  bool _privacyOptionsRequired = false;

  /// SDK initialize ho chuka hai, ab ads request ki ja sakti hain
  bool get isReady => _sdkInitialized;

  /// Ads dikhai ja sakti hain ya nahi: SDK tayyar ho AUR user Premium na ho.
  /// Premium khareedte hi ye false ho jata hai aur banner / interstitial band ho jate hain.
  bool get canShowAds => _sdkInitialized && !BillingService.instance.isPremium;

  /// EU/UK ke users ko Settings mein "Ad privacy settings" ka option dikhana zaroori hota hai
  bool get privacyOptionsRequired => _privacyOptionsRequired;

  Future<void> init() async {
    if (_started) return; // sirf ek dafa
    _started = true;

    // Premium ki halat badle (khareedna / restore) to ads foran band ya shuru ho jayein
    BillingService.instance.addListener(_onBillingChanged);

    final Completer<void> done = Completer<void>();
    void finish() {
      if (!done.isCompleted) done.complete();
    }

    try {
      final bool debugEea = kDebugMode && _testEeaConsent;
      if (debugEea) {
        // Pehli install jaisa tajurba dobara dekhne ke liye
        await ConsentInformation.instance.reset();
      }

      final ConsentRequestParameters params = ConsentRequestParameters(
        consentDebugSettings: debugEea
            ? ConsentDebugSettings(
                debugGeography: DebugGeography.debugGeographyEea,
                testIdentifiers: _testDeviceIds,
              )
            : null,
      );

      // 1) Har launch par consent ki maloomat update karo
      ConsentInformation.instance.requestConsentInfoUpdate(
        params,
        () async {
          // 2) Zaroorat ho to form dikhao
          ConsentForm.loadAndShowConsentFormIfRequired((FormError? formError) async {
            if (formError != null) _log('consent form: ${formError.message}');
            await _afterConsent();
            finish();
          });
        },
        (FormError error) async {
          // Error aaye to bhi pichli session ki consent se ads chal sakti hain
          _log('consent update: ${error.message}');
          await _afterConsent();
          finish();
        },
      );

      // Pichli session ki consent mil chuki ho to foran initialize
      // (naye consent ka intezaar nahi karte, Google yehi kehta hai)
      await _initializeSdkIfAllowed();

      await done.future.timeout(const Duration(seconds: 60), onTimeout: () {});
    } catch (e) {
      _log('init error: $e');
      finish();
    }
  }

  Future<void> _afterConsent() async {
    await _refreshPrivacyOptions();
    await _initializeSdkIfAllowed();
  }

  Future<void> _initializeSdkIfAllowed() async {
    if (_sdkInitialized) return;
    try {
      final bool canRequest = await ConsentInformation.instance.canRequestAds();
      if (!canRequest || _sdkInitialized) return;

      // Pehle flag lagao, taake do jagah se ek saath initialize na ho
      _sdkInitialized = true;
      await MobileAds.instance.initialize();
      _log('Ads SDK initialized');
      _lastCanShow = canShowAds;
      notifyListeners();
    } catch (e) {
      _sdkInitialized = false; // dobara koshish ho sake
      _log('SDK initialize error: $e');
    }
  }

  // BillingService bohot dafa notify karta hai, is liye sirf tab aage batao jab
  // "ads dikhani hain ya nahi" ka jawab badle
  void _onBillingChanged() {
    final bool now = canShowAds;
    if (now == _lastCanShow) return;
    _lastCanShow = now;
    _log('canShowAds -> $now');
    notifyListeners();
  }

  Future<void> _refreshPrivacyOptions() async {
    try {
      final PrivacyOptionsRequirementStatus status =
          await ConsentInformation.instance.getPrivacyOptionsRequirementStatus();
      final bool required = status == PrivacyOptionsRequirementStatus.required;
      if (required != _privacyOptionsRequired) {
        _privacyOptionsRequired = required;
        notifyListeners();
      }
    } catch (e) {
      _log('privacy options: $e');
    }
  }

  /// Settings ke "Ad privacy settings" button se bulayein (sirf privacyOptionsRequired par)
  void showPrivacyOptions() {
    ConsentForm.showPrivacyOptionsForm((FormError? formError) {
      if (formError != null) _log('privacy options form: ${formError.message}');
    });
  }

  void _log(String message) {
    if (kDebugMode) debugPrint('AdsService: $message');
  }
}