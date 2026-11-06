import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../core/ads_config.dart';
import '../services/ads_service.dart';

/// Chat list ke neeche ka adaptive banner.
///
/// Ye widget hamesha tree mein rehta hai aur `visible` se chhupta / dikhta hai, taake tab
/// badalne par ad baar baar dobara na mangni paray (zyada requests Google ki policy ke khilaf hain).
class BannerAdView extends StatefulWidget {
  const BannerAdView({super.key, this.visible = true});

  final bool visible;

  @override
  State<BannerAdView> createState() => _BannerAdViewState();
}

class _BannerAdViewState extends State<BannerAdView> {
  // Ad load na ho to itni der baad dobara koshish
  static const Duration _retryDelay = Duration(seconds: 60);

  BannerAd? _ad;
  bool _loaded = false;
  bool _loading = false;
  int _width = 0;
  Timer? _retry;

  @override
  void initState() {
    super.initState();
    AdsService.instance.addListener(_onAdsChanged);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Content ki asli chaurai (AppShell tablet par 640 tak rokta hai)
    _width = MediaQuery.sizeOf(context).width.truncate();
    _maybeLoad();
  }

  @override
  void didUpdateWidget(covariant BannerAdView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.visible && !oldWidget.visible) _maybeLoad();
  }

  @override
  void dispose() {
    _retry?.cancel();
    AdsService.instance.removeListener(_onAdsChanged);
    _ad?.dispose();
    super.dispose();
  }

  void _onAdsChanged() {
    if (!mounted) return;
    // Premium ho gaya ho to maujooda ad bhi hata do (memory aur requests bachti hain)
    if (!AdsService.instance.canShowAds && _ad != null) {
      _retry?.cancel();
      _ad?.dispose();
      _ad = null;
      _loaded = false;
      _loading = false;
    }
    _maybeLoad();
    setState(() {});
  }

  Future<void> _maybeLoad() async {
    if (!mounted || _loading || _ad != null) return;
    if (!widget.visible || !AdsService.instance.canShowAds || _width <= 0) {
      return;
    }

    _loading = true;
    try {
      final AnchoredAdaptiveBannerAdSize? size =
          await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
            _width,
          );
      if (!mounted || size == null) {
        _loading = false;
        return;
      }

      final BannerAd ad = BannerAd(
        adUnitId: AdsConfig.bannerUnitId,
        size: size,
        request: const AdRequest(),
        listener: BannerAdListener(
          onAdLoaded: (Ad ad) {
            _loading = false;
            if (!mounted) {
              ad.dispose();
              return;
            }
            setState(() => _loaded = true);
          },
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            ad.dispose();
            _loading = false;
            _ad = null;
            _loaded = false;
            if (!mounted) return;
            setState(() {});
            // Net na ho ya ad na mile to thori der baad dobara
            _retry?.cancel();
            _retry = Timer(_retryDelay, _maybeLoad);
          },
        ),
      );
      _ad = ad;
      await ad.load();
    } catch (_) {
      _loading = false;
      _ad?.dispose();
      _ad = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final BannerAd? ad = _ad;
    if (!widget.visible ||
        !_loaded ||
        ad == null ||
        !AdsService.instance.canShowAds) {
      return const SizedBox.shrink();
    }

    // Ad ke upar neeche thori jagah, taake galti se click na ho
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: SizedBox(
        width: ad.size.width.toDouble(),
        height: ad.size.height.toDouble(),
        child: AdWidget(ad: ad),
      ),
    );
  }
}