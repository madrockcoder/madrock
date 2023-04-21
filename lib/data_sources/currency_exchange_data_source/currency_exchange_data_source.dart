import 'package:dio/dio.dart';
import 'package:geniuspay/core/errors/error.dart';
import 'package:geniuspay/core/network/http_requester.dart';
import 'package:geniuspay/core/network/network_info.dart';
import 'package:geniuspay/models/conversion.dart';
import 'package:geniuspay/models/exchange_rate.dart';
import 'package:geniuspay/repos/local_repo.dart';
import 'package:uuid/uuid.dart';

import 'package:geniuspay/util/security.dart';
import 'package:geniuspay/repos/api_path.dart';
import 'package:injectable/injectable.dart';

abstract class CurrencyExchangeDataSource {
  Future<ExchangeRate> fetchExchangeRate(
      String buyCurrency, String sellCurrency, String fixedSide, String amount);
  Future<Conversion> createConversion(ExchangeRate exchangeRate, String uid,
      String buyingWalletId, String sellingWalletId);

  Future<List<Conversion>> getTransactions(
      {required String uid, String? pages});
}

@LazySingleton(as: CurrencyExchangeDataSource)
class CurrencyExchangeDataSourceImpl
    with HMACSecurity
    implements CurrencyExchangeDataSource {
  CurrencyExchangeDataSourceImpl(
      {required this.networkInfo,
      required this.localDataStorage,
      required this.dio,
      required this.httpClient});
  final NetworkInfo networkInfo;
  final LocalBase localDataStorage;
  final Dio dio;
  final HttpServiceRequester httpClient;

  @override
  Future<ExchangeRate> fetchExchangeRate(String buyCurrency,
      String sellCurrency, String fixedSide, String amount) async {
    if (await networkInfo.isConnected) {
      final result = await httpClient.getRequest(
          endpoint: APIPath.exchangeRatesDetailed(
              amount: amount,
              buyCurrency: buyCurrency,
              sellCurrency: sellCurrency,
              fixedSide: fixedSide));
      final body = result.data;
      if (body['detailed_rates'] != null) {
        return ExchangeRate(
            settlementTime: '123',
            sellAmount: body['detailed_rates']['result'].toString(),
            buyCurrency: buyCurrency,
            sellCurrency: sellCurrency,
            fixedSide: fixedSide,
            rate: body['detailed_rates']['info']['rate'].toString(),
            buyAmount: amount,
            fees: body['fees'].toString(),
            currencyPair: buyCurrency + sellCurrency);
      }

      return ExchangeRate.fromMap(result.data);
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<Conversion> createConversion(ExchangeRate exchangeRate, String uid,
      String buyingWalletId, String sellingWalletId) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      final result = await httpClient.post(
        uuid: uuid,
        token: localDataStorage.getToken(),
        endpoint: APIPath.createConversion,
        body: {
          "user": uid,
          "buy_currency": exchangeRate.buyCurrency,
          // "buy_wallet": buyingWalletId,
          "sell_currency": exchangeRate.sellCurrency,
          // "sell_wallet": sellingWalletId,
          "amount": exchangeRate.buyAmount,
          "description": "currency exchange"
        },
      );
      return Conversion.fromMap(result.data);
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<List<Conversion>> getTransactions(
      {required String uid, String? pages}) async {
    if (await networkInfo.isConnected) {
      final result = await httpClient.getRequest(
          endpoint: APIPath.fetchExchangeConversions(uid: uid, pages: pages));
      final body = result.data['results'];
      return ConversionList.fromJson(body).list;
    } else {
      throw NoInternetException();
    }
  }
}
