/// Ads ki IDs aur settings ek hi jagah.
class AdsConfig {
  AdsConfig._();

  /// true = Google ke test ads (development mein hamesha yahi rakhein).
  /// Step 7 mein asli IDs bhar kar false karenge.
  ///
  /// WARNING: asli ads par khud kabhi click na karein, account ban ho sakta hai.
  static const bool useTestAds = true;

  // ---- Google ke test ad units (Android) ----
  static const String _testBanner = 'ca-app-pub-3940256099942544/9214589741';
  static const String _testInterstitial =
      'ca-app-pub-3940256099942544/1033173712';

  // ---- Aap ki asli ad unit IDs (Step 7 mein yahan likhni hain) ----
  static const String _realBanner = 'ca-app-pub-XXXXXXXXXXXXXXXX/YYYYYYYYYY';
  static const String _realInterstitial =
      'ca-app-pub-XXXXXXXXXXXXXXXX/ZZZZZZZZZZ';

  static String get bannerUnitId => useTestAds ? _testBanner : _realBanner;

  static String get interstitialUnitId =>
      useTestAds ? _testInterstitial : _realInterstitial;

  /// Status har kitni dafa save hone par ek interstitial dikhe
  static const int savesPerInterstitial = 3;

  /// Do interstitial ke beech kam az kam itna waqt (user ko tang na karein)
  static const Duration minGapBetweenInterstitials = Duration(minutes: 2);
}