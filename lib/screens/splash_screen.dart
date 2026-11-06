// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:lucide_icons_flutter/lucide_icons.dart';

// import '../app_config.dart';
// import '../services/connected_apps_service.dart';
// import '../services/messages_store.dart';
// import '../services/seen_chats_service.dart';
// import 'connected_apps_screen.dart';
// import 'home_screen.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   // Apna logo yahan lagao (native splash wala hi)
//   static const String _logoPath = 'assets/images/splash_logo.jpeg';

//   // Logo ka size
//   static const double _logoSize = 130;

//   // Logo ko center se upar shift karna hai, is liye offset
//   // Negative value = upar, positive = neeche
//   static const double _logoTopOffset = 0;

//   // FIX: splash kam az kam kitni der dikhe (pehle 5 second tha, bohot lamba)
//   static const Duration _minShow = Duration(milliseconds: 2500);

//   // Splash ke rang (ye screen hamesha light rehti hai)
//   static const Color _heading = Color(0xFF0B3D2E);
//   static const Color _accent = Color(0xFF16B864);

//   // Status bar transparent aur icons kaale, native splash jaisa
//   static const SystemUiOverlayStyle _overlay = SystemUiOverlayStyle(
//     statusBarColor: Colors.transparent,
//     statusBarIconBrightness: Brightness.dark,
//     statusBarBrightness: Brightness.light,
//     systemNavigationBarColor: Colors.white,
//     systemNavigationBarIconBrightness: Brightness.dark,
//   );

//   late final AnimationController _controller;
//   late final Animation<double> _fade;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 700),
//     );

//     _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

//     _controller.forward();

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       FlutterNativeSplash.remove();
//     });

//     _start();
//   }

//   Future<void> _start() async {
//     // Timer aur jaanch saath chalte hain, is liye splash zaroorat se zyada nahi rukti
//     final Future<void> minDelay = Future<void>.delayed(_minShow);

//     List<String> apps = [];
//     try {
//       apps = await ConnectedAppsService.instance.getConnectedApps();

//       // App connected hai to splash ke waqt mein hi messages aur seen-chats
//       // load kar lo, taake ConnectedAppsScreen khulte hi tayyar ho
//       if (apps.isNotEmpty) {
//         await MessagesStore.instance.start();
//         await SeenChatsService.instance.preload();
//       }
//     } catch (e) {
//       // FIX: error chupna nahi chahiye, kam az kam debug mein dikhe
//       debugPrint('Splash init error: $e');
//     }

//     await minDelay;
//     if (!mounted) return;

//     final bool hasApps = apps.isNotEmpty;

//     // pushReplacement: back dabane par splash par wapas na aaye
//     Navigator.of(context).pushReplacement(
//       PageRouteBuilder<void>(
//         transitionDuration: const Duration(milliseconds: 400),
//         pageBuilder: (context, animation, secondaryAnimation) =>
//             hasApps ? const ConnectedAppsScreen() : const HomeScreen(),
//         transitionsBuilder: (context, animation, secondaryAnimation, child) =>
//             FadeTransition(opacity: animation, child: child),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnnotatedRegion<SystemUiOverlayStyle>(
//       value: _overlay,
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         // SafeArea jaan bujh kar nahi lagaya: logo poori screen ke beech mein
//         // rehna chahiye, bilkul native splash ki tarah
//         body: LayoutBuilder(
//           builder: (context, box) {
//             final double centerY = box.maxHeight / 2;
//             final double bottomInset = MediaQuery.paddingOf(context).bottom;

//             // App name ki position: logo ke neeche thora sa gap
//             final double appNameTop =
//                 centerY + _logoTopOffset + _logoSize / 2 + 20;

//             return Stack(
//               children: [
//                 // Logo bilkul beech mein, bina animation ke
//                 Center(
//                   child: Transform.translate(
//                     offset: const Offset(0, _logoTopOffset),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(_logoSize * 0.215),
//                       child: Image.asset(
//                         _logoPath,
//                         width: _logoSize,
//                         height: _logoSize,
//                         fit: BoxFit.contain,
//                         errorBuilder: (context, error, stackTrace) {
//                           debugPrint('Splash logo load nahi hua: $error');
//                           return Container(
//                             width: _logoSize * 0.6,
//                             height: _logoSize * 0.6,
//                             decoration: const BoxDecoration(
//                               color: Color(0xFFDDF7E7),
//                               shape: BoxShape.circle,
//                             ),
//                             child: const Icon(
//                               LucideIcons.messageCircle,
//                               size: 40,
//                               color: _accent,
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//                 // Sirf App Name, logo ke neeche dheere se fade in hota hai
//                 Positioned(
//                   top: appNameTop,
//                   left: 0,
//                   right: 0,
//                   child: FadeTransition(
//                     opacity: _fade,
//                     child: const Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 32),
//                       child: Text(
//                         AppConfig.appName,
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 26,
//                           fontWeight: FontWeight.w800,
//                           color: _heading,
//                           letterSpacing: -0.5,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),

//                 // Neeche line wali loading animation
//                 Positioned(
//                   bottom: bottomInset + 40,
//                   left: 0,
//                   right: 0,
//                   child: Center(
//                     child: FadeTransition(
//                       opacity: _fade,
//                       // SizedBox se width fix ki hai taake line center rahe
//                       child: const SizedBox(
//                         width: 120,
//                         child: LinearProgressIndicator(
//                           minHeight: 3,
//                           backgroundColor: Color(0xFFE0F2E9),
//                           color: _accent,
//                           borderRadius: BorderRadius.all(Radius.circular(10)),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../app_config.dart';
import '../services/connected_apps_service.dart';
import '../services/messages_store.dart';
import '../services/seen_chats_service.dart';
import 'connected_apps_screen.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  // Apna logo yahan lagao (native splash wala hi)
  static const String _logoPath = 'assets/images/splash_logo.jpeg';

  // Logo ka size
  static const double _logoSize = 130;

  // Logo ko center se upar shift karna hai, is liye offset
  // Negative value = upar, positive = neeche
  static const double _logoTopOffset = 0;

  // FIX: splash kam az kam kitni der dikhe (pehle 5 second tha, bohot lamba)
  static const Duration _minShow = Duration(milliseconds: 2500);

  // Splash ke rang (ye screen hamesha light rehti hai)
  static const Color _heading = Color(0xFF0B3D2E);
  static const Color _accent = Color(0xFF388E3C); // brand green (sab screens ke barabar)

  // Status bar transparent aur icons kaale, native splash jaisa
  static const SystemUiOverlayStyle _overlay = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  );

  late final AnimationController _controller;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    _controller.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FlutterNativeSplash.remove();
    });

    _start();
  }

  Future<void> _start() async {
    // Timer aur jaanch saath chalte hain, is liye splash zaroorat se zyada nahi rukti
    final Future<void> minDelay = Future<void>.delayed(_minShow);

    List<String> apps = [];
    try {
      apps = await ConnectedAppsService.instance.getConnectedApps();

      // App connected hai to splash ke waqt mein hi messages aur seen-chats
      // load kar lo, taake ConnectedAppsScreen khulte hi tayyar ho
      if (apps.isNotEmpty) {
        await MessagesStore.instance.start();
        await SeenChatsService.instance.preload();
      }
    } catch (e) {
      // FIX: error chupna nahi chahiye, kam az kam debug mein dikhe
      debugPrint('Splash init error: $e');
    }

    await minDelay;
    if (!mounted) return;

    final bool hasApps = apps.isNotEmpty;

    // pushReplacement: back dabane par splash par wapas na aaye
    Navigator.of(context).pushReplacement(
      PageRouteBuilder<void>(
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (context, animation, secondaryAnimation) =>
            hasApps ? const ConnectedAppsScreen() : const HomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _overlay,
      child: Scaffold(
        backgroundColor: Colors.white,
        // SafeArea jaan bujh kar nahi lagaya: logo poori screen ke beech mein
        // rehna chahiye, bilkul native splash ki tarah
        body: LayoutBuilder(
          builder: (context, box) {
            final double centerY = box.maxHeight / 2;
            final double bottomInset = MediaQuery.paddingOf(context).bottom;

            // App name ki position: logo ke neeche thora sa gap
            final double appNameTop =
                centerY + _logoTopOffset + _logoSize / 2 + 20;

            return Stack(
              children: [
                // Logo bilkul beech mein, bina animation ke
                Center(
                  child: Transform.translate(
                    offset: const Offset(0, _logoTopOffset),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(_logoSize * 0.215),
                      child: Image.asset(
                        _logoPath,
                        width: _logoSize,
                        height: _logoSize,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          debugPrint('Splash logo load nahi hua: $error');
                          return Container(
                            width: _logoSize * 0.6,
                            height: _logoSize * 0.6,
                            decoration: const BoxDecoration(
                              color: Color(0xFFE8F5E9),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              LucideIcons.messageCircle,
                              size: 40,
                              color: _accent,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                // Sirf App Name, logo ke neeche dheere se fade in hota hai
                Positioned(
                  top: appNameTop,
                  left: 0,
                  right: 0,
                  child: FadeTransition(
                    opacity: _fade,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        AppConfig.appName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          color: _heading,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                  ),
                ),

                // Neeche line wali loading animation
                Positioned(
                  bottom: bottomInset + 40,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: FadeTransition(
                      opacity: _fade,
                      // SizedBox se width fix ki hai taake line center rahe
                      child: const SizedBox(
                        width: 120,
                        child: LinearProgressIndicator(
                          minHeight: 3,
                          backgroundColor: Color(0xFFE8F5E9),
                          color: _accent,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}