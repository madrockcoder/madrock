import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:geniuspay/models/total_amount.dart';

class TrustlyPaymentResponse extends Equatable {
  final String id;
  final String user;
  final String currency;
  final TotalAmount instructedAmount;
  final TotalAmount fees;
  final TotalAmount totalAmount;
  final String paymentUrl;
  final String status;
  final String reference;
  const TrustlyPaymentResponse({
    required this.id,
    required this.user,
    required this.currency,
    required this.instructedAmount,
    required this.fees,
    required this.totalAmount,
    required this.paymentUrl,
    required this.status,
    required this.reference
  });

  factory TrustlyPaymentResponse.fromMap(Map<String, dynamic> map) {
    return TrustlyPaymentResponse(
        id: map['id'],
        user: map['user'],
        currency: map['currency'],
        instructedAmount: TotalAmount.fromMap(map['instructed_amount']),
        fees: TotalAmount.fromMap(map['fees']),
        totalAmount: TotalAmount.fromMap(map['total_amount']),
        paymentUrl: map['checkout_url'],
        reference: map['reference'],
        status: map['status']);
  }

  factory TrustlyPaymentResponse.fromJson(String source) =>
      TrustlyPaymentResponse.fromMap(json.decode(source));

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
