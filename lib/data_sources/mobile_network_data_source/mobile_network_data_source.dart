import 'package:dio/dio.dart';
import 'package:geniuspay/core/errors/error.dart';
import 'package:geniuspay/core/network/http_requester.dart';
import 'package:geniuspay/core/network/network_info.dart';
import 'package:geniuspay/models/mobile_network.dart';
import 'package:geniuspay/repos/api_path.dart';
import 'package:geniuspay/util/security.dart';
import 'package:injectable/injectable.dart';

abstract class MobileNetworkDataSource {
  Future<MobileNetworkList> fetchMobileNetworks();
}

@LazySingleton(as: MobileNetworkDataSource)
class MobileNetworkDataSourceImpl
    with HMACSecurity
    implements MobileNetworkDataSource {
  final NetworkInfo networkInfo;
  final Dio dio;
  final HttpServiceRequester httpClient;
  MobileNetworkDataSourceImpl(this.networkInfo, this.dio, this.httpClient);

  @override
  Future<MobileNetworkList> fetchMobileNetworks() async {
    if (await networkInfo.isConnected) {
      final result = await httpClient.getRequest(
          endpoint: APIPath.fetchMobileNetworks);
      final body = result.data['results'];
      return MobileNetworkList.fromJson(body);
    } else {
      throw NoInternetException();
    }
  }
}