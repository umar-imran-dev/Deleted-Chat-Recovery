// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:lucide_icons_flutter/lucide_icons.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../app_config.dart';
// import '../theme/app_colors.dart';
// import '../theme/theme_controller.dart';

// class _Point {
//   final IconData icon;
//   final String title;
//   final String text;

//   const _Point(this.icon, this.title, this.text);
// }

// // Notification access maangne se pehle dikhne wali "prominent disclosure".
// // Google Play ko ye screen app ke andar chahiye, sirf Privacy Policy kaafi nahi.
// class NotificationDisclosureScreen extends StatelessWidget {
//   const NotificationDisclosureScreen({super.key});

//   static const String _acceptedKey = 'notification_disclosure_accepted';

//   static Future<bool> isAccepted() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getBool(_acceptedKey) ?? false;
//   }

//   // Screen kholo, user ne "Agree" dabaya to true
//   static Future<bool> show(BuildContext context) async {
//     final bool? agreed = await Navigator.push<bool>(
//       context,
//       MaterialPageRoute(builder: (_) => const NotificationDisclosureScreen()),
//     );
//     return agreed ?? false;
//   }

//   // Pehle se manzoor ho chuka ho to seedha true, warna screen dikhao
//   static Future<bool> ensureAccepted(BuildContext context) async {
//     if (await isAccepted()) return true;
//     if (!context.mounted) return false;
//     return show(context);
//   }

//   Future<void> _accept(BuildContext context) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool(_acceptedKey, true);
//     if (!context.mounted) return;
//     Navigator.pop(context, true);
//   }

//   static const List<_Point> _reads = [
//     _Point(
//       LucideIcons.bell,
//       'Notifications of the apps you connect',
//       'For example WhatsApp, Instagram, Messenger, Snapchat and TikTok. Only notifications from the supported apps are used.',
//     ),
//     _Point(
//       LucideIcons.messageCircle,
//       'What is saved from each message',
//       'The sender or chat name, the message text shown in the notification, the time, and the sender\'s profile picture if the notification includes one.',
//     ),
//   ];

//   static const List<_Point> _privacy = [
//     _Point(
//       LucideIcons.smartphone,
//       'Stored on your phone only',
//       'Saved messages never leave your device. We do not upload, sell or share them, and we do not use them for ads or analytics.',
//     ),
//     _Point(
//       LucideIcons.eyeOff,
//       'What the app does not read',
//       'Your contacts, photos, files, camera, microphone, location, or anything that was never shown as a notification.',
//     ),
//     _Point(
//       LucideIcons.slidersHorizontal,
//       'You stay in control',
//       'Turn off Notification access in Android Settings at any time, delete saved messages from the app, or uninstall to remove everything.',
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return ListenableBuilder(
//       listenable: ThemeController.instance,
//       builder: (context, _) {
//         final AppColors c = AppColors.current;

//         return Scaffold(
//           backgroundColor: c.background,
//           appBar: AppBar(
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//             scrolledUnderElevation: 0,
//             automaticallyImplyLeading: false,
//             titleSpacing: 16,
//             systemOverlayStyle:
//                 c.isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
//             title: Row(
//               children: [
//                 GestureDetector(
//                   onTap: () => Navigator.maybePop(context),
//                   child: Icon(LucideIcons.chevronLeft, size: 22, color: c.heading),
//                 ),
//                 const SizedBox(width: 14),
//                 Text(
//                   'Before you continue',
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.w700,
//                     color: c.heading,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           body: ListView(
//             padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
//             children: [
//               _header(c),
//               const SizedBox(height: 20),
//               _sectionTitle(c, 'What this app reads'),
//               const SizedBox(height: 12),
//               _card(c, _reads),
//               const SizedBox(height: 20),
//               _sectionTitle(c, 'Why we need it'),
//               const SizedBox(height: 12),
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: c.card,
//                   borderRadius: BorderRadius.circular(24),
//                 ),
//                 child: Text(
//                   'Android does not let apps see deleted messages. By saving a copy of each incoming notification, ${AppConfig.appName} lets you read a message later, even if the sender deletes it. This is the only purpose of this permission.',
//                   style: TextStyle(fontSize: 13.5, height: 1.55, color: c.body),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               _sectionTitle(c, 'Your privacy'),
//               const SizedBox(height: 12),
//               _card(c, _privacy),
//             ],
//           ),
//           bottomNavigationBar: SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   SizedBox(
//                     width: double.infinity,
//                     height: 50,
//                     child: ElevatedButton(
//                       onPressed: () => _accept(context),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: c.accent,
//                         foregroundColor: Colors.white,
//                         elevation: 0,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                       ),
//                       child: const Text(
//                         'Agree and continue',
//                         style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   TextButton(
//                     onPressed: () => Navigator.pop(context, false),
//                     child: Text(
//                       'Not now',
//                       style: TextStyle(
//                         fontSize: 13.5,
//                         fontWeight: FontWeight.w600,
//                         color: c.muted,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _header(AppColors c) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: c.highlight,
//         borderRadius: BorderRadius.circular(22),
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 48,
//             height: 48,
//             decoration: BoxDecoration(
//               color: c.surface,
//               shape: BoxShape.circle,
//             ),
//             child: Icon(LucideIcons.shieldCheck, color: c.accent, size: 24),
//           ),
//           const SizedBox(width: 14),
//           Expanded(
//             child: Text(
//               '${AppConfig.appName} needs Notification access to work. Please read how it is used.',
//               style: TextStyle(
//                 fontSize: 14,
//                 height: 1.45,
//                 fontWeight: FontWeight.w600,
//                 color: c.heading,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _sectionTitle(AppColors c, String text) {
//     return Row(
//       children: [
//         Container(
//           width: 4,
//           height: 22,
//           decoration: BoxDecoration(
//             color: c.accent,
//             borderRadius: BorderRadius.circular(4),
//           ),
//         ),
//         const SizedBox(width: 10),
//         Text(
//           text,
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//             color: c.heading,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _card(AppColors c, List<_Point> points) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
//       decoration: BoxDecoration(
//         color: c.card,
//         borderRadius: BorderRadius.circular(24),
//       ),
//       child: Column(
//         children: [
//           for (int i = 0; i < points.length; i++) ...[
//             _row(c, points[i]),
//             if (i != points.length - 1) Divider(height: 1, color: c.line),
//           ],
//         ],
//       ),
//     );
//   }

//   Widget _row(AppColors c, _Point p) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 12),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             width: 40,
//             height: 40,
//             decoration: BoxDecoration(
//               color: c.accentPale,
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: Icon(p.icon, size: 20, color: c.iconOnPale),
//           ),
//           const SizedBox(width: 14),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   p.title,
//                   style: TextStyle(
//                     fontSize: 15,
//                     fontWeight: FontWeight.w600,
//                     color: c.title,
//                   ),
//                 ),
//                 const SizedBox(height: 3),
//                 Text(
//                   p.text,
//                   style: TextStyle(fontSize: 12.5, height: 1.45, color: c.muted),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }