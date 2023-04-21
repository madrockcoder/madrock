import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:geniuspay/models/total_amount.dart';

class PayUPaymentResponse extends Equatable {
  final String id;
  final String user;
  final String currency;
  final String amount;
  final TotalAmount fees;
  final TotalAmount totalAmount;
  final String paymentUrl;
  final String status;
  const PayUPaymentResponse(
      {required this.id,
      required this.user,
      required this.currency,
      required this.amount,
      required this.fees,
      required this.totalAmount,
      required this.paymentUrl,
      required this.status});

  factory PayUPaymentResponse.fromMap(Map<String, dynamic> map) {
    return PayUPaymentResponse(
        id: map['id'],
        user: map['user'],
        currency: map['fees_currency'],
        amount: map['amount'],
        fees: TotalAmount.fromMap(map['fees']),
        totalAmount: TotalAmount.fromMap(map['total_amount']),
        paymentUrl: map['redirect_url'],
        status: map['status']);
  }

  factory PayUPaymentResponse.fromJson(String source) =>
      PayUPaymentResponse.fromMap(json.decode(source));

  @override
  List<Object> get props {
    return [id, user, currency, amount, fees, totalAmount, paymentUrl];
  }
}
