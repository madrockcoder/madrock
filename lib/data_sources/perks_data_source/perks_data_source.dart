import 'package:dio/dio.dart';
import 'package:geniuspay/core/errors/error.dart';
import 'package:geniuspay/core/network/http_requester.dart';
import 'package:geniuspay/core/network/network_info.dart';
import 'package:geniuspay/models/perk.dart';
import 'package:geniuspay/repos/local_repo.dart';

import 'package:geniuspay/util/security.dart';
import 'package:geniuspay/repos/api_path.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

abstract class PerksDataSource {
  Future<List<Perk>> getPerkList();
  Future<String> claimPerk(String accountId, String perkId);
  Future<List<String>> getPerksCategories();
}

@LazySingleton(as: PerksDataSource)
class PerksDataSourceImpl with HMACSecurity implements PerksDataSource {
  PerksDataSourceImpl(
      {required this.networkInfo,
      required this.localDataStorage,
      required this.dio,
      required this.httpClient});
  final NetworkInfo networkInfo;
  final LocalBase localDataStorage;
  final Dio dio;
  final HttpServiceRequester httpClient;

  @override
  Future<List<Perk>> getPerkList() async {
    if (await networkInfo.isConnected) {
      final result = await httpClient.getRequest(endpoint: APIPath.perks);
      final body = result.data['results'];
      return PerkList.fromJson(body).list;
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<String> claimPerk(String accountId, String perkId) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      final result = await httpClient.post(
          endpoint: APIPath.claimPerk,
          body: {"user": accountId, "perk": perkId},
          uuid: uuid);
      return result.data['id'];
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<List<String>> getPerksCategories() async {
    if (await networkInfo.isConnected) {
      final result =
          await httpClient.getRequest(endpoint: APIPath.getPerkCategories);
      // List<Map<String, dynamic>> mylist = [
      //   {"name": "String"}
      // ];
      // final res = mylist.map((e) => e['name']).toList();
      final dynamicList = result.data['results'] as List;
      final List<String> list =
          dynamicList.map((e) => e['name'].toString()).toList();
      return list;
    } else {
      throw NoInternetException();
    }
  }
}
