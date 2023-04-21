import 'package:dartz/dartz.dart';
import 'package:geniuspay/core/errors/errors.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/models/mollie_response.dart';
import 'package:geniuspay/models/payu_response.dart';
import 'package:geniuspay/models/stitch_response.dart';
import 'package:geniuspay/models/trustly_response.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/repos/deposit_funds_repository.dart';
import 'package:injectable/injectable.dart';

abstract class DepositFundsService {
  Future<Either<Failure, StitchPaymentResponse>> createStitchPayment(
      String amount, String uid, String walletId);

  Future<Either<Failure, PayUPaymentResponse>> createPayUPayment(
      String amount, String uid, String walletId);

  Future<Either<Failure, PayUPaymentResponse>> payUpaymentStatus(String payUId);

  Future<Either<Failure, TrustlyPaymentResponse>> createTrustlyPayment(
      String amount, String uid, Wallet wallet);

  Future<Either<Failure, TrustlyPaymentResponse>> trustlyPaymentStatus(
      String trustlyId);

  Future<Either<Failure, MolliePaymentResponse>> createMolliePayment(
      String amount, String uid, Wallet wallet);

  Future<Either<Failure, MolliePaymentResponse>> molliePaymentStatus(
      String mollieId);

  Future<Either<Failure, Map<String, String>>> initiateCardTransfer(
      String amount, String currency, String userId, String walletID);

  Future<Either<Failure, Map<String, dynamic>>> createCardPayment(
      String amount, String currency);

  Future<Either<Failure, bool>> confirmCardTransfer(
      String userId, String payInId, Map<String, dynamic> object);
}

@LazySingleton(as: DepositFundsService)
class DepositFundsServiceImpl extends DepositFundsService {
  final DepositFundsRepository _depositFundsRepository =
      sl<DepositFundsRepository>();

  @override
  Future<Either<Failure, StitchPaymentResponse>> createStitchPayment(
      String amount, String uid, String walletId) async {
    return _depositFundsRepository.createStitchPayment(amount, uid, walletId);
  }

  @override
  Future<Either<Failure, PayUPaymentResponse>> createPayUPayment(
      String amount, String uid, String walletId) async {
    return _depositFundsRepository.createPayUPayment(amount, uid, walletId);
  }

  @override
  Future<Either<Failure, PayUPaymentResponse>> payUpaymentStatus(
      String payUId) async {
    return _depositFundsRepository.payUpaymentStatus(payUId);
  }

  @override
  Future<Either<Failure, TrustlyPaymentResponse>> createTrustlyPayment(
      String amount, String uid, Wallet wallet) async {
    return _depositFundsRepository.createTrustlyPayment(amount, uid, wallet);
  }

  @override
  Future<Either<Failure, TrustlyPaymentResponse>> trustlyPaymentStatus(
      String trustlyId) async {
    return _depositFundsRepository.trustlyPaymentStatus(trustlyId);
  }

  @override
  Future<Either<Failure, MolliePaymentResponse>> createMolliePayment(
      String amount, String uid, Wallet wallet) async {
    return _depositFundsRepository.createMolliePayment(amount, uid, wallet);
  }

  @override
  Future<Either<Failure, MolliePaymentResponse>> molliePaymentStatus(
      String mollieId) async {
    return _depositFundsRepository.molliePaymentStatus(mollieId);
  }

  @override
  Future<Either<Failure, Map<String, String>>> initiateCardTransfer(
      String amount, String currency, String userId, String walletID) async {
    return _depositFundsRepository.initiateCardTransfer(amount, currency, userId, walletID);
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> createCardPayment(
      String amount, String currency) async {
    return _depositFundsRepository.createCardPayment(amount, currency);
  }

  @override
  Future<Either<Failure, bool>> confirmCardTransfer(
      String userId, String payInId, Map<String, dynamic> object) async {
    return _depositFundsRepository.confirmCardTransfer(userId, payInId, object);
  }
}
