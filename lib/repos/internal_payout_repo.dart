import 'dart:convert';

import 'package:http/http.dart' as http;

import '../app/shared_widgets/http_exception.dart';
import '../models/exchange_rate.dart';
import '../models/internal_payment.dart';
import '../models/payee.dart';
import '../models/recipient.dart';
import '../util/security.dart';
import 'api_path.dart';

abstract class InternalPaymentBase {
  Future<void> createTransfer(InternalPayment internalPayment);
  Future<Payee> fetchPayeeByEmail(String email);
  Future<void> checkgeniuspayUserByEmail(String email);
  // Future<ExchangeRate> fetchExchangeRate(String currencyPair);
  Future<ExchangeRate> fetchExchangeRate(ExchangeRate rate);
  Future<List<Recipient>> fetchUserRecipients();
  Future<Recipient> createRecipient(Recipient recipient);
  // Future<List<DatedTransaction>> fetchTransactions();
}

class InternalPayoutRepo with HMACSecurity implements InternalPaymentBase {
  InternalPayoutRepo({
    required this.token,
    required this.uid,
  });
  final String token;
  final String uid;

  @override
  Future<void> createTransfer(InternalPayment internalPayment) async {
    try {
      final response = await http.post(
        Uri.parse(APIPath.createp2pTransfer),
        headers: headers(
          token: token,
          hmac: generateHMACSignature(
            path: APIPath.createp2pTransfer,
            method: 'POST',
            payload: internalPayment.toMap(),
          ),
        ),
        body: internalPayment.toJson(),
      );

      final body = json.decode(response.body);
      if (body['errors'] != null) {
        throw CustomHttpException(
            title: 'Couldn\'t Complete Request',
            message: body['errors'][0]['message'] as String);
      } else if (body['error_message'] != null) {
        throw CustomHttpException(
            title: 'Couldn\'t Complete Request',
            message: body['error_message']);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> checkgeniuspayUserByEmail(String email) async {
    try {
      final response = await http.get(
        Uri.parse(APIPath.checkgeniuspayUserByEmail(email)),
        headers: headers(token: token),
      );

      final body = json.decode(response.body);

      if (body['errors'] != null) {
        throw CustomHttpException(
            title: 'Error fetching Payee',
            message: body['errors'][0]['message']);
      } else if (body['error_message'] != null) {
        throw CustomHttpException(
            title: 'Error fetching beneficiary',
            message: body['error_message']);
      } else if (!(body['status'] as bool)) {
        throw CustomHttpException(
            title: 'Error fetching beneficiary',
            message:
                'The beneficiary with the provided email is not a geniuspay user.');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Payee> fetchPayeeByEmail(String email) async {
    try {
      final response = await http.get(
        Uri.parse(APIPath.payeeIdByEmail(email)),
        headers: headers(token: token),
      );

      final body = json.decode(response.body);

      if (body['errors'] != null) {
        throw CustomHttpException(
            title: 'Couldn\'t Complete Request',
            message: body['errors'][0]['message']);
      } else if (body['error_message'] != null) {
        throw CustomHttpException(
            title: 'Couldn\'t Complete Request',
            message: body['error_message']);
      } else {
        return Payee.fromJson(response.body);
      }
    } catch (e) {
      rethrow;
    }
  }

  // @override
  // Future<List<DatedTransaction>> fetchTransactions() async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse(APIPath.fetchTransactions(uid: uid)),
  //       headers: headers(token: token),
  //     );

  //     final body = json.decode(response.body);

  //     if (body['message'] != null) {
  //       throw CustomHttpException(
  //           title: 'An error occurred', message: body['message']);
  //     } else {
  //       final transactions = body['results'] as List<dynamic>;
  //       return transactions
  //           .map((transaction) => DatedTransaction.fromMap(transaction))
  //           .toList();
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // @override
  // Future<ExchangeRate> fetchExchangeRate(String currencyPair) async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse(APIPath.exchangeRate(currencyPair)),
  //       headers: {
  //         'content-type': 'application/json; charset=utf-8',
  //         'Accept': 'application/json',
  //         'Authorization': 'Token $token',
  //         'X-Auth-Client': authClient,
  //       },
  //     );

  //     final body = json.decode(response.body);

  //     if (body['errors'] != null) {
  //       throw CustomHttpException(
  //           title: 'Couldn\'t Complete Request',
  //           message: body['errors'][0]['message']);
  //     } else if (body['error_message'] != null) {
  //       throw CustomHttpException(
  //           title: 'Couldn\'t Complete Request',
  //           message: body['error_message']);
  //     } else {
  //       return ExchangeRate.fromJson(response.body);
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  @override
  Future<ExchangeRate> fetchExchangeRate(ExchangeRate rate) async {
    try {
      final response = await http.get(
        Uri.parse(APIPath.exchangeRatesDetailed(
          amount: rate.sellAmount,
          buyCurrency: rate.buyCurrency,
          fixedSide: rate.fixedSide,
          sellCurrency: rate.sellCurrency,
        )),
        headers: headers(token: token),
      );

      final body = json.decode(response.body);

      if (body['errors'] != null) {
        throw CustomHttpException(
            title: 'Couldn\'t Complete Request',
            message: body['errors'][0]['message']);
      } else if (body['error_message'] != null) {
        throw CustomHttpException(
            title: 'Couldn\'t Complete Request',
            message: body['error_message']);
      } else {
        return ExchangeRate.fromJson(response.body);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Recipient>> fetchUserRecipients() async {
    try {
      final response = await http.get(
        Uri.parse(APIPath.fetchUserRecipients(uid)),
        headers: headers(token: token),
      );

      final body = json.decode(response.body)['results'] as List<dynamic>;

      return body.map((e) => Recipient.fromMap(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Recipient> createRecipient(Recipient recipient) async {
    try {
      final response = await http.post(
        Uri.parse(APIPath.addEmailRecipient),
        headers: headers(
          token: token,
          hmac: generateHMACSignature(
            path: APIPath.addEmailRecipient,
            method: 'POST',
            payload: recipient.toMap(),
          ),
        ),
        body: recipient.toJson(),
      );

      final body = json.decode(response.body);

      if (body['errors'] != null) {
        throw CustomHttpException(
            title: 'Couldn\'t Complete Request',
            message: body['errors'][0]['message']);
      } else if (body['error_message'] != null) {
        throw CustomHttpException(
            title: 'Couldn\'t Complete Request',
            message: body['error_message']);
      } else {
        return Recipient.fromJson(response.body);
      }
    } catch (e) {
      rethrow;
    }
  }
}
