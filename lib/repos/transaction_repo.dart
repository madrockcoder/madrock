import 'dart:convert';

import 'package:http/http.dart' as http;

import '../app/shared_widgets/http_exception.dart';
import '../models/internal_payment.dart';
import '../models/recipient.dart';
import '../models/transaction.dart';
import '../util/security.dart';
import 'api_path.dart';

abstract class TransactionBase {
  Future<List<Recipient>> fetchUserRecipients();
  // Future<List<DatedTransaction>> fetchTransactions();
  Future<void> repeatTransfer(InternalPayment internalPayment);
  Future<Transaction> getTransactionByID(String id);
}

class TransactionRepo with HMACSecurity implements TransactionBase {
  TransactionRepo({
    required this.token,
    this.uid,
  });
  final String token;
  final String? uid;

  @override
  Future<List<Recipient>> fetchUserRecipients() async {
    try {
      final response = await http.get(
        Uri.parse(APIPath.fetchUserRecipients(uid!)),
        headers: headers(token: token),
      );

      final body = json.decode(response.body)['results'] as List<dynamic>;

      return body.map((e) => Recipient.fromMap(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  // @override
  // Future<List<DatedTransaction>> fetchTransactions() async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse(APIPath.fetchTransactions(uid: uid!)),
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

  @override
  Future<Transaction> getTransactionByID(String transactionId) async {
    try {
      final response = await http.get(
        Uri.parse(APIPath.getTransactionByID(uid!, transactionId)),
        headers: headers(token: token),
      );

      final body = json.decode(response.body);

      if (body['message'] != null) {
        throw CustomHttpException(
            title: 'An error occurred', message: body['message']);
      } else {
        return Transaction.fromJson(response.body);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> repeatTransfer(InternalPayment internalPayment) async {
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
            message: body['errors'][0]['message']);
      } else if (body['error_message'] != null) {
        throw CustomHttpException(
            title: 'Couldn\'t Complete Request',
            message: body['error_message']);
      }
    } catch (e) {
      rethrow;
    }
  }

  //2e9a052f-3e0e-4d4c-82ad-905841265b06
  //1b0450d9-6a2d-4dfb-8555-396db9589889
  //3ea33855-230e-4c6d-a579-bb84b468a961

  // @override
  // Future<Transaction?> getTransactionByID(String id) async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse(APIPath.getTransactionByID(id)),
  //       headers: headers(token: token),
  //     );

  //     final body = json.decode(response.body);

  //     if (body['message'] != null) {
  //       throw CustomHttpException(
  //           title: 'An error occurred', message: body['message']);
  //     } else {
  //        body['results'] as List<dynamic>;
  //       return null;
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // fetch the transaction here.

}
