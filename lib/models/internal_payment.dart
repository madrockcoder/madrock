import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:geniuspay/models/total_amount.dart';

class InternalPayment extends Equatable {
  final String sourceID;
  final String payerID;
  final String payeeID;
  final TotalAmount amount;
  final String description;
  const InternalPayment({
    required this.sourceID,
    required this.payerID,
    required this.payeeID,
    required this.amount,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'source_account': sourceID,
      'payer': payerID,
      'payee': payeeID,
      'amount': amount.toMap(),
      'description': description,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object> get props {
    return [
      payerID,
      payeeID,
      amount,
      description,
    ];
  }

  @override
  String toString() {
    return 'InternalPayment(payerID: $payerID, payeeID: $payeeID, amount: $amount, description: $description)';
  }
}
