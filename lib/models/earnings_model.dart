import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:geniuspay/models/total_amount.dart';
import 'package:geniuspay/models/wallet.dart';

class EarningsModel extends Equatable {
  final AvailableBalance availableBalance;
  final AvailableBalance pendingBalance;
  final List<BonusTransaction> transactions;
  const EarningsModel(
      {required this.availableBalance,
      required this.pendingBalance,
      required this.transactions});

  Map<String, dynamic> toMap() {
    return {};
  }

  factory EarningsModel.fromMap(Map<String, dynamic> map) {
    return EarningsModel(
      availableBalance: AvailableBalance.fromMap(map['available_balance']),
      transactions: BonusTransactionList.fromJson(map['transactions']).list,
      pendingBalance: AvailableBalance.fromMap(map['pending_balance']),
    );
  }

  String toJson() => json.encode(toMap());

  factory EarningsModel.fromJson(String source) =>
      EarningsModel.fromMap(json.decode(source));

  @override
  List<Object?> get props {
    return [];
  }
}

class BonusTransaction extends Equatable {
  final TotalAmount amount;
  final String createdAt;
  final String referral;
  final String description;
  const BonusTransaction(
      {required this.amount,
      required this.createdAt,
      required this.referral,
      required this.description});

  Map<String, dynamic> toMap() {
    return {};
  }

  factory BonusTransaction.fromMap(Map<String, dynamic> map) {
    return BonusTransaction(
        amount: TotalAmount.fromMap(map['amount']),
        createdAt: map['created_at'] ?? '',
        referral: map['referral'] ?? '',
        description: map['description'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory BonusTransaction.fromJson(String source) =>
      BonusTransaction.fromMap(json.decode(source));

  @override
  List<Object?> get props {
    return [];
  }
}

class BonusTransactionList {
  BonusTransactionList({required this.list});

  factory BonusTransactionList.fromJson(List parsedJson) {
    final list = parsedJson.map((value) {
      return BonusTransaction.fromMap(value);
    }).toList();
    return BonusTransactionList(list: list);
  }

  final List<BonusTransaction> list;
}
