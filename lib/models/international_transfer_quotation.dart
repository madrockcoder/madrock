import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:geniuspay/models/total_amount.dart';

class InternationalTransferQuotation extends Equatable {
  final String? id;
  final String user;
  final String sourceCurrency;
  final TotalAmount sourceAmount;
  final TotalAmount targetAmount;
  final String targetCurrency;
  final String rate;

  const InternationalTransferQuotation({
    this.id,
    required this.user,
    required this.sourceCurrency,
    required this.sourceAmount,
    required this.targetCurrency,
    required this.targetAmount,
    required this.rate,
  });

  Map<String, dynamic> toMap() {
    return {};
  }

  factory InternationalTransferQuotation.fromMap(Map<String, dynamic> map) {
    return InternationalTransferQuotation(
      id: map['id'],
      user: map['user'],
      sourceCurrency: map['source_currency'],
      targetCurrency: map['target_currency'],
      sourceAmount: TotalAmount.fromMap(map['source_amount']),
      targetAmount: TotalAmount.fromMap(map['target_amount']),
      rate: map['rate'],
    );
  }
  String toJson() => json.encode(toMap());

  @override
  List<Object> get props {
    return [];
  }
}
