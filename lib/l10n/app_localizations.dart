import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_id.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_ur.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
    Locale('id'),
    Locale('pt'),
    Locale('ru'),
    Locale('tr'),
    Locale('ur'),
    Locale('zh'),
  ];

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @general.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @darkModeSub.
  ///
  /// In en, this message translates to:
  /// **'Switch between light and dark theme'**
  String get darkModeSub;

  /// No description provided for @saveProfilePictures.
  ///
  /// In en, this message translates to:
  /// **'Save Profile Pictures'**
  String get saveProfilePictures;

  /// No description provided for @saveProfilePicturesSub.
  ///
  /// In en, this message translates to:
  /// **'Keep the sender photo shown in notifications'**
  String get saveProfilePicturesSub;

  /// No description provided for @clearAllData.
  ///
  /// In en, this message translates to:
  /// **'Clear All Data'**
  String get clearAllData;

  /// No description provided for @clearAllDataSub.
  ///
  /// In en, this message translates to:
  /// **'Delete all saved messages'**
  String get clearAllDataSub;

  /// No description provided for @clearAllDataText.
  ///
  /// In en, this message translates to:
  /// **'All saved messages and profile pictures will be deleted from this app. This cannot be undone.'**
  String get clearAllDataText;

  /// No description provided for @allSavedMessagesDeleted.
  ///
  /// In en, this message translates to:
  /// **'All saved messages deleted'**
  String get allSavedMessagesDeleted;

  /// No description provided for @couldNotClearData.
  ///
  /// In en, this message translates to:
  /// **'Could not clear data: {error}'**
  String couldNotClearData(String error);

  /// No description provided for @restartService.
  ///
  /// In en, this message translates to:
  /// **'Restart Service'**
  String get restartService;

  /// No description provided for @restartServiceSub.
  ///
  /// In en, this message translates to:
  /// **'If messages stop being saved'**
  String get restartServiceSub;

  /// No description provided for @guide.
  ///
  /// In en, this message translates to:
  /// **'Guide'**
  String get guide;

  /// No description provided for @guideSub.
  ///
  /// In en, this message translates to:
  /// **'Learn how to use the app'**
  String get guideSub;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @privacyPolicySub.
  ///
  /// In en, this message translates to:
  /// **'How your data is used'**
  String get privacyPolicySub;

  /// No description provided for @rateUs.
  ///
  /// In en, this message translates to:
  /// **'Rate Us'**
  String get rateUs;

  /// No description provided for @rateUsSub.
  ///
  /// In en, this message translates to:
  /// **'Support us with your valuable rating'**
  String get rateUsSub;

  /// No description provided for @shareApp.
  ///
  /// In en, this message translates to:
  /// **'Share App'**
  String get shareApp;

  /// No description provided for @shareAppSub.
  ///
  /// In en, this message translates to:
  /// **'Invite others to recover their messages'**
  String get shareAppSub;

  /// No description provided for @disclaimer.
  ///
  /// In en, this message translates to:
  /// **'Disclaimer'**
  String get disclaimer;

  /// No description provided for @disclaimerSub.
  ///
  /// In en, this message translates to:
  /// **'Important information'**
  String get disclaimerSub;

  /// No description provided for @feedback.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get feedback;

  /// No description provided for @feedbackSub.
  ///
  /// In en, this message translates to:
  /// **'Help us improve the app'**
  String get feedbackSub;

  /// No description provided for @aboutUs.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get aboutUs;

  /// No description provided for @aboutUsSub.
  ///
  /// In en, this message translates to:
  /// **'Know more about the app'**
  String get aboutUsSub;

  /// No description provided for @chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose language'**
  String get chooseLanguage;

  /// No description provided for @deviceLanguage.
  ///
  /// In en, this message translates to:
  /// **'Device language'**
  String get deviceLanguage;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @maybeLater.
  ///
  /// In en, this message translates to:
  /// **'Maybe later'**
  String get maybeLater;

  /// No description provided for @suggestedApps.
  ///
  /// In en, this message translates to:
  /// **'Suggested apps'**
  String get suggestedApps;

  /// No description provided for @otherApps.
  ///
  /// In en, this message translates to:
  /// **'Other apps'**
  String get otherApps;

  /// No description provided for @messageRecovery.
  ///
  /// In en, this message translates to:
  /// **'Message Recovery'**
  String get messageRecovery;

  /// No description provided for @keepRunningInBackground.
  ///
  /// In en, this message translates to:
  /// **'Keep the app running in the background'**
  String get keepRunningInBackground;

  /// No description provided for @battery.
  ///
  /// In en, this message translates to:
  /// **'Battery'**
  String get battery;

  /// No description provided for @autoStart.
  ///
  /// In en, this message translates to:
  /// **'Auto-start'**
  String get autoStart;

  /// No description provided for @addMore.
  ///
  /// In en, this message translates to:
  /// **'Add more'**
  String get addMore;

  /// No description provided for @allMessages.
  ///
  /// In en, this message translates to:
  /// **'All Messages'**
  String get allMessages;

  /// No description provided for @unreadMessages.
  ///
  /// In en, this message translates to:
  /// **'Unread Messages'**
  String get unreadMessages;

  /// No description provided for @connectAppFirst.
  ///
  /// In en, this message translates to:
  /// **'Connect an app first'**
  String get connectAppFirst;

  /// No description provided for @supportComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Support for this app is coming soon'**
  String get supportComingSoon;

  /// No description provided for @allowNotificationAccess.
  ///
  /// In en, this message translates to:
  /// **'Allow Notification Access'**
  String get allowNotificationAccess;

  /// No description provided for @allowNotificationAccessText.
  ///
  /// In en, this message translates to:
  /// **'We need notification access to recover deleted messages. Messages read here won’t show blue ticks.'**
  String get allowNotificationAccessText;

  /// No description provided for @allowPermission.
  ///
  /// In en, this message translates to:
  /// **'Allow Permission'**
  String get allowPermission;

  /// No description provided for @noNotificationsYet.
  ///
  /// In en, this message translates to:
  /// **'No Notifications Yet'**
  String get noNotificationsYet;

  /// No description provided for @noNotificationsText.
  ///
  /// In en, this message translates to:
  /// **'We’ll show your message notifications here as soon as they arrive.'**
  String get noNotificationsText;

  /// No description provided for @noUnreadMessages.
  ///
  /// In en, this message translates to:
  /// **'No Unread Messages'**
  String get noUnreadMessages;

  /// No description provided for @noUnreadText.
  ///
  /// In en, this message translates to:
  /// **'You’re all caught up. New messages will appear here.'**
  String get noUnreadText;

  /// No description provided for @navMessages.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get navMessages;

  /// No description provided for @navDeletedMedia.
  ///
  /// In en, this message translates to:
  /// **'Deleted Media'**
  String get navDeletedMedia;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @navCrown.
  ///
  /// In en, this message translates to:
  /// **'Crown'**
  String get navCrown;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get comingSoon;

  /// No description provided for @rateEnjoying.
  ///
  /// In en, this message translates to:
  /// **'Enjoying {appName}?'**
  String rateEnjoying(String appName);

  /// No description provided for @rateSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your rating helps us improve and helps others find the app.'**
  String get rateSubtitle;

  /// No description provided for @rateTapStar.
  ///
  /// In en, this message translates to:
  /// **'Tap a star to rate'**
  String get rateTapStar;

  /// No description provided for @ratePoor.
  ///
  /// In en, this message translates to:
  /// **'Poor'**
  String get ratePoor;

  /// No description provided for @rateFair.
  ///
  /// In en, this message translates to:
  /// **'Fair'**
  String get rateFair;

  /// No description provided for @rateGood.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get rateGood;

  /// No description provided for @rateVeryGood.
  ///
  /// In en, this message translates to:
  /// **'Very good'**
  String get rateVeryGood;

  /// No description provided for @rateExcellent.
  ///
  /// In en, this message translates to:
  /// **'Excellent'**
  String get rateExcellent;

  /// No description provided for @searchLanguage.
  ///
  /// In en, this message translates to:
  /// **'Search language...'**
  String get searchLanguage;

  /// No description provided for @deleteMessagesTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete messages?'**
  String get deleteMessagesTitle;

  /// No description provided for @deleteMessagesText.
  ///
  /// In en, this message translates to:
  /// **'The selected messages will be deleted from this app only. They cannot be restored.'**
  String get deleteMessagesText;

  /// No description provided for @selectTooltip.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get selectTooltip;

  /// No description provided for @selectedCount.
  ///
  /// In en, this message translates to:
  /// **'{count} selected'**
  String selectedCount(int count);

  /// No description provided for @selectAll.
  ///
  /// In en, this message translates to:
  /// **'Select all'**
  String get selectAll;

  /// No description provided for @clearSelection.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clearSelection;

  /// No description provided for @deleteWithCount.
  ///
  /// In en, this message translates to:
  /// **'Delete ({count})'**
  String deleteWithCount(int count);

  /// No description provided for @chatEmpty.
  ///
  /// In en, this message translates to:
  /// **'No messages in this chat'**
  String get chatEmpty;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @selectApps.
  ///
  /// In en, this message translates to:
  /// **'Select Apps'**
  String get selectApps;

  /// No description provided for @searchApps.
  ///
  /// In en, this message translates to:
  /// **'Search apps...'**
  String get searchApps;

  /// No description provided for @appsHeading.
  ///
  /// In en, this message translates to:
  /// **'Apps'**
  String get appsHeading;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @pickAtLeastOneApp.
  ///
  /// In en, this message translates to:
  /// **'Pick at least one app'**
  String get pickAtLeastOneApp;

  /// No description provided for @restartingService.
  ///
  /// In en, this message translates to:
  /// **'Restarting service...'**
  String get restartingService;

  /// No description provided for @serviceRestarted.
  ///
  /// In en, this message translates to:
  /// **'Service restarted. New messages will be saved again.'**
  String get serviceRestarted;

  /// No description provided for @notificationAccessOffTitle.
  ///
  /// In en, this message translates to:
  /// **'Notification access is off'**
  String get notificationAccessOffTitle;

  /// No description provided for @notificationAccessOffText.
  ///
  /// In en, this message translates to:
  /// **'Turn on Notification access for this app, otherwise it cannot save messages.'**
  String get notificationAccessOffText;

  /// No description provided for @restartNotConfirmedTitle.
  ///
  /// In en, this message translates to:
  /// **'Restart not confirmed'**
  String get restartNotConfirmedTitle;

  /// No description provided for @restartNotConfirmedText.
  ///
  /// In en, this message translates to:
  /// **'The restart was requested but the service did not confirm. Open Notification access, switch this app off and on again, then come back.'**
  String get restartNotConfirmedText;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @openSettings.
  ///
  /// In en, this message translates to:
  /// **'Open settings'**
  String get openSettings;

  /// No description provided for @couldNotOpenPlayStore.
  ///
  /// In en, this message translates to:
  /// **'Could not open Google Play'**
  String get couldNotOpenPlayStore;

  /// No description provided for @noEmailApp.
  ///
  /// In en, this message translates to:
  /// **'No email app found'**
  String get noEmailApp;

  /// No description provided for @premiumRecoverMessages.
  ///
  /// In en, this message translates to:
  /// **'Recover Deleted Messages'**
  String get premiumRecoverMessages;

  /// No description provided for @premiumRecoverMedia.
  ///
  /// In en, this message translates to:
  /// **'Recover Deleted Media'**
  String get premiumRecoverMedia;

  /// No description provided for @premiumRemoveAds.
  ///
  /// In en, this message translates to:
  /// **'Remove Ads'**
  String get premiumRemoveAds;

  /// No description provided for @premiumPrioritySupport.
  ///
  /// In en, this message translates to:
  /// **'Priority Customer Support'**
  String get premiumPrioritySupport;

  /// No description provided for @premiumUnlimitedRecovery.
  ///
  /// In en, this message translates to:
  /// **'Unlimited Data Recovery'**
  String get premiumUnlimitedRecovery;

  /// No description provided for @planPro.
  ///
  /// In en, this message translates to:
  /// **'Pro'**
  String get planPro;

  /// No description provided for @planBasic.
  ///
  /// In en, this message translates to:
  /// **'Basic'**
  String get planBasic;

  /// No description provided for @goPremium.
  ///
  /// In en, this message translates to:
  /// **'Go Premium'**
  String get goPremium;

  /// No description provided for @goPremiumSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Unlock all features and get the best recovery experience.'**
  String get goPremiumSubtitle;

  /// No description provided for @premiumPricePerWeek.
  ///
  /// In en, this message translates to:
  /// **'{price} / Weekly'**
  String premiumPricePerWeek(String price);

  /// No description provided for @premiumTrialNote.
  ///
  /// In en, this message translates to:
  /// **'after FREE 3-days trial ends'**
  String get premiumTrialNote;

  /// No description provided for @startFreeTrial.
  ///
  /// In en, this message translates to:
  /// **'Start Free Trial'**
  String get startFreeTrial;

  /// No description provided for @autoRenewNote.
  ///
  /// In en, this message translates to:
  /// **'Subscription will auto-renew, Cancel anytime.'**
  String get autoRenewNote;

  /// No description provided for @guideIntro.
  ///
  /// In en, this message translates to:
  /// **'Follow these steps once and {appName} will keep a copy of your incoming messages.'**
  String guideIntro(String appName);

  /// No description provided for @guideStep.
  ///
  /// In en, this message translates to:
  /// **'Step {number}'**
  String guideStep(int number);

  /// No description provided for @guideStep1Title.
  ///
  /// In en, this message translates to:
  /// **'Connect your apps'**
  String get guideStep1Title;

  /// No description provided for @guideStep1Text.
  ///
  /// In en, this message translates to:
  /// **'On the home screen tap an app, or choose “{otherApps}” to pick several at once. You can add more apps later with the “{addMore}” button.'**
  String guideStep1Text(String otherApps, String addMore);

  /// No description provided for @guideStep2Title.
  ///
  /// In en, this message translates to:
  /// **'Allow notification access'**
  String get guideStep2Title;

  /// No description provided for @guideStep2Text.
  ///
  /// In en, this message translates to:
  /// **'The app can only save a message when it can read the notification that the other app shows. Open the list below, find this app and switch it on.'**
  String get guideStep2Text;

  /// No description provided for @guideOpenNotificationAccess.
  ///
  /// In en, this message translates to:
  /// **'Open Notification access'**
  String get guideOpenNotificationAccess;

  /// No description provided for @guideStep3Title.
  ///
  /// In en, this message translates to:
  /// **'Keep it running in the background'**
  String get guideStep3Title;

  /// No description provided for @guideStep3Text.
  ///
  /// In en, this message translates to:
  /// **'Some phones close background apps to save battery, which can make you miss messages. Allow this app to run without battery restrictions and, if your phone has it, turn on Auto-start.'**
  String get guideStep3Text;

  /// No description provided for @guideStep4Title.
  ///
  /// In en, this message translates to:
  /// **'What gets saved'**
  String get guideStep4Title;

  /// No description provided for @guideStep4Text.
  ///
  /// In en, this message translates to:
  /// **'Keep these points in mind:'**
  String get guideStep4Text;

  /// No description provided for @guideSaved1.
  ///
  /// In en, this message translates to:
  /// **'Keep notifications on for the chats you care about. Muted chats cannot be saved.'**
  String get guideSaved1;

  /// No description provided for @guideSaved2.
  ///
  /// In en, this message translates to:
  /// **'A message is not saved if you were already looking at that chat.'**
  String get guideSaved2;

  /// No description provided for @guideSaved3.
  ///
  /// In en, this message translates to:
  /// **'Only text is saved. Photos, voice messages and calls are not recovered.'**
  String get guideSaved3;

  /// No description provided for @guideStep5Title.
  ///
  /// In en, this message translates to:
  /// **'Read your saved messages'**
  String get guideStep5Title;

  /// No description provided for @guideStep5Text.
  ///
  /// In en, this message translates to:
  /// **'Open the “{messagesTab}” tab, pick an app at the top, then tap a person to see the saved conversation. Use “{unreadMessages}” to see chats you have not opened yet.'**
  String guideStep5Text(String messagesTab, String unreadMessages);

  /// No description provided for @guideStep6Title.
  ///
  /// In en, this message translates to:
  /// **'Delete messages'**
  String get guideStep6Title;

  /// No description provided for @guideStep6Text.
  ///
  /// In en, this message translates to:
  /// **'Press and hold a message, or tap the select icon at the top. Choose messages or “{selectAll}”, then tap “{delete}”. To remove everything at once, use “{settings}” > “{clearAll}”.'**
  String guideStep6Text(
    String selectAll,
    String delete,
    String settings,
    String clearAll,
  );

  /// No description provided for @guideStep7Title.
  ///
  /// In en, this message translates to:
  /// **'Something not saving?'**
  String get guideStep7Title;

  /// No description provided for @guideStep7Text.
  ///
  /// In en, this message translates to:
  /// **'Try these in order:'**
  String get guideStep7Text;

  /// No description provided for @guideFix1.
  ///
  /// In en, this message translates to:
  /// **'Check that Notification access is on.'**
  String get guideFix1;

  /// No description provided for @guideFix2.
  ///
  /// In en, this message translates to:
  /// **'Check the battery and Auto-start settings above.'**
  String get guideFix2;

  /// No description provided for @guideFix3.
  ///
  /// In en, this message translates to:
  /// **'Make sure notifications are not muted for that chat.'**
  String get guideFix3;

  /// No description provided for @guideFix4.
  ///
  /// In en, this message translates to:
  /// **'Restart the service with the button below.'**
  String get guideFix4;

  /// No description provided for @readDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Read the disclaimer'**
  String get readDisclaimer;

  /// No description provided for @ourStory.
  ///
  /// In en, this message translates to:
  /// **'Our story'**
  String get ourStory;

  /// No description provided for @aboutStory1.
  ///
  /// In en, this message translates to:
  /// **'{appName} was built for a simple reason: an important message should not be lost just because someone deleted it. The app keeps a copy of the messages that arrive on your phone, organized by app and by person, so you can read them later.'**
  String aboutStory1(String appName);

  /// No description provided for @aboutStory2.
  ///
  /// In en, this message translates to:
  /// **'It works by reading the notifications on your own phone, with your permission, and your saved messages stay on your device.'**
  String get aboutStory2;

  /// No description provided for @highlights.
  ///
  /// In en, this message translates to:
  /// **'Highlights'**
  String get highlights;

  /// No description provided for @featureOrganizedTitle.
  ///
  /// In en, this message translates to:
  /// **'Organized chats'**
  String get featureOrganizedTitle;

  /// No description provided for @featureOrganizedText.
  ///
  /// In en, this message translates to:
  /// **'Messages are grouped by app and by person, just like the apps you already use.'**
  String get featureOrganizedText;

  /// No description provided for @featurePrivateTitle.
  ///
  /// In en, this message translates to:
  /// **'Private by design'**
  String get featurePrivateTitle;

  /// No description provided for @featurePrivateText.
  ///
  /// In en, this message translates to:
  /// **'Saved messages stay on your phone and are never uploaded to our servers.'**
  String get featurePrivateText;

  /// No description provided for @featureBackgroundTitle.
  ///
  /// In en, this message translates to:
  /// **'Works in the background'**
  String get featureBackgroundTitle;

  /// No description provided for @featureBackgroundText.
  ///
  /// In en, this message translates to:
  /// **'Keeps saving new messages even when the app is closed, as long as your phone allows it.'**
  String get featureBackgroundText;

  /// No description provided for @featureControlTitle.
  ///
  /// In en, this message translates to:
  /// **'You stay in control'**
  String get featureControlTitle;

  /// No description provided for @featureControlText.
  ///
  /// In en, this message translates to:
  /// **'Delete any message or chat, or turn off access, whenever you like.'**
  String get featureControlText;

  /// No description provided for @worksWith.
  ///
  /// In en, this message translates to:
  /// **'Works with'**
  String get worksWith;

  /// No description provided for @legalSupport.
  ///
  /// In en, this message translates to:
  /// **'Legal & support'**
  String get legalSupport;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact us'**
  String get contactUs;

  /// No description provided for @versionLabel.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String versionLabel(String version);

  /// No description provided for @allRightsReserved.
  ///
  /// In en, this message translates to:
  /// **'© {year} {developer}. All rights reserved.'**
  String allRightsReserved(String year, String developer);

  /// No description provided for @notAffiliated.
  ///
  /// In en, this message translates to:
  /// **'Not affiliated with WhatsApp, Meta, Snapchat, TikTok or any other app mentioned.'**
  String get notAffiliated;

  /// No description provided for @shareMessage.
  ///
  /// In en, this message translates to:
  /// **'Keep a copy of your incoming messages, even if they are deleted later.'**
  String get shareMessage;

  /// No description provided for @navStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get navStatus;

  /// No description provided for @statusAllowTitle.
  ///
  /// In en, this message translates to:
  /// **'Allow access to the Status folder'**
  String get statusAllowTitle;

  /// No description provided for @statusAllowText.
  ///
  /// In en, this message translates to:
  /// **'To show WhatsApp statuses, choose the Status folder once. The app only reads this folder and nothing is uploaded.'**
  String get statusAllowText;

  /// No description provided for @statusChangeFolder.
  ///
  /// In en, this message translates to:
  /// **'Change folder'**
  String get statusChangeFolder;

  /// No description provided for @statusWrongFolder.
  ///
  /// In en, this message translates to:
  /// **'That doesn’t look like the Status folder. Please try again.'**
  String get statusWrongFolder;

  /// No description provided for @statusEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No statuses found'**
  String get statusEmptyTitle;

  /// No description provided for @statusEmptyText.
  ///
  /// In en, this message translates to:
  /// **'Open WhatsApp and view a few statuses first, then come back and pull down to refresh.'**
  String get statusEmptyText;

  /// No description provided for @statusSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved to your gallery'**
  String get statusSaved;

  /// No description provided for @statusSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not save this status'**
  String get statusSaveFailed;

  /// No description provided for @saveAction.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveAction;

  /// No description provided for @statusOnlyWhatsApp.
  ///
  /// In en, this message translates to:
  /// **'Only WhatsApp statuses can be saved. Facebook and Instagram stories are not stored on your phone, so this app cannot save them.'**
  String get statusOnlyWhatsApp;

  /// No description provided for @statusRespectNote.
  ///
  /// In en, this message translates to:
  /// **'Please save only content you have the right to use.'**
  String get statusRespectNote;

  /// No description provided for @statusChooseFolder.
  ///
  /// In en, this message translates to:
  /// **'Allow access'**
  String get statusChooseFolder;

  /// No description provided for @deleteChatsTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete chats?'**
  String get deleteChatsTitle;

  /// No description provided for @deleteChatsText.
  ///
  /// In en, this message translates to:
  /// **'The selected chats and all their saved messages will be deleted from this app only. They cannot be restored.'**
  String get deleteChatsText;

  /// No description provided for @statusViewedNote.
  ///
  /// In en, this message translates to:
  /// **'Any status you view in WhatsApp will appear here, and you can save it.'**
  String get statusViewedNote;

  /// No description provided for @premiumPriceLine.
  ///
  /// In en, this message translates to:
  /// **'{price} / month'**
  String premiumPriceLine(String price);

  /// No description provided for @premiumPriceUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Price unavailable. Please try again later.'**
  String get premiumPriceUnavailable;

  /// No description provided for @subscribeNow.
  ///
  /// In en, this message translates to:
  /// **'Subscribe'**
  String get subscribeNow;

  /// No description provided for @restorePurchases.
  ///
  /// In en, this message translates to:
  /// **'Restore purchases'**
  String get restorePurchases;

  /// No description provided for @youArePremium.
  ///
  /// In en, this message translates to:
  /// **'You are Premium. Thank you!'**
  String get youArePremium;

  /// No description provided for @premiumSaveAnyStatus.
  ///
  /// In en, this message translates to:
  /// **'Save any status'**
  String get premiumSaveAnyStatus;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'de',
    'en',
    'es',
    'fr',
    'hi',
    'id',
    'pt',
    'ru',
    'tr',
    'ur',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'id':
      return AppLocalizationsId();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'tr':
      return AppLocalizationsTr();
    case 'ur':
      return AppLocalizationsUr();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
