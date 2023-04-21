import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:geniuspay/models/total_amount.dart';

class StitchPaymentResponse extends Equatable {
  final String id;
  final String user;
  final String currency;
  final String amount;
  final TotalAmount fees;
  final TotalAmount totalAmount;
  final String paymentUrl;
  const StitchPaymentResponse({
    required this.id,
    required this.user,
    required this.currency,
    required this.amount,
    required this.fees,
    required this.totalAmount,
    required this.paymentUrl,
  });

  factory StitchPaymentResponse.fromMap(Map<String, dynamic> map) {
    return StitchPaymentResponse(
      id: map['id'],
      user: map['user'],
      currency: TotalAmount.fromMap(map['total_amount']).currency,
      amount: TotalAmount.fromMap(map['instructed_amount']).value.toString(),
      fees: TotalAmount.fromMap(map['fees']),
      totalAmount: TotalAmount.fromMap(map['total_amount']),
      paymentUrl: map['payment_request_url'],
    );
  }

  factory StitchPaymentResponse.fromJson(String source) =>
      StitchPaymentResponse.fromMap(json.decode(source));

  @override
  List<Object> get props {
    return [id, user, currency, amount, fees, totalAmount, paymentUrl];
  }
}
