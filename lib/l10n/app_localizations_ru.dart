// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get settings => 'Настройки';

  @override
  String get general => 'Общие';

  @override
  String get other => 'Другое';

  @override
  String get language => 'Язык';

  @override
  String get darkMode => 'Тёмная тема';

  @override
  String get darkModeSub => 'Переключение между светлой и тёмной темой';

  @override
  String get saveProfilePictures => 'Сохранять фото профиля';

  @override
  String get saveProfilePicturesSub =>
      'Сохранять фото отправителя из уведомлений';

  @override
  String get clearAllData => 'Удалить все данные';

  @override
  String get clearAllDataSub => 'Удалить все сохранённые сообщения';

  @override
  String get clearAllDataText =>
      'Все сохранённые сообщения и фото профиля будут удалены из этого приложения. Это действие нельзя отменить.';

  @override
  String get allSavedMessagesDeleted => 'Все сохранённые сообщения удалены';

  @override
  String couldNotClearData(String error) {
    return 'Не удалось удалить данные: $error';
  }

  @override
  String get restartService => 'Перезапустить службу';

  @override
  String get restartServiceSub => 'Если сообщения перестали сохраняться';

  @override
  String get guide => 'Руководство';

  @override
  String get guideSub => 'Узнайте, как пользоваться приложением';

  @override
  String get privacyPolicy => 'Политика конфиденциальности';

  @override
  String get privacyPolicySub => 'Как используются ваши данные';

  @override
  String get rateUs => 'Оцените нас';

  @override
  String get rateUsSub => 'Поддержите нас своей оценкой';

  @override
  String get shareApp => 'Поделиться приложением';

  @override
  String get shareAppSub => 'Пригласите других восстановить свои сообщения';

  @override
  String get disclaimer => 'Отказ от ответственности';

  @override
  String get disclaimerSub => 'Важная информация';

  @override
  String get feedback => 'Отзыв';

  @override
  String get feedbackSub => 'Помогите нам улучшить приложение';

  @override
  String get aboutUs => 'О нас';

  @override
  String get aboutUsSub => 'Узнайте больше о приложении';

  @override
  String get chooseLanguage => 'Выберите язык';

  @override
  String get deviceLanguage => 'Язык устройства';

  @override
  String get cancel => 'Отмена';

  @override
  String get delete => 'Удалить';

  @override
  String get submit => 'Отправить';

  @override
  String get maybeLater => 'Позже';

  @override
  String get suggestedApps => 'Рекомендуемые приложения';

  @override
  String get otherApps => 'Другие приложения';

  @override
  String get messageRecovery => 'Восстановление сообщений';

  @override
  String get keepRunningInBackground => 'Держите приложение работающим в фоне';

  @override
  String get battery => 'Батарея';

  @override
  String get autoStart => 'Автозапуск';

  @override
  String get addMore => 'Добавить ещё';

  @override
  String get allMessages => 'Все сообщения';

  @override
  String get unreadMessages => 'Непрочитанные';

  @override
  String get connectAppFirst => 'Сначала подключите приложение';

  @override
  String get supportComingSoon => 'Поддержка этого приложения скоро появится';

  @override
  String get allowNotificationAccess => 'Разрешить доступ к уведомлениям';

  @override
  String get allowNotificationAccessText =>
      'Для восстановления удалённых сообщений нужен доступ к уведомлениям. Сообщения, прочитанные здесь, не получат синие галочки.';

  @override
  String get allowPermission => 'Разрешить';

  @override
  String get noNotificationsYet => 'Уведомлений пока нет';

  @override
  String get noNotificationsText =>
      'Мы покажем уведомления о ваших сообщениях здесь, как только они придут.';

  @override
  String get noUnreadMessages => 'Нет непрочитанных сообщений';

  @override
  String get noUnreadText => 'Всё прочитано. Новые сообщения появятся здесь.';

  @override
  String get navMessages => 'Сообщения';

  @override
  String get navDeletedMedia => 'Удалённые медиа';

  @override
  String get navSettings => 'Настройки';

  @override
  String get navCrown => 'Корона';

  @override
  String get comingSoon => 'Скоро';

  @override
  String rateEnjoying(String appName) {
    return 'Нравится $appName?';
  }

  @override
  String get rateSubtitle =>
      'Ваша оценка помогает нам становиться лучше, а другим — находить приложение.';

  @override
  String get rateTapStar => 'Нажмите на звезду, чтобы оценить';

  @override
  String get ratePoor => 'Плохо';

  @override
  String get rateFair => 'Нормально';

  @override
  String get rateGood => 'Хорошо';

  @override
  String get rateVeryGood => 'Очень хорошо';

  @override
  String get rateExcellent => 'Отлично';

  @override
  String get searchLanguage => 'Поиск языка';

  @override
  String get deleteMessagesTitle => 'Удалить сообщения?';

  @override
  String get deleteMessagesText =>
      'Выбранные сообщения будут удалены только из этого приложения. Их нельзя будет восстановить.';

  @override
  String get selectTooltip => 'Выбрать';

  @override
  String selectedCount(int count) {
    return 'Выбрано: $count';
  }

  @override
  String get selectAll => 'Выбрать все';

  @override
  String get clearSelection => 'Сбросить';

  @override
  String deleteWithCount(int count) {
    return 'Удалить ($count)';
  }

  @override
  String get chatEmpty => 'В этом чате нет сообщений';

  @override
  String get today => 'Сегодня';

  @override
  String get yesterday => 'Вчера';

  @override
  String get selectApps => 'Выбор приложений';

  @override
  String get searchApps => 'Поиск приложений...';

  @override
  String get appsHeading => 'Приложения';

  @override
  String get next => 'Далее';

  @override
  String get pickAtLeastOneApp => 'Выберите хотя бы одно приложение';

  @override
  String get restartingService => 'Перезапуск службы...';

  @override
  String get serviceRestarted =>
      'Служба перезапущена. Новые сообщения снова будут сохраняться.';

  @override
  String get notificationAccessOffTitle => 'Доступ к уведомлениям отключён';

  @override
  String get notificationAccessOffText =>
      'Включите доступ к уведомлениям для этого приложения, иначе оно не сможет сохранять сообщения.';

  @override
  String get restartNotConfirmedTitle => 'Перезапуск не подтверждён';

  @override
  String get restartNotConfirmedText =>
      'Перезапуск был запрошен, но служба не подтвердила его. Откройте доступ к уведомлениям, выключите и снова включите это приложение, затем вернитесь.';

  @override
  String get close => 'Закрыть';

  @override
  String get openSettings => 'Открыть настройки';

  @override
  String get couldNotOpenPlayStore => 'Не удалось открыть Google Play';

  @override
  String get noEmailApp => 'Приложение для почты не найдено';

  @override
  String get premiumRecoverMessages => 'Восстановление удалённых сообщений';

  @override
  String get premiumRecoverMedia => 'Восстановление удалённых медиа';

  @override
  String get premiumRemoveAds => 'Отключение рекламы';

  @override
  String get premiumPrioritySupport => 'Приоритетная поддержка';

  @override
  String get premiumUnlimitedRecovery => 'Неограниченное восстановление данных';

  @override
  String get planPro => 'Pro';

  @override
  String get planBasic => 'Базовый';

  @override
  String get goPremium => 'Перейти на Premium';

  @override
  String get goPremiumSubtitle =>
      'Откройте все функции и получите лучший опыт восстановления.';

  @override
  String premiumPricePerWeek(String price) {
    return '$price / в неделю';
  }

  @override
  String get premiumTrialNote =>
      'после окончания БЕСПЛАТНОГО 3-дневного пробного периода';

  @override
  String get startFreeTrial => 'Начать бесплатный период';

  @override
  String get autoRenewNote =>
      'Подписка продлевается автоматически. Отменить можно в любой момент.';

  @override
  String guideIntro(String appName) {
    return 'Выполните эти шаги один раз, и $appName будет хранить копию ваших входящих сообщений.';
  }

  @override
  String guideStep(int number) {
    return 'Шаг $number';
  }

  @override
  String get guideStep1Title => 'Подключите приложения';

  @override
  String guideStep1Text(String otherApps, String addMore) {
    return 'На главном экране нажмите на приложение или выберите «$otherApps», чтобы выбрать сразу несколько. Позже можно добавить ещё приложения кнопкой «$addMore».';
  }

  @override
  String get guideStep2Title => 'Разрешите доступ к уведомлениям';

  @override
  String get guideStep2Text =>
      'Приложение может сохранить сообщение, только если оно читает уведомление, которое показывает другое приложение. Откройте список ниже, найдите это приложение и включите его.';

  @override
  String get guideOpenNotificationAccess => 'Открыть доступ к уведомлениям';

  @override
  String get guideStep3Title => 'Держите его работающим в фоне';

  @override
  String get guideStep3Text =>
      'Некоторые телефоны закрывают фоновые приложения для экономии заряда, из-за чего можно пропустить сообщения. Разрешите этому приложению работать без ограничений батареи и, если на вашем телефоне есть такая функция, включите автозапуск.';

  @override
  String get guideStep4Title => 'Что сохраняется';

  @override
  String get guideStep4Text => 'Учитывайте следующее:';

  @override
  String get guideSaved1 =>
      'Оставьте уведомления включёнными для важных чатов. Чаты с отключённым звуком сохранить нельзя.';

  @override
  String get guideSaved2 =>
      'Сообщение не сохраняется, если вы в этот момент уже смотрели этот чат.';

  @override
  String get guideSaved3 =>
      'Сохраняется только текст. Фото, голосовые сообщения и звонки не восстанавливаются.';

  @override
  String get guideStep5Title => 'Читайте сохранённые сообщения';

  @override
  String guideStep5Text(String messagesTab, String unreadMessages) {
    return 'Откройте вкладку «$messagesTab», выберите приложение вверху, затем нажмите на человека, чтобы увидеть сохранённую переписку. Раздел «$unreadMessages» покажет чаты, которые вы ещё не открывали.';
  }

  @override
  String get guideStep6Title => 'Удаляйте сообщения';

  @override
  String guideStep6Text(
    String selectAll,
    String delete,
    String settings,
    String clearAll,
  ) {
    return 'Нажмите и удерживайте сообщение или нажмите значок выбора вверху. Выберите сообщения или «$selectAll», затем нажмите «$delete». Чтобы удалить всё сразу, используйте «$settings» > «$clearAll».';
  }

  @override
  String get guideStep7Title => 'Что-то не сохраняется?';

  @override
  String get guideStep7Text => 'Попробуйте по порядку:';

  @override
  String get guideFix1 => 'Проверьте, что доступ к уведомлениям включён.';

  @override
  String get guideFix2 => 'Проверьте настройки батареи и автозапуска выше.';

  @override
  String get guideFix3 => 'Убедитесь, что уведомления этого чата не отключены.';

  @override
  String get guideFix4 => 'Перезапустите службу кнопкой ниже.';

  @override
  String get readDisclaimer => 'Прочитать отказ от ответственности';

  @override
  String get ourStory => 'Наша история';

  @override
  String aboutStory1(String appName) {
    return '$appName создано по простой причине: важное сообщение не должно пропадать только потому, что его кто-то удалил. Приложение хранит копию сообщений, приходящих на ваш телефон, упорядоченных по приложениям и людям, чтобы вы могли прочитать их позже.';
  }

  @override
  String get aboutStory2 =>
      'Оно работает, читая уведомления на вашем собственном телефоне с вашего разрешения, а сохранённые сообщения остаются на вашем устройстве.';

  @override
  String get highlights => 'Особенности';

  @override
  String get featureOrganizedTitle => 'Упорядоченные чаты';

  @override
  String get featureOrganizedText =>
      'Сообщения сгруппированы по приложениям и людям, как в приложениях, которыми вы уже пользуетесь.';

  @override
  String get featurePrivateTitle => 'Приватность по умолчанию';

  @override
  String get featurePrivateText =>
      'Сохранённые сообщения остаются на вашем телефоне и никогда не загружаются на наши серверы.';

  @override
  String get featureBackgroundTitle => 'Работает в фоне';

  @override
  String get featureBackgroundText =>
      'Продолжает сохранять новые сообщения, даже когда приложение закрыто, если телефон это позволяет.';

  @override
  String get featureControlTitle => 'Всё под вашим контролем';

  @override
  String get featureControlText =>
      'Удаляйте любое сообщение или чат либо отключайте доступ в любой момент.';

  @override
  String get worksWith => 'Работает с';

  @override
  String get legalSupport => 'Правовая информация и поддержка';

  @override
  String get contactUs => 'Связаться с нами';

  @override
  String versionLabel(String version) {
    return 'Версия $version';
  }

  @override
  String allRightsReserved(String year, String developer) {
    return '© $year $developer. Все права защищены.';
  }

  @override
  String get notAffiliated =>
      'Не связано с WhatsApp, Meta, Snapchat, TikTok или другими упомянутыми приложениями.';

  @override
  String get shareMessage =>
      'Сохраняйте копию входящих сообщений, даже если их потом удалят.';

  @override
  String get navStatus => 'Статусы';

  @override
  String get statusAllowTitle => 'Разрешить доступ к папке статусов';

  @override
  String get statusAllowText =>
      'Чтобы показывать статусы WhatsApp, один раз выберите папку статусов. Приложение читает только эту папку, ничего не загружается.';

  @override
  String get statusChangeFolder => 'Сменить папку';

  @override
  String get statusWrongFolder =>
      'Это не похоже на папку статусов. Попробуйте ещё раз.';

  @override
  String get statusEmptyTitle => 'Статусы не найдены';

  @override
  String get statusEmptyText =>
      'Сначала откройте WhatsApp и посмотрите несколько статусов, затем вернитесь и потяните вниз для обновления.';

  @override
  String get statusSaved => 'Сохранено в галерее';

  @override
  String get statusSaveFailed => 'Не удалось сохранить этот статус';

  @override
  String get saveAction => 'Сохранить';

  @override
  String get statusOnlyWhatsApp =>
      'Можно сохранять только статусы WhatsApp. Истории Facebook и Instagram не хранятся на телефоне, поэтому приложение не может их сохранить.';

  @override
  String get statusRespectNote =>
      'Сохраняйте только тот контент, который вы вправе использовать.';

  @override
  String get statusChooseFolder => 'Разрешить доступ';

  @override
  String get deleteChatsTitle => 'Удалить чаты?';

  @override
  String get deleteChatsText =>
      'Выбранные чаты и все их сохранённые сообщения будут удалены только из этого приложения. Восстановить их будет нельзя.';

  @override
  String get statusViewedNote =>
      'Любой статус, который вы посмотрите в WhatsApp, появится здесь, и вы сможете его сохранить.';

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
