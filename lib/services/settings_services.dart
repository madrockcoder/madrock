import 'package:dartz/dartz.dart';
import 'package:geniuspay/core/errors/errors.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/models/notification_option.dart';
import 'package:geniuspay/repos/settings_repository.dart';
import 'package:injectable/injectable.dart';

abstract class SettingsService {
  Future<Either<Failure, NotificationOption>> updateNotifcationOptin(
      String id, NotificationOption notificationOption);
}

@LazySingleton(as: SettingsService)
class SettingsServiceImpl extends SettingsService {
  final SettingsRepository _settingsRepository = sl<SettingsRepository>();

  @override
  Future<Either<Failure, NotificationOption>> updateNotifcationOptin(
      String id, NotificationOption notificationOption) async {
    return _settingsRepository.updateNotifcationOptin(id, notificationOption);
  }
}
