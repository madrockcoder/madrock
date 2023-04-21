import 'package:dartz/dartz.dart';
import 'package:geniuspay/app/devices/model/device_model.dart';
import 'package:geniuspay/core/errors/failure.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/repos/devices_repository.dart';
import 'package:injectable/injectable.dart';

abstract class DevicesServices {
  Future<Either<Failure, List<DeviceModel>>> fetchDevices(
    String searchTerm,
    int pageNumber,
    int pageSize,
  );
  Future<Either<Failure, DeviceModel>> createDevice(
    String deviceID, {
    required String name,
    required String registrationID,
    required bool active,
    required String type,
  });
}

@LazySingleton(as: DevicesServices)
class DevicesServicesImpl implements DevicesServices {
  final DevicesRepository _devicesRepository = sl<DevicesRepository>();

  @override
  Future<Either<Failure, DeviceModel>> createDevice(
    String deviceID, {
    required String name,
    required String registrationID,
    required bool active,
    required String type,
  }) async {
    return _devicesRepository.createDevice(
      deviceID,
      name: name,
      registrationID: registrationID,
      active: active,
      type: type,
    );
  }

  @override
  Future<Either<Failure, List<DeviceModel>>> fetchDevices(
      String searchTerm, int pageNumber, int pageSize) async {
    return await _devicesRepository.fetchDevices(
      searchTerm,
      pageNumber,
      pageSize,
    );
  }
}
