import 'package:dio/dio.dart';
import 'package:geniuspay/core/errors/error.dart';
import 'package:geniuspay/core/network/http_requester.dart';
import 'package:geniuspay/core/network/network_info.dart';
import 'package:geniuspay/repos/local_repo.dart';
import 'package:uuid/uuid.dart';

import 'package:geniuspay/util/security.dart';
import 'package:geniuspay/repos/api_path.dart';
import 'package:injectable/injectable.dart';

abstract class PointsDataSource {
  Future<String> getPoints();
}

@LazySingleton(as: PointsDataSource)
class PointsDataSourceImpl with HMACSecurity implements PointsDataSource {
  PointsDataSourceImpl(
      {required this.networkInfo,
      required this.localDataStorage,
      required this.dio,
      required this.httpClient});
  final NetworkInfo networkInfo;
  final LocalBase localDataStorage;
  final Dio dio;
  final HttpServiceRequester httpClient;

  @override
  Future<String> getPoints() async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      final result =
          await httpClient.getRequest(endpoint: APIPath.getUserPoints);
      final body = result.data['points'];
      return body.toString();
    } else {
      throw NoInternetException();
    }
  }
}
