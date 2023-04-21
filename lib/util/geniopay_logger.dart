import 'package:flutter/cupertino.dart';
import 'package:geniuspay/environment_config.dart';

class geniuspayLogger {
  /*print only in dev mode */

  static void log(dynamic message) {
    if (EnvironmentConfig.env == Flavor.dev) debugPrint(message);
  }
}
