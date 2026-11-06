import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../core/ads_config.dart';
import 'ads_service.dart';

/// Status save hone ke baad kabhi kabhi (har AdsConfig.savesPerInterstitial dafa) ek
/// interstitial dikhata hai. Ad pehle se load rakhta hai, taake dikhane mein der na lage.
class InterstitialAdManager {
  InterstitialAdManager._() {
    AdsService.instance.addListener(_onAdsChanged);
  }
  static final InterstitialAdManager instance = InterstitialAdManager._();

  InterstitialAd? _ad;
  bool _loading = false;
  int _saveCount = 0;
  DateTime? _lastShown;

  // Premium ho gaya ho to load ki hui ad fenk do
  void _onAdsChanged() {
    if (!AdsService.instance.canShowAds) {
      _ad?.dispose();
      _ad = null;
    }
  }

  /// Ad pehle se load kar lo (Status tab khulte hi, aur har ad ke baad)
  void preload() {
    if (_ad != null || _loading) return;
    if (!AdsService.instance.canShowAds) return;

    _loading = true;
    InterstitialAd.load(
      adUnitId: AdsConfig.interstitialUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _ad = ad;
          _loading = false;
        },
        onAdFailedToLoad: (LoadAdError error) {
          _loading = false;
          _log('interstitial load: ${error.message}');
        },
      ),
    );
  }

  /// Har KAMYAB status save ke baad bulayein.
  Future<void> onStatusSaved() async {
    if (!AdsService.instance.canShowAds) return;

    _saveCount++;
    if (_saveCount < AdsConfig.savesPerInterstitial) {
      preload(); // agli baar ke liye tayyar rakho
      return;
    }

    final InterstitialAd? ad = _ad;
    if (ad == null) {
      // Ad abhi load nahi hui, agle save par dikha denge (count wahi rehta hai)
      preload();
      return;
    }

    final DateTime? last = _lastShown;
    if (last != null &&
        DateTime.now().difference(last) < AdsConfig.minGapBetweenInterstitials) {
      return; // abhi abhi ek ad dikhi hai
    }

    _saveCount = 0;
    _ad = null;
    _lastShown = DateTime.now();

    ad.fullScreenContentCallback = FullScreenContentCallback<InterstitialAd>(
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        ad.dispose();
        preload();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        _log('interstitial show: ${error.message}');
        ad.dispose();
        preload();
      },
    );

    // Pehle "Saved" ka tick / snackbar nazar aa jaye, phir ad
    await Future<void>.delayed(const Duration(milliseconds: 700));
    try {
      await ad.show();
    } catch (e) {
      _log('interstitial show error: $e');
      ad.dispose();
      preload();
    }
  }

  void _log(String message) {
    if (kDebugMode) debugPrint('InterstitialAdManager: $message');
  }
}