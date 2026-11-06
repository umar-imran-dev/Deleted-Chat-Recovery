// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:lucide_icons_flutter/lucide_icons.dart';

// import '../app_config.dart';
// import '../services/app_actions.dart';
// import '../theme/app_colors.dart';
// import '../theme/theme_controller.dart';

// class LegalSection {
//   final String title;
//   final List<String> paragraphs;
//   final List<String> bullets;

//   const LegalSection({
//     required this.title,
//     this.paragraphs = const [],
//     this.bullets = const [],
//   });
// }

// class LegalPage extends StatelessWidget {
//   final String title;
//   final IconData icon;
//   final String intro;
//   final List<LegalSection> sections;

//   const LegalPage({
//     super.key,
//     required this.title,
//     required this.icon,
//     required this.intro,
//     required this.sections,
//   });

//   TextStyle _bodyStyle(AppColors c) =>
//       TextStyle(fontSize: 13.5, height: 1.5, color: c.body);

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
//                   title,
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.w700,
//                     color: c.heading,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           body: ListView(
//             padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
//             children: [
//               _header(c),
//               const SizedBox(height: 16),
//               for (int i = 0; i < sections.length; i++)
//                 _sectionCard(c, i + 1, sections[i]),
//               _contactCard(context, c),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _header(AppColors c) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: c.highlight,
//         borderRadius: BorderRadius.circular(22),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 width: 44,
//                 height: 44,
//                 decoration: BoxDecoration(
//                   color: c.surface,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(icon, color: c.accent, size: 22),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       AppConfig.appName,
//                       style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w700,
//                         color: c.heading,
//                       ),
//                     ),
//                     const SizedBox(height: 2),
//                     Text(
//                       'Last updated: ${AppConfig.policyUpdated}',
//                       style: TextStyle(fontSize: 11.5, color: c.muted),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           Text(intro, style: _bodyStyle(c)),
//         ],
//       ),
//     );
//   }

//   Widget _sectionCard(AppColors c, int number, LegalSection section) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: c.card,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 width: 26,
//                 height: 26,
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   color: c.accentPale,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Text(
//                   '$number',
//                   style: TextStyle(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w800,
//                     color: c.accent,
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 10),
//               Expanded(
//                 child: Text(
//                   section.title,
//                   style: TextStyle(
//                     fontSize: 15.5,
//                     fontWeight: FontWeight.w700,
//                     color: c.heading,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 10),
//           for (final String p in section.paragraphs)
//             Padding(
//               padding: const EdgeInsets.only(bottom: 8),
//               child: Text(p, style: _bodyStyle(c)),
//             ),
//           for (final String b in section.bullets)
//             Padding(
//               padding: const EdgeInsets.only(bottom: 6),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(top: 7),
//                     child: Container(
//                       width: 5,
//                       height: 5,
//                       decoration: BoxDecoration(
//                         color: c.accent,
//                         shape: BoxShape.circle,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   Expanded(child: Text(b, style: _bodyStyle(c))),
//                 ],
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _contactCard(BuildContext context, AppColors c) {
//     return Container(
//       padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: c.accentPale, width: 1.5),
//       ),
//       child: Row(
//         children: [
//           Icon(LucideIcons.mail, color: c.accent, size: 22),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Questions or requests?',
//                   style: TextStyle(
//                     fontSize: 13.5,
//                     fontWeight: FontWeight.w700,
//                     color: c.heading,
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   AppConfig.supportEmail,
//                   style: TextStyle(fontSize: 12, color: c.muted),
//                 ),
//               ],
//             ),
//           ),
//           TextButton(
//             onPressed: () => AppActions.sendFeedback(context),
//             child: Text('Contact', style: TextStyle(color: c.accent)),
//           ),
//         ],
//       ),
//     );
//   }
// }