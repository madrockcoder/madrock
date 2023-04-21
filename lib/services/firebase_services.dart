import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geniuspay/models/notification_message.dart';
import 'package:geniuspay/util/essentials.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  saveMessage(message);
}

void saveMessage(RemoteMessage message) async {
  final prefs = await SharedPreferences.getInstance();
  List<String> finalData = [];
  List<String>? notifs = prefs.getStringList('notifications');
  debugPrint("Noti: ${message.data}");
  final data = NotificationMessage.fromJson({
    'id': message.messageId as String,
    'title': message.notification?.title as String,
    'body': message.notification?.body as String,
    'dateSent': DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now()),
    'type': '',
    //'type': message.data['type'],
    // TODO: Run this part was false initially
    'read': 'false'
  });
  if (notifs != null) {
    finalData.addAll(notifs);
  }
  finalData.add(jsonEncode(data.toJson()));
  await prefs.setStringList('notifications', finalData);
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  importance: Importance.max,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class FirebaseServices {
  Future<void> init() async {
    final token = await FirebaseMessaging.instance.getToken();
    debugPrint('token is $token');
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('logo');
    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    const MacOSInitializationSettings initializationSettingsMacOS =
        MacOSInitializationSettings(
            requestAlertPermission: false,
            requestBadgePermission: false,
            requestSoundPermission: false);
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: initializationSettingsMacOS);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;
      AndroidNotification android = message.notification!.android!;

      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              icon: android.smallIcon,
              // other properties...
            ),
          ));
      saveMessage(message);
    });
  }
}
