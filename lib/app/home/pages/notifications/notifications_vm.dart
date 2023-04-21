import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/models/notification_message.dart';
import 'package:geniuspay/models/user.dart';
import 'package:geniuspay/repos/local_repo.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class NotificationsVM extends BaseModel {
  final AuthenticationService _authenticationService =
      sl<AuthenticationService>();
  final LocalBase _localBase = sl<LocalBase>();
  User? get user => _authenticationService.user;
  List<NotificationMessage> notifications = [];
  int get unreadNotifications => getUnreadNotifs();
  void getNotifications() {
    notifications = [];
    final data = _localBase.getNotifications();
    if (data.isEmpty) {
      notifications = [];
      notifyListeners();
    } else {
      for (var val in data) {
        final element = NotificationMessage.fromJson(jsonDecode(val));
        notifications.add(element);
      }
      notifications = notifications.reversed.toList();
      notifyListeners();
    }

    getUnreadNotifs();
  }

  Future<void> clearAllNotifs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('notifications');
    getNotifications();
  }

  Future<void> markAllAsRead() async {
    List<NotificationMessage> modifiedData = [];

    var data = _localBase.getNotifications();
    if (data.isNotEmpty) {
      for (var val in data) {
        var element = NotificationMessage.fromJson(jsonDecode(val));
        element.read = 'true';
        modifiedData.add(element);
      }
      final finalData =
          modifiedData.map((e) => jsonEncode(e.toJson())).toList();
      final prefs = await SharedPreferences.getInstance();
      prefs.setStringList('notifications', finalData);

      getUnreadNotifs();
      notifyListeners();
    }
  }

  Future<void> removeNotif(String id) async {
    notifications.removeWhere((element) => element.id == id);
    final prefs = await SharedPreferences.getInstance();
    List<String> notifs = [];
    for (var val in notifications) {
      notifs.add(jsonEncode(val.toJson()));
    }
    prefs.setStringList('notifications', notifs);
    await SharedPreferences.getInstance();
    getNotifications();
  }

  int getUnreadNotifs() {
    final data = _localBase.getNotifications();
    if (data.isEmpty) {
      return 0;
    }
    int count = 0;
    for (var val in data) {
      final element = NotificationMessage.fromJson(jsonDecode(val));
      if (element.read == 'false') {
        count++;
      }
    }

    return count;
  }
}
