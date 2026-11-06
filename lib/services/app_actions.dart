import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../app_config.dart';
import '../l10n/app_localizations.dart';

class AppActions {
  AppActions._();

  static Future<void> shareApp(BuildContext context) async {
    final AppLocalizations t = AppLocalizations.of(context)!;
    await SharePlus.instance.share(
      ShareParams(
        subject: AppConfig.appName,
        text:
            '${t.shareMessage}\n'
            '${AppConfig.appName}: ${AppConfig.playStoreUrl}',
      ),
    );
  }

  static Future<void> openPlayStore(BuildContext context) async {
    final AppLocalizations t = AppLocalizations.of(context)!;
    await _open(
      context,
      Uri.parse(AppConfig.playStoreUrl),
      t.couldNotOpenPlayStore,
    );
  }

  static Future<void> sendFeedback(BuildContext context) async {
    final AppLocalizations t = AppLocalizations.of(context)!;
    // Subject English mein hi rehta hai, kyunke ye email aap ko aati hai
    final String subject = Uri.encodeComponent('${AppConfig.appName} Feedback');
    final Uri uri = Uri.parse(
      'mailto:${AppConfig.supportEmail}?subject=$subject',
    );
    await _open(context, uri, t.noEmailApp);
  }

  static Future<void> _open(
    BuildContext context,
    Uri uri,
    String errorText,
  ) async {
    bool ok = false;
    try {
      ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {}
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorText)));
    }
  }

  static Future<void> openPrivacyPolicy(BuildContext context) async {
    // await se pehle le lo, taake context ka masla na ho
    final AppLocalizations t = AppLocalizations.of(context)!;
    final Uri uri = Uri.parse(AppConfig.privacyPolicyUrl);

    bool ok = false;
    try {
      ok = await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
    } catch (_) {}
    if (!ok) {
      try {
        ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
      } catch (_) {}
    }
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Could not open the link")));    // ............... baqi zbanoo mai change krna 
    }
  }
}
