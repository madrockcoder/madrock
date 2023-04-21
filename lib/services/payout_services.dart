import 'package:dartz/dartz.dart';
import 'package:geniuspay/core/errors/errors.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/models/internal_mobile_payment.dart';
import 'package:geniuspay/models/internal_payment.dart';
import 'package:geniuspay/models/international_transfer_model.dart';
import 'package:geniuspay/models/international_transfer_quotation.dart';
import 'package:geniuspay/models/total_amount.dart';
import 'package:geniuspay/repos/payout_repository.dart';
import 'package:injectable/injectable.dart';

abstract class PayoutService {
  Future<Either<Failure, String>> createp2pTransfer(
      InternalPayment internalPayment);
  Future<Either<Failure, String>> createp2pMobileTransfer(
      InternalMobilePayment internalMobilePayment);
  Future<Either<Failure, InternationalTransferModel>>
      validateInternationalTransfer(
          InternationalTransferModel internationalTransfer);

  Future<Either<Failure, InternationalTransferQuotation>> getQuotation(
      TotalAmount instructedAmount, String targetCurrency, String accountId);
  Future<Either<Failure, String>> createInternationalTransfer(
      InternationalTransferModel internationalTransfer);
}

@LazySingleton(as: PayoutService)
class PayoutServiceImpl extends PayoutService {
  final PayoutRepository _transactionRepository = sl<PayoutRepository>();

  @override
  Future<Either<Failure, String>> createp2pTransfer(
      InternalPayment internalPayment) async {
    return _transactionRepository.createp2pTransasction(internalPayment);
  }

  @override
  Future<Either<Failure, String>> createp2pMobileTransfer(
      InternalMobilePayment internalMobilePayment) async {
    return _transactionRepository.createp2pMobileTransasction(internalMobilePayment);
  }

  @override
  Future<Either<Failure, String>> createInternationalTransfer(
      InternationalTransferModel internationalTransfer) async {
    return _transactionRepository
        .createInternationalTransfer(internationalTransfer);
  }

  @override
  Future<Either<Failure, InternationalTransferModel>>
      validateInternationalTransfer(
          InternationalTransferModel internationalTransfer) async {
    return _transactionRepository
        .validateInternationalTransfer(internationalTransfer);
  }

  @override
  Future<Either<Failure, InternationalTransferQuotation>> getQuotation(
      TotalAmount instructedAmount,
      String targetCurrency,
      String accountId) async {
    return _transactionRepository.getQuotation(
        instructedAmount, targetCurrency, accountId);
  }
}
