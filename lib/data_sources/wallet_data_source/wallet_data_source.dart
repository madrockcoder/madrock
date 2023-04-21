import 'package:dio/dio.dart';
import 'package:geniuspay/core/errors/error.dart';
import 'package:geniuspay/core/network/http_requester.dart';
import 'package:geniuspay/core/network/network_info.dart';
import 'package:geniuspay/models/country.dart';
import 'package:geniuspay/models/currency.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/models/wallet_account_details.dart';
import 'package:geniuspay/models/wallet_transaction.dart';
import 'package:geniuspay/repos/api_path.dart';
import 'package:geniuspay/repos/local_repo.dart';
import 'package:geniuspay/util/essentials.dart';
import 'package:geniuspay/util/security.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

abstract class WalletDataSource {
  Future<List<Country>> fetchCountries(String searchTerm);
  Future<Wallet> createWallet(Wallet wallet);
  Future<List<Wallet>> fetchWallets(
      {String searchTerm = '', required String uid});
  Future<Wallet> fetchIndividualWallet(
      {required String uid, required String walletId});
  Future<bool> setDefaultWallet(Wallet wallet, String uid);
  Future<List<Currency>> fetchCurrencies();
  Future<String> closeWallet(Wallet wallet, String uid);
  Future<String> changeWalletStatus(Wallet wallet, String uid, String status);
  Future<List<WalletTransaction>> getWalletTransactions(
      String walletId, String uid, String? pages);
  Future<List<WalletAccountDetails>> fetchWalletAccountDetails(
      String walletId, String uid);
  Future<String> updateFriendlyName(
      String walletId, String friendlyName, String uid);
  Future<List<Currency>> searchCurrencies(String searchTerm);
}

@LazySingleton(as: WalletDataSource)
class WalletDataSourceImpl with HMACSecurity implements WalletDataSource {
  WalletDataSourceImpl(
      {required this.networkInfo,
      required this.localDataStorage,
      required this.dio,
      required this.httpClient});
  final NetworkInfo networkInfo;
  final LocalBase localDataStorage;
  final Dio dio;
  final HttpServiceRequester httpClient;

  @override
  Future<List<Country>> fetchCountries(String searchTerm) async {
    if (await networkInfo.isConnected) {
      final result =
          await httpClient.getRequest(endpoint: APIPath.fetchCountries('50'));
      final body = result.data['results'];
      return CountrylList.fromJson(body).list;
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<Wallet> createWallet(Wallet wallet) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      final result = await httpClient.post(
        uuid: uuid,
        endpoint: APIPath.createWallet,
        body: wallet.toMap(wallet.friendlyName),
      );
      debugPrint(result.data);
      return Wallet.fromMap(result.data);
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<String> updateFriendlyName(
      String walletId, String friendlyName, String uid) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      final result = await httpClient.putRequest(
        uuid: uuid,
        endpoint: APIPath.updateWalletFriendlyName(uid, walletId),
        body: {'friendly_name': friendlyName},
      );
      return result.data.toString();
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<List<Currency>> fetchCurrencies() async {
    if (await networkInfo.isConnected) {
      final result =
          await httpClient.getRequest(endpoint: APIPath.fetchCurrencies('100'));
      final body = result.data['results'];
      return CurrencyList.fromJson(body).list;
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<List<Currency>> searchCurrencies(String searchTerm) async {
    if (await networkInfo.isConnected) {
      final result = await httpClient.getRequest(
          endpoint: APIPath.searchCurrencies(searchTerm));
      final body = result.data['results'];

      return CurrencyList.fromJson(body).list;
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<String> closeWallet(Wallet wallet, String uid) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      final response = await httpClient.deleteRequest(
          uuid: uuid,
          endpoint: APIPath.closeWallet(uid, wallet.walletID!),
          body: {'account_id': uid, 'wallet_id': wallet.walletID});
      return response.data.toString();
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<String> changeWalletStatus(
    Wallet wallet,
    String uid,
    String status,
  ) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      final result = await httpClient.post(
        uuid: uuid,
        endpoint: APIPath.changeWalletStatus(uid, wallet.walletID!),
        body: {'status': status},
      );
      final body = result.data['status'] as String;
      return body;
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<bool> setDefaultWallet(Wallet wallet, String uid) async {
    if (await networkInfo.isConnected) {
      final uuid = const Uuid().v4();
      final result = await httpClient.putRequest(
        uuid: uuid,
        endpoint: APIPath.defaultWallet(uid, wallet.walletID!),
        token: localDataStorage.getToken(),
        body: {'account_id': uid, 'wallet_id': wallet.walletID},
      );
      final body = result.data;
      return body['default'] as bool;
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<List<Wallet>> fetchWallets(
      {String searchTerm = '', required String uid}) async {
    if (await networkInfo.isConnected) {
      final result = await httpClient.getRequest(
          endpoint: APIPath.userWallets(uid, searchTerm));

      final body = result.data['results'] as List<dynamic>;
      return WalletList.fromJson(body).list.reversed.toList();
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<Wallet> fetchIndividualWallet(
      {required String uid, required String walletId}) async {
    if (await networkInfo.isConnected) {
      final result = await httpClient.getRequest(
          endpoint: APIPath.getIndividualWallet(uid, walletId));
      debugPrint(result.data);
      return Wallet.fromMap(result.data as Map<String, dynamic>);
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<List<WalletAccountDetails>> fetchWalletAccountDetails(
      String walletId, String uid) async {
    if (await networkInfo.isConnected) {
      final result = await httpClient.getRequest(
          endpoint: APIPath.walletAccountDetails(uid, walletId));
      final body = result.data as List<dynamic>;
      return WalletAccountDetailsList.fromJson(body).list;
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<List<WalletTransaction>> getWalletTransactions(
      String walletId, String uid, String? pages) async {
    if (await networkInfo.isConnected) {
      final result = await httpClient.getRequest(
          endpoint: APIPath.walletTransactions(uid, walletId, pages));
      final body = result.data['results'] as List<dynamic>;

      return WalletTransactionList.fromJson(body).list;
    } else {
      throw NoInternetException();
    }
  }
}
