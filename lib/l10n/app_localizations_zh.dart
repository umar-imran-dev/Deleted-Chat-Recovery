// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get settings => '设置';

  @override
  String get general => '通用';

  @override
  String get other => '其他';

  @override
  String get language => '语言';

  @override
  String get darkMode => '深色模式';

  @override
  String get darkModeSub => '在浅色和深色主题之间切换';

  @override
  String get saveProfilePictures => '保存头像';

  @override
  String get saveProfilePicturesSub => '保留通知中显示的发送者头像';

  @override
  String get clearAllData => '清除所有数据';

  @override
  String get clearAllDataSub => '删除所有已保存的消息';

  @override
  String get clearAllDataText => '此应用中所有已保存的消息和头像都将被删除，且无法恢复。';

  @override
  String get allSavedMessagesDeleted => '所有已保存的消息已删除';

  @override
  String couldNotClearData(String error) {
    return '无法清除数据：$error';
  }

  @override
  String get restartService => '重启服务';

  @override
  String get restartServiceSub => '如果消息不再被保存';

  @override
  String get guide => '使用指南';

  @override
  String get guideSub => '了解如何使用本应用';

  @override
  String get privacyPolicy => '隐私政策';

  @override
  String get privacyPolicySub => '我们如何使用您的数据';

  @override
  String get rateUs => '给我们评分';

  @override
  String get rateUsSub => '用您宝贵的评分支持我们';

  @override
  String get shareApp => '分享应用';

  @override
  String get shareAppSub => '邀请他人找回他们的消息';

  @override
  String get disclaimer => '免责声明';

  @override
  String get disclaimerSub => '重要信息';

  @override
  String get feedback => '意见反馈';

  @override
  String get feedbackSub => '帮助我们改进应用';

  @override
  String get aboutUs => '关于我们';

  @override
  String get aboutUsSub => '了解更多关于本应用的信息';

  @override
  String get chooseLanguage => '选择语言';

  @override
  String get deviceLanguage => '设备语言';

  @override
  String get cancel => '取消';

  @override
  String get delete => '删除';

  @override
  String get submit => '提交';

  @override
  String get maybeLater => '以后再说';

  @override
  String get suggestedApps => '推荐应用';

  @override
  String get otherApps => '其他应用';

  @override
  String get messageRecovery => '消息恢复';

  @override
  String get keepRunningInBackground => '让应用保持在后台运行';

  @override
  String get battery => '电池';

  @override
  String get autoStart => '自启动';

  @override
  String get addMore => '添加更多';

  @override
  String get allMessages => '全部消息';

  @override
  String get unreadMessages => '未读消息';

  @override
  String get connectAppFirst => '请先连接一个应用';

  @override
  String get supportComingSoon => '即将支持此应用';

  @override
  String get allowNotificationAccess => '允许通知访问';

  @override
  String get allowNotificationAccessText =>
      '我们需要通知访问权限来恢复已删除的消息。在此阅读的消息不会显示蓝色已读标记。';

  @override
  String get allowPermission => '授予权限';

  @override
  String get noNotificationsYet => '暂无通知';

  @override
  String get noNotificationsText => '消息通知一到达，我们就会显示在这里。';

  @override
  String get noUnreadMessages => '没有未读消息';

  @override
  String get noUnreadText => '您已全部查看。新消息将显示在这里。';

  @override
  String get navMessages => '消息';

  @override
  String get navDeletedMedia => '已删除媒体';

  @override
  String get navSettings => '设置';

  @override
  String get navCrown => '皇冠';

  @override
  String get comingSoon => '敬请期待';

  @override
  String rateEnjoying(String appName) {
    return '喜欢 $appName 吗？';
  }

  @override
  String get rateSubtitle => '您的评分帮助我们改进，也帮助更多人发现这款应用。';

  @override
  String get rateTapStar => '点击星星进行评分';

  @override
  String get ratePoor => '很差';

  @override
  String get rateFair => '一般';

  @override
  String get rateGood => '不错';

  @override
  String get rateVeryGood => '很好';

  @override
  String get rateExcellent => '非常棒';

  @override
  String get searchLanguage => '搜索语言...';

  @override
  String get deleteMessagesTitle => '删除消息？';

  @override
  String get deleteMessagesText => '所选消息仅会从此应用中删除，且无法恢复。';

  @override
  String get selectTooltip => '选择';

  @override
  String selectedCount(int count) {
    return '已选择 $count 项';
  }

  @override
  String get selectAll => '全选';

  @override
  String get clearSelection => '清除';

  @override
  String deleteWithCount(int count) {
    return '删除（$count）';
  }

  @override
  String get chatEmpty => '此聊天中没有消息';

  @override
  String get today => '今天';

  @override
  String get yesterday => '昨天';

  @override
  String get selectApps => '选择应用';

  @override
  String get searchApps => '搜索应用...';

  @override
  String get appsHeading => '应用';

  @override
  String get next => '下一步';

  @override
  String get pickAtLeastOneApp => '请至少选择一个应用';

  @override
  String get restartingService => '正在重启服务...';

  @override
  String get serviceRestarted => '服务已重启，新消息将再次被保存。';

  @override
  String get notificationAccessOffTitle => '通知访问已关闭';

  @override
  String get notificationAccessOffText => '请为此应用开启通知访问，否则无法保存消息。';

  @override
  String get restartNotConfirmedTitle => '重启未确认';

  @override
  String get restartNotConfirmedText =>
      '已请求重启，但服务未确认。请打开通知访问，关闭此应用后再重新开启，然后返回。';

  @override
  String get close => '关闭';

  @override
  String get openSettings => '打开设置';

  @override
  String get couldNotOpenPlayStore => '无法打开 Google Play';

  @override
  String get noEmailApp => '未找到邮件应用';

  @override
  String get premiumRecoverMessages => '恢复已删除的消息';

  @override
  String get premiumRecoverMedia => '恢复已删除的媒体';

  @override
  String get premiumRemoveAds => '移除广告';

  @override
  String get premiumPrioritySupport => '优先客户支持';

  @override
  String get premiumUnlimitedRecovery => '无限数据恢复';

  @override
  String get planPro => '专业版';

  @override
  String get planBasic => '基础版';

  @override
  String get goPremium => '升级高级版';

  @override
  String get goPremiumSubtitle => '解锁全部功能，获得最佳恢复体验。';

  @override
  String premiumPricePerWeek(String price) {
    return '$price / 每周';
  }

  @override
  String get premiumTrialNote => '3 天免费试用结束后';

  @override
  String get startFreeTrial => '开始免费试用';

  @override
  String get autoRenewNote => '订阅将自动续订，可随时取消。';

  @override
  String guideIntro(String appName) {
    return '只需按以下步骤操作一次，$appName 就会保存您收到的消息副本。';
  }

  @override
  String guideStep(int number) {
    return '第 $number 步';
  }

  @override
  String get guideStep1Title => '连接您的应用';

  @override
  String guideStep1Text(String otherApps, String addMore) {
    return '在主屏幕上点击一个应用，或选择“$otherApps”一次选择多个。之后您可以通过“$addMore”按钮添加更多应用。';
  }

  @override
  String get guideStep2Title => '允许通知访问';

  @override
  String get guideStep2Text => '只有能读取其他应用显示的通知，本应用才能保存消息。请打开下方列表，找到本应用并开启。';

  @override
  String get guideOpenNotificationAccess => '打开通知访问';

  @override
  String get guideStep3Title => '保持后台运行';

  @override
  String get guideStep3Text =>
      '部分手机会为了省电而关闭后台应用，导致您错过消息。请允许本应用不受电池限制运行，如果您的手机有“自启动”选项，请开启。';

  @override
  String get guideStep4Title => '会保存哪些内容';

  @override
  String get guideStep4Text => '请注意以下几点：';

  @override
  String get guideSaved1 => '请为重要的聊天保持通知开启。已静音的聊天无法保存。';

  @override
  String get guideSaved2 => '如果您当时正在查看该聊天，消息不会被保存。';

  @override
  String get guideSaved3 => '仅保存文字。照片、语音消息和通话不会被恢复。';

  @override
  String get guideStep5Title => '查看已保存的消息';

  @override
  String guideStep5Text(String messagesTab, String unreadMessages) {
    return '打开“$messagesTab”标签，在顶部选择一个应用，然后点击某个联系人查看已保存的对话。使用“$unreadMessages”查看您尚未打开的聊天。';
  }

  @override
  String get guideStep6Title => '删除消息';

  @override
  String guideStep6Text(
    String selectAll,
    String delete,
    String settings,
    String clearAll,
  ) {
    return '长按一条消息，或点击顶部的选择图标。选择消息或“$selectAll”，然后点击“$delete”。如需一次清除全部，请使用“$settings”>“$clearAll”。';
  }

  @override
  String get guideStep7Title => '有内容没有被保存？';

  @override
  String get guideStep7Text => '请按顺序尝试：';

  @override
  String get guideFix1 => '检查通知访问是否已开启。';

  @override
  String get guideFix2 => '检查上方的电池和自启动设置。';

  @override
  String get guideFix3 => '确认该聊天的通知没有被静音。';

  @override
  String get guideFix4 => '使用下方按钮重启服务。';

  @override
  String get readDisclaimer => '阅读免责声明';

  @override
  String get ourStory => '我们的故事';

  @override
  String aboutStory1(String appName) {
    return '$appName 的诞生源于一个简单的理由：重要的消息不应仅仅因为有人删除了它就丢失。应用会保存您手机上收到的消息副本，并按应用和联系人整理，方便您日后查看。';
  }

  @override
  String get aboutStory2 => '它在您的许可下读取您自己手机上的通知来工作，已保存的消息只会保留在您的设备上。';

  @override
  String get highlights => '功能亮点';

  @override
  String get featureOrganizedTitle => '条理清晰的聊天';

  @override
  String get featureOrganizedText => '消息按应用和联系人分组，就像您已在使用的应用一样。';

  @override
  String get featurePrivateTitle => '隐私优先设计';

  @override
  String get featurePrivateText => '已保存的消息保留在您的手机上，绝不会上传到我们的服务器。';

  @override
  String get featureBackgroundTitle => '后台运行';

  @override
  String get featureBackgroundText => '即使应用已关闭，只要手机允许，也会继续保存新消息。';

  @override
  String get featureControlTitle => '一切由您掌控';

  @override
  String get featureControlText => '您可以随时删除任何消息或聊天，或关闭访问权限。';

  @override
  String get worksWith => '支持的应用';

  @override
  String get legalSupport => '法律与支持';

  @override
  String get contactUs => '联系我们';

  @override
  String versionLabel(String version) {
    return '版本 $version';
  }

  @override
  String allRightsReserved(String year, String developer) {
    return '© $year $developer。保留所有权利。';
  }

  @override
  String get notAffiliated =>
      '与 WhatsApp、Meta、Snapchat、TikTok 或文中提及的任何其他应用无关联。';

  @override
  String get shareMessage => '保存您收到的消息副本，即使它们日后被删除。';

  @override
  String get navStatus => '状态';

  @override
  String get statusAllowTitle => '允许访问状态文件夹';

  @override
  String get statusAllowText =>
      '要显示 WhatsApp 状态，请选择一次状态文件夹。应用只读取此文件夹，不会上传任何内容。';

  @override
  String get statusChangeFolder => '更改文件夹';

  @override
  String get statusWrongFolder => '这似乎不是状态文件夹，请重试。';

  @override
  String get statusEmptyTitle => '未找到状态';

  @override
  String get statusEmptyText => '请先打开 WhatsApp 查看几条状态，然后返回并下拉刷新。';

  @override
  String get statusSaved => '已保存到相册';

  @override
  String get statusSaveFailed => '无法保存此状态';

  @override
  String get saveAction => '保存';

  @override
  String get statusOnlyWhatsApp =>
      '仅支持保存 WhatsApp 状态。Facebook 和 Instagram 的快拍不会存储在您的手机上，因此本应用无法保存。';

  @override
  String get statusRespectNote => '请只保存您有权使用的内容。';

  @override
  String get statusChooseFolder => '允许访问';

  @override
  String get deleteChatsTitle => '删除聊天？';

  @override
  String get deleteChatsText => '所选聊天及其所有已保存的消息仅会从此应用中删除，且无法恢复。';

  @override
  String get statusViewedNote => '您在 WhatsApp 中查看过的任何状态都会显示在这里，您可以将其保存。';

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
