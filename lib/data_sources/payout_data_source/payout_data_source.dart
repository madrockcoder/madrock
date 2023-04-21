
import 'package:dio/dio.dart';
import 'package:geniuspay/core/errors/error.dart';
import 'package:geniuspay/core/network/http_requester.dart';
import 'package:geniuspay/core/network/network_info.dart';
import 'package:geniuspay/models/internal_mobile_payment.dart';
import 'package:geniuspay/models/internal_payment.dart';
import 'package:geniuspay/models/international_transfer_model.dart';
import 'package:geniuspay/models/international_transfer_quotation.dart';
import 'package:geniuspay/models/total_amount.dart';
import 'package:geniuspay/repos/local_repo.dart';
import 'package:uuid/uuid.dart';

import 'package:geniuspay/util/security.dart';
import 'package:geniuspay/repos/api_path.dart';
import 'package:injectable/injectable.dart';

abstract class PayoutDataSource {
  //p2p
  Future<String> createP2pTransfer(InternalPayment internalPayment);
  Future<String> createP2pMobileTransfer(InternalMobilePayment internalMobilePayment);

  //international
  Future<InternationalTransferModel> validateInternationalTransfer(
      InternationalTransferModel internationalTransfer);

  Future<InternationalTransferQuotation> getQuotation(
      TotalAmount instructedAmount, String targetCurrency, String accountId);
  Future<String> createInternationalTransfer(
      InternationalTransferModel internationalTransfer);
}

@LazySingleton(as: PayoutDataSource)
class PayoutDataSourceImpl with HMACSecurity implements PayoutDataSource {
  PayoutDataSourceImpl(
      {required this.networkInfo,
      required this.localDataStorage,
      required this.dio,
      required this.httpClient});
  final NetworkInfo networkInfo;
  final LocalBase localDataStorage;
  final Dio dio;
  final HttpServiceRequester httpClient;

  @override
  Future<String> createP2pTransfer(InternalPayment internalPayment) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      final result = await httpClient
          .post(endpoint: APIPath.createp2pTransfer, uuid: uuid, body: {
        "source_account": internalPayment.sourceID,
        "payer": internalPayment.payerID,
        "payee": internalPayment.payeeID,
        "amount": {
          "value": internalPayment.amount.value,
          "currency": internalPayment.amount.currency
        },
        "description": internalPayment.description
      });
      final body = result.data;
      return body['reference'];
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<String> createP2pMobileTransfer(InternalMobilePayment internalMobilePayment) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      var internalMobilePaymentMap = {
        "country": internalMobilePayment.country,
        "mobile_network": internalMobilePayment.mobileNetwork,
        "payer": internalMobilePayment.payerID,
        "payee": internalMobilePayment.payeeID,
        "currency": InternalMobilePayment.countryModel(internalMobilePayment.country).currencyISO,
        "amount": internalMobilePayment.amount.value.toString(),
        "sending_reason": internalMobilePayment.sendingReason,
      };
      final result = await httpClient
          .post(endpoint: APIPath.createp2pMobileTransfer, uuid: uuid, body: internalMobilePaymentMap);
      final body = result.data;
      return body['reference'];
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<String> createInternationalTransfer(
      InternationalTransferModel internationalTransfer) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      final result = await httpClient.post(
          endpoint: internationalTransfer.quotation == null
              ? APIPath.createInternationalTransfer
              : APIPath.createInternationalTransferWithQuotation,
          uuid: uuid,
          body: internationalTransfer.toMap());
      final body = result.data;
      return body['reference'];
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<InternationalTransferModel> validateInternationalTransfer(
      InternationalTransferModel internationalTransfer) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      final result = await httpClient.post(
          endpoint: internationalTransfer.quotation == null
              ? APIPath.validateInternationalTransfer
              : APIPath.validateInternationalQuotation,
          uuid: uuid,
          body: internationalTransfer.toMap());
      final body = result.data;
      return InternationalTransferModel.fromMap(body);
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<InternationalTransferQuotation> getQuotation(
      TotalAmount instructedAmount,
      String targetCurrency,
      String accountId) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      final data = {
        "instructed_amount": instructedAmount.toMap(),
        "user": accountId,
        "target_currency": targetCurrency,
      };
      final result = await httpClient.post(
          endpoint: APIPath.getInternationalTransferQuotation,
          uuid: uuid,
          body: data);
      final body = result.data;
      return InternationalTransferQuotation.fromMap(result.data);
    } else {
      throw NoInternetException();
    }
  }
}
