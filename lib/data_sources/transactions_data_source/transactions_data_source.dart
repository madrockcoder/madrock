
import 'package:dio/dio.dart';
import 'package:geniuspay/core/errors/error.dart';
import 'package:geniuspay/core/network/http_requester.dart';
import 'package:geniuspay/core/network/network_info.dart';
import 'package:geniuspay/models/transaction.dart';
import 'package:geniuspay/repos/local_repo.dart';

import 'package:geniuspay/util/security.dart';
import 'package:geniuspay/repos/api_path.dart';
import 'package:injectable/injectable.dart';

abstract class TransactionsDataSource {
  Future<List<DatedTransaction>> fetchAccountTransactions(
      String uid, String? pagelength, String? walletId);
}

@LazySingleton(as: TransactionsDataSource)
class TransactionsDataSourceImpl
    with HMACSecurity
    implements TransactionsDataSource {
  TransactionsDataSourceImpl(
      {required this.networkInfo,
      required this.localDataStorage,
      required this.dio,
      required this.httpClient});
  final NetworkInfo networkInfo;
  final LocalBase localDataStorage;
  final Dio dio;
  final HttpServiceRequester httpClient;

  @override
  Future<List<DatedTransaction>> fetchAccountTransactions(
      String uid, String? pagelength, String? walletId) async {
    if (await networkInfo.isConnected) {
      final result = await httpClient.getRequest(
          endpoint: APIPath.fetchTransactions(uid, pagelength, walletId));
      final body = result.data['results'];
      return DatedTransactionList.fromJson(body).list;
    } else {
      throw NoInternetException();
    }
  }
}
