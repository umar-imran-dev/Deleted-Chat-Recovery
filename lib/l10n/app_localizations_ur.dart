// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class AppLocalizationsUr extends AppLocalizations {
  AppLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String get settings => 'ترتیبات';

  @override
  String get general => 'عمومی';

  @override
  String get other => 'دیگر';

  @override
  String get language => 'زبان';

  @override
  String get darkMode => 'ڈارک موڈ';

  @override
  String get darkModeSub => 'لائٹ اور ڈارک تھیم کے درمیان تبدیل کریں';

  @override
  String get saveProfilePictures => 'پروفائل تصاویر محفوظ کریں';

  @override
  String get saveProfilePicturesSub =>
      'نوٹیفکیشن میں نظر آنے والی بھیجنے والے کی تصویر رکھیں';

  @override
  String get clearAllData => 'تمام ڈیٹا صاف کریں';

  @override
  String get clearAllDataSub => 'تمام محفوظ پیغامات حذف کریں';

  @override
  String get clearAllDataText =>
      'اس ایپ سے تمام محفوظ پیغامات اور پروفائل تصاویر حذف ہو جائیں گی۔ اسے واپس نہیں کیا جا سکتا۔';

  @override
  String get allSavedMessagesDeleted => 'تمام محفوظ پیغامات حذف ہو گئے';

  @override
  String couldNotClearData(String error) {
    return 'ڈیٹا صاف نہیں ہو سکا: $error';
  }

  @override
  String get restartService => 'سروس دوبارہ شروع کریں';

  @override
  String get restartServiceSub => 'اگر پیغامات محفوظ ہونا بند ہو جائیں';

  @override
  String get guide => 'گائیڈ';

  @override
  String get guideSub => 'ایپ استعمال کرنا سیکھیں';

  @override
  String get privacyPolicy => 'پرائیویسی پالیسی';

  @override
  String get privacyPolicySub => 'آپ کا ڈیٹا کیسے استعمال ہوتا ہے';

  @override
  String get rateUs => 'ہمیں ریٹ کریں';

  @override
  String get rateUsSub => 'اپنی قیمتی ریٹنگ سے ہماری مدد کریں';

  @override
  String get shareApp => 'ایپ شیئر کریں';

  @override
  String get shareAppSub => 'دوسروں کو اپنے پیغامات واپس پانے کی دعوت دیں';

  @override
  String get disclaimer => 'دستبرداری';

  @override
  String get disclaimerSub => 'اہم معلومات';

  @override
  String get feedback => 'فیڈ بیک';

  @override
  String get feedbackSub => 'ایپ کو بہتر بنانے میں ہماری مدد کریں';

  @override
  String get aboutUs => 'ہمارے بارے میں';

  @override
  String get aboutUsSub => 'ایپ کے بارے میں مزید جانیں';

  @override
  String get chooseLanguage => 'زبان منتخب کریں';

  @override
  String get deviceLanguage => 'ڈیوائس کی زبان';

  @override
  String get cancel => 'منسوخ کریں';

  @override
  String get delete => 'حذف کریں';

  @override
  String get submit => 'جمع کرائیں';

  @override
  String get maybeLater => 'بعد میں';

  @override
  String get suggestedApps => 'تجویز کردہ ایپس';

  @override
  String get otherApps => 'دیگر ایپس';

  @override
  String get messageRecovery => 'میسج ریکوری';

  @override
  String get keepRunningInBackground => 'ایپ کو بیک گراؤنڈ میں چلتا رکھیں';

  @override
  String get battery => 'بیٹری';

  @override
  String get autoStart => 'آٹو اسٹارٹ';

  @override
  String get addMore => 'مزید شامل کریں';

  @override
  String get allMessages => 'تمام پیغامات';

  @override
  String get unreadMessages => 'غیر پڑھے پیغامات';

  @override
  String get connectAppFirst => 'پہلے کوئی ایپ جوڑیں';

  @override
  String get supportComingSoon => 'اس ایپ کی سپورٹ جلد آ رہی ہے';

  @override
  String get allowNotificationAccess => 'نوٹیفکیشن تک رسائی کی اجازت دیں';

  @override
  String get allowNotificationAccessText =>
      'حذف شدہ پیغامات واپس پانے کے لیے ہمیں نوٹیفکیشن تک رسائی چاہیے۔ یہاں پڑھے گئے پیغامات پر نیلے ٹک نہیں لگیں گے۔';

  @override
  String get allowPermission => 'اجازت دیں';

  @override
  String get noNotificationsYet => 'ابھی کوئی نوٹیفکیشن نہیں';

  @override
  String get noNotificationsText =>
      'آپ کے پیغامات کے نوٹیفکیشن آتے ہی ہم انہیں یہاں دکھائیں گے۔';

  @override
  String get noUnreadMessages => 'کوئی غیر پڑھا پیغام نہیں';

  @override
  String get noUnreadText =>
      'سب دیکھا جا چکا ہے۔ نئے پیغامات یہاں نظر آئیں گے۔';

  @override
  String get navMessages => 'پیغامات';

  @override
  String get navDeletedMedia => 'حذف شدہ میڈیا';

  @override
  String get navSettings => 'ترتیبات';

  @override
  String get navCrown => 'تاج';

  @override
  String get comingSoon => 'جلد آ رہا ہے';

  @override
  String rateEnjoying(String appName) {
    return 'کیا آپ $appName سے لطف اندوز ہو رہے ہیں؟';
  }

  @override
  String get rateSubtitle =>
      'آپ کی ریٹنگ ہمیں بہتر بنانے میں مدد دیتی ہے اور دوسروں کو ایپ ڈھونڈنے میں۔';

  @override
  String get rateTapStar => 'ریٹ کرنے کے لیے ستارے پر ٹیپ کریں';

  @override
  String get ratePoor => 'خراب';

  @override
  String get rateFair => 'ٹھیک ٹھاک';

  @override
  String get rateGood => 'اچھا';

  @override
  String get rateVeryGood => 'بہت اچھا';

  @override
  String get rateExcellent => 'بہترین';

  @override
  String get searchLanguage => 'زبان تلاش کریں';

  @override
  String get deleteMessagesTitle => 'پیغامات حذف کریں؟';

  @override
  String get deleteMessagesText =>
      'منتخب پیغامات صرف اس ایپ سے حذف ہوں گے۔ انہیں واپس نہیں لایا جا سکتا۔';

  @override
  String get selectTooltip => 'منتخب کریں';

  @override
  String selectedCount(int count) {
    return '$count منتخب';
  }

  @override
  String get selectAll => 'سب منتخب کریں';

  @override
  String get clearSelection => 'صاف کریں';

  @override
  String deleteWithCount(int count) {
    return 'حذف کریں ($count)';
  }

  @override
  String get chatEmpty => 'اس چیٹ میں کوئی پیغام نہیں';

  @override
  String get today => 'آج';

  @override
  String get yesterday => 'کل';

  @override
  String get selectApps => 'ایپس منتخب کریں';

  @override
  String get searchApps => 'ایپس تلاش کریں...';

  @override
  String get appsHeading => 'ایپس';

  @override
  String get next => 'آگے';

  @override
  String get pickAtLeastOneApp => 'کم از کم ایک ایپ منتخب کریں';

  @override
  String get restartingService => 'سروس دوبارہ شروع ہو رہی ہے...';

  @override
  String get serviceRestarted =>
      'سروس دوبارہ شروع ہو گئی۔ نئے پیغامات دوبارہ محفوظ ہوں گے۔';

  @override
  String get notificationAccessOffTitle => 'نوٹیفکیشن تک رسائی بند ہے';

  @override
  String get notificationAccessOffText =>
      'اس ایپ کے لیے نوٹیفکیشن تک رسائی آن کریں، ورنہ یہ پیغامات محفوظ نہیں کر سکتی۔';

  @override
  String get restartNotConfirmedTitle => 'ری اسٹارٹ کی تصدیق نہیں ہوئی';

  @override
  String get restartNotConfirmedText =>
      'ری اسٹارٹ کی درخواست بھیجی گئی مگر سروس نے تصدیق نہیں کی۔ نوٹیفکیشن تک رسائی کھولیں، اس ایپ کو بند کر کے دوبارہ آن کریں، پھر واپس آئیں۔';

  @override
  String get close => 'بند کریں';

  @override
  String get openSettings => 'ترتیبات کھولیں';

  @override
  String get couldNotOpenPlayStore => 'گوگل پلے نہیں کھل سکا';

  @override
  String get noEmailApp => 'کوئی ای میل ایپ نہیں ملی';

  @override
  String get premiumRecoverMessages => 'حذف شدہ پیغامات واپس پائیں';

  @override
  String get premiumRecoverMedia => 'حذف شدہ میڈیا واپس پائیں';

  @override
  String get premiumRemoveAds => 'اشتہارات ہٹائیں';

  @override
  String get premiumPrioritySupport => 'ترجیحی کسٹمر سپورٹ';

  @override
  String get premiumUnlimitedRecovery => 'لامحدود ڈیٹا ریکوری';

  @override
  String get planPro => 'پرو';

  @override
  String get planBasic => 'بنیادی';

  @override
  String get goPremium => 'پریمیم لیں';

  @override
  String get goPremiumSubtitle =>
      'تمام فیچرز انلاک کریں اور بہترین ریکوری تجربہ حاصل کریں۔';

  @override
  String premiumPricePerWeek(String price) {
    return '$price / ہفتہ وار';
  }

  @override
  String get premiumTrialNote => '3 دن کے مفت ٹرائل کے بعد';

  @override
  String get startFreeTrial => 'مفت ٹرائل شروع کریں';

  @override
  String get autoRenewNote =>
      'سبسکرپشن خود بخود تجدید ہوگی، کبھی بھی منسوخ کریں۔';

  @override
  String guideIntro(String appName) {
    return 'یہ مراحل ایک بار مکمل کریں اور $appName آپ کے آنے والے پیغامات کی کاپی محفوظ رکھے گی۔';
  }

  @override
  String guideStep(int number) {
    return 'مرحلہ $number';
  }

  @override
  String get guideStep1Title => 'اپنی ایپس جوڑیں';

  @override
  String guideStep1Text(String otherApps, String addMore) {
    return 'ہوم اسکرین پر کسی ایپ پر ٹیپ کریں، یا ایک ساتھ کئی چننے کے لیے “$otherApps” منتخب کریں۔ بعد میں آپ “$addMore” بٹن سے مزید ایپس شامل کر سکتے ہیں۔';
  }

  @override
  String get guideStep2Title => 'نوٹیفکیشن تک رسائی دیں';

  @override
  String get guideStep2Text =>
      'ایپ تبھی پیغام محفوظ کر سکتی ہے جب وہ دوسری ایپ کی دکھائی ہوئی نوٹیفکیشن پڑھ سکے۔ نیچے دی گئی فہرست کھولیں، اس ایپ کو تلاش کریں اور آن کر دیں۔';

  @override
  String get guideOpenNotificationAccess => 'نوٹیفکیشن تک رسائی کھولیں';

  @override
  String get guideStep3Title => 'اسے بیک گراؤنڈ میں چلتا رکھیں';

  @override
  String get guideStep3Text =>
      'کچھ فونز بیٹری بچانے کے لیے بیک گراؤنڈ ایپس بند کر دیتے ہیں، جس سے پیغامات رہ سکتے ہیں۔ اس ایپ کو بیٹری کی پابندی کے بغیر چلنے دیں اور اگر آپ کے فون میں ہو تو آٹو اسٹارٹ آن کریں۔';

  @override
  String get guideStep4Title => 'کیا محفوظ ہوتا ہے';

  @override
  String get guideStep4Text => 'ان باتوں کا خیال رکھیں:';

  @override
  String get guideSaved1 =>
      'جن چیٹس کی آپ کو فکر ہے ان کی نوٹیفکیشن آن رکھیں۔ میوٹ کی گئی چیٹس محفوظ نہیں ہو سکتیں۔';

  @override
  String get guideSaved2 =>
      'اگر آپ اس وقت وہی چیٹ دیکھ رہے تھے تو پیغام محفوظ نہیں ہوتا۔';

  @override
  String get guideSaved3 =>
      'صرف ٹیکسٹ محفوظ ہوتا ہے۔ تصاویر، وائس میسج اور کالز واپس نہیں ملتیں۔';

  @override
  String get guideStep5Title => 'اپنے محفوظ پیغامات پڑھیں';

  @override
  String guideStep5Text(String messagesTab, String unreadMessages) {
    return '“$messagesTab” ٹیب کھولیں، اوپر سے کوئی ایپ چنیں، پھر کسی شخص پر ٹیپ کر کے محفوظ گفتگو دیکھیں۔ جو چیٹس آپ نے ابھی نہیں کھولیں انہیں دیکھنے کے لیے “$unreadMessages” استعمال کریں۔';
  }

  @override
  String get guideStep6Title => 'پیغامات حذف کریں';

  @override
  String guideStep6Text(
    String selectAll,
    String delete,
    String settings,
    String clearAll,
  ) {
    return 'کسی پیغام کو دبائے رکھیں، یا اوپر سلیکٹ آئیکن پر ٹیپ کریں۔ پیغامات یا “$selectAll” چنیں، پھر “$delete” دبائیں۔ سب کچھ ایک ساتھ ہٹانے کے لیے “$settings” > “$clearAll” استعمال کریں۔';
  }

  @override
  String get guideStep7Title => 'کچھ محفوظ نہیں ہو رہا؟';

  @override
  String get guideStep7Text => 'انہیں ترتیب سے آزمائیں:';

  @override
  String get guideFix1 => 'دیکھیں کہ نوٹیفکیشن تک رسائی آن ہے۔';

  @override
  String get guideFix2 => 'اوپر دی گئی بیٹری اور آٹو اسٹارٹ کی ترتیبات دیکھیں۔';

  @override
  String get guideFix3 => 'یقینی بنائیں کہ اس چیٹ کی نوٹیفکیشن میوٹ نہیں ہے۔';

  @override
  String get guideFix4 => 'نیچے دیے گئے بٹن سے سروس دوبارہ شروع کریں۔';

  @override
  String get readDisclaimer => 'دستبرداری پڑھیں';

  @override
  String get ourStory => 'ہماری کہانی';

  @override
  String aboutStory1(String appName) {
    return '$appName ایک سادہ وجہ سے بنائی گئی: کوئی اہم پیغام صرف اس لیے ضائع نہیں ہونا چاہیے کہ کسی نے اسے حذف کر دیا۔ ایپ آپ کے فون پر آنے والے پیغامات کی کاپی ایپ اور شخص کے حساب سے ترتیب دے کر رکھتی ہے تاکہ آپ انہیں بعد میں پڑھ سکیں۔';
  }

  @override
  String get aboutStory2 =>
      'یہ آپ کی اجازت سے آپ ہی کے فون کی نوٹیفکیشنز پڑھ کر کام کرتی ہے، اور آپ کے محفوظ پیغامات آپ کے ڈیوائس پر ہی رہتے ہیں۔';

  @override
  String get highlights => 'نمایاں خصوصیات';

  @override
  String get featureOrganizedTitle => 'منظم چیٹس';

  @override
  String get featureOrganizedText =>
      'پیغامات ایپ اور شخص کے حساب سے گروپ ہوتے ہیں، بالکل ان ایپس کی طرح جو آپ پہلے سے استعمال کرتے ہیں۔';

  @override
  String get featurePrivateTitle => 'ڈیزائن سے ہی نجی';

  @override
  String get featurePrivateText =>
      'محفوظ پیغامات آپ کے فون پر رہتے ہیں اور ہمارے سرورز پر کبھی اپ لوڈ نہیں ہوتے۔';

  @override
  String get featureBackgroundTitle => 'بیک گراؤنڈ میں کام کرتی ہے';

  @override
  String get featureBackgroundText =>
      'ایپ بند ہونے پر بھی نئے پیغامات محفوظ کرتی رہتی ہے، بشرطیکہ آپ کا فون اجازت دے۔';

  @override
  String get featureControlTitle => 'کنٹرول آپ کے ہاتھ میں';

  @override
  String get featureControlText =>
      'جب چاہیں کوئی بھی پیغام یا چیٹ حذف کریں، یا رسائی بند کر دیں۔';

  @override
  String get worksWith => 'ان کے ساتھ کام کرتی ہے';

  @override
  String get legalSupport => 'قانونی اور سپورٹ';

  @override
  String get contactUs => 'ہم سے رابطہ کریں';

  @override
  String versionLabel(String version) {
    return 'ورژن $version';
  }

  @override
  String allRightsReserved(String year, String developer) {
    return '© $year $developer۔ تمام حقوق محفوظ ہیں۔';
  }

  @override
  String get notAffiliated =>
      'WhatsApp، Meta، Snapchat، TikTok یا ذکر کی گئی کسی بھی دوسری ایپ سے کوئی وابستگی نہیں۔';

  @override
  String get shareMessage =>
      'اپنے آنے والے پیغامات کی کاپی محفوظ رکھیں، چاہے وہ بعد میں حذف ہو جائیں۔';

  @override
  String get navStatus => 'اسٹیٹس';

  @override
  String get statusAllowTitle => 'اسٹیٹس فولڈر تک رسائی دیں';

  @override
  String get statusAllowText =>
      'واٹس ایپ اسٹیٹس دکھانے کے لیے اسٹیٹس فولڈر ایک بار منتخب کریں۔ ایپ صرف یہی فولڈر پڑھتی ہے اور کچھ بھی اپ لوڈ نہیں ہوتا۔';

  @override
  String get statusChangeFolder => 'فولڈر تبدیل کریں';

  @override
  String get statusWrongFolder =>
      'یہ اسٹیٹس فولڈر نہیں لگتا۔ دوبارہ کوشش کریں۔';

  @override
  String get statusEmptyTitle => 'کوئی اسٹیٹس نہیں ملا';

  @override
  String get statusEmptyText =>
      'پہلے واٹس ایپ کھول کر چند اسٹیٹس دیکھیں، پھر واپس آ کر نیچے کھینچ کر ریفریش کریں۔';

  @override
  String get statusSaved => 'آپ کی گیلری میں محفوظ ہو گیا';

  @override
  String get statusSaveFailed => 'یہ اسٹیٹس محفوظ نہیں ہو سکا';

  @override
  String get saveAction => 'محفوظ کریں';

  @override
  String get statusOnlyWhatsApp =>
      'صرف واٹس ایپ اسٹیٹس محفوظ ہو سکتے ہیں۔ فیس بک اور انسٹاگرام اسٹوریز آپ کے فون میں محفوظ نہیں ہوتیں، اس لیے یہ ایپ انہیں محفوظ نہیں کر سکتی۔';

  @override
  String get statusRespectNote =>
      'براہِ کرم صرف وہی مواد محفوظ کریں جسے استعمال کرنے کا آپ کو حق ہو۔';

  @override
  String get statusChooseFolder => 'رسائی دیں';

  @override
  String get deleteChatsTitle => 'چیٹس حذف کریں؟';

  @override
  String get deleteChatsText =>
      'منتخب چیٹس اور ان کے تمام محفوظ پیغامات صرف اس ایپ سے حذف ہوں گے۔ انہیں واپس نہیں لایا جا سکتا۔';

  @override
  String get statusViewedNote =>
      'آپ واٹس ایپ میں جو بھی اسٹیٹس دیکھیں گے وہ یہاں نظر آئے گا اور آپ اسے محفوظ کر سکیں گے۔';

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
