import 'package:intl/intl.dart';

class RemoteConfigDataModel {
  RemoteConfigDataModel.fromJson(Map<String, dynamic> data) {
    appUrl = data['app_url'] as String;
    apiKey = data['api_key'] as String;
    secretKey = data['secret_key'] as String;
    logo = data['logo'] as String;
    sentryId = data['sentry_id'] as String;
    mixPanel = data['mixpanel'] as String;
    allowSocialSignup = data['allow_social_signup'] as bool;
    allowKyc = data['allow_kyc'] as bool;
    maintenance = data['maintenance'] as bool;
    baseUrl = data['base_url'] as String;
    googleMapKey = data['google_map_api'];
    apiVersion = data['api_version'] as String;
    supportedCountries = data['supported_countries'] as List<String>;
    maintenanceTime = data['maintenance_time'] as DateTime;
    stripeCredentials = data['stripe_credentials'] as Map<String, String>;
  }

  String? appUrl;
  String? apiKey;
  String? secretKey;
  String? logo;
  String? sentryId;
  String? mixPanel;
  String? baseUrl;
  String? googleMapKey;
  String? apiVersion;
  List<String> supportedCountries = [];
  bool? allowSocialSignup;
  bool? allowKyc;
  bool? maintenance;
  DateTime? maintenanceTime;
  Map<String, String> stripeCredentials = {};
}

DateTime maintenanceTimeJsonToDateTime(data) => DateFormat('yyyy-MM-dd HH:mm:ss').parse(
    "${DateTime.now().year}-${data['date'].split('/')[1]}-${data['date'].split('/')[0]} ${data['time'].split(':')[0]}:${data['time'].split(':')[1]}:00");
