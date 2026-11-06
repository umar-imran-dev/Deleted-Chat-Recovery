// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get general => 'सामान्य';

  @override
  String get other => 'अन्य';

  @override
  String get language => 'भाषा';

  @override
  String get darkMode => 'डार्क मोड';

  @override
  String get darkModeSub => 'लाइट और डार्क थीम के बीच बदलें';

  @override
  String get saveProfilePictures => 'प्रोफ़ाइल फ़ोटो सेव करें';

  @override
  String get saveProfilePicturesSub =>
      'नोटिफ़िकेशन में दिखने वाली भेजने वाले की फ़ोटो रखें';

  @override
  String get clearAllData => 'सारा डेटा हटाएँ';

  @override
  String get clearAllDataSub => 'सभी सेव किए गए मैसेज हटाएँ';

  @override
  String get clearAllDataText =>
      'इस ऐप से सभी सेव किए गए मैसेज और प्रोफ़ाइल फ़ोटो हटा दी जाएँगी। इसे वापस नहीं किया जा सकता।';

  @override
  String get allSavedMessagesDeleted => 'सभी सेव किए गए मैसेज हटा दिए गए';

  @override
  String couldNotClearData(String error) {
    return 'डेटा नहीं हटाया जा सका: $error';
  }

  @override
  String get restartService => 'सर्विस दोबारा शुरू करें';

  @override
  String get restartServiceSub => 'अगर मैसेज सेव होना बंद हो जाएँ';

  @override
  String get guide => 'गाइड';

  @override
  String get guideSub => 'ऐप इस्तेमाल करना सीखें';

  @override
  String get privacyPolicy => 'प्राइवेसी पॉलिसी';

  @override
  String get privacyPolicySub => 'आपका डेटा कैसे इस्तेमाल होता है';

  @override
  String get rateUs => 'हमें रेट करें';

  @override
  String get rateUsSub => 'अपनी कीमती रेटिंग से हमारा साथ दें';

  @override
  String get shareApp => 'ऐप शेयर करें';

  @override
  String get shareAppSub => 'दूसरों को उनके मैसेज वापस पाने के लिए बुलाएँ';

  @override
  String get disclaimer => 'अस्वीकरण';

  @override
  String get disclaimerSub => 'ज़रूरी जानकारी';

  @override
  String get feedback => 'फ़ीडबैक';

  @override
  String get feedbackSub => 'ऐप को बेहतर बनाने में हमारी मदद करें';

  @override
  String get aboutUs => 'हमारे बारे में';

  @override
  String get aboutUsSub => 'ऐप के बारे में और जानें';

  @override
  String get chooseLanguage => 'भाषा चुनें';

  @override
  String get deviceLanguage => 'डिवाइस की भाषा';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get delete => 'हटाएँ';

  @override
  String get submit => 'सबमिट करें';

  @override
  String get maybeLater => 'बाद में';

  @override
  String get suggestedApps => 'सुझाए गए ऐप्स';

  @override
  String get otherApps => 'अन्य ऐप्स';

  @override
  String get messageRecovery => 'मैसेज रिकवरी';

  @override
  String get keepRunningInBackground => 'ऐप को बैकग्राउंड में चालू रखें';

  @override
  String get battery => 'बैटरी';

  @override
  String get autoStart => 'ऑटो-स्टार्ट';

  @override
  String get addMore => 'और जोड़ें';

  @override
  String get allMessages => 'सभी मैसेज';

  @override
  String get unreadMessages => 'अनपढ़े मैसेज';

  @override
  String get connectAppFirst => 'पहले कोई ऐप कनेक्ट करें';

  @override
  String get supportComingSoon => 'इस ऐप का सपोर्ट जल्द आ रहा है';

  @override
  String get allowNotificationAccess => 'नोटिफ़िकेशन एक्सेस की अनुमति दें';

  @override
  String get allowNotificationAccessText =>
      'हटाए गए मैसेज वापस पाने के लिए हमें नोटिफ़िकेशन एक्सेस चाहिए। यहाँ पढ़े गए मैसेज पर ब्लू टिक नहीं दिखेंगे।';

  @override
  String get allowPermission => 'अनुमति दें';

  @override
  String get noNotificationsYet => 'अभी कोई नोटिफ़िकेशन नहीं';

  @override
  String get noNotificationsText =>
      'आपके मैसेज के नोटिफ़िकेशन आते ही हम उन्हें यहाँ दिखाएँगे।';

  @override
  String get noUnreadMessages => 'कोई अनपढ़ा मैसेज नहीं';

  @override
  String get noUnreadText => 'सब देखा जा चुका है। नए मैसेज यहाँ दिखेंगे।';

  @override
  String get navMessages => 'मैसेज';

  @override
  String get navDeletedMedia => 'हटाया गया मीडिया';

  @override
  String get navSettings => 'सेटिंग्स';

  @override
  String get navCrown => 'ताज';

  @override
  String get comingSoon => 'जल्द आ रहा है';

  @override
  String rateEnjoying(String appName) {
    return 'क्या आप $appName का आनंद ले रहे हैं?';
  }

  @override
  String get rateSubtitle =>
      'आपकी रेटिंग हमें बेहतर बनने में और दूसरों को ऐप खोजने में मदद करती है।';

  @override
  String get rateTapStar => 'रेट करने के लिए स्टार पर टैप करें';

  @override
  String get ratePoor => 'खराब';

  @override
  String get rateFair => 'ठीक-ठाक';

  @override
  String get rateGood => 'अच्छा';

  @override
  String get rateVeryGood => 'बहुत अच्छा';

  @override
  String get rateExcellent => 'बेहतरीन';

  @override
  String get searchLanguage => 'भाषा खोजें';

  @override
  String get deleteMessagesTitle => 'मैसेज हटाएँ?';

  @override
  String get deleteMessagesText =>
      'चुने गए मैसेज सिर्फ़ इस ऐप से हटाए जाएँगे। इन्हें वापस नहीं लाया जा सकता।';

  @override
  String get selectTooltip => 'चुनें';

  @override
  String selectedCount(int count) {
    return '$count चुने गए';
  }

  @override
  String get selectAll => 'सभी चुनें';

  @override
  String get clearSelection => 'साफ़ करें';

  @override
  String deleteWithCount(int count) {
    return 'हटाएँ ($count)';
  }

  @override
  String get chatEmpty => 'इस चैट में कोई मैसेज नहीं है';

  @override
  String get today => 'आज';

  @override
  String get yesterday => 'कल';

  @override
  String get selectApps => 'ऐप्स चुनें';

  @override
  String get searchApps => 'ऐप्स खोजें...';

  @override
  String get appsHeading => 'ऐप्स';

  @override
  String get next => 'आगे';

  @override
  String get pickAtLeastOneApp => 'कम से कम एक ऐप चुनें';

  @override
  String get restartingService => 'सर्विस दोबारा शुरू हो रही है...';

  @override
  String get serviceRestarted =>
      'सर्विस दोबारा शुरू हो गई। नए मैसेज फिर से सेव होंगे।';

  @override
  String get notificationAccessOffTitle => 'नोटिफ़िकेशन एक्सेस बंद है';

  @override
  String get notificationAccessOffText =>
      'इस ऐप के लिए नोटिफ़िकेशन एक्सेस चालू करें, वरना यह मैसेज सेव नहीं कर सकती।';

  @override
  String get restartNotConfirmedTitle => 'रीस्टार्ट की पुष्टि नहीं हुई';

  @override
  String get restartNotConfirmedText =>
      'रीस्टार्ट का अनुरोध भेजा गया, लेकिन सर्विस ने पुष्टि नहीं की। नोटिफ़िकेशन एक्सेस खोलें, इस ऐप को बंद करके फिर चालू करें, फिर वापस आएँ।';

  @override
  String get close => 'बंद करें';

  @override
  String get openSettings => 'सेटिंग्स खोलें';

  @override
  String get couldNotOpenPlayStore => 'Google Play नहीं खुल सका';

  @override
  String get noEmailApp => 'कोई ईमेल ऐप नहीं मिला';

  @override
  String get premiumRecoverMessages => 'हटाए गए मैसेज वापस पाएँ';

  @override
  String get premiumRecoverMedia => 'हटाया गया मीडिया वापस पाएँ';

  @override
  String get premiumRemoveAds => 'विज्ञापन हटाएँ';

  @override
  String get premiumPrioritySupport => 'प्राथमिकता कस्टमर सपोर्ट';

  @override
  String get premiumUnlimitedRecovery => 'असीमित डेटा रिकवरी';

  @override
  String get planPro => 'प्रो';

  @override
  String get planBasic => 'बेसिक';

  @override
  String get goPremium => 'प्रीमियम लें';

  @override
  String get goPremiumSubtitle =>
      'सभी फ़ीचर अनलॉक करें और सबसे बेहतरीन रिकवरी अनुभव पाएँ।';

  @override
  String premiumPricePerWeek(String price) {
    return '$price / साप्ताहिक';
  }

  @override
  String get premiumTrialNote => '3 दिन का मुफ़्त ट्रायल खत्म होने के बाद';

  @override
  String get startFreeTrial => 'मुफ़्त ट्रायल शुरू करें';

  @override
  String get autoRenewNote =>
      'सब्सक्रिप्शन अपने आप रिन्यू होगा, कभी भी रद्द करें।';

  @override
  String guideIntro(String appName) {
    return 'ये चरण एक बार पूरे करें और $appName आपके आने वाले मैसेज की कॉपी रखेगा।';
  }

  @override
  String guideStep(int number) {
    return 'चरण $number';
  }

  @override
  String get guideStep1Title => 'अपने ऐप्स कनेक्ट करें';

  @override
  String guideStep1Text(String otherApps, String addMore) {
    return 'होम स्क्रीन पर किसी ऐप पर टैप करें, या एक साथ कई चुनने के लिए “$otherApps” चुनें। बाद में आप “$addMore” बटन से और ऐप्स जोड़ सकते हैं।';
  }

  @override
  String get guideStep2Title => 'नोटिफ़िकेशन एक्सेस की अनुमति दें';

  @override
  String get guideStep2Text =>
      'ऐप तभी मैसेज सेव कर सकता है जब वह दूसरे ऐप की दिखाई गई नोटिफ़िकेशन पढ़ सके। नीचे दी गई सूची खोलें, इस ऐप को ढूँढें और चालू कर दें।';

  @override
  String get guideOpenNotificationAccess => 'नोटिफ़िकेशन एक्सेस खोलें';

  @override
  String get guideStep3Title => 'इसे बैकग्राउंड में चालू रखें';

  @override
  String get guideStep3Text =>
      'कुछ फ़ोन बैटरी बचाने के लिए बैकग्राउंड ऐप्स बंद कर देते हैं, जिससे मैसेज छूट सकते हैं। इस ऐप को बैटरी पाबंदी के बिना चलने दें और अगर आपके फ़ोन में हो तो ऑटो-स्टार्ट चालू करें।';

  @override
  String get guideStep4Title => 'क्या सेव होता है';

  @override
  String get guideStep4Text => 'इन बातों का ध्यान रखें:';

  @override
  String get guideSaved1 =>
      'जिन चैट की आपको परवाह है उनकी नोटिफ़िकेशन चालू रखें। म्यूट की गई चैट सेव नहीं हो सकतीं।';

  @override
  String get guideSaved2 =>
      'अगर आप उस समय वही चैट देख रहे थे तो मैसेज सेव नहीं होता।';

  @override
  String get guideSaved3 =>
      'सिर्फ़ टेक्स्ट सेव होता है। फ़ोटो, वॉइस मैसेज और कॉल वापस नहीं मिलते।';

  @override
  String get guideStep5Title => 'अपने सेव किए मैसेज पढ़ें';

  @override
  String guideStep5Text(String messagesTab, String unreadMessages) {
    return '“$messagesTab” टैब खोलें, ऊपर से कोई ऐप चुनें, फिर किसी व्यक्ति पर टैप करके सेव की गई बातचीत देखें। जो चैट आपने अभी नहीं खोली उन्हें देखने के लिए “$unreadMessages” इस्तेमाल करें।';
  }

  @override
  String get guideStep6Title => 'मैसेज हटाएँ';

  @override
  String guideStep6Text(
    String selectAll,
    String delete,
    String settings,
    String clearAll,
  ) {
    return 'किसी मैसेज को दबाए रखें, या ऊपर चुनने वाले आइकन पर टैप करें। मैसेज या “$selectAll” चुनें, फिर “$delete” दबाएँ। सब कुछ एक साथ हटाने के लिए “$settings” > “$clearAll” इस्तेमाल करें।';
  }

  @override
  String get guideStep7Title => 'कुछ सेव नहीं हो रहा?';

  @override
  String get guideStep7Text => 'इन्हें क्रम से आज़माएँ:';

  @override
  String get guideFix1 => 'जाँचें कि नोटिफ़िकेशन एक्सेस चालू है।';

  @override
  String get guideFix2 => 'ऊपर दी गई बैटरी और ऑटो-स्टार्ट सेटिंग्स जाँचें।';

  @override
  String get guideFix3 => 'पक्का करें कि उस चैट की नोटिफ़िकेशन म्यूट नहीं है।';

  @override
  String get guideFix4 => 'नीचे दिए बटन से सर्विस दोबारा शुरू करें।';

  @override
  String get readDisclaimer => 'अस्वीकरण पढ़ें';

  @override
  String get ourStory => 'हमारी कहानी';

  @override
  String aboutStory1(String appName) {
    return '$appName एक सीधी वजह से बनाया गया: कोई ज़रूरी मैसेज सिर्फ़ इसलिए खो नहीं जाना चाहिए कि किसी ने उसे हटा दिया। ऐप आपके फ़ोन पर आने वाले मैसेज की कॉपी ऐप और व्यक्ति के हिसाब से सजाकर रखता है, ताकि आप उन्हें बाद में पढ़ सकें।';
  }

  @override
  String get aboutStory2 =>
      'यह आपकी अनुमति से आपके ही फ़ोन की नोटिफ़िकेशन पढ़कर काम करता है, और आपके सेव किए मैसेज आपके डिवाइस पर ही रहते हैं।';

  @override
  String get highlights => 'खास बातें';

  @override
  String get featureOrganizedTitle => 'व्यवस्थित चैट';

  @override
  String get featureOrganizedText =>
      'मैसेज ऐप और व्यक्ति के हिसाब से ग्रुप होते हैं, बिल्कुल उन ऐप्स की तरह जो आप पहले से इस्तेमाल करते हैं।';

  @override
  String get featurePrivateTitle => 'डिज़ाइन से ही निजी';

  @override
  String get featurePrivateText =>
      'सेव किए मैसेज आपके फ़ोन पर रहते हैं और हमारे सर्वर पर कभी अपलोड नहीं होते।';

  @override
  String get featureBackgroundTitle => 'बैकग्राउंड में काम करता है';

  @override
  String get featureBackgroundText =>
      'ऐप बंद होने पर भी नए मैसेज सेव करता रहता है, बशर्ते आपका फ़ोन अनुमति दे।';

  @override
  String get featureControlTitle => 'कंट्रोल आपके हाथ में';

  @override
  String get featureControlText =>
      'जब चाहें कोई भी मैसेज या चैट हटाएँ, या एक्सेस बंद कर दें।';

  @override
  String get worksWith => 'इनके साथ काम करता है';

  @override
  String get legalSupport => 'कानूनी और सपोर्ट';

  @override
  String get contactUs => 'हमसे संपर्क करें';

  @override
  String versionLabel(String version) {
    return 'वर्शन $version';
  }

  @override
  String allRightsReserved(String year, String developer) {
    return '© $year $developer। सर्वाधिकार सुरक्षित।';
  }

  @override
  String get notAffiliated =>
      'WhatsApp, Meta, Snapchat, TikTok या उल्लेखित किसी भी अन्य ऐप से कोई संबंध नहीं।';

  @override
  String get shareMessage =>
      'अपने आने वाले मैसेज की कॉपी रखें, भले ही वे बाद में हटा दिए जाएँ।';

  @override
  String get navStatus => 'स्टेटस';

  @override
  String get statusAllowTitle => 'स्टेटस फ़ोल्डर की अनुमति दें';

  @override
  String get statusAllowText =>
      'व्हाट्सऐप स्टेटस दिखाने के लिए स्टेटस फ़ोल्डर एक बार चुनें। ऐप सिर्फ़ यही फ़ोल्डर पढ़ता है और कुछ भी अपलोड नहीं होता।';

  @override
  String get statusChangeFolder => 'फ़ोल्डर बदलें';

  @override
  String get statusWrongFolder =>
      'यह स्टेटस फ़ोल्डर नहीं लग रहा। कृपया फिर कोशिश करें।';

  @override
  String get statusEmptyTitle => 'कोई स्टेटस नहीं मिला';

  @override
  String get statusEmptyText =>
      'पहले व्हाट्सऐप खोलकर कुछ स्टेटस देखें, फिर वापस आकर नीचे खींचकर रिफ़्रेश करें।';

  @override
  String get statusSaved => 'आपकी गैलरी में सेव हो गया';

  @override
  String get statusSaveFailed => 'यह स्टेटस सेव नहीं हो सका';

  @override
  String get saveAction => 'सेव करें';

  @override
  String get statusOnlyWhatsApp =>
      'सिर्फ़ व्हाट्सऐप स्टेटस सेव हो सकते हैं। फ़ेसबुक और इंस्टाग्राम स्टोरीज़ आपके फ़ोन में स्टोर नहीं होतीं, इसलिए यह ऐप उन्हें सेव नहीं कर सकता।';

  @override
  String get statusRespectNote =>
      'कृपया सिर्फ़ वही कंटेंट सेव करें जिसे इस्तेमाल करने का आपको अधिकार है।';

  @override
  String get statusChooseFolder => 'एक्सेस की अनुमति दें';

  @override
  String get deleteChatsTitle => 'चैट हटाएँ?';

  @override
  String get deleteChatsText =>
      'चुनी गई चैट और उनके सभी सेव किए गए मैसेज सिर्फ़ इस ऐप से हटाए जाएँगे। इन्हें वापस नहीं लाया जा सकता।';

  @override
  String get statusViewedNote =>
      'आप व्हाट्सऐप में जो भी स्टेटस देखेंगे, वह यहाँ दिखेगा और आप उसे सेव कर सकेंगे।';

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
