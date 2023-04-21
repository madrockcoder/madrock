import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:geniuspay/models/total_amount.dart';

class TransactionLimits extends Equatable {
  final TotalAmount topUpLimit;
  final TotalAmount topUpLimitRemaining;
  final TotalAmount payoutLimit;
  final TotalAmount payoutLimitRemaining;
  final TotalAmount exchangeLimit;
  final TotalAmount exchangeLimitRemaining;
  final String expireDate;
  const TransactionLimits({
    required this.topUpLimit,
    required this.topUpLimitRemaining,
    required this.payoutLimit,
    required this.payoutLimitRemaining,
    required this.exchangeLimit,
    required this.exchangeLimitRemaining,
    required this.expireDate,
  });

  factory TransactionLimits.fromMap(Map<String, dynamic> map) {
    return TransactionLimits(
        topUpLimit: TotalAmount.fromMap(map['top_up_limit']),
        topUpLimitRemaining: TotalAmount.fromMap(map['top_up_limit_remaining']),
        payoutLimit: TotalAmount.fromMap(map['payout_limit']),
        payoutLimitRemaining:
            TotalAmount.fromMap(map['payout_limit_remaining']),
        exchangeLimit: TotalAmount.fromMap(map['exchange_limit']),
        exchangeLimitRemaining:
            TotalAmount.fromMap(map['exchange_limit_remaining']),
        expireDate: map['limit_expire_at']);
  }

  factory TransactionLimits.fromJson(String source) =>
      TransactionLimits.fromMap(json.decode(source));

  @override
  List<Object> get props {
    return [];
  }
}
