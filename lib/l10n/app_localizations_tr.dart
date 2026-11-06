// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get settings => 'Ayarlar';

  @override
  String get general => 'Genel';

  @override
  String get other => 'Diğer';

  @override
  String get language => 'Dil';

  @override
  String get darkMode => 'Karanlık Mod';

  @override
  String get darkModeSub => 'Açık ve koyu tema arasında geçiş yap';

  @override
  String get saveProfilePictures => 'Profil Fotoğraflarını Kaydet';

  @override
  String get saveProfilePicturesSub =>
      'Bildirimlerde görünen gönderen fotoğrafını sakla';

  @override
  String get clearAllData => 'Tüm Verileri Sil';

  @override
  String get clearAllDataSub => 'Kayıtlı tüm mesajları sil';

  @override
  String get clearAllDataText =>
      'Kayıtlı tüm mesajlar ve profil fotoğrafları bu uygulamadan silinecek. Bu işlem geri alınamaz.';

  @override
  String get allSavedMessagesDeleted => 'Kayıtlı tüm mesajlar silindi';

  @override
  String couldNotClearData(String error) {
    return 'Veriler silinemedi: $error';
  }

  @override
  String get restartService => 'Hizmeti Yeniden Başlat';

  @override
  String get restartServiceSub => 'Mesajlar kaydedilmeyi bırakırsa';

  @override
  String get guide => 'Rehber';

  @override
  String get guideSub => 'Uygulamayı nasıl kullanacağınızı öğrenin';

  @override
  String get privacyPolicy => 'Gizlilik Politikası';

  @override
  String get privacyPolicySub => 'Verileriniz nasıl kullanılır';

  @override
  String get rateUs => 'Bizi Puanlayın';

  @override
  String get rateUsSub => 'Değerli puanınızla bizi destekleyin';

  @override
  String get shareApp => 'Uygulamayı Paylaş';

  @override
  String get shareAppSub => 'Başkalarını mesajlarını kurtarmaya davet edin';

  @override
  String get disclaimer => 'Sorumluluk Reddi';

  @override
  String get disclaimerSub => 'Önemli bilgiler';

  @override
  String get feedback => 'Geri Bildirim';

  @override
  String get feedbackSub => 'Uygulamayı geliştirmemize yardım edin';

  @override
  String get aboutUs => 'Hakkımızda';

  @override
  String get aboutUsSub => 'Uygulama hakkında daha fazla bilgi edinin';

  @override
  String get chooseLanguage => 'Dil seçin';

  @override
  String get deviceLanguage => 'Cihaz dili';

  @override
  String get cancel => 'İptal';

  @override
  String get delete => 'Sil';

  @override
  String get submit => 'Gönder';

  @override
  String get maybeLater => 'Belki sonra';

  @override
  String get suggestedApps => 'Önerilen uygulamalar';

  @override
  String get otherApps => 'Diğer uygulamalar';

  @override
  String get messageRecovery => 'Mesaj Kurtarma';

  @override
  String get keepRunningInBackground =>
      'Uygulamanın arka planda çalışmasını sağlayın';

  @override
  String get battery => 'Pil';

  @override
  String get autoStart => 'Otomatik başlatma';

  @override
  String get addMore => 'Daha fazla ekle';

  @override
  String get allMessages => 'Tüm Mesajlar';

  @override
  String get unreadMessages => 'Okunmamış Mesajlar';

  @override
  String get connectAppFirst => 'Önce bir uygulama bağlayın';

  @override
  String get supportComingSoon => 'Bu uygulamanın desteği yakında geliyor';

  @override
  String get allowNotificationAccess => 'Bildirim Erişimine İzin Ver';

  @override
  String get allowNotificationAccessText =>
      'Silinen mesajları kurtarmak için bildirim erişimine ihtiyacımız var. Burada okunan mesajlarda mavi tik görünmez.';

  @override
  String get allowPermission => 'İzin Ver';

  @override
  String get noNotificationsYet => 'Henüz Bildirim Yok';

  @override
  String get noNotificationsText =>
      'Mesaj bildirimleriniz geldiği anda burada gösterilecek.';

  @override
  String get noUnreadMessages => 'Okunmamış Mesaj Yok';

  @override
  String get noUnreadText =>
      'Hepsini okudunuz. Yeni mesajlar burada görünecek.';

  @override
  String get navMessages => 'Mesajlar';

  @override
  String get navDeletedMedia => 'Silinen Medya';

  @override
  String get navSettings => 'Ayarlar';

  @override
  String get navCrown => 'Taç';

  @override
  String get comingSoon => 'Yakında';

  @override
  String rateEnjoying(String appName) {
    return '$appName uygulamasını beğeniyor musunuz?';
  }

  @override
  String get rateSubtitle =>
      'Puanınız gelişmemize ve başkalarının uygulamayı bulmasına yardımcı olur.';

  @override
  String get rateTapStar => 'Puanlamak için bir yıldıza dokunun';

  @override
  String get ratePoor => 'Kötü';

  @override
  String get rateFair => 'Orta';

  @override
  String get rateGood => 'İyi';

  @override
  String get rateVeryGood => 'Çok iyi';

  @override
  String get rateExcellent => 'Mükemmel';

  @override
  String get searchLanguage => 'Search language...';

  @override
  String get deleteMessagesTitle => 'Delete messages?';

  @override
  String get deleteMessagesText =>
      'The selected messages will be deleted from this app only. They cannot be restored.';

  @override
  String get selectTooltip => 'Select';

  @override
  String selectedCount(int count) {
    return '$count selected';
  }

  @override
  String get selectAll => 'Select all';

  @override
  String get clearSelection => 'Clear';

  @override
  String deleteWithCount(int count) {
    return 'Delete ($count)';
  }

  @override
  String get chatEmpty => 'No messages in this chat';

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get selectApps => 'Select Apps';

  @override
  String get searchApps => 'Search apps...';

  @override
  String get appsHeading => 'Apps';

  @override
  String get next => 'Next';

  @override
  String get pickAtLeastOneApp => 'Pick at least one app';

  @override
  String get restartingService => 'Restarting service...';

  @override
  String get serviceRestarted =>
      'Service restarted. New messages will be saved again.';

  @override
  String get notificationAccessOffTitle => 'Notification access is off';

  @override
  String get notificationAccessOffText =>
      'Turn on Notification access for this app, otherwise it cannot save messages.';

  @override
  String get restartNotConfirmedTitle => 'Restart not confirmed';

  @override
  String get restartNotConfirmedText =>
      'The restart was requested but the service did not confirm. Open Notification access, switch this app off and on again, then come back.';

  @override
  String get close => 'Close';

  @override
  String get openSettings => 'Open settings';

  @override
  String get couldNotOpenPlayStore => 'Could not open Google Play';

  @override
  String get noEmailApp => 'No email app found';

  @override
  String get premiumRecoverMessages => 'Recover Deleted Messages';

  @override
  String get premiumRecoverMedia => 'Recover Deleted Media';

  @override
  String get premiumRemoveAds => 'Remove Ads';

  @override
  String get premiumPrioritySupport => 'Priority Customer Support';

  @override
  String get premiumUnlimitedRecovery => 'Unlimited Data Recovery';

  @override
  String get planPro => 'Pro';

  @override
  String get planBasic => 'Basic';

  @override
  String get goPremium => 'Go Premium';

  @override
  String get goPremiumSubtitle =>
      'Unlock all features and get the best recovery experience.';

  @override
  String premiumPricePerWeek(String price) {
    return '$price / Weekly';
  }

  @override
  String get premiumTrialNote => 'after FREE 3-days trial ends';

  @override
  String get startFreeTrial => 'Start Free Trial';

  @override
  String get autoRenewNote => 'Subscription will auto-renew, Cancel anytime.';

  @override
  String guideIntro(String appName) {
    return 'Follow these steps once and $appName will keep a copy of your incoming messages.';
  }

  @override
  String guideStep(int number) {
    return 'Step $number';
  }

  @override
  String get guideStep1Title => 'Connect your apps';

  @override
  String guideStep1Text(String otherApps, String addMore) {
    return 'On the home screen tap an app, or choose “$otherApps” to pick several at once. You can add more apps later with the “$addMore” button.';
  }

  @override
  String get guideStep2Title => 'Allow notification access';

  @override
  String get guideStep2Text =>
      'The app can only save a message when it can read the notification that the other app shows. Open the list below, find this app and switch it on.';

  @override
  String get guideOpenNotificationAccess => 'Open Notification access';

  @override
  String get guideStep3Title => 'Keep it running in the background';

  @override
  String get guideStep3Text =>
      'Some phones close background apps to save battery, which can make you miss messages. Allow this app to run without battery restrictions and, if your phone has it, turn on Auto-start.';

  @override
  String get guideStep4Title => 'What gets saved';

  @override
  String get guideStep4Text => 'Keep these points in mind:';

  @override
  String get guideSaved1 =>
      'Keep notifications on for the chats you care about. Muted chats cannot be saved.';

  @override
  String get guideSaved2 =>
      'A message is not saved if you were already looking at that chat.';

  @override
  String get guideSaved3 =>
      'Only text is saved. Photos, voice messages and calls are not recovered.';

  @override
  String get guideStep5Title => 'Read your saved messages';

  @override
  String guideStep5Text(String messagesTab, String unreadMessages) {
    return 'Open the “$messagesTab” tab, pick an app at the top, then tap a person to see the saved conversation. Use “$unreadMessages” to see chats you have not opened yet.';
  }

  @override
  String get guideStep6Title => 'Delete messages';

  @override
  String guideStep6Text(
    String selectAll,
    String delete,
    String settings,
    String clearAll,
  ) {
    return 'Press and hold a message, or tap the select icon at the top. Choose messages or “$selectAll”, then tap “$delete”. To remove everything at once, use “$settings” > “$clearAll”.';
  }

  @override
  String get guideStep7Title => 'Something not saving?';

  @override
  String get guideStep7Text => 'Try these in order:';

  @override
  String get guideFix1 => 'Check that Notification access is on.';

  @override
  String get guideFix2 => 'Check the battery and Auto-start settings above.';

  @override
  String get guideFix3 =>
      'Make sure notifications are not muted for that chat.';

  @override
  String get guideFix4 => 'Restart the service with the button below.';

  @override
  String get readDisclaimer => 'Read the disclaimer';

  @override
  String get ourStory => 'Our story';

  @override
  String aboutStory1(String appName) {
    return '$appName was built for a simple reason: an important message should not be lost just because someone deleted it. The app keeps a copy of the messages that arrive on your phone, organized by app and by person, so you can read them later.';
  }

  @override
  String get aboutStory2 =>
      'It works by reading the notifications on your own phone, with your permission, and your saved messages stay on your device.';

  @override
  String get highlights => 'Highlights';

  @override
  String get featureOrganizedTitle => 'Organized chats';

  @override
  String get featureOrganizedText =>
      'Messages are grouped by app and by person, just like the apps you already use.';

  @override
  String get featurePrivateTitle => 'Private by design';

  @override
  String get featurePrivateText =>
      'Saved messages stay on your phone and are never uploaded to our servers.';

  @override
  String get featureBackgroundTitle => 'Works in the background';

  @override
  String get featureBackgroundText =>
      'Keeps saving new messages even when the app is closed, as long as your phone allows it.';

  @override
  String get featureControlTitle => 'You stay in control';

  @override
  String get featureControlText =>
      'Delete any message or chat, or turn off access, whenever you like.';

  @override
  String get worksWith => 'Works with';

  @override
  String get legalSupport => 'Legal & support';

  @override
  String get contactUs => 'Contact us';

  @override
  String versionLabel(String version) {
    return 'Version $version';
  }

  @override
  String allRightsReserved(String year, String developer) {
    return '© $year $developer. All rights reserved.';
  }

  @override
  String get notAffiliated =>
      'Not affiliated with WhatsApp, Meta, Snapchat, TikTok or any other app mentioned.';

  @override
  String get shareMessage =>
      'Keep a copy of your incoming messages, even if they are deleted later.';

  @override
  String get navStatus => 'Status';

  @override
  String get statusAllowTitle => 'Allow access to the Status folder';

  @override
  String get statusAllowText =>
      'To show WhatsApp statuses, choose the Status folder once. The app only reads this folder and nothing is uploaded.';

  @override
  String get statusChangeFolder => 'Change folder';

  @override
  String get statusWrongFolder =>
      'That doesn’t look like the Status folder. Please try again.';

  @override
  String get statusEmptyTitle => 'No statuses found';

  @override
  String get statusEmptyText =>
      'Open WhatsApp and view a few statuses first, then come back and pull down to refresh.';

  @override
  String get statusSaved => 'Saved to your gallery';

  @override
  String get statusSaveFailed => 'Could not save this status';

  @override
  String get saveAction => 'Save';

  @override
  String get statusOnlyWhatsApp =>
      'Only WhatsApp statuses can be saved. Facebook and Instagram stories are not stored on your phone, so this app cannot save them.';

  @override
  String get statusRespectNote =>
      'Please save only content you have the right to use.';

  @override
  String get statusChooseFolder => 'Allow access';

  @override
  String get deleteChatsTitle => 'Delete chats?';

  @override
  String get deleteChatsText =>
      'The selected chats and all their saved messages will be deleted from this app only. They cannot be restored.';

  @override
  String get statusViewedNote =>
      'Any status you view in WhatsApp will appear here, and you can save it.';

  @override
  String premiumPriceLine(String price) {
    return '$price / month';
  }

  @override
  String get premiumPriceUnavailable =>
      'Price unavailable. Please try again later.';

  @override
  String get subscribeNow => 'Subscribe';

  @override
  String get restorePurchases => 'Restore purchases';

  @override
  String get youArePremium => 'You are Premium. Thank you!';

  @override
  String get premiumSaveAnyStatus => 'Save any status';
}
