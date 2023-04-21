import 'package:dartz/dartz.dart';
import 'package:geniuspay/core/errors/errors.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/models/country.dart';
import 'package:geniuspay/models/currency.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/models/wallet_account_details.dart';
import 'package:geniuspay/models/wallet_transaction.dart';
import 'package:geniuspay/repos/wallet_repository.dart';
import 'package:injectable/injectable.dart';

abstract class WalletService {
  Future<Either<Failure, List<Country>>> fetchCountries(String searchTerm);
  Future<Either<Failure, Wallet>> createWallet(Wallet wallet);
  Future<Either<Failure, List<Wallet>>> fetchWallets(
      {String searchTerm = '', required String uid});
  Future<Either<Failure, bool>> setDefaultWallet(Wallet wallet, String uid);
  Future<Either<Failure, List<Currency>>> fetchCurrencies();
  Future<Either<Failure, String>> closeWallet(Wallet wallet, String uid);
  Future<Either<Failure, String>> changeWalletStatus(
      Wallet wallet, String uid, String status);
  Future<Either<Failure, List<WalletTransaction>>> getWalletTransactions(
      String walletId, String uid, String? pages);
  Future<Either<Failure, List<WalletAccountDetails>>> fetchWalletAccountDetails(
      String walletId, String uid);
  Future<Either<Failure, String>> updateFriendlyName(
      String walletId, String friendlyName, String uid);
  Future<Either<Failure, List<Currency>>> searchCurrencies(String searchTerm);
  Future<Either<Failure, Wallet>> fetchIndividualWallet(
      {required String uid, required String walletId});
}

@LazySingleton(as: WalletService)
class WalletServiceImpl extends WalletService {
  final WalletRepository _walletRepository = sl<WalletRepository>();

  @override
  Future<Either<Failure, List<Country>>> fetchCountries(
      String searchTerm) async {
    return _walletRepository.fetchCountries(searchTerm);
  }
  //2

  @override
  Future<Either<Failure, Wallet>> createWallet(Wallet wallet) async {
    return _walletRepository.createWallet(wallet);
  }

  @override
  Future<Either<Failure, String>> updateFriendlyName(
      String walletId, String friendlyName, String uid) async {
    return _walletRepository.updateFriendlyName(walletId, friendlyName, uid);
  }

  @override
  Future<Either<Failure, List<Currency>>> fetchCurrencies() async {
    return _walletRepository.fetchCurrencies();
  }

  @override
  Future<Either<Failure, List<Currency>>> searchCurrencies(
      String searchTerm) async {
    return _walletRepository.searchCurrencies(searchTerm);
  }

  @override
  Future<Either<Failure, String>> closeWallet(Wallet wallet, String uid) async {
    return _walletRepository.closeWallet(wallet, uid);
  }

  @override
  Future<Either<Failure, String>> changeWalletStatus(
      Wallet wallet, String uid, String status) async {
    return _walletRepository.changeWalletStatus(wallet, uid, status);
  }

  @override
  Future<Either<Failure, bool>> setDefaultWallet(
      Wallet wallet, String uid) async {
    return _walletRepository.setDefaultWallet(wallet, uid);
  }

  @override
  Future<Either<Failure, List<Wallet>>> fetchWallets(
      {String searchTerm = '', required String uid}) async {
    return _walletRepository.fetchWallets(searchTerm: searchTerm, uid: uid);
  }

  @override
  Future<Either<Failure, List<WalletAccountDetails>>> fetchWalletAccountDetails(
      String walletId, String uid) async {
    return _walletRepository.fetchWalletAccountDetails(walletId, uid);
  }

  @override
  Future<Either<Failure, List<WalletTransaction>>> getWalletTransactions(
      String walletId, String uid, String? pages) async {
    return _walletRepository.getWalletTransactions(walletId, uid, pages);
  }

  @override
  Future<Either<Failure, Wallet>> fetchIndividualWallet(
      {required String uid, required String walletId}) async {
    return _walletRepository.fetchIndividualWallet(
        uid: uid, walletId: walletId);
  }
}
