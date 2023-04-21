import 'package:dartz/dartz.dart';
import 'package:geniuspay/core/errors/errors.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/models/conversion.dart';
import 'package:geniuspay/models/exchange_rate.dart';
import 'package:geniuspay/repos/currency_exchange_repository.dart';
import 'package:injectable/injectable.dart';

abstract class CurrencyExchangeService {
  Future<Either<Failure, ExchangeRate>> fetchExchangeRate(
      String buyCurrency, String sellCurrency, String fixedSide, String amount);
  Future<Either<Failure, Conversion>> createConversion(
      ExchangeRate exchangeRate,
      String uid,
      String buyingWalletId,
      String sellingWalletId);
  Future<Either<Failure, List<Conversion>>> getTransactions(
      {required String uid, String? pages});
}

@LazySingleton(as: CurrencyExchangeService)
class CurrencyExchangeServiceImpl extends CurrencyExchangeService {
  final CurrencyExchangeRepository _walletRepository =
      sl<CurrencyExchangeRepository>();

  @override
  Future<Either<Failure, ExchangeRate>> fetchExchangeRate(String buyCurrency,
      String sellCurrency, String fixedSide, String amount) async {
    return _walletRepository.fetchExchangeRate(
        buyCurrency, sellCurrency, fixedSide, amount);
  }

  @override
  Future<Either<Failure, Conversion>> createConversion(
      ExchangeRate exchangeRate,
      String uid,
      String buyingWalletId,
      String sellingWalletId) async {
    return _walletRepository.createConversion(
        exchangeRate, uid, buyingWalletId, sellingWalletId);
  }

  @override
  Future<Either<Failure, List<Conversion>>> getTransactions(
      {required String uid, String? pages}) async {
    return _walletRepository.getTransactions(uid: uid, pages: pages);
  }
}
