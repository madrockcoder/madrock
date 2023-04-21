import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:geniuspay/models/total_amount.dart';

class MolliePaymentResponse extends Equatable {
  final String id;
  final String user;
  final String currency;
  final TotalAmount instructedAmount;
  final TotalAmount fees;
  final TotalAmount totalAmount;
  final String paymentUrl;
  final String status;
  const MolliePaymentResponse({
    required this.id,
    required this.user,
    required this.currency,
    required this.instructedAmount,
    required this.fees,
    required this.totalAmount,
    required this.paymentUrl,
    required this.status,
  });

  factory MolliePaymentResponse.fromMap(Map<String, dynamic> map) {
    return MolliePaymentResponse(
        id: map['id'],
        user: map['user'],
        currency: TotalAmount.fromMap(map['instructed_amount']).currency,
        instructedAmount: TotalAmount.fromMap(map['instructed_amount']),
        fees: TotalAmount.fromMap(map['fees']),
        totalAmount: TotalAmount.fromMap(map['total_amount']),
        paymentUrl: map['checkout_url'],
        status: map['status']);
  }

  factory MolliePaymentResponse.fromJson(String source) =>
      MolliePaymentResponse.fromMap(json.decode(source));

  @override
  List<Object> get props {
    return [
      id,
      user,
      currency,
      instructedAmount,
      fees,
      totalAmount,
      paymentUrl
    ];
  }
}
