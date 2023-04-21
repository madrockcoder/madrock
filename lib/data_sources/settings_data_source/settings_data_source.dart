import 'package:dio/dio.dart';
import 'package:geniuspay/core/errors/error.dart';
import 'package:geniuspay/core/network/http_requester.dart';
import 'package:geniuspay/core/network/network_info.dart';
import 'package:geniuspay/models/notification_option.dart';
import 'package:geniuspay/repos/local_repo.dart';
import 'package:uuid/uuid.dart';

import 'package:geniuspay/util/security.dart';
import 'package:geniuspay/repos/api_path.dart';
import 'package:injectable/injectable.dart';

abstract class SettingsDataSource {
  Future<NotificationOption> updateNotifcationOptin(
      String id, NotificationOption notificationOption);
}

@LazySingleton(as: SettingsDataSource)
class SettingsDataSourceImpl with HMACSecurity implements SettingsDataSource {
  SettingsDataSourceImpl(
      {required this.networkInfo,
      required this.localDataStorage,
      required this.dio,
      required this.httpClient});
  final NetworkInfo networkInfo;
  final LocalBase localDataStorage;
  final Dio dio;
  final HttpServiceRequester httpClient;

  @override
  Future<NotificationOption> updateNotifcationOptin(
      String id, NotificationOption notificationOption) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      final result = await httpClient.putRequest(
          endpoint: APIPath.updateNotificationOptin(id),
          uuid: uuid,
          body: notificationOption.toMap());
      return NotificationOption.fromMap(result.data);
    } else {
      throw NoInternetException();
    }
  }
}
