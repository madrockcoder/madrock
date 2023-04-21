import 'package:dio/dio.dart';
import 'package:geniuspay/app/devices/model/device_model.dart';
import 'package:geniuspay/core/errors/error.dart';
import 'package:geniuspay/core/network/networks.dart';
import 'package:geniuspay/util/security.dart';
import 'package:geniuspay/repos/api_path.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

abstract class DevicesDataSource {
  Future<List<DeviceModel>> fetchAllDevices(
    String searchTerm,
    int pageNumber,
    int pageSize,
  );

  Future<DeviceModel?> createDevice(
    String deviceID, {
    required String name,
    required String registrationID,
    required bool active,
    required String type,
  });
}

@LazySingleton(as: DevicesDataSource)
class DevicesDataSourceImpl with HMACSecurity implements DevicesDataSource {
  final NetworkInfo networkInfo;
  final Dio dio;
  final HttpServiceRequester httpClient;

  DevicesDataSourceImpl({
    required this.networkInfo,
    required this.dio,
    required this.httpClient,
  });

  @override
  Future<List<DeviceModel>> fetchAllDevices(
    String searchTerm,
    int pageNumber,
    int pageSize,
  ) async {
    if (await networkInfo.isConnected) {
      final result = await httpClient.getRequest(
        endpoint: APIPath.getDevices(searchTerm, pageNumber, pageSize),
      );
      final devices = result.data['results'];
      return DeviceModelList.fromJson(devices).list;
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<DeviceModel?> createDevice(
    String deviceID, {
    required String name,
    required String registrationID,
    required bool active,
    required String type,
  }) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      final result = await httpClient
          .post(uuid: uuid, endpoint: APIPath.createDevice, body: {
        "name": name,
        "registration_id": registrationID,
        "active": active,
        "type": type,
        "device_id": deviceID
      });
      return DeviceModel.fromJson(result.data);
    } else {
      NoInternetException();
    }
    return null;
  }
}
