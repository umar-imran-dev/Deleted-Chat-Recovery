// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get settings => 'Ajustes';

  @override
  String get general => 'General';

  @override
  String get other => 'Otros';

  @override
  String get language => 'Idioma';

  @override
  String get darkMode => 'Modo oscuro';

  @override
  String get darkModeSub => 'Cambia entre el tema claro y el oscuro';

  @override
  String get saveProfilePictures => 'Guardar fotos de perfil';

  @override
  String get saveProfilePicturesSub =>
      'Conserva la foto del remitente que aparece en las notificaciones';

  @override
  String get clearAllData => 'Borrar todos los datos';

  @override
  String get clearAllDataSub => 'Elimina todos los mensajes guardados';

  @override
  String get clearAllDataText =>
      'Se eliminarán de esta app todos los mensajes guardados y las fotos de perfil. Esta acción no se puede deshacer.';

  @override
  String get allSavedMessagesDeleted =>
      'Todos los mensajes guardados se eliminaron';

  @override
  String couldNotClearData(String error) {
    return 'No se pudieron borrar los datos: $error';
  }

  @override
  String get restartService => 'Reiniciar servicio';

  @override
  String get restartServiceSub => 'Si los mensajes dejan de guardarse';

  @override
  String get guide => 'Guía';

  @override
  String get guideSub => 'Aprende a usar la app';

  @override
  String get privacyPolicy => 'Política de privacidad';

  @override
  String get privacyPolicySub => 'Cómo se usan tus datos';

  @override
  String get rateUs => 'Valóranos';

  @override
  String get rateUsSub => 'Apóyanos con tu valoración';

  @override
  String get shareApp => 'Compartir app';

  @override
  String get shareAppSub => 'Invita a otros a recuperar sus mensajes';

  @override
  String get disclaimer => 'Aviso legal';

  @override
  String get disclaimerSub => 'Información importante';

  @override
  String get feedback => 'Comentarios';

  @override
  String get feedbackSub => 'Ayúdanos a mejorar la app';

  @override
  String get aboutUs => 'Acerca de nosotros';

  @override
  String get aboutUsSub => 'Conoce más sobre la app';

  @override
  String get chooseLanguage => 'Elegir idioma';

  @override
  String get deviceLanguage => 'Idioma del dispositivo';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get submit => 'Enviar';

  @override
  String get maybeLater => 'Quizás después';

  @override
  String get suggestedApps => 'Apps sugeridas';

  @override
  String get otherApps => 'Otras apps';

  @override
  String get messageRecovery => 'Recuperación de mensajes';

  @override
  String get keepRunningInBackground =>
      'Mantén la app funcionando en segundo plano';

  @override
  String get battery => 'Batería';

  @override
  String get autoStart => 'Inicio automático';

  @override
  String get addMore => 'Añadir más';

  @override
  String get allMessages => 'Todos los mensajes';

  @override
  String get unreadMessages => 'Mensajes sin leer';

  @override
  String get connectAppFirst => 'Conecta primero una app';

  @override
  String get supportComingSoon =>
      'La compatibilidad con esta app llegará pronto';

  @override
  String get allowNotificationAccess => 'Permitir acceso a notificaciones';

  @override
  String get allowNotificationAccessText =>
      'Necesitamos acceso a las notificaciones para recuperar mensajes eliminados. Los mensajes leídos aquí no mostrarán el doble check azul.';

  @override
  String get allowPermission => 'Permitir permiso';

  @override
  String get noNotificationsYet => 'Aún no hay notificaciones';

  @override
  String get noNotificationsText =>
      'Mostraremos aquí las notificaciones de tus mensajes en cuanto lleguen.';

  @override
  String get noUnreadMessages => 'No hay mensajes sin leer';

  @override
  String get noUnreadText =>
      'Estás al día. Los mensajes nuevos aparecerán aquí.';

  @override
  String get navMessages => 'Mensajes';

  @override
  String get navDeletedMedia => 'Multimedia eliminada';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get navCrown => 'Corona';

  @override
  String get comingSoon => 'Próximamente';

  @override
  String rateEnjoying(String appName) {
    return '¿Te gusta $appName?';
  }

  @override
  String get rateSubtitle =>
      'Tu valoración nos ayuda a mejorar y a que otros encuentren la app.';

  @override
  String get rateTapStar => 'Toca una estrella para valorar';

  @override
  String get ratePoor => 'Malo';

  @override
  String get rateFair => 'Regular';

  @override
  String get rateGood => 'Bueno';

  @override
  String get rateVeryGood => 'Muy bueno';

  @override
  String get rateExcellent => 'Excelente';

  @override
  String get searchLanguage => 'Buscar idioma';

  @override
  String get deleteMessagesTitle => '¿Eliminar mensajes?';

  @override
  String get deleteMessagesText =>
      'Los mensajes seleccionados se eliminarán solo de esta app. No se pueden recuperar.';

  @override
  String get selectTooltip => 'Seleccionar';

  @override
  String selectedCount(int count) {
    return '$count seleccionados';
  }

  @override
  String get selectAll => 'Seleccionar todo';

  @override
  String get clearSelection => 'Borrar';

  @override
  String deleteWithCount(int count) {
    return 'Eliminar ($count)';
  }

  @override
  String get chatEmpty => 'No hay mensajes en este chat';

  @override
  String get today => 'Hoy';

  @override
  String get yesterday => 'Ayer';

  @override
  String get selectApps => 'Seleccionar apps';

  @override
  String get searchApps => 'Buscar apps...';

  @override
  String get appsHeading => 'Apps';

  @override
  String get next => 'Siguiente';

  @override
  String get pickAtLeastOneApp => 'Elige al menos una app';

  @override
  String get restartingService => 'Reiniciando servicio...';

  @override
  String get serviceRestarted =>
      'Servicio reiniciado. Los mensajes nuevos se guardarán de nuevo.';

  @override
  String get notificationAccessOffTitle =>
      'El acceso a notificaciones está desactivado';

  @override
  String get notificationAccessOffText =>
      'Activa el acceso a notificaciones para esta app; de lo contrario no podrá guardar mensajes.';

  @override
  String get restartNotConfirmedTitle => 'Reinicio no confirmado';

  @override
  String get restartNotConfirmedText =>
      'Se solicitó el reinicio pero el servicio no lo confirmó. Abre el acceso a notificaciones, desactiva y vuelve a activar esta app y regresa.';

  @override
  String get close => 'Cerrar';

  @override
  String get openSettings => 'Abrir ajustes';

  @override
  String get couldNotOpenPlayStore => 'No se pudo abrir Google Play';

  @override
  String get noEmailApp => 'No se encontró ninguna app de correo';

  @override
  String get premiumRecoverMessages => 'Recuperar mensajes eliminados';

  @override
  String get premiumRecoverMedia => 'Recuperar multimedia eliminada';

  @override
  String get premiumRemoveAds => 'Quitar anuncios';

  @override
  String get premiumPrioritySupport => 'Atención al cliente prioritaria';

  @override
  String get premiumUnlimitedRecovery => 'Recuperación de datos ilimitada';

  @override
  String get planPro => 'Pro';

  @override
  String get planBasic => 'Básico';

  @override
  String get goPremium => 'Hazte Premium';

  @override
  String get goPremiumSubtitle =>
      'Desbloquea todas las funciones y disfruta de la mejor experiencia de recuperación.';

  @override
  String premiumPricePerWeek(String price) {
    return '$price / semana';
  }

  @override
  String get premiumTrialNote => 'tras finalizar la prueba GRATUITA de 3 días';

  @override
  String get startFreeTrial => 'Iniciar prueba gratuita';

  @override
  String get autoRenewNote =>
      'La suscripción se renueva automáticamente. Cancela cuando quieras.';

  @override
  String guideIntro(String appName) {
    return 'Sigue estos pasos una sola vez y $appName guardará una copia de tus mensajes entrantes.';
  }

  @override
  String guideStep(int number) {
    return 'Paso $number';
  }

  @override
  String get guideStep1Title => 'Conecta tus apps';

  @override
  String guideStep1Text(String otherApps, String addMore) {
    return 'En la pantalla de inicio toca una app, o elige “$otherApps” para seleccionar varias a la vez. Más adelante puedes añadir más apps con el botón “$addMore”.';
  }

  @override
  String get guideStep2Title => 'Permite el acceso a notificaciones';

  @override
  String get guideStep2Text =>
      'La app solo puede guardar un mensaje si puede leer la notificación que muestra la otra app. Abre la lista de abajo, busca esta app y actívala.';

  @override
  String get guideOpenNotificationAccess => 'Abrir acceso a notificaciones';

  @override
  String get guideStep3Title => 'Mantenla funcionando en segundo plano';

  @override
  String get guideStep3Text =>
      'Algunos teléfonos cierran las apps en segundo plano para ahorrar batería, y podrías perder mensajes. Permite que esta app funcione sin restricciones de batería y, si tu teléfono lo tiene, activa el inicio automático.';

  @override
  String get guideStep4Title => 'Qué se guarda';

  @override
  String get guideStep4Text => 'Ten en cuenta lo siguiente:';

  @override
  String get guideSaved1 =>
      'Mantén activadas las notificaciones de los chats que te importan. Los chats silenciados no se pueden guardar.';

  @override
  String get guideSaved2 =>
      'Un mensaje no se guarda si ya estabas viendo ese chat.';

  @override
  String get guideSaved3 =>
      'Solo se guarda el texto. Las fotos, notas de voz y llamadas no se recuperan.';

  @override
  String get guideStep5Title => 'Lee tus mensajes guardados';

  @override
  String guideStep5Text(String messagesTab, String unreadMessages) {
    return 'Abre la pestaña “$messagesTab”, elige una app arriba y toca una persona para ver la conversación guardada. Usa “$unreadMessages” para ver los chats que aún no has abierto.';
  }

  @override
  String get guideStep6Title => 'Elimina mensajes';

  @override
  String guideStep6Text(
    String selectAll,
    String delete,
    String settings,
    String clearAll,
  ) {
    return 'Mantén pulsado un mensaje o toca el icono de selección de arriba. Elige mensajes o “$selectAll” y toca “$delete”. Para borrar todo de una vez, usa “$settings” > “$clearAll”.';
  }

  @override
  String get guideStep7Title => '¿Algo no se guarda?';

  @override
  String get guideStep7Text => 'Prueba esto en orden:';

  @override
  String get guideFix1 =>
      'Comprueba que el acceso a notificaciones esté activado.';

  @override
  String get guideFix2 =>
      'Revisa los ajustes de batería e inicio automático de arriba.';

  @override
  String get guideFix3 =>
      'Asegúrate de que las notificaciones de ese chat no estén silenciadas.';

  @override
  String get guideFix4 => 'Reinicia el servicio con el botón de abajo.';

  @override
  String get readDisclaimer => 'Leer el aviso legal';

  @override
  String get ourStory => 'Nuestra historia';

  @override
  String aboutStory1(String appName) {
    return '$appName nació por una razón sencilla: un mensaje importante no debería perderse solo porque alguien lo eliminó. La app guarda una copia de los mensajes que llegan a tu teléfono, organizados por app y por persona, para que puedas leerlos más tarde.';
  }

  @override
  String get aboutStory2 =>
      'Funciona leyendo las notificaciones de tu propio teléfono, con tu permiso, y tus mensajes guardados permanecen en tu dispositivo.';

  @override
  String get highlights => 'Destacados';

  @override
  String get featureOrganizedTitle => 'Chats organizados';

  @override
  String get featureOrganizedText =>
      'Los mensajes se agrupan por app y por persona, igual que las apps que ya usas.';

  @override
  String get featurePrivateTitle => 'Privada por diseño';

  @override
  String get featurePrivateText =>
      'Los mensajes guardados permanecen en tu teléfono y nunca se suben a nuestros servidores.';

  @override
  String get featureBackgroundTitle => 'Funciona en segundo plano';

  @override
  String get featureBackgroundText =>
      'Sigue guardando mensajes nuevos incluso con la app cerrada, siempre que tu teléfono lo permita.';

  @override
  String get featureControlTitle => 'Tú tienes el control';

  @override
  String get featureControlText =>
      'Elimina cualquier mensaje o chat, o desactiva el acceso, cuando quieras.';

  @override
  String get worksWith => 'Compatible con';

  @override
  String get legalSupport => 'Legal y soporte';

  @override
  String get contactUs => 'Contáctanos';

  @override
  String versionLabel(String version) {
    return 'Versión $version';
  }

  @override
  String allRightsReserved(String year, String developer) {
    return '© $year $developer. Todos los derechos reservados.';
  }

  @override
  String get notAffiliated =>
      'No está afiliada a WhatsApp, Meta, Snapchat, TikTok ni a ninguna otra app mencionada.';

  @override
  String get shareMessage =>
      'Guarda una copia de tus mensajes entrantes, incluso si se eliminan más tarde.';

  @override
  String get navStatus => 'Estados';

  @override
  String get statusAllowTitle => 'Permitir acceso a la carpeta de Estados';

  @override
  String get statusAllowText =>
      'Para mostrar los estados de WhatsApp, elige la carpeta de Estados una sola vez. La app solo lee esta carpeta y no se sube nada.';

  @override
  String get statusChangeFolder => 'Cambiar carpeta';

  @override
  String get statusWrongFolder =>
      'Esa no parece la carpeta de Estados. Inténtalo de nuevo.';

  @override
  String get statusEmptyTitle => 'No se encontraron estados';

  @override
  String get statusEmptyText =>
      'Abre WhatsApp y mira algunos estados primero; luego vuelve y desliza hacia abajo para actualizar.';

  @override
  String get statusSaved => 'Guardado en tu galería';

  @override
  String get statusSaveFailed => 'No se pudo guardar este estado';

  @override
  String get saveAction => 'Guardar';

  @override
  String get statusOnlyWhatsApp =>
      'Solo se pueden guardar estados de WhatsApp. Las historias de Facebook e Instagram no se almacenan en tu teléfono, por lo que esta app no puede guardarlas.';

  @override
  String get statusRespectNote =>
      'Guarda solo contenido que tengas derecho a usar.';

  @override
  String get statusChooseFolder => 'Permitir acceso';

  @override
  String get deleteChatsTitle => '¿Eliminar chats?';

  @override
  String get deleteChatsText =>
      'Los chats seleccionados y todos sus mensajes guardados se eliminarán solo de esta app. No se pueden recuperar.';

  @override
  String get statusViewedNote =>
      'Cualquier estado que veas en WhatsApp aparecerá aquí y podrás guardarlo.';

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
