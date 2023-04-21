import 'dart:convert';

import 'package:geniuspay/models/country.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/essentials.dart';

abstract class LocalBase {
  String? getToken();
  void setToken(String token);
  Future<void> removeToken();

  String? getPasscode();
  void setPasscode(String token);

  // device countries
  void setdeviceCountry(String token); // nationality
  Country? getdeviceCountry();

  void setResidenceCountry(String token); // residemce
  Country? getResidenceCountry();

  void setBirthCountry(String token);
  Country? getBirthCountry();

  void deleteToken();
  void deletePasscode();

  bool getFaceID();
  void setFaceID(bool token);

  void deleteFaceID();
  void acceptPrivacyAndTerms();
  bool? getPrivacyAndTerms();
  void setVeriffUrl(String? url);
  String? getVeriffUrl();
  void setBool(String key, bool value);
  bool getBool(String key);
  void setList(String key, List<String> list);
  List<String> getList(String key);
  int getInt(String key);
  String? getFcmToken();
  void setFcmToken(String token);
  List<String> getNotifications();
  void setHomeWidgetOrder(List<int> list);
  List<int> getHomeWidgetOrder();
  int availableOtpResends();
  void decrementAvailableOtpResends();
  bool isReferAndEarnPageOpenedOnce();
  void setReferAndEarnPageAsOpened();
  bool isCreateAWalletPageOpenedOnce();
  void setCreateAWalletPageAsOpened();

  void setPrivacySettings(Map<String, dynamic> settings);
  Map<String, dynamic> getPrivacySettings();

  void setNotificationSettings(Map<String, dynamic> settings);
  Map<String, dynamic> getNotificationSettings();
}

@LazySingleton(as: LocalBase)
class LocalRepo implements LocalBase {
  LocalRepo(this.prefs);

  final SharedPreferences prefs;

  @override
  Map<String, dynamic> getNotificationSettings() {
    final result = prefs.getString('notificationSettings');
    if (result != null) {
      return jsonDecode(result);
    } else {
      return {
        'security_unusual_activity': true,
        'security_new_signin': true,
        'news_latest': true,
        'news_updates': true,
      };
    }
  }

  @override
  void setNotificationSettings(Map<String, dynamic> settings) {
    final jsonString = jsonEncode(settings);
    prefs.setString('notificationSettings', jsonString);
  }

  @override
  Map<String, dynamic> getPrivacySettings() {
    final result = prefs.getString('privacySettings');
    if (result != null) {
      return jsonDecode(result);
    } else {
      return {
        'data_preference_performance': true,
        'data_preference_targeting': true,
        'marketing_preference_pushnotif': true,
        'marketing_preference_email': true,
        'marketing_preference_sms': true,
        'marketing_preference_parter': true,
        'default_notification_actions': true,
        'bills_calendar': true
      };
    }
  }

  @override
  void setPrivacySettings(Map<String, dynamic> settings) {
    final jsonString = jsonEncode(settings);
    prefs.setString('privacySettings', jsonString);
  }

  @override
  List<String> getNotifications() {
    final result = prefs.getStringList('notifications');

    return result ?? [];
  }

  @override
  void setHomeWidgetOrder(List<int> list) {
    List<String> stringList = list.map((e) => e.toString()).toList();
    prefs.setStringList('homewidgetorder', stringList);
  }

  @override
  List<int> getHomeWidgetOrder() {
    final result = prefs.getStringList('homewidgetorder');
    if (result == null) {
      return [0, 1, 2, 3];
    } else {
      List<int> intList = result.map((e) => int.parse(e)).toList();
      return intList;
    }
  }

  @override
  void setFcmToken(String token) {
    debugPrint('token ... is $token');
    prefs.setString('fcmToken', token);
  }

  @override
  String? getFcmToken() {
    return prefs.getString('fcmToken');
  }

  @override
  void acceptPrivacyAndTerms() {
    prefs.setBool('privacyandterms', true);
  }

  @override
  bool? getPrivacyAndTerms() {
    return prefs.getBool('privacyandterms');
  }

  @override
  String? getToken() {
    return prefs.getString('token');
  }

  @override
  void setToken(String token) {
    debugPrint('tokencc ... is $token');
    prefs.setString('token', token);
  }

  @override
  Future<void> removeToken() async {
    await prefs.remove('token');
  }

// countries
  @override
  Country? getdeviceCountry() {
    final result = prefs.getString('deviceCountry');
    if (result != null) {
      return Country.fromJson(result);
    } else {
      return null;
    }
  }

  @override
  void setdeviceCountry(String token) {
    prefs.setString('deviceCountry', token);
  }

  @override
  Country? getResidenceCountry() {
    final result = prefs.getString('residenceCountry');
    if (result != null) {
      return Country.fromJson(result);
    } else {
      return null;
    }
  }

  @override
  void setResidenceCountry(String token) {
    prefs.setString('residenceCountry', token);
  }

  @override
  Country? getBirthCountry() {
    final result = prefs.getString('birthCountry');
    if (result != null) {
      return Country.fromJson(result);
    } else {
      return null;
    }
  }

  @override
  void setBirthCountry(String token) {
    prefs.setString('birthCountry', token);
  }

  @override
  String? getVeriffUrl() {
    return prefs.getString('veriffurl');
  }

  @override
  void setVeriffUrl(String? url) {
    if (url != null) {
      prefs.setString('veriffurl', url);
    } else {
      prefs.remove('veriffurl');
    }
  }

  @override
  String? getPasscode() {
    return prefs.getString('passcode');
  }

  @override
  void setPasscode(String token) {
    prefs.setString('passcode', token);
  }

  @override
  void deleteToken() {
    prefs.remove('token');
  }

  @override
  void deletePasscode() {
    prefs.remove('passcode');
  }

  @override
  bool getFaceID() {
    return prefs.getBool('face_id') ?? false;
  }

  @override
  void setFaceID(bool token) {
    prefs.setBool('face_id', token);
  }

  @override
  void deleteFaceID() {
    prefs.remove('face_id');
  }

  @override
  void setBool(String key, bool value) {
    prefs.setBool(key, value);
  }

  @override
  bool getBool(String key) {
    return prefs.getBool(key) ?? false;
  }

  @override
  List<String> getList(String key) {
    return prefs.getStringList(key) ?? [];
  }

  @override
  void setList(String key, List<String> list) {
    prefs.setStringList(key, list);
  }

  @override
  int getInt(String key) {
    return prefs.getInt(key) ?? 0;
  }

  @override
  int availableOtpResends() {
    return prefs.getInt('is_otp_resend_limit_exceeded') ?? 3;
  }

  @override
  void decrementAvailableOtpResends() {
    prefs.setInt('is_otp_resend_limit_exceeded', availableOtpResends() - 1);
  }

  @override
  bool isReferAndEarnPageOpenedOnce() {
    return prefs.getBool('is_refer_and_earn_page_opened_once') == true;
  }

  @override
  void setReferAndEarnPageAsOpened() {
    prefs.setBool('is_refer_and_earn_page_opened_once', true);
  }

  @override
  bool isCreateAWalletPageOpenedOnce() {
    return prefs.getBool('is_create_a_wallet_page_opened_once') == true;
  }

  @override
  void setCreateAWalletPageAsOpened() {
    prefs.setBool('is_create_a_wallet_page_opened_once', true);
  }
}
