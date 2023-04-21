import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geniuspay/models/remote_config_data_model.dart';

class RemoteConfigService {
  static final RemoteConfigService _instance = RemoteConfigService._internal();
  static final FirebaseRemoteConfig _firebaseRemoteConfig = FirebaseRemoteConfig.instance;

  static late RemoteConfigDataModel _configDataModel;

  factory RemoteConfigService._internal() => _instance;

  static Future<void> init({required bool isDebug}) async {
    if (!isDebug) {
      await _firebaseRemoteConfig.ensureInitialized();
      await _firebaseRemoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 20),
        minimumFetchInterval: const Duration(seconds: 20),
      ));
    }
    String liveUrl = dotenv.get('LIVE_BASE_URL');
    String liveApiKey = dotenv.get('LIVE_API_KEY');
    String liveSecret = dotenv.get('LIVE_SECRET_KEY');
    String googleMapKey = dotenv.get('GOOGLE_MAP_KEY');

    await _firebaseRemoteConfig.setDefaults({
      'app_url': liveUrl,
      'api_key': liveApiKey,
      'secret_key': liveSecret,
      'google_map_api': googleMapKey,
      'logo': "url",
      'sentry_id': "https://37e3367eb44b4c6a9d74f396586fc6d5@o1090126.ingest.sentry.io/6124299",
      'mixpanel': "2be446f07d3ef1b36e3da2e3a1ea14bd",
      'allow_social_signup': true,
      'allow_kyc': true,
      'maintenance': false,
      'base_url': liveUrl,
      'api_version': 'v1.0',
      'supported_countries': '["CA","IN"]',
      'maintenance_time': jsonEncode({"time": "08:00", "time_zone": "CEST", "date": "23/09"}),
      'stripe_credentials': jsonEncode({
        'STRIPE_PUBLIC_KEY_TEST':
            'pk_test_51Ks2QQBnIAGt8eGEqAtlwEahpgqAKcS1necP5VU9BbgVflpWGal25f7HE1AKeSDker88OA7dQOWr4qdpgZHNQLLF00IDFK39VU',
        'STRIPE_SECRET_KEY_TEST':
            'sk_test_51Ks2QQBnIAGt8eGEY6GTefOq3lZkyGsq7TLLhX1qdaRfbG9lX2sxNyqboiwBHbuCFrYI2G7DLY4zbvJqkuzCmKFK00AJxAnFym',
        'STRIPE_PUBLIC_KEY_LIVE':
            'pk_live_51Ks2QQBnIAGt8eGE3py8ILizFhgSuXsVvJmn2L1xU2RNMw2xUkcGnoA1TECworybSnXBpi09pZxwSrLLr8QP2nix00G9xqd8Bq',
        'STRIPE_SECRET_KEY_LIVE':
            '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'
      })
    });
    if (!isDebug) {
      try {
        await _firebaseRemoteConfig.fetchAndActivate();
      } catch (e) {}
    }
    _configDataModel = RemoteConfigDataModel.fromJson({
      'app_url': _firebaseRemoteConfig.getString('app_url'),
      'api_key': _firebaseRemoteConfig.getString('api_key'),
      'secret_key': _firebaseRemoteConfig.getString('secret_key'),
      'logo': _firebaseRemoteConfig.getString('logo'),
      'sentry_id': _firebaseRemoteConfig.getString('sentry_id'),
      'mixpanel': _firebaseRemoteConfig.getString('mixpanel'),
      'allow_social_signup': _firebaseRemoteConfig.getBool('allow_social_signup'),
      'allow_kyc': _firebaseRemoteConfig.getBool('allow_kyc'),
      'maintenance': _firebaseRemoteConfig.getBool('maintenance'),
      'base_url': _firebaseRemoteConfig.getString('base_url'),
      'api_version': _firebaseRemoteConfig.getString('api_version'),
      'supported_countries': List<String>.from((jsonDecode(_firebaseRemoteConfig.getString('supported_countries'))) as List),
      'maintenance_time': maintenanceTimeJsonToDateTime(
          Map<String, String>.from((jsonDecode(_firebaseRemoteConfig.getString('maintenance_time'))) as Map)),
      'stripe_credentials': Map<String, String>.from((jsonDecode(_firebaseRemoteConfig.getString('stripe_credentials'))) as Map)
    });
  }

  static RemoteConfigDataModel get getRemoteData => _configDataModel;
}
