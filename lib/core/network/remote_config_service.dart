// import 'package:firebase_remote_config/firebase_remote_config.dart';
// import 'package:injectable/injectable.dart';
// import 'package:logger/logger.dart';

// @lazySingleton
// class RemoteConfigService {
//   final RemoteConfig remoteConfig;

//   RemoteConfigService({required this.remoteConfig});

//   // double get minAxaxForEarn => remoteConfig.getDouble(minAmountToEnableEarn);

//   Future initialize() async {
//     try {
//       await _fetchAndActivate();
//     } catch (e) {
//       Logger(
//         filter: DevelopmentFilter(),
//       ).e('Rmeote Config fetch throttled: $e');
//     }
//   }

//   Future _fetchAndActivate() async {
//     var updated = await remoteConfig.fetchAndActivate();
//     if (updated) {

//     } else {
//       Logger(
//         filter: DevelopmentFilter(),
//       ).e('the config values were previously updated');
//     }
//   }
// }
