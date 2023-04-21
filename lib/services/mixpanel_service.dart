import 'package:geniuspay/services/remote_config_service.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';

class MixPanelService {
  static final MixPanelService _instance = MixPanelService._internal();
  static Mixpanel? _mixpanel;

  factory MixPanelService._internal() => _instance;

  static initMixpanel() async {
    _mixpanel = await Mixpanel.init(
        RemoteConfigService.getRemoteData.mixPanel ?? '',
        optOutTrackingDefault: false);
  }

  static updateUserActivity(String event, {Map<String, dynamic>? properties}) {
    _mixpanel!.track(event, properties: properties);
  }

  static setOnceProperty(Map<String, dynamic> properties) {
    _mixpanel!.registerSuperPropertiesOnce(properties);
  }

  static clearProperty() {
    _mixpanel!.clearSuperProperties();
  }

  static setUserIdentifier(String userID) {
    _mixpanel!.identify(userID);
  }
}
