// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get settings => 'Pengaturan';

  @override
  String get general => 'Umum';

  @override
  String get other => 'Lainnya';

  @override
  String get language => 'Bahasa';

  @override
  String get darkMode => 'Mode Gelap';

  @override
  String get darkModeSub => 'Beralih antara tema terang dan gelap';

  @override
  String get saveProfilePictures => 'Simpan Foto Profil';

  @override
  String get saveProfilePicturesSub =>
      'Simpan foto pengirim yang tampil di notifikasi';

  @override
  String get clearAllData => 'Hapus Semua Data';

  @override
  String get clearAllDataSub => 'Hapus semua pesan tersimpan';

  @override
  String get clearAllDataText =>
      'Semua pesan tersimpan dan foto profil akan dihapus dari aplikasi ini. Tindakan ini tidak dapat dibatalkan.';

  @override
  String get allSavedMessagesDeleted => 'Semua pesan tersimpan telah dihapus';

  @override
  String couldNotClearData(String error) {
    return 'Tidak dapat menghapus data: $error';
  }

  @override
  String get restartService => 'Mulai Ulang Layanan';

  @override
  String get restartServiceSub => 'Jika pesan berhenti tersimpan';

  @override
  String get guide => 'Panduan';

  @override
  String get guideSub => 'Pelajari cara menggunakan aplikasi';

  @override
  String get privacyPolicy => 'Kebijakan Privasi';

  @override
  String get privacyPolicySub => 'Bagaimana data Anda digunakan';

  @override
  String get rateUs => 'Beri Kami Nilai';

  @override
  String get rateUsSub => 'Dukung kami dengan penilaian Anda';

  @override
  String get shareApp => 'Bagikan Aplikasi';

  @override
  String get shareAppSub => 'Ajak orang lain memulihkan pesan mereka';

  @override
  String get disclaimer => 'Sanggahan';

  @override
  String get disclaimerSub => 'Informasi penting';

  @override
  String get feedback => 'Masukan';

  @override
  String get feedbackSub => 'Bantu kami meningkatkan aplikasi';

  @override
  String get aboutUs => 'Tentang Kami';

  @override
  String get aboutUsSub => 'Ketahui lebih lanjut tentang aplikasi';

  @override
  String get chooseLanguage => 'Pilih bahasa';

  @override
  String get deviceLanguage => 'Bahasa perangkat';

  @override
  String get cancel => 'Batal';

  @override
  String get delete => 'Hapus';

  @override
  String get submit => 'Kirim';

  @override
  String get maybeLater => 'Nanti saja';

  @override
  String get suggestedApps => 'Aplikasi yang disarankan';

  @override
  String get otherApps => 'Aplikasi lain';

  @override
  String get messageRecovery => 'Pemulihan Pesan';

  @override
  String get keepRunningInBackground =>
      'Jaga aplikasi tetap berjalan di latar belakang';

  @override
  String get battery => 'Baterai';

  @override
  String get autoStart => 'Mulai otomatis';

  @override
  String get addMore => 'Tambah lagi';

  @override
  String get allMessages => 'Semua Pesan';

  @override
  String get unreadMessages => 'Pesan Belum Dibaca';

  @override
  String get connectAppFirst => 'Hubungkan aplikasi terlebih dahulu';

  @override
  String get supportComingSoon => 'Dukungan untuk aplikasi ini segera hadir';

  @override
  String get allowNotificationAccess => 'Izinkan Akses Notifikasi';

  @override
  String get allowNotificationAccessText =>
      'Kami memerlukan akses notifikasi untuk memulihkan pesan yang dihapus. Pesan yang dibaca di sini tidak akan menampilkan centang biru.';

  @override
  String get allowPermission => 'Berikan Izin';

  @override
  String get noNotificationsYet => 'Belum Ada Notifikasi';

  @override
  String get noNotificationsText =>
      'Kami akan menampilkan notifikasi pesan Anda di sini begitu masuk.';

  @override
  String get noUnreadMessages => 'Tidak Ada Pesan Belum Dibaca';

  @override
  String get noUnreadText =>
      'Semua sudah dibaca. Pesan baru akan muncul di sini.';

  @override
  String get navMessages => 'Pesan';

  @override
  String get navDeletedMedia => 'Media Terhapus';

  @override
  String get navSettings => 'Pengaturan';

  @override
  String get navCrown => 'Mahkota';

  @override
  String get comingSoon => 'Segera hadir';

  @override
  String rateEnjoying(String appName) {
    return 'Suka dengan $appName?';
  }

  @override
  String get rateSubtitle =>
      'Penilaian Anda membantu kami berkembang dan membantu orang lain menemukan aplikasi ini.';

  @override
  String get rateTapStar => 'Ketuk bintang untuk menilai';

  @override
  String get ratePoor => 'Buruk';

  @override
  String get rateFair => 'Cukup';

  @override
  String get rateGood => 'Bagus';

  @override
  String get rateVeryGood => 'Sangat bagus';

  @override
  String get rateExcellent => 'Luar biasa';

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
