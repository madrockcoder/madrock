// import 'package:flutter/material.dart';
// import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
// import 'package:geniuspay/app/auth/pages/flash_screens/start_page.dart';
// import 'package:geniuspay/app/auth/pages/sign_up/widgets/auth_provider.dart';
// import 'package:geniuspay/app/home/pages/home_containter.dart';
// import 'package:geniuspay/app/shared_widgets/error_page.dart';
// import 'package:geniuspay/app/shared_widgets/error_screens/server_down_screen.dart';
// import 'package:geniuspay/core/injections/locator.dart';
// import 'package:geniuspay/services/auth_services.dart';
// import 'package:provider/provider.dart';

// import '../app/shared_widgets/http_exception.dart';
// import '../repos/local_repo.dart';

// class AppInitializer {
//   AppInitializer({required this.context});
//   final BuildContext context;

//   final AuthenticationService _authenticationService =
//       sl<AuthenticationService>();
//   Future<void> load() async {
//     try {
//       final token = _fetchToken();

//       if (token != null) {
//         await _authenticationService.getUser();
//         final user = _authenticationService.user;
//         if (user != null) {
//           HomeWidget.show(context);
//         } else {
//           ServerDownScreen.show(context: context);
//         }
//       } else {
//         // HomeWidget.show(context);
//         Navigator.of(context).push(
//           MaterialPageRoute(builder: (_) => const Startpage()),
//         );
//       }
//     } on CustomHttpException catch (e) {
//       if (e.title.contains('Error Finding User') ||
//           e.message.contains('Invalid token')) {
//         await context.read<AuthProvider>().logout();
//       }
//       // c@gmail.com
//     } catch (e) {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (_) => const ErrorPage()),
//       );
//     }
//   }

//   Future<bool> checkIFDeviceIsBreaked() async {
//     return await FlutterJailbreakDetection.jailbroken ||
//         await FlutterJailbreakDetection.developerMode;
//   }

//   //? TASK 2
//   String? _fetchToken() {
//     final localBase = sl<LocalBase>();
//     // localBase.deleteToken();
//     return localBase.getToken();
//   }
// }
