// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get settings => 'Einstellungen';

  @override
  String get general => 'Allgemein';

  @override
  String get other => 'Sonstiges';

  @override
  String get language => 'Sprache';

  @override
  String get darkMode => 'Dunkelmodus';

  @override
  String get darkModeSub => 'Zwischen hellem und dunklem Design wechseln';

  @override
  String get saveProfilePictures => 'Profilbilder speichern';

  @override
  String get saveProfilePicturesSub =>
      'Das in Benachrichtigungen angezeigte Absenderfoto behalten';

  @override
  String get clearAllData => 'Alle Daten löschen';

  @override
  String get clearAllDataSub => 'Alle gespeicherten Nachrichten löschen';

  @override
  String get clearAllDataText =>
      'Alle gespeicherten Nachrichten und Profilbilder werden aus dieser App gelöscht. Dies kann nicht rückgängig gemacht werden.';

  @override
  String get allSavedMessagesDeleted =>
      'Alle gespeicherten Nachrichten wurden gelöscht';

  @override
  String couldNotClearData(String error) {
    return 'Daten konnten nicht gelöscht werden: $error';
  }

  @override
  String get restartService => 'Dienst neu starten';

  @override
  String get restartServiceSub =>
      'Falls Nachrichten nicht mehr gespeichert werden';

  @override
  String get guide => 'Anleitung';

  @override
  String get guideSub => 'So verwendest du die App';

  @override
  String get privacyPolicy => 'Datenschutzerklärung';

  @override
  String get privacyPolicySub => 'Wie deine Daten verwendet werden';

  @override
  String get rateUs => 'Bewerte uns';

  @override
  String get rateUsSub => 'Unterstütze uns mit deiner Bewertung';

  @override
  String get shareApp => 'App teilen';

  @override
  String get shareAppSub =>
      'Lade andere ein, ihre Nachrichten wiederherzustellen';

  @override
  String get disclaimer => 'Haftungsausschluss';

  @override
  String get disclaimerSub => 'Wichtige Informationen';

  @override
  String get feedback => 'Feedback';

  @override
  String get feedbackSub => 'Hilf uns, die App zu verbessern';

  @override
  String get aboutUs => 'Über uns';

  @override
  String get aboutUsSub => 'Mehr über die App erfahren';

  @override
  String get chooseLanguage => 'Sprache wählen';

  @override
  String get deviceLanguage => 'Gerätesprache';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get delete => 'Löschen';

  @override
  String get submit => 'Absenden';

  @override
  String get maybeLater => 'Vielleicht später';

  @override
  String get suggestedApps => 'Vorgeschlagene Apps';

  @override
  String get otherApps => 'Weitere Apps';

  @override
  String get messageRecovery => 'Nachrichten-Wiederherstellung';

  @override
  String get keepRunningInBackground => 'App im Hintergrund aktiv halten';

  @override
  String get battery => 'Akku';

  @override
  String get autoStart => 'Autostart';

  @override
  String get addMore => 'Mehr hinzufügen';

  @override
  String get allMessages => 'Alle Nachrichten';

  @override
  String get unreadMessages => 'Ungelesene Nachrichten';

  @override
  String get connectAppFirst => 'Verbinde zuerst eine App';

  @override
  String get supportComingSoon => 'Die Unterstützung für diese App kommt bald';

  @override
  String get allowNotificationAccess =>
      'Zugriff auf Benachrichtigungen erlauben';

  @override
  String get allowNotificationAccessText =>
      'Wir benötigen Zugriff auf Benachrichtigungen, um gelöschte Nachrichten wiederherzustellen. Hier gelesene Nachrichten zeigen keine blauen Haken.';

  @override
  String get allowPermission => 'Berechtigung erteilen';

  @override
  String get noNotificationsYet => 'Noch keine Benachrichtigungen';

  @override
  String get noNotificationsText =>
      'Wir zeigen deine Nachrichtenbenachrichtigungen hier an, sobald sie eintreffen.';

  @override
  String get noUnreadMessages => 'Keine ungelesenen Nachrichten';

  @override
  String get noUnreadText =>
      'Du bist auf dem neuesten Stand. Neue Nachrichten erscheinen hier.';

  @override
  String get navMessages => 'Nachrichten';

  @override
  String get navDeletedMedia => 'Gelöschte Medien';

  @override
  String get navSettings => 'Einstellungen';

  @override
  String get navCrown => 'Krone';

  @override
  String get comingSoon => 'Demnächst';

  @override
  String rateEnjoying(String appName) {
    return 'Gefällt dir $appName?';
  }

  @override
  String get rateSubtitle =>
      'Deine Bewertung hilft uns, besser zu werden, und hilft anderen, die App zu finden.';

  @override
  String get rateTapStar => 'Tippe auf einen Stern, um zu bewerten';

  @override
  String get ratePoor => 'Schlecht';

  @override
  String get rateFair => 'Mittelmäßig';

  @override
  String get rateGood => 'Gut';

  @override
  String get rateVeryGood => 'Sehr gut';

  @override
  String get rateExcellent => 'Ausgezeichnet';

  @override
  String get searchLanguage => 'Sprache suchen...';

  @override
  String get deleteMessagesTitle => 'Nachrichten löschen?';

  @override
  String get deleteMessagesText =>
      'Die ausgewählten Nachrichten werden nur aus dieser App gelöscht. Sie können nicht wiederhergestellt werden.';

  @override
  String get selectTooltip => 'Auswählen';

  @override
  String selectedCount(int count) {
    return '$count ausgewählt';
  }

  @override
  String get selectAll => 'Alle auswählen';

  @override
  String get clearSelection => 'Leeren';

  @override
  String deleteWithCount(int count) {
    return 'Löschen ($count)';
  }

  @override
  String get chatEmpty => 'Keine Nachrichten in diesem Chat';

  @override
  String get today => 'Heute';

  @override
  String get yesterday => 'Gestern';

  @override
  String get selectApps => 'Apps auswählen';

  @override
  String get searchApps => 'Apps suchen...';

  @override
  String get appsHeading => 'Apps';

  @override
  String get next => 'Weiter';

  @override
  String get pickAtLeastOneApp => 'Wähle mindestens eine App';

  @override
  String get restartingService => 'Dienst wird neu gestartet...';

  @override
  String get serviceRestarted =>
      'Dienst neu gestartet. Neue Nachrichten werden wieder gespeichert.';

  @override
  String get notificationAccessOffTitle =>
      'Benachrichtigungszugriff ist deaktiviert';

  @override
  String get notificationAccessOffText =>
      'Aktiviere den Benachrichtigungszugriff für diese App, sonst kann sie keine Nachrichten speichern.';

  @override
  String get restartNotConfirmedTitle => 'Neustart nicht bestätigt';

  @override
  String get restartNotConfirmedText =>
      'Der Neustart wurde angefordert, aber der Dienst hat ihn nicht bestätigt. Öffne den Benachrichtigungszugriff, schalte diese App aus und wieder ein und komm dann zurück.';

  @override
  String get close => 'Schließen';

  @override
  String get openSettings => 'Einstellungen öffnen';

  @override
  String get couldNotOpenPlayStore =>
      'Google Play konnte nicht geöffnet werden';

  @override
  String get noEmailApp => 'Keine E-Mail-App gefunden';

  @override
  String get premiumRecoverMessages => 'Gelöschte Nachrichten wiederherstellen';

  @override
  String get premiumRecoverMedia => 'Gelöschte Medien wiederherstellen';

  @override
  String get premiumRemoveAds => 'Werbung entfernen';

  @override
  String get premiumPrioritySupport => 'Bevorzugter Kundensupport';

  @override
  String get premiumUnlimitedRecovery => 'Unbegrenzte Datenwiederherstellung';

  @override
  String get planPro => 'Pro';

  @override
  String get planBasic => 'Basic';

  @override
  String get goPremium => 'Premium holen';

  @override
  String get goPremiumSubtitle =>
      'Schalte alle Funktionen frei und erlebe die beste Wiederherstellung.';

  @override
  String premiumPricePerWeek(String price) {
    return '$price / wöchentlich';
  }

  @override
  String get premiumTrialNote =>
      'nach Ende der KOSTENLOSEN 3-tägigen Testphase';

  @override
  String get startFreeTrial => 'Kostenlos testen';

  @override
  String get autoRenewNote =>
      'Das Abo verlängert sich automatisch. Jederzeit kündbar.';

  @override
  String guideIntro(String appName) {
    return 'Folge diesen Schritten einmal und $appName speichert eine Kopie deiner eingehenden Nachrichten.';
  }

  @override
  String guideStep(int number) {
    return 'Schritt $number';
  }

  @override
  String get guideStep1Title => 'Verbinde deine Apps';

  @override
  String guideStep1Text(String otherApps, String addMore) {
    return 'Tippe auf dem Startbildschirm auf eine App oder wähle „$otherApps“, um mehrere auf einmal auszuwählen. Mit der Schaltfläche „$addMore“ kannst du später weitere Apps hinzufügen.';
  }

  @override
  String get guideStep2Title => 'Benachrichtigungszugriff erlauben';

  @override
  String get guideStep2Text =>
      'Die App kann eine Nachricht nur speichern, wenn sie die Benachrichtigung der anderen App lesen kann. Öffne die Liste unten, suche diese App und schalte sie ein.';

  @override
  String get guideOpenNotificationAccess => 'Benachrichtigungszugriff öffnen';

  @override
  String get guideStep3Title => 'Im Hintergrund aktiv halten';

  @override
  String get guideStep3Text =>
      'Manche Smartphones schließen Hintergrund-Apps, um Akku zu sparen, wodurch Nachrichten verpasst werden können. Erlaube dieser App, ohne Akkubeschränkungen zu laufen, und aktiviere, falls vorhanden, den Autostart.';

  @override
  String get guideStep4Title => 'Was gespeichert wird';

  @override
  String get guideStep4Text => 'Beachte diese Punkte:';

  @override
  String get guideSaved1 =>
      'Lass Benachrichtigungen für wichtige Chats eingeschaltet. Stummgeschaltete Chats können nicht gespeichert werden.';

  @override
  String get guideSaved2 =>
      'Eine Nachricht wird nicht gespeichert, wenn du den Chat gerade angesehen hast.';

  @override
  String get guideSaved3 =>
      'Nur Text wird gespeichert. Fotos, Sprachnachrichten und Anrufe werden nicht wiederhergestellt.';

  @override
  String get guideStep5Title => 'Gespeicherte Nachrichten lesen';

  @override
  String guideStep5Text(String messagesTab, String unreadMessages) {
    return 'Öffne den Tab „$messagesTab“, wähle oben eine App und tippe dann auf eine Person, um die gespeicherte Unterhaltung zu sehen. Mit „$unreadMessages“ siehst du Chats, die du noch nicht geöffnet hast.';
  }

  @override
  String get guideStep6Title => 'Nachrichten löschen';

  @override
  String guideStep6Text(
    String selectAll,
    String delete,
    String settings,
    String clearAll,
  ) {
    return 'Halte eine Nachricht gedrückt oder tippe oben auf das Auswahlsymbol. Wähle Nachrichten oder „$selectAll“ und tippe auf „$delete“. Um alles auf einmal zu entfernen, nutze „$settings“ > „$clearAll“.';
  }

  @override
  String get guideStep7Title => 'Wird etwas nicht gespeichert?';

  @override
  String get guideStep7Text => 'Probiere diese Schritte der Reihe nach:';

  @override
  String get guideFix1 =>
      'Prüfe, ob der Benachrichtigungszugriff eingeschaltet ist.';

  @override
  String get guideFix2 => 'Prüfe die Akku- und Autostart-Einstellungen oben.';

  @override
  String get guideFix3 =>
      'Stelle sicher, dass die Benachrichtigungen für diesen Chat nicht stummgeschaltet sind.';

  @override
  String get guideFix4 => 'Starte den Dienst mit der Schaltfläche unten neu.';

  @override
  String get readDisclaimer => 'Haftungsausschluss lesen';

  @override
  String get ourStory => 'Unsere Geschichte';

  @override
  String aboutStory1(String appName) {
    return '$appName entstand aus einem einfachen Grund: Eine wichtige Nachricht sollte nicht verloren gehen, nur weil sie jemand gelöscht hat. Die App speichert eine Kopie der Nachrichten, die auf deinem Handy ankommen, geordnet nach App und Person, damit du sie später lesen kannst.';
  }

  @override
  String get aboutStory2 =>
      'Sie funktioniert, indem sie mit deiner Erlaubnis die Benachrichtigungen auf deinem eigenen Handy liest, und deine gespeicherten Nachrichten bleiben auf deinem Gerät.';

  @override
  String get highlights => 'Highlights';

  @override
  String get featureOrganizedTitle => 'Übersichtliche Chats';

  @override
  String get featureOrganizedText =>
      'Nachrichten werden nach App und Person gruppiert, genau wie in den Apps, die du bereits nutzt.';

  @override
  String get featurePrivateTitle => 'Privat von Grund auf';

  @override
  String get featurePrivateText =>
      'Gespeicherte Nachrichten bleiben auf deinem Handy und werden nie auf unsere Server hochgeladen.';

  @override
  String get featureBackgroundTitle => 'Läuft im Hintergrund';

  @override
  String get featureBackgroundText =>
      'Speichert neue Nachrichten auch bei geschlossener App weiter, solange dein Handy es erlaubt.';

  @override
  String get featureControlTitle => 'Du behältst die Kontrolle';

  @override
  String get featureControlText =>
      'Lösche jederzeit jede Nachricht oder jeden Chat oder schalte den Zugriff aus.';

  @override
  String get worksWith => 'Funktioniert mit';

  @override
  String get legalSupport => 'Rechtliches und Support';

  @override
  String get contactUs => 'Kontakt';

  @override
  String versionLabel(String version) {
    return 'Version $version';
  }

  @override
  String allRightsReserved(String year, String developer) {
    return '© $year $developer. Alle Rechte vorbehalten.';
  }

  @override
  String get notAffiliated =>
      'Nicht verbunden mit WhatsApp, Meta, Snapchat, TikTok oder einer anderen erwähnten App.';

  @override
  String get shareMessage =>
      'Speichere eine Kopie deiner eingehenden Nachrichten, auch wenn sie später gelöscht werden.';

  @override
  String get navStatus => 'Status';

  @override
  String get statusAllowTitle => 'Zugriff auf den Status-Ordner erlauben';

  @override
  String get statusAllowText =>
      'Um WhatsApp-Status anzuzeigen, wähle den Status-Ordner einmalig aus. Die App liest nur diesen Ordner, und es wird nichts hochgeladen.';

  @override
  String get statusChangeFolder => 'Ordner ändern';

  @override
  String get statusWrongFolder =>
      'Das scheint nicht der Status-Ordner zu sein. Bitte versuche es erneut.';

  @override
  String get statusEmptyTitle => 'Keine Status gefunden';

  @override
  String get statusEmptyText =>
      'Öffne zuerst WhatsApp und sieh dir einige Status an, komm dann zurück und ziehe zum Aktualisieren nach unten.';

  @override
  String get statusSaved => 'In deiner Galerie gespeichert';

  @override
  String get statusSaveFailed =>
      'Dieser Status konnte nicht gespeichert werden';

  @override
  String get saveAction => 'Speichern';

  @override
  String get statusOnlyWhatsApp =>
      'Es können nur WhatsApp-Status gespeichert werden. Facebook- und Instagram-Storys werden nicht auf deinem Handy gespeichert, daher kann diese App sie nicht sichern.';

  @override
  String get statusRespectNote =>
      'Speichere nur Inhalte, die du verwenden darfst.';

  @override
  String get statusChooseFolder => 'Zugriff erlauben';

  @override
  String get deleteChatsTitle => 'Chats löschen?';

  @override
  String get deleteChatsText =>
      'Die ausgewählten Chats und alle gespeicherten Nachrichten darin werden nur aus dieser App gelöscht. Sie können nicht wiederhergestellt werden.';

  @override
  String get statusViewedNote =>
      'Jeder Status, den du in WhatsApp ansiehst, erscheint hier und kann von dir gespeichert werden.';

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
