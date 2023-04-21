import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:geniuspay/core/errors/error.dart';
import 'package:geniuspay/core/injections/injections.dart';
import 'package:geniuspay/core/network/http_requester.dart';
import 'package:geniuspay/core/network/network_info.dart';
import 'package:geniuspay/models/mollie_response.dart';
import 'package:geniuspay/models/payu_response.dart';
import 'package:geniuspay/models/stitch_response.dart';
import 'package:geniuspay/models/trustly_response.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/repos/local_repo.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:uuid/uuid.dart';
import 'package:geniuspay/app/Profile/refer/widgets/string_constants.dart' as sc;
import 'package:geniuspay/util/security.dart';
import 'package:geniuspay/repos/api_path.dart';
import 'package:injectable/injectable.dart';
// import 'package:flutter_stripe/flutte?r_stripe.dart' as fs;
import 'package:http/http.dart' as http;

abstract class DepositFundsDataSource {
  Future<StitchPaymentResponse> createStitchPayment(
      String amount, String uid, String walletId);

  Future<PayUPaymentResponse> createPayUPayment(
      String amount, String uid, String walletId);

  Future<PayUPaymentResponse> payUpaymentStatus(String payUId);

  Future<TrustlyPaymentResponse> createTrustlyPayment(
      String amount, String uid, Wallet wallet);

  Future<TrustlyPaymentResponse> trustlyPaymentStatus(String trustlyId);

  Future<MolliePaymentResponse> createMolliePayment(
      String amount, String uid, Wallet wallet);

  Future<MolliePaymentResponse> molliePaymentStatus(String mollieId);

  Future<Map<String, dynamic>> createCardPayment(
      String amount, String currency);

  Future<Map<String, String>> initiateCardTransfer(
      String amount, String currency, String userId, String walletID);

  Future<bool> confirmCardTransfer(
      String userId, String payInId, Map<String, dynamic> object);
}

@LazySingleton(as: DepositFundsDataSource)
class DepositFundsDataSourceImpl
    with HMACSecurity
    implements DepositFundsDataSource {
  DepositFundsDataSourceImpl(
      {required this.networkInfo,
      required this.localDataStorage,
      required this.dio,
      required this.httpClient});

  final NetworkInfo networkInfo;
  final LocalBase localDataStorage;
  final Dio dio;
  final HttpServiceRequester httpClient;

  @override
  Future<StitchPaymentResponse> createStitchPayment(
      String amount, String uid, String walletId) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      final result = await httpClient.post(
          uuid: uuid,
          token: localDataStorage.getToken(),
          endpoint: APIPath.stitchPayment,
          body: {
            "user": uid,
            "target_account": walletId,
            "amount": {"currency": "ZAR", "value": amount},
          });
      final body = result.data;
      return StitchPaymentResponse.fromMap(body);
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<PayUPaymentResponse> createPayUPayment(
      String amount, String uid, String walletId) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      final result = await httpClient.post(
          uuid: uuid,
          token: localDataStorage.getToken(),
          endpoint: APIPath.payuPayment,
          body: {
            "user": uid,
            "target_account": walletId,
            "amount": amount,
          });
      final body = result.data;
      return PayUPaymentResponse.fromMap(body);
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<PayUPaymentResponse> payUpaymentStatus(String payUID) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      final result = await httpClient.getRequest(
        endpoint: APIPath.payuPaymentStatus(payUID),
      );
      final body = result.data;
      return PayUPaymentResponse.fromMap(body);
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<TrustlyPaymentResponse> createTrustlyPayment(
      String amount, String uid, Wallet wallet) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      final payload = {
        "user": uid,
        "target_account": wallet.walletID,
        "amount": {"currency": wallet.currency, "value": amount},
      };
      final result = await httpClient.post(
          uuid: uuid,
          token: localDataStorage.getToken(),
          endpoint: APIPath.trustlyPayment,
          body: payload);
      final body = result.data;
      return TrustlyPaymentResponse.fromMap(body);
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<TrustlyPaymentResponse> trustlyPaymentStatus(String trustlyId) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      final result = await httpClient.getRequest(
        endpoint: APIPath.trustlyPaymentStatus(trustlyId),
      );
      final body = result.data;
      return TrustlyPaymentResponse.fromMap(body);
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<MolliePaymentResponse> createMolliePayment(
      String amount, String uid, Wallet wallet) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      final payload = {
        "user": uid,
        "target_account": wallet.walletID,
        "amount": {"currency": wallet.currency, "value": amount},
      };
      final result = await httpClient.post(
          uuid: uuid,
          token: localDataStorage.getToken(),
          endpoint: APIPath.molliePayment,
          body: payload);
      final body = result.data;
      return MolliePaymentResponse.fromMap(body);
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<MolliePaymentResponse> molliePaymentStatus(String mollieId) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      final result = await httpClient.getRequest(
        endpoint: APIPath.molliePaymentStatus(mollieId),
      );
      final body = result.data;
      return MolliePaymentResponse.fromMap(body);
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<Map<String, String>> initiateCardTransfer(
      String amount, String currency, String userId, String walletID) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      final result = await httpClient
          .post(endpoint: APIPath.initiateCardTransfer, uuid: uuid, body: {
        "user": userId,
        "target_account": walletID,
        "amount": {"value": amount, "currency": currency}
      });
      final body = result.data;
      Map<String, String> res = {};
      res['id'] = body['id'];
      res['reference'] = body['reference'];
      return res;
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<Map<String, dynamic>> createCardPayment(
      String amount, String currency) async {
    if (await networkInfo.isConnected) {
      Map<String, dynamic> body = {
        'amount': ((int.parse(amount)) * 100).toString(),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
          Uri.parse(APIPath.createStripePaymentIntent),
          body: body,
          headers: {
            'Authorization': 'Bearer ${sc.secretKey}',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      Map<String, dynamic> paymentIntentData = jsonDecode(response.body);
      final AuthenticationService _auth = sl<AuthenticationService>();
      // await fs.Stripe.instance
      //     .initPaymentSheet(
      //         paymentSheetParameters: fs.SetupPaymentSheetParameters(
      //             paymentIntentClientSecret: paymentIntentData['client_secret'],
      //             primaryButtonColor: AppColor.kSecondaryColor,
      //             currencyCode: currency,
      //             billingDetails: fs.BillingDetails(
      //                 email: _auth.user!.email,
      //                 name: _auth.user!.name,
      //                 address: fs.Address(
      //                     country: _auth.user!.userProfile.countryIso2,
      //                     city: _auth.user!.userProfile.addresses!.city,
      //                     state: _auth.user!.userProfile.addresses!.state,
      //                     postalCode:
      //                         _auth.user!.userProfile.addresses!.zipCode,
      //                     line1:
      //                         _auth.user!.userProfile.addresses!.addressLine1,
      //                     line2:
      //                         _auth.user!.userProfile.addresses!.addressLine2)),
      //             merchantCountryCode: 'US',
      //             merchantDisplayName: 'JAMES'))
      //     .then((value) {});
      // await fs.Stripe.instance.presentPaymentSheet().then((newValue) async {
      //   print("paid successfully");
      //   var response = await http.get(
      //       Uri.parse(
      //           "https://api.stripe.com${paymentIntentData['charges']['url']}"),
      //       headers: {
      //         'Authorization': 'Bearer ${sc.secretKey}',
      //         'Content-Type': 'application/x-www-form-urlencoded'
      //       });
      //   paymentIntentData['charges'] = jsonDecode(response.body)['data'][0];
      // });
      print("here");
      if (paymentIntentData.isEmpty) {
        throw "error";
      }
      return paymentIntentData;
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<bool> confirmCardTransfer(
      String userId, String payInId, Map<String, dynamic> object) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      final result = await httpClient.post(
          endpoint: APIPath.cardPaymentConfirm,
          uuid: uuid,
          body: {
            'user_id': userId,
            'payin_request_id': payInId,
            'object': object
          });
      final body = result.data;
      print(body);
      return true;
    } else {
      throw NoInternetException();
    }
  }
}
