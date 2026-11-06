// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get settings => 'Configurações';

  @override
  String get general => 'Geral';

  @override
  String get other => 'Outros';

  @override
  String get language => 'Idioma';

  @override
  String get darkMode => 'Modo escuro';

  @override
  String get darkModeSub => 'Alternar entre o tema claro e o escuro';

  @override
  String get saveProfilePictures => 'Salvar fotos de perfil';

  @override
  String get saveProfilePicturesSub =>
      'Manter a foto do remetente exibida nas notificações';

  @override
  String get clearAllData => 'Limpar todos os dados';

  @override
  String get clearAllDataSub => 'Excluir todas as mensagens salvas';

  @override
  String get clearAllDataText =>
      'Todas as mensagens salvas e fotos de perfil serão excluídas deste app. Isso não pode ser desfeito.';

  @override
  String get allSavedMessagesDeleted =>
      'Todas as mensagens salvas foram excluídas';

  @override
  String couldNotClearData(String error) {
    return 'Não foi possível limpar os dados: $error';
  }

  @override
  String get restartService => 'Reiniciar serviço';

  @override
  String get restartServiceSub => 'Se as mensagens pararem de ser salvas';

  @override
  String get guide => 'Guia';

  @override
  String get guideSub => 'Aprenda a usar o app';

  @override
  String get privacyPolicy => 'Política de privacidade';

  @override
  String get privacyPolicySub => 'Como seus dados são usados';

  @override
  String get rateUs => 'Avalie-nos';

  @override
  String get rateUsSub => 'Apoie-nos com sua avaliação';

  @override
  String get shareApp => 'Compartilhar app';

  @override
  String get shareAppSub => 'Convide outras pessoas a recuperar suas mensagens';

  @override
  String get disclaimer => 'Aviso legal';

  @override
  String get disclaimerSub => 'Informações importantes';

  @override
  String get feedback => 'Feedback';

  @override
  String get feedbackSub => 'Ajude-nos a melhorar o app';

  @override
  String get aboutUs => 'Sobre nós';

  @override
  String get aboutUsSub => 'Saiba mais sobre o app';

  @override
  String get chooseLanguage => 'Escolher idioma';

  @override
  String get deviceLanguage => 'Idioma do dispositivo';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Excluir';

  @override
  String get submit => 'Enviar';

  @override
  String get maybeLater => 'Talvez depois';

  @override
  String get suggestedApps => 'Apps sugeridos';

  @override
  String get otherApps => 'Outros apps';

  @override
  String get messageRecovery => 'Recuperação de mensagens';

  @override
  String get keepRunningInBackground =>
      'Mantenha o app em execução em segundo plano';

  @override
  String get battery => 'Bateria';

  @override
  String get autoStart => 'Início automático';

  @override
  String get addMore => 'Adicionar mais';

  @override
  String get allMessages => 'Todas as mensagens';

  @override
  String get unreadMessages => 'Mensagens não lidas';

  @override
  String get connectAppFirst => 'Conecte um app primeiro';

  @override
  String get supportComingSoon => 'O suporte a este app chegará em breve';

  @override
  String get allowNotificationAccess => 'Permitir acesso às notificações';

  @override
  String get allowNotificationAccessText =>
      'Precisamos de acesso às notificações para recuperar mensagens excluídas. As mensagens lidas aqui não mostrarão os vistos azuis.';

  @override
  String get allowPermission => 'Permitir acesso';

  @override
  String get noNotificationsYet => 'Nenhuma notificação ainda';

  @override
  String get noNotificationsText =>
      'Mostraremos aqui as notificações das suas mensagens assim que chegarem.';

  @override
  String get noUnreadMessages => 'Nenhuma mensagem não lida';

  @override
  String get noUnreadText =>
      'Você está em dia. As novas mensagens aparecerão aqui.';

  @override
  String get navMessages => 'Mensagens';

  @override
  String get navDeletedMedia => 'Mídia excluída';

  @override
  String get navSettings => 'Configurações';

  @override
  String get navCrown => 'Coroa';

  @override
  String get comingSoon => 'Em breve';

  @override
  String rateEnjoying(String appName) {
    return 'Está gostando do $appName?';
  }

  @override
  String get rateSubtitle =>
      'Sua avaliação nos ajuda a melhorar e ajuda outras pessoas a encontrar o app.';

  @override
  String get rateTapStar => 'Toque em uma estrela para avaliar';

  @override
  String get ratePoor => 'Ruim';

  @override
  String get rateFair => 'Razoável';

  @override
  String get rateGood => 'Bom';

  @override
  String get rateVeryGood => 'Muito bom';

  @override
  String get rateExcellent => 'Excelente';

  @override
  String get searchLanguage => 'Pesquisar idioma';

  @override
  String get deleteMessagesTitle => 'Excluir mensagens?';

  @override
  String get deleteMessagesText =>
      'As mensagens selecionadas serão excluídas somente deste app. Elas não podem ser restauradas.';

  @override
  String get selectTooltip => 'Selecionar';

  @override
  String selectedCount(int count) {
    return '$count selecionadas';
  }

  @override
  String get selectAll => 'Selecionar tudo';

  @override
  String get clearSelection => 'Limpar';

  @override
  String deleteWithCount(int count) {
    return 'Excluir ($count)';
  }

  @override
  String get chatEmpty => 'Nenhuma mensagem nesta conversa';

  @override
  String get today => 'Hoje';

  @override
  String get yesterday => 'Ontem';

  @override
  String get selectApps => 'Selecionar apps';

  @override
  String get searchApps => 'Pesquisar apps...';

  @override
  String get appsHeading => 'Apps';

  @override
  String get next => 'Avançar';

  @override
  String get pickAtLeastOneApp => 'Escolha pelo menos um app';

  @override
  String get restartingService => 'Reiniciando serviço...';

  @override
  String get serviceRestarted =>
      'Serviço reiniciado. As novas mensagens voltarão a ser salvas.';

  @override
  String get notificationAccessOffTitle =>
      'O acesso às notificações está desativado';

  @override
  String get notificationAccessOffText =>
      'Ative o acesso às notificações para este app; caso contrário, ele não poderá salvar mensagens.';

  @override
  String get restartNotConfirmedTitle => 'Reinício não confirmado';

  @override
  String get restartNotConfirmedText =>
      'O reinício foi solicitado, mas o serviço não confirmou. Abra o acesso às notificações, desative e ative este app novamente e volte.';

  @override
  String get close => 'Fechar';

  @override
  String get openSettings => 'Abrir configurações';

  @override
  String get couldNotOpenPlayStore => 'Não foi possível abrir o Google Play';

  @override
  String get noEmailApp => 'Nenhum app de e-mail encontrado';

  @override
  String get premiumRecoverMessages => 'Recuperar mensagens excluídas';

  @override
  String get premiumRecoverMedia => 'Recuperar mídia excluída';

  @override
  String get premiumRemoveAds => 'Remover anúncios';

  @override
  String get premiumPrioritySupport => 'Suporte prioritário ao cliente';

  @override
  String get premiumUnlimitedRecovery => 'Recuperação de dados ilimitada';

  @override
  String get planPro => 'Pro';

  @override
  String get planBasic => 'Básico';

  @override
  String get goPremium => 'Seja Premium';

  @override
  String get goPremiumSubtitle =>
      'Desbloqueie todos os recursos e tenha a melhor experiência de recuperação.';

  @override
  String premiumPricePerWeek(String price) {
    return '$price / semana';
  }

  @override
  String get premiumTrialNote => 'após o fim do teste GRÁTIS de 3 dias';

  @override
  String get startFreeTrial => 'Iniciar teste grátis';

  @override
  String get autoRenewNote =>
      'A assinatura é renovada automaticamente. Cancele quando quiser.';

  @override
  String guideIntro(String appName) {
    return 'Siga estes passos uma vez e o $appName guardará uma cópia das suas mensagens recebidas.';
  }

  @override
  String guideStep(int number) {
    return 'Passo $number';
  }

  @override
  String get guideStep1Title => 'Conecte seus apps';

  @override
  String guideStep1Text(String otherApps, String addMore) {
    return 'Na tela inicial, toque em um app ou escolha “$otherApps” para selecionar vários de uma vez. Depois, você pode adicionar mais apps com o botão “$addMore”.';
  }

  @override
  String get guideStep2Title => 'Permita o acesso às notificações';

  @override
  String get guideStep2Text =>
      'O app só consegue salvar uma mensagem se puder ler a notificação exibida pelo outro app. Abra a lista abaixo, encontre este app e ative-o.';

  @override
  String get guideOpenNotificationAccess => 'Abrir acesso às notificações';

  @override
  String get guideStep3Title => 'Mantenha em execução em segundo plano';

  @override
  String get guideStep3Text =>
      'Alguns celulares fecham apps em segundo plano para economizar bateria, o que pode fazer você perder mensagens. Permita que este app funcione sem restrições de bateria e, se o seu celular tiver, ative o início automático.';

  @override
  String get guideStep4Title => 'O que é salvo';

  @override
  String get guideStep4Text => 'Tenha em mente estes pontos:';

  @override
  String get guideSaved1 =>
      'Mantenha as notificações ativadas para as conversas importantes. Conversas silenciadas não podem ser salvas.';

  @override
  String get guideSaved2 =>
      'Uma mensagem não é salva se você já estava vendo aquela conversa.';

  @override
  String get guideSaved3 =>
      'Apenas texto é salvo. Fotos, mensagens de voz e chamadas não são recuperadas.';

  @override
  String get guideStep5Title => 'Leia suas mensagens salvas';

  @override
  String guideStep5Text(String messagesTab, String unreadMessages) {
    return 'Abra a aba “$messagesTab”, escolha um app no topo e toque em uma pessoa para ver a conversa salva. Use “$unreadMessages” para ver as conversas que você ainda não abriu.';
  }

  @override
  String get guideStep6Title => 'Exclua mensagens';

  @override
  String guideStep6Text(
    String selectAll,
    String delete,
    String settings,
    String clearAll,
  ) {
    return 'Mantenha uma mensagem pressionada ou toque no ícone de seleção no topo. Escolha mensagens ou “$selectAll” e toque em “$delete”. Para remover tudo de uma vez, use “$settings” > “$clearAll”.';
  }

  @override
  String get guideStep7Title => 'Algo não está sendo salvo?';

  @override
  String get guideStep7Text => 'Tente isto, em ordem:';

  @override
  String get guideFix1 => 'Verifique se o acesso às notificações está ativado.';

  @override
  String get guideFix2 =>
      'Verifique as configurações de bateria e início automático acima.';

  @override
  String get guideFix3 =>
      'Confirme que as notificações dessa conversa não estão silenciadas.';

  @override
  String get guideFix4 => 'Reinicie o serviço com o botão abaixo.';

  @override
  String get readDisclaimer => 'Ler o aviso legal';

  @override
  String get ourStory => 'Nossa história';

  @override
  String aboutStory1(String appName) {
    return 'O $appName foi criado por um motivo simples: uma mensagem importante não deve ser perdida só porque alguém a excluiu. O app guarda uma cópia das mensagens que chegam ao seu celular, organizadas por app e por pessoa, para que você possa lê-las depois.';
  }

  @override
  String get aboutStory2 =>
      'Ele funciona lendo as notificações do seu próprio celular, com a sua permissão, e as mensagens salvas permanecem no seu dispositivo.';

  @override
  String get highlights => 'Destaques';

  @override
  String get featureOrganizedTitle => 'Conversas organizadas';

  @override
  String get featureOrganizedText =>
      'As mensagens são agrupadas por app e por pessoa, como nos apps que você já usa.';

  @override
  String get featurePrivateTitle => 'Privado por design';

  @override
  String get featurePrivateText =>
      'As mensagens salvas ficam no seu celular e nunca são enviadas aos nossos servidores.';

  @override
  String get featureBackgroundTitle => 'Funciona em segundo plano';

  @override
  String get featureBackgroundText =>
      'Continua salvando novas mensagens mesmo com o app fechado, desde que o seu celular permita.';

  @override
  String get featureControlTitle => 'Você no controle';

  @override
  String get featureControlText =>
      'Exclua qualquer mensagem ou conversa, ou desative o acesso, quando quiser.';

  @override
  String get worksWith => 'Funciona com';

  @override
  String get legalSupport => 'Legal e suporte';

  @override
  String get contactUs => 'Fale conosco';

  @override
  String versionLabel(String version) {
    return 'Versão $version';
  }

  @override
  String allRightsReserved(String year, String developer) {
    return '© $year $developer. Todos os direitos reservados.';
  }

  @override
  String get notAffiliated =>
      'Sem afiliação com WhatsApp, Meta, Snapchat, TikTok ou qualquer outro app mencionado.';

  @override
  String get shareMessage =>
      'Guarde uma cópia das suas mensagens recebidas, mesmo que sejam excluídas depois.';

  @override
  String get navStatus => 'Status';

  @override
  String get statusAllowTitle => 'Permitir acesso à pasta de Status';

  @override
  String get statusAllowText =>
      'Para mostrar os status do WhatsApp, escolha a pasta de Status uma única vez. O app lê somente essa pasta e nada é enviado.';

  @override
  String get statusChangeFolder => 'Alterar pasta';

  @override
  String get statusWrongFolder =>
      'Essa não parece ser a pasta de Status. Tente novamente.';

  @override
  String get statusEmptyTitle => 'Nenhum status encontrado';

  @override
  String get statusEmptyText =>
      'Abra o WhatsApp e veja alguns status primeiro; depois volte e puxe para baixo para atualizar.';

  @override
  String get statusSaved => 'Salvo na sua galeria';

  @override
  String get statusSaveFailed => 'Não foi possível salvar este status';

  @override
  String get saveAction => 'Salvar';

  @override
  String get statusOnlyWhatsApp =>
      'Somente status do WhatsApp podem ser salvos. Os stories do Facebook e do Instagram não ficam armazenados no seu celular, então este app não consegue salvá-los.';

  @override
  String get statusRespectNote =>
      'Salve apenas conteúdo que você tenha o direito de usar.';

  @override
  String get statusChooseFolder => 'Permitir acesso';

  @override
  String get deleteChatsTitle => 'Excluir conversas?';

  @override
  String get deleteChatsText =>
      'As conversas selecionadas e todas as mensagens salvas nelas serão excluídas somente deste app. Elas não podem ser restauradas.';

  @override
  String get statusViewedNote =>
      'Qualquer status que você ver no WhatsApp aparecerá aqui e você poderá salvá-lo.';

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
