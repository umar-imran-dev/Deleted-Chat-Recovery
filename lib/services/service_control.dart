import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../l10n/app_localizations.dart';
import '../theme/app_colors.dart';

enum RestartResult { running, accessOff, notConfirmed }

class ServiceControl {
  ServiceControl._();

  static const MethodChannel _channel = MethodChannel('native_log');

  static Future<bool> isAccessEnabled() async {
    try {
      return await _channel.invokeMethod<bool>('isEnabled') ?? false;
    } catch (_) {
      return false;
    }
  }

  static Future<void> openNotificationAccess() async {
    try {
      await _channel.invokeMethod('openSettings');
    } catch (_) {}
  }

  static Future<void> openBatterySettings() async {
    try {
      await _channel.invokeMethod('openBatterySettings');
    } catch (_) {}
  }

  static Future<void> openAutoStart() async {
    try {
      await _channel.invokeMethod('openAutoStartSettings');
    } catch (_) {}
  }

  // Service restart karo aur 5 second tak intezaar karo ke wo wapas juri ya nahi
  static Future<RestartResult> restart() async {
    if (!await isAccessEnabled()) return RestartResult.accessOff;

    try {
      final bool requested =
          await _channel.invokeMethod<bool>('restartService') ?? false;
      if (!requested) return RestartResult.notConfirmed;

      for (int i = 0; i < 10; i++) {
        await Future<void>.delayed(const Duration(milliseconds: 500));
        final bool connected =
            await _channel.invokeMethod<bool>('isServiceConnected') ?? false;
        if (connected) return RestartResult.running;
      }
    } catch (_) {}

    return RestartResult.notConfirmed;
  }

  // Poora flow screen ke sath: spinner, phir nateeje ke hisaab se message
  static Future<void> restartWithUi(BuildContext context) async {
    final AppColors c = AppColors.current;
    // await se pehle le lo, taake context ka masla na ho
    final AppLocalizations t = AppLocalizations.of(context)!;

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: AlertDialog(
          backgroundColor: c.dialog,
          content: Row(
            children: [
              const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2.5),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  t.restartingService,
                  style: TextStyle(color: c.title),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    final RestartResult result = await restart();

    if (!context.mounted) return;
    Navigator.of(context, rootNavigator: true).pop();

    switch (result) {
      case RestartResult.running:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t.serviceRestarted)),
        );
        break;
      case RestartResult.accessOff:
        await _showSettingsDialog(
          context,
          t.notificationAccessOffTitle,
          t.notificationAccessOffText,
        );
        break;
      case RestartResult.notConfirmed:
        await _showSettingsDialog(
          context,
          t.restartNotConfirmedTitle,
          t.restartNotConfirmedText,
        );
        break;
    }
  }

  static Future<void> _showSettingsDialog(
    BuildContext context,
    String title,
    String message,
  ) async {
    final AppColors c = AppColors.current;
    final AppLocalizations t = AppLocalizations.of(context)!;
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: c.dialog,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: c.heading,
          ),
        ),
        content: Text(message, style: TextStyle(fontSize: 14, color: c.muted)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(t.close, style: TextStyle(color: c.muted)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              openNotificationAccess();
            },
            child: Text(t.openSettings, style: TextStyle(color: c.accent)),
          ),
        ],
      ),
    );
  }
}