

// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/cupertino.dart';

// import '../models/notification_message.dart';
// import '../services/notification_servics.dart';



// class NotificationProvider extends ChangeNotifier{


//    List<NotificationMessage> notifications =[];

//    late StreamSubscription listener ;

//    NotificationProvider(){

//      getNotificationsMessage();
//      listener = NotificationServices.controller.stream.listen((NotificationEnum message) {
//         getNotificationsMessage();
//      });

//    }

//    getNotificationsMessage(){
//     List<String> stringNotifications = NotificationServices.getNotification();
//     notifications =[];
//     for (var element in stringNotifications) {
//       NotificationMessage  message = NotificationMessage.fromJsom(jsonDecode(element));
//       notifications.add(message);
//     }
//    notifyListeners();
//   }

//   void readNotification(int index){
//     NotificationMessage  message = notifications[index];
//     message.read = true;
//     notifications[index] = message;
//     NotificationServices.read(index,jsonEncode(message.toJson()));
//     notifyListeners();
//   }

//   void muteNotification(){
//     NotificationServices.muteNotification();
//   }

//   void markAllRead(){
//      List<String> messages = [];

//   for (var message in notifications) {
//     if (!message.read!) message.read = true;
//     messages.add(jsonEncode(message.toJson()));
//   }
//      NotificationServices.markAllRead(messages);
//     notifyListeners();

//   }

//   void clearNotification(){
//     notifications =[];
//     NotificationServices.clearNotification();
//     notifyListeners();
//   }

//   void closeListener(){
//     listener.cancel();
//   }






// }