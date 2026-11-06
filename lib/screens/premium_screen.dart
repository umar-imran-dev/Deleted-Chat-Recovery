import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../l10n/app_localizations.dart';
import '../services/app_actions.dart';
import '../services/billing_service.dart';
import '../theme/app_colors.dart';
import '../theme/theme_controller.dart';

// Sirf tab true karein jab Play Console mein subscription par free trial wala offer
// sach mein bana ho. Warna "Start free trial" likhna Play ki policy ke khilaf hai.
const bool _offersFreeTrial = false;

// Premium screen ke rang: light mein aap ke asli rang, dark mein unke dark roop
class _P {
  final bool dark;
  const _P(this.dark);

  static const Color green = Color(0xFF388E3C); // brand green (sab screens ke barabar)

  // Bottom nav wala green color (dynamic theme color)
  Color get navGreen => AppColors.current.green(600);

  Color get ink => dark ? const Color(0xFFE6F2EC) : const Color(0xFF102B2C);
  Color get muted => dark ? const Color(0xFF93A8A0) : const Color(0xFF8A9A9B);
  Color get paleGreen =>
      dark ? const Color(0xFF1E3A2D) : const Color(0xFFE8F5E9);
  Color get line => dark ? const Color(0xFF2A3A34) : const Color(0xFFEDF3F1);
  Color get bg => dark ? const Color(0xFF0E1513) : const Color(0xFFFCFEFD);
  Color get card => dark ? const Color(0xFF18221F) : Colors.white;
  Color get header => dark ? const Color(0xFF1B2823) : const Color(0xFFF7FCFA);
  Color get pillActive =>
      dark ? const Color(0xFF1E3A2D) : const Color(0xFFC8E6C9);
  Color get pillInactive =>
      dark ? const Color(0xFF22302B) : const Color(0xFFF0F3F2);
  Color get priceCard =>
      dark ? const Color(0xFF16271F) : const Color(0xFFE8F5E9);
  Color get priceText =>
      dark ? const Color(0xFF7BE0AE) : const Color(0xFF2E7D32);
  Color get minus => dark ? const Color(0xFF4A5C55) : const Color(0xFFB8C7C5);
  Color get tableShadow => dark ? Colors.transparent : const Color(0x080C6650);

  // Star ke peeche ki halki roshan jagah (halki green)
  Color get starGlow =>
      dark ? const Color(0xFF143A2C) : const Color(0xFFE8F5E9);
}

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen>
    with SingleTickerProviderStateMixin {
  // Header aur rows dono isi width ko use karenge => columns align
  static const double colW = 64;
  static const double rowH = 52;

  // Star ki animation ka ek chakkar kitni der ka ho (barha do to dheeri ho jayegi)
  static const Duration _starSpeed = Duration(milliseconds: 2200);

  // basic: true => Basic plan mein bhi check dikhega
  List<_PremiumFeature> _features(AppLocalizations t) => [
    _PremiumFeature(
      t.premiumSaveAnyStatus,
      LucideIcons.download,
      basic: true,
    ),
    _PremiumFeature(t.premiumRecoverMedia, LucideIcons.image),
    _PremiumFeature(t.premiumRemoveAds, LucideIcons.ban),
    _PremiumFeature(
      t.premiumPrioritySupport,
      LucideIcons.headphones,
      basic: true,
    ),
    _PremiumFeature(t.premiumUnlimitedRecovery, LucideIcons.database),
  ];

  bool _showClose = false;
  Timer? _timer;
  late final AnimationController _starController;

  // Jo error user ko dikha chuke hain (wahi error baar baar na dikhe)
  String? _shownError;

  @override
  void initState() {
    super.initState();
    // Star hamesha upar neeche chalta rahe (aage-peeche)
    _starController = AnimationController(vsync: this, duration: _starSpeed)
      ..repeat(reverse: true);

    // 2 second baad cross dikhao
    _timer = Timer(const Duration(seconds: 2), () {
      if (mounted) setState(() => _showClose = true);
    });

    // FIX: payment ka nateeja stream se baad mein aata hai, is liye billing ko sunna zaroori hai
    BillingService.instance.addListener(_onBilling);
  }

  @override
  void dispose() {
    BillingService.instance.removeListener(_onBilling);
    _timer?.cancel();
    _starController.dispose();
    super.dispose();
  }

  // FIX: payment fail ya error aaye to snackbar, aur wahi error dobara nahi
  void _onBilling() {
    if (!mounted) return;
    final String? message = BillingService.instance.errorMessage;
    if (message == null) {
      _shownError = null;
      return;
    }
    if (message != _shownError) {
      _shownError = message;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // FIX: ab theme ke saath BillingService bhi suni jati hai (loading, premium, price)
    return ListenableBuilder(
      listenable: Listenable.merge([
        ThemeController.instance,
        BillingService.instance,
      ]),
      builder: (context, _) {
        final _P p = _P(AppColors.current.isDark);
        final AppLocalizations t = AppLocalizations.of(context)!;
        final BillingService billing = BillingService.instance;

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: p.dark
              ? SystemUiOverlayStyle.light
              : SystemUiOverlayStyle.dark,
          child: Scaffold(
            backgroundColor: p.bg,
            body: SafeArea(
              // Lamba text (German, Russian) ho to screen scroll ho sake
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(18, 24, 18, 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ---------- Close (cross), right side, 2 sec baad ----------
                    SizedBox(
                      height: 28,
                      child: Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: AnimatedOpacity(
                          opacity: _showClose ? 1 : 0,
                          duration: const Duration(milliseconds: 300),
                          child: IgnorePointer(
                            ignoring: !_showClose,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              onPressed: () => Navigator.of(context).maybePop(),
                              icon: Icon(LucideIcons.x, color: p.ink, size: 24),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    _hero(p, t),
                    const SizedBox(height: 18),
                    _comparisonTable(p, t),
                    const SizedBox(height: 12),

                    // FIX: Premium ho chuka ho to khareedne ka button nahi, shukriya ka card
                    if (billing.isPremium)
                      _activeCard(p, t)
                    else ...[
                      _priceCard(p, t, billing),
                      const SizedBox(height: 10),
                      _buyButton(t, billing),
                    ],
                    const SizedBox(height: 8),
                    Text(
                      t.autoRenewNote,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: p.muted,
                        fontSize: 11,
                        height: 1.3,
                      ),
                    ),

                    // FIX: Restore aur Privacy Policy (Play subscription policy ke liye zaroori)
                    Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        TextButton(
                          onPressed: billing.isLoading
                              ? null
                              : () => billing.restore(),
                          child: Text(
                            t.restorePurchases,
                            style: TextStyle(color: p.muted, fontSize: 12),
                          ),
                        ),
                        TextButton(
                          onPressed: () => AppActions.openPrivacyPolicy(context),
                          child: Text(
                            t.privacyPolicy,
                            style: TextStyle(color: p.muted, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // ---------------- HERO (animated star) ----------------
  Widget _hero(_P p, AppLocalizations t) {
    return Column(
      children: [
        SizedBox(
          width: 150,
          height: 136,
          child: AnimatedBuilder(
            animation: _starController,
            builder: (context, _) {
              // v: 0 se 1 aur wapas 1 se 0 (aage-peeche), narm raftaar ke saath
              final double v = Curves.easeInOut.transform(_starController.value);

              final double floatY = -8 + 16 * v; // upar neeche
              final double scale = 0.94 + 0.14 * v; // dhadakna
              final double angle = -0.10 + 0.20 * v; // zara sa ghoomna

              return Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  // Peeche halki roshan gol jagah
                  Container(
                    width: 112,
                    height: 112,
                    decoration: BoxDecoration(
                      color: p.starGlow,
                      shape: BoxShape.circle,
                    ),
                  ),

                  // Aas paas jhilmilate chhote star
                  Positioned(top: 10, right: 16, child: _sparkle(15, v)),
                  Positioned(bottom: 16, left: 12, child: _sparkle(11, 1 - v)),
                  Positioned(top: 26, left: 18, child: _sparkle(9, v)),

                  // Bara star
                  Transform.translate(
                    offset: Offset(0, floatY),
                    child: Transform.rotate(
                      angle: angle,
                      child: Transform.scale(
                        scale: scale,
                        child: Icon(
                          Icons.star_rounded,
                          size: 86,
                          color: p.navGreen,
                          shadows: [
                            Shadow(
                              color: p.navGreen.withValues(alpha: 0.45),
                              blurRadius: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 4),
        Text(
          t.goPremium,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: p.ink,
            fontSize: 26,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          t.goPremiumSubtitle,
          textAlign: TextAlign.center,
          style: TextStyle(color: p.muted, fontSize: 13, height: 1.35),
        ),
      ],
    );
  }

  // Chhota jhilmilata star: t (0..1) ke hisaab se roshan aur bara chhota hota hai
  Widget _sparkle(double size, double t) {
    return Opacity(
      opacity: 0.25 + 0.75 * t,
      child: Transform.scale(
        scale: 0.7 + 0.5 * t,
        // Chhote stars ka color bhi wahi bottom nav wala green
        child: Icon(
          Icons.star_rounded,
          size: size,
          color: AppColors.current.green(600),
        ),
      ),
    );
  }

  // ---------------- TABLE ----------------
  Widget _comparisonTable(_P p, AppLocalizations t) {
    final List<_PremiumFeature> features = _features(t);

    return Container(
      decoration: BoxDecoration(
        color: p.card,
        border: Border.all(color: p.line),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: p.tableShadow,
            blurRadius: 14,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: p.header,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(17),
              ),
            ),
            child: Row(
              children: [
                const Expanded(child: SizedBox()),
                _pillHeader(p, t.planPro, active: true),
                _pillHeader(p, t.planBasic, active: false),
              ],
            ),
          ),

          // Rows
          for (int i = 0; i < features.length; i++) ...[
            SizedBox(
              height: rowH,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: p.paleGreen,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(features[i].icon, color: _P.green, size: 17),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        features[i].title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: p.ink,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                        ),
                      ),
                    ),
                    // Pro column, hamesha check
                    const SizedBox(
                      width: colW,
                      child: Center(
                        child: Icon(
                          LucideIcons.check,
                          color: _P.green,
                          size: 19,
                        ),
                      ),
                    ),
                    // Basic column, sirf basic: true wali rows par check
                    SizedBox(
                      width: colW,
                      child: Center(
                        child: features[i].basic
                            ? const Icon(
                                LucideIcons.check,
                                color: _P.green,
                                size: 19,
                              )
                            : Icon(LucideIcons.minus, color: p.minus, size: 17),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (i != features.length - 1)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Divider(height: 1, color: p.line),
              ),
          ],
        ],
      ),
    );
  }

  Widget _pillHeader(_P p, String label, {required bool active}) {
    return SizedBox(
      width: colW,
      child: Center(
        child: Container(
          width: colW - 8,
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: active ? p.pillActive : p.pillInactive,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: active ? _P.green : p.muted,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- PRICE CARD ----------------
  Widget _priceCard(_P p, AppLocalizations t, BillingService billing) {
    // FIX: pehle yahan 'Rs 3,350.00' likha hua tha. Ab Google Play se aayi asli qeemat.
    final String? price = billing.product?.price;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        color: p.priceCard,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 26,
            child: Icon(LucideIcons.crown, color: _P.green, size: 22),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  price == null
                      ? t.premiumPriceUnavailable
                      : t.premiumPriceLine(price),
                  style: TextStyle(
                    color: p.priceText,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                if (_offersFreeTrial) ...[
                  const SizedBox(height: 2),
                  Text(
                    t.premiumTrialNote,
                    style: TextStyle(color: p.muted, fontSize: 11),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Premium ho chuka ho to
  Widget _activeCard(_P p, AppLocalizations t) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: p.priceCard,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(LucideIcons.crown, color: _P.green, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              t.youArePremium,
              style: TextStyle(
                color: p.priceText,
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- BUTTON ----------------
  // Bilkul Status tab ke "Allow access" button jaisa: poori width, height 52,
  // radius 14, accent rang, bina shadow ke
  Widget _buyButton(AppLocalizations t, BillingService billing) {
    final AppColors c = AppColors.current;
    // FIX: button ab sirf payment chalte waqt band hota hai. Plan load na hua ho to bhi
    // button hara rehta hai aur dabane par message aata hai ("plan abhi load nahi hua").
    // Pehle plan na milne par button disable ho kar grey ho jata tha.
    final bool enabled = !billing.isLoading;

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        // Nateeja (error ya kamyabi) _onBilling aur billing ki state se aata hai
        onPressed: enabled ? () => billing.buyPremium() : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: c.accent,
          foregroundColor: Colors.white,
          // Payment chalte waqt (spinner ke saath) bhi hara rahe, grey na ho
          disabledBackgroundColor: c.accent,
          disabledForegroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: billing.isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Colors.white,
                ),
              )
            : Text(
                // "free trial" tab hi likhein jab Console mein trial offer ho
                _offersFreeTrial ? t.startFreeTrial : t.subscribeNow,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
      ),
    );
  }
}

class _PremiumFeature {
  final String title;
  final IconData icon;
  final bool basic; // Basic plan mein available hai ya nahi
  const _PremiumFeature(this.title, this.icon, {this.basic = false});
}