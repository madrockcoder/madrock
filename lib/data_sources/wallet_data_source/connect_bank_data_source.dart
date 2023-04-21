import 'package:dio/dio.dart';
import 'package:geniuspay/core/errors/error.dart';
import 'package:geniuspay/core/network/http_requester.dart';
import 'package:geniuspay/core/network/network_info.dart';
import 'package:geniuspay/models/connect_bank_response.dart';
import 'package:geniuspay/models/nordigen_bank.dart';
import 'package:geniuspay/repos/local_repo.dart';

import 'package:geniuspay/util/security.dart';
import 'package:geniuspay/repos/api_path.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

abstract class ConnectBankDataSource {
  Future<ConnectBankResponse> initiateRequisition(
      String accountId, String aspsp);
  Future<ConnectBankResponse> getStatus(String aspsp);
  Future<List<NordigenBank>> getBankAccountsFromCountry(String country);
}

@LazySingleton(as: ConnectBankDataSource)
class ConnectBankDataSourceImpl
    with HMACSecurity
    implements ConnectBankDataSource {
  ConnectBankDataSourceImpl(
      {required this.networkInfo,
      required this.localDataStorage,
      required this.dio,
      required this.httpClient});
  final NetworkInfo networkInfo;
  final LocalBase localDataStorage;
  final Dio dio;
  final HttpServiceRequester httpClient;

  @override
  Future<List<NordigenBank>> getBankAccountsFromCountry(String country) async {
    if (await networkInfo.isConnected) {
      final result = await httpClient.getRequest(
          endpoint: APIPath.getBankAccountsFromCountry(country));
      final body = result.data;
      return NordigenBankList.fromJson(body['results']).list;
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<ConnectBankResponse> initiateRequisition(
      String accountId, String aspsp) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      final result = await httpClient.post(
          endpoint: APIPath.initiateRequisition,
          uuid: uuid,
          body: {"user": accountId, "aspsp": aspsp});
      final body = result.data;
      return ConnectBankResponse.fromMap(body);
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<ConnectBankResponse> getStatus(String aspsp) async {
    if (await networkInfo.isConnected) {
      final result = await httpClient.getRequest(
          endpoint: APIPath.getRequisitionStatus(aspsp));
      final body = result.data;
      return ConnectBankResponse.fromMap(body);
    } else {
      throw NoInternetException();
    }
  }
}
