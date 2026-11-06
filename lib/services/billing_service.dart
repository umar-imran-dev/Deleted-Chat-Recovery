import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BillingService extends ChangeNotifier {
  BillingService._();
  static final BillingService instance = BillingService._();

  // Play Console mein jo Product ID rakhi hai, bilkul wahi likho
  static const String premiumProductId = 'premium_monthly';
  static const String _premiumKey = 'is_premium';

  final InAppPurchase _iap = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? _subscription;

  bool storeAvailable = false;
  bool isPremium = false;
  bool isLoading = false;
  ProductDetails? product;
  String? errorMessage;

  Future<void> init() async {
    // Purchase stream ko app shuru hote hi sunna zaroori hai, warna adhoori
    // payments ke updates miss ho sakte hain. FIX: listener do dafa nahi lagta.
    _subscription ??= _iap.purchaseStream.listen(
      _onPurchaseUpdates,
      onError: (Object e) {
        errorMessage = e.toString();
        isLoading = false;
        notifyListeners();
      },
    );

    // FIX: store ya prefs fail hon to app crash na ho
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      isPremium = prefs.getBool(_premiumKey) ?? false;
      notifyListeners();

      storeAvailable = await _iap.isAvailable();
      if (storeAvailable) {
        await _loadProduct();
        await _iap.restorePurchases();
      }
    } catch (e) {
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<void> _loadProduct() async {
    try {
      final ProductDetailsResponse response = await _iap.queryProductDetails({
        premiumProductId,
      });
      if (response.error != null) {
        errorMessage = response.error!.message;
        return;
      }
      if (response.productDetails.isEmpty) {
        // FIX: user ko dikhne wale errors English mein
        errorMessage = 'Plan not found. Check the Product ID in Play Console.';
        return;
      }
      product = response.productDetails.first;
    } catch (e) {
      errorMessage = e.toString();
    }
  }

  Future<void> buyPremium() async {
    final ProductDetails? p = product;
    if (p == null) {
      errorMessage = 'The plan is still loading. Please try again.';
      notifyListeners();
      return;
    }

    errorMessage = null;
    isLoading = true;
    notifyListeners();

    try {
      final bool started = await _iap.buyNonConsumable(
        purchaseParam: PurchaseParam(productDetails: p),
      );
      if (!started) {
        isLoading = false;
        errorMessage = 'Could not start the payment.';
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> restore() async {
    errorMessage = null;
    try {
      await _iap.restorePurchases();
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> _onPurchaseUpdates(List<PurchaseDetails> purchases) async {
    for (final PurchaseDetails p in purchases) {
      try {
        if (p.productID == premiumProductId) {
          switch (p.status) {
            case PurchaseStatus.pending:
              isLoading = true;
              break;
            case PurchaseStatus.purchased:
            case PurchaseStatus.restored:
              await _setPremium(true);
              isLoading = false;
              break;
            case PurchaseStatus.error:
              isLoading = false;
              errorMessage = p.error?.message ?? 'Payment failed.';
              break;
            case PurchaseStatus.canceled:
              isLoading = false;
              break;
          }
        }

        // Purchase ko "complete" karna zaroori hai. Android par ye acknowledge
        // karta hai, aur 3 din tak acknowledge na ho to Google paisay wapas kar deta hai.
        // FIX: ek purchase fail ho to baqi purchases na rukein.
        if (p.pendingCompletePurchase) {
          await _iap.completePurchase(p);
        }
      } catch (e) {
        isLoading = false;
        errorMessage = e.toString();
      }
    }
    notifyListeners();
  }

  Future<void> _setPremium(bool value) async {
    isPremium = value;
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_premiumKey, value);
    } catch (e) {
      if (kDebugMode) debugPrint('BillingService._setPremium: $e');
    }
  }

  /// Sirf TEST ke liye (debug build mein): bina payment ke Premium on/off karo.
  /// Release build mein ye kuch nahi karta. Test ke baad iska istemal hata dein.
  Future<void> debugSetPremium(bool value) async {
    if (!kDebugMode) return;
    await _setPremium(value);
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _subscription = null;
    super.dispose();
  }
}

// NOTE: isPremium abhi sirf phone par SharedPreferences mein hai. Subscription
// expire ya cancel hone par ye apne aap false nahi hota. Iske liye Google Play
// Developer API se server-side verification chahiye.