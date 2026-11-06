// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get settings => 'Paramètres';

  @override
  String get general => 'Général';

  @override
  String get other => 'Autres';

  @override
  String get language => 'Langue';

  @override
  String get darkMode => 'Mode sombre';

  @override
  String get darkModeSub => 'Basculer entre le thème clair et le thème sombre';

  @override
  String get saveProfilePictures => 'Enregistrer les photos de profil';

  @override
  String get saveProfilePicturesSub =>
      'Conserver la photo de l’expéditeur affichée dans les notifications';

  @override
  String get clearAllData => 'Effacer toutes les données';

  @override
  String get clearAllDataSub => 'Supprimer tous les messages enregistrés';

  @override
  String get clearAllDataText =>
      'Tous les messages enregistrés et les photos de profil seront supprimés de cette application. Cette action est irréversible.';

  @override
  String get allSavedMessagesDeleted =>
      'Tous les messages enregistrés ont été supprimés';

  @override
  String couldNotClearData(String error) {
    return 'Impossible d’effacer les données : $error';
  }

  @override
  String get restartService => 'Redémarrer le service';

  @override
  String get restartServiceSub => 'Si les messages ne sont plus enregistrés';

  @override
  String get guide => 'Guide';

  @override
  String get guideSub => 'Apprendre à utiliser l’application';

  @override
  String get privacyPolicy => 'Politique de confidentialité';

  @override
  String get privacyPolicySub => 'Comment vos données sont utilisées';

  @override
  String get rateUs => 'Notez-nous';

  @override
  String get rateUsSub => 'Soutenez-nous avec votre note';

  @override
  String get shareApp => 'Partager l’application';

  @override
  String get shareAppSub =>
      'Invitez d’autres personnes à récupérer leurs messages';

  @override
  String get disclaimer => 'Avertissement';

  @override
  String get disclaimerSub => 'Informations importantes';

  @override
  String get feedback => 'Avis';

  @override
  String get feedbackSub => 'Aidez-nous à améliorer l’application';

  @override
  String get aboutUs => 'À propos';

  @override
  String get aboutUsSub => 'En savoir plus sur l’application';

  @override
  String get chooseLanguage => 'Choisir la langue';

  @override
  String get deviceLanguage => 'Langue de l’appareil';

  @override
  String get cancel => 'Annuler';

  @override
  String get delete => 'Supprimer';

  @override
  String get submit => 'Envoyer';

  @override
  String get maybeLater => 'Plus tard';

  @override
  String get suggestedApps => 'Applications suggérées';

  @override
  String get otherApps => 'Autres applications';

  @override
  String get messageRecovery => 'Récupération de messages';

  @override
  String get keepRunningInBackground =>
      'Gardez l’application active en arrière-plan';

  @override
  String get battery => 'Batterie';

  @override
  String get autoStart => 'Démarrage auto';

  @override
  String get addMore => 'Ajouter';

  @override
  String get allMessages => 'Tous les messages';

  @override
  String get unreadMessages => 'Messages non lus';

  @override
  String get connectAppFirst => 'Connectez d’abord une application';

  @override
  String get supportComingSoon =>
      'La prise en charge de cette application arrive bientôt';

  @override
  String get allowNotificationAccess => 'Autoriser l’accès aux notifications';

  @override
  String get allowNotificationAccessText =>
      'Nous avons besoin de l’accès aux notifications pour récupérer les messages supprimés. Les messages lus ici n’afficheront pas les coches bleues.';

  @override
  String get allowPermission => 'Autoriser';

  @override
  String get noNotificationsYet => 'Aucune notification pour le moment';

  @override
  String get noNotificationsText =>
      'Nous afficherons ici les notifications de vos messages dès leur arrivée.';

  @override
  String get noUnreadMessages => 'Aucun message non lu';

  @override
  String get noUnreadText =>
      'Vous êtes à jour. Les nouveaux messages apparaîtront ici.';

  @override
  String get navMessages => 'Messages';

  @override
  String get navDeletedMedia => 'Médias supprimés';

  @override
  String get navSettings => 'Paramètres';

  @override
  String get navCrown => 'Couronne';

  @override
  String get comingSoon => 'Bientôt disponible';

  @override
  String rateEnjoying(String appName) {
    return 'Vous aimez $appName ?';
  }

  @override
  String get rateSubtitle =>
      'Votre note nous aide à nous améliorer et aide d’autres personnes à trouver l’application.';

  @override
  String get rateTapStar => 'Touchez une étoile pour noter';

  @override
  String get ratePoor => 'Mauvais';

  @override
  String get rateFair => 'Passable';

  @override
  String get rateGood => 'Bien';

  @override
  String get rateVeryGood => 'Très bien';

  @override
  String get rateExcellent => 'Excellent';

  @override
  String get searchLanguage => 'Rechercher une langue';

  @override
  String get deleteMessagesTitle => 'Supprimer les messages ?';

  @override
  String get deleteMessagesText =>
      'Les messages sélectionnés seront supprimés de cette application uniquement. Ils ne pourront pas être restaurés.';

  @override
  String get selectTooltip => 'Sélectionner';

  @override
  String selectedCount(int count) {
    return '$count sélectionné(s)';
  }

  @override
  String get selectAll => 'Tout sélectionner';

  @override
  String get clearSelection => 'Effacer';

  @override
  String deleteWithCount(int count) {
    return 'Supprimer ($count)';
  }

  @override
  String get chatEmpty => 'Aucun message dans cette conversation';

  @override
  String get today => 'Aujourd’hui';

  @override
  String get yesterday => 'Hier';

  @override
  String get selectApps => 'Sélectionner des applications';

  @override
  String get searchApps => 'Rechercher des applications...';

  @override
  String get appsHeading => 'Applications';

  @override
  String get next => 'Suivant';

  @override
  String get pickAtLeastOneApp => 'Choisissez au moins une application';

  @override
  String get restartingService => 'Redémarrage du service...';

  @override
  String get serviceRestarted =>
      'Service redémarré. Les nouveaux messages seront de nouveau enregistrés.';

  @override
  String get notificationAccessOffTitle =>
      'L’accès aux notifications est désactivé';

  @override
  String get notificationAccessOffText =>
      'Activez l’accès aux notifications pour cette application, sinon elle ne peut pas enregistrer les messages.';

  @override
  String get restartNotConfirmedTitle => 'Redémarrage non confirmé';

  @override
  String get restartNotConfirmedText =>
      'Le redémarrage a été demandé mais le service ne l’a pas confirmé. Ouvrez l’accès aux notifications, désactivez puis réactivez cette application, puis revenez.';

  @override
  String get close => 'Fermer';

  @override
  String get openSettings => 'Ouvrir les paramètres';

  @override
  String get couldNotOpenPlayStore => 'Impossible d’ouvrir Google Play';

  @override
  String get noEmailApp => 'Aucune application de messagerie trouvée';

  @override
  String get premiumRecoverMessages => 'Récupérer les messages supprimés';

  @override
  String get premiumRecoverMedia => 'Récupérer les médias supprimés';

  @override
  String get premiumRemoveAds => 'Supprimer les publicités';

  @override
  String get premiumPrioritySupport => 'Assistance client prioritaire';

  @override
  String get premiumUnlimitedRecovery => 'Récupération de données illimitée';

  @override
  String get planPro => 'Pro';

  @override
  String get planBasic => 'Basique';

  @override
  String get goPremium => 'Passez à Premium';

  @override
  String get goPremiumSubtitle =>
      'Débloquez toutes les fonctionnalités et profitez de la meilleure expérience de récupération.';

  @override
  String premiumPricePerWeek(String price) {
    return '$price / semaine';
  }

  @override
  String get premiumTrialNote => 'après la fin de l’essai GRATUIT de 3 jours';

  @override
  String get startFreeTrial => 'Commencer l’essai gratuit';

  @override
  String get autoRenewNote =>
      'L’abonnement se renouvelle automatiquement. Annulez à tout moment.';

  @override
  String guideIntro(String appName) {
    return 'Suivez ces étapes une seule fois et $appName conservera une copie de vos messages entrants.';
  }

  @override
  String guideStep(int number) {
    return 'Étape $number';
  }

  @override
  String get guideStep1Title => 'Connectez vos applications';

  @override
  String guideStep1Text(String otherApps, String addMore) {
    return 'Sur l’écran d’accueil, touchez une application ou choisissez « $otherApps » pour en sélectionner plusieurs à la fois. Vous pourrez en ajouter d’autres plus tard avec le bouton « $addMore ».';
  }

  @override
  String get guideStep2Title => 'Autorisez l’accès aux notifications';

  @override
  String get guideStep2Text =>
      'L’application ne peut enregistrer un message que si elle peut lire la notification affichée par l’autre application. Ouvrez la liste ci-dessous, trouvez cette application et activez-la.';

  @override
  String get guideOpenNotificationAccess => 'Ouvrir l’accès aux notifications';

  @override
  String get guideStep3Title => 'Gardez-la active en arrière-plan';

  @override
  String get guideStep3Text =>
      'Certains téléphones ferment les applications en arrière-plan pour économiser la batterie, ce qui peut vous faire manquer des messages. Autorisez cette application à fonctionner sans restriction de batterie et, si votre téléphone le propose, activez le démarrage automatique.';

  @override
  String get guideStep4Title => 'Ce qui est enregistré';

  @override
  String get guideStep4Text => 'Gardez ces points à l’esprit :';

  @override
  String get guideSaved1 =>
      'Gardez les notifications activées pour les conversations qui comptent. Les conversations en sourdine ne peuvent pas être enregistrées.';

  @override
  String get guideSaved2 =>
      'Un message n’est pas enregistré si vous consultiez déjà cette conversation.';

  @override
  String get guideSaved3 =>
      'Seul le texte est enregistré. Les photos, messages vocaux et appels ne sont pas récupérés.';

  @override
  String get guideStep5Title => 'Lisez vos messages enregistrés';

  @override
  String guideStep5Text(String messagesTab, String unreadMessages) {
    return 'Ouvrez l’onglet « $messagesTab », choisissez une application en haut, puis touchez une personne pour voir la conversation enregistrée. Utilisez « $unreadMessages » pour voir les conversations que vous n’avez pas encore ouvertes.';
  }

  @override
  String get guideStep6Title => 'Supprimez des messages';

  @override
  String guideStep6Text(
    String selectAll,
    String delete,
    String settings,
    String clearAll,
  ) {
    return 'Appuyez longuement sur un message ou touchez l’icône de sélection en haut. Choisissez des messages ou « $selectAll », puis touchez « $delete ». Pour tout supprimer d’un coup, utilisez « $settings » > « $clearAll ».';
  }

  @override
  String get guideStep7Title => 'Quelque chose ne s’enregistre pas ?';

  @override
  String get guideStep7Text => 'Essayez ceci dans l’ordre :';

  @override
  String get guideFix1 => 'Vérifiez que l’accès aux notifications est activé.';

  @override
  String get guideFix2 =>
      'Vérifiez les paramètres de batterie et de démarrage automatique ci-dessus.';

  @override
  String get guideFix3 =>
      'Assurez-vous que les notifications de cette conversation ne sont pas en sourdine.';

  @override
  String get guideFix4 => 'Redémarrez le service avec le bouton ci-dessous.';

  @override
  String get readDisclaimer => 'Lire l’avertissement';

  @override
  String get ourStory => 'Notre histoire';

  @override
  String aboutStory1(String appName) {
    return '$appName est né d’une raison simple : un message important ne devrait pas être perdu simplement parce que quelqu’un l’a supprimé. L’application conserve une copie des messages qui arrivent sur votre téléphone, organisés par application et par personne, afin que vous puissiez les lire plus tard.';
  }

  @override
  String get aboutStory2 =>
      'Elle fonctionne en lisant les notifications de votre propre téléphone, avec votre autorisation, et vos messages enregistrés restent sur votre appareil.';

  @override
  String get highlights => 'Points forts';

  @override
  String get featureOrganizedTitle => 'Conversations organisées';

  @override
  String get featureOrganizedText =>
      'Les messages sont regroupés par application et par personne, comme dans les applications que vous utilisez déjà.';

  @override
  String get featurePrivateTitle => 'Confidentielle par conception';

  @override
  String get featurePrivateText =>
      'Les messages enregistrés restent sur votre téléphone et ne sont jamais envoyés vers nos serveurs.';

  @override
  String get featureBackgroundTitle => 'Fonctionne en arrière-plan';

  @override
  String get featureBackgroundText =>
      'Continue d’enregistrer les nouveaux messages même lorsque l’application est fermée, tant que votre téléphone l’autorise.';

  @override
  String get featureControlTitle => 'Vous gardez le contrôle';

  @override
  String get featureControlText =>
      'Supprimez n’importe quel message ou conversation, ou désactivez l’accès, quand vous le souhaitez.';

  @override
  String get worksWith => 'Compatible avec';

  @override
  String get legalSupport => 'Mentions légales et assistance';

  @override
  String get contactUs => 'Nous contacter';

  @override
  String versionLabel(String version) {
    return 'Version $version';
  }

  @override
  String allRightsReserved(String year, String developer) {
    return '© $year $developer. Tous droits réservés.';
  }

  @override
  String get notAffiliated =>
      'Non affiliée à WhatsApp, Meta, Snapchat, TikTok ni à aucune autre application mentionnée.';

  @override
  String get shareMessage =>
      'Conservez une copie de vos messages entrants, même s’ils sont supprimés plus tard.';

  @override
  String get navStatus => 'Statuts';

  @override
  String get statusAllowTitle => 'Autoriser l’accès au dossier des statuts';

  @override
  String get statusAllowText =>
      'Pour afficher les statuts WhatsApp, choisissez une seule fois le dossier des statuts. L’application ne lit que ce dossier et rien n’est envoyé.';

  @override
  String get statusChangeFolder => 'Changer de dossier';

  @override
  String get statusWrongFolder =>
      'Ce n’est pas le dossier des statuts. Veuillez réessayer.';

  @override
  String get statusEmptyTitle => 'Aucun statut trouvé';

  @override
  String get statusEmptyText =>
      'Ouvrez d’abord WhatsApp et regardez quelques statuts, puis revenez et tirez vers le bas pour actualiser.';

  @override
  String get statusSaved => 'Enregistré dans votre galerie';

  @override
  String get statusSaveFailed => 'Impossible d’enregistrer ce statut';

  @override
  String get saveAction => 'Enregistrer';

  @override
  String get statusOnlyWhatsApp =>
      'Seuls les statuts WhatsApp peuvent être enregistrés. Les stories Facebook et Instagram ne sont pas stockées sur votre téléphone, cette application ne peut donc pas les enregistrer.';

  @override
  String get statusRespectNote =>
      'N’enregistrez que du contenu que vous avez le droit d’utiliser.';

  @override
  String get statusChooseFolder => 'Autoriser l’accès';

  @override
  String get deleteChatsTitle => 'Supprimer les conversations ?';

  @override
  String get deleteChatsText =>
      'Les conversations sélectionnées et tous leurs messages enregistrés seront supprimés de cette application uniquement. Ils ne pourront pas être restaurés.';

  @override
  String get statusViewedNote =>
      'Tout statut que vous consultez dans WhatsApp apparaîtra ici et vous pourrez l’enregistrer.';

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
