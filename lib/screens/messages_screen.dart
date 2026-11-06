// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/foundation.dart' show PluginUtilities;

// import 'dart:ui';

// import '../background/background_entry.dart';
// import '../models/saved_message.dart';
// import '../services/messages_store.dart';
// import 'chat_detail_screen.dart';

// import 'dart:io';

// import '../services/avatar_service.dart';

// class MessagesScreen extends StatefulWidget {
//   const MessagesScreen({super.key});

//   @override
//   State<MessagesScreen> createState() => _MessagesScreenState();
// }

// class _MessagesScreenState extends State<MessagesScreen>
//     with WidgetsBindingObserver {
//   static const MethodChannel _channel = MethodChannel('native_log');

//   bool _hasPermission = false;
//   bool _batteryOk = false;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     MessagesStore.instance.addListener(_onStoreChanged);
//     _init();
//   }

//   Future<void> _init() async {
//     await MessagesStore.instance.start();
//     _checkPermission();
//     _checkBattery();
//     _registerBackgroundHandle();
//   }

//   void _onStoreChanged() {
//     if (mounted) setState(() {});
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed) {
//       _checkPermission();
//       _checkBattery();
//       MessagesStore.instance.reload();
//     }
//   }

//   Future<void> _checkPermission() async {
//     bool granted = false;
//     try {
//       granted = await _channel.invokeMethod<bool>('isEnabled') ?? false;
//     } catch (_) {}
//     if (!mounted) return;
//     setState(() => _hasPermission = granted);
//   }

//   Future<void> _checkBattery() async {
//     bool ok = false;
//     try {
//       ok = await _channel.invokeMethod<bool>('isBatteryUnrestricted') ?? false;
//     } catch (_) {}
//     if (!mounted) return;
//     setState(() => _batteryOk = ok);
//   }

//   Future<void> _openSettings() async {
//     await _channel.invokeMethod('openSettings');
//   }

//   Future<void> _openBatterySettings() async {
//     bool opened = false;
//     try {
//       opened =
//           await _channel.invokeMethod<bool>('openBatterySettings') ?? false;
//     } catch (_) {}
//     if (!mounted) return;
//     if (!opened) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text('Settings nahi khul saki')));
//     }
//   }

//   Future<void> _openAutoStartSettings() async {
//     await _channel.invokeMethod('openAutoStartSettings');
//   }

//   Future<void> _registerBackgroundHandle() async {
//     final CallbackHandle? handle = PluginUtilities.getCallbackHandle(
//       backgroundMain,
//     );
//     if (handle == null) return;
//     try {
//       await _channel.invokeMethod('registerBackgroundHandle', {
//         'handle': handle.toRawHandle(),
//       });
//     } catch (_) {}
//   }

//   Future<void> _showNativeLog() async {
//     List<String> lines;
//     try {
//       lines = await _channel.invokeListMethod<String>('getLog') ?? [];
//     } catch (e) {
//       lines = ['Error: $e'];
//     }
//     if (!mounted) return;
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Native (Kotlin) log'),
//         content: SizedBox(
//           width: double.maxFinite,
//           height: 400,
//           child: ListView.builder(
//             itemCount: lines.length,
//             itemBuilder: (context, i) => Padding(
//               padding: const EdgeInsets.symmetric(vertical: 4),
//               child: Text(lines[i], style: const TextStyle(fontSize: 12)),
//             ),
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Close'),
//           ),
//         ],
//       ),
//     );
//   }

//     Widget _buildAvatar(String sender) {
//     return FutureBuilder<String?>(
//       future: AvatarService.instance.pathFor('WhatsApp', sender),
//       builder: (context, snapshot) {
//         final String? path = snapshot.data;
//         if (path != null && File(path).existsSync()) {
//           return CircleAvatar(backgroundImage: FileImage(File(path)));
//         }
//         return CircleAvatar(
//           backgroundColor: Colors.teal.shade100,
//           child: Text(
//             sender.isNotEmpty ? sender[0].toUpperCase() : '?',
//             style: const TextStyle(fontWeight: FontWeight.bold),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     MessagesStore.instance.removeListener(_onStoreChanged);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final List<SavedMessage> chats = MessagesStore.instance.chatSummariesFor(
//       'WhatsApp',
//     );

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('WhatsApp'),
//         backgroundColor: Colors.teal.shade100,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.science),
//             onPressed: _showNativeLog,
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Card(
//             margin: const EdgeInsets.all(12),
//             color: _hasPermission
//                 ? Colors.green.shade100
//                 : Colors.orange.shade100,
//             child: ListTile(
//               leading: Icon(
//                 _hasPermission
//                     ? Icons.check_circle
//                     : Icons.warning_amber_rounded,
//               ),
//               title: Text(
//                 _hasPermission ? 'Permission mil gayi' : 'Permission nahi mili',
//               ),
//               trailing: _hasPermission
//                   ? null
//                   : ElevatedButton(
//                       onPressed: _openSettings,
//                       child: const Text('Allow'),
//                     ),
//             ),
//           ),
//           if (!_batteryOk)
//             Card(
//               margin: const EdgeInsets.symmetric(horizontal: 12),
//               color: Colors.orange.shade100,
//               child: Column(
//                 children: [
//                   const ListTile(
//                     leading: Icon(Icons.battery_alert),
//                     title: Text('Background mein chalte rehne ke liye 2 kaam'),
//                     subtitle: Text(
//                       'Battery restriction hatao, aur Auto-start on karo, warna phone message miss kar sakta hai',
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 12),
//                     child: Wrap(
//                       spacing: 8,
//                       children: [
//                         ElevatedButton(
//                           onPressed: _openBatterySettings,
//                           child: const Text('Battery'),
//                         ),
//                         OutlinedButton(
//                           onPressed: _openAutoStartSettings,
//                           child: const Text('Auto-start'),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           Expanded(
//             child: chats.isEmpty
//                 ? const Center(child: Text('Abhi koi chat save nahi hui'))
//                 : ListView.separated(
//                     itemCount: chats.length,
//                     separatorBuilder: (context, index) =>
//                         const Divider(height: 1),
//                     itemBuilder: (context, index) {
//                       final SavedMessage chat = chats[index];
//                       final String time = TimeOfDay.fromDateTime(
//                         chat.receivedAt,
//                       ).format(context);
//                       return ListTile(
//                         leading: _buildAvatar(chat.sender),
//                         title: Text(
//                           chat.sender,
//                           style: const TextStyle(fontWeight: FontWeight.w600),
//                         ),
//                         subtitle: Text(
//                           chat.isDeleted
//                               ? 'Aakhri message delete hua tha'
//                               : chat.text,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: chat.isDeleted
//                               ? TextStyle(color: Colors.red.shade400)
//                               : null,
//                         ),
//                         trailing: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Text(
//                               time,
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.grey.shade600,
//                               ),
//                             ),
//                             if (chat.isDeleted)
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 4),
//                                 child: Chip(
//                                   label: const Text(
//                                     'Deleted',
//                                     style: TextStyle(fontSize: 10),
//                                   ),
//                                   backgroundColor: Colors.red.shade100,
//                                   materialTapTargetSize:
//                                       MaterialTapTargetSize.shrinkWrap,
//                                   visualDensity: VisualDensity.compact,
//                                 ),
//                               ),
//                           ],
//                         ),
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => ChatDetailScreen(
//                                 app: 'WhatsApp',
//                                 sender: chat.sender,
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     },
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }
