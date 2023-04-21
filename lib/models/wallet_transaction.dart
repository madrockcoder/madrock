import 'dart:convert';

import 'package:geniuspay/models/transaction.dart';
import 'package:geniuspay/util/enums.dart';

import 'total_amount.dart';

class WalletTransaction extends Transaction {
  const WalletTransaction({
    required String id,
    required TransactionType type,
    required String paymentMethod,
    required TransactionStatus status,
    required String description,
    required String paymentFrom,
    required String paymentTo,
    required String reference,
    required PaymentDirection direction,
    required TotalAmount totalAmount,
    String? beneficiary,
    required String sourceWallet,
    String? signedAmountWithCurrency,
    required Fees fees,
    required String createdAt,
    required TotalAmount debitedAmount,
  }) : super(
            id: id,
            type: type,
            beneficiary: beneficiary,
            paymentMethod: paymentMethod,
            status: status,
            reference: reference,
            description: description,
            paymentFrom: paymentFrom,
            sourceWalletRef: sourceWallet,
            paymentTo: paymentTo,
            direction: direction,
            totalAmount: totalAmount,
            signedAmountWithCurrency: signedAmountWithCurrency,
            createdAt: createdAt,
            fees: fees,
            debitedAmount: debitedAmount);

  factory WalletTransaction.fromMap(Map<String, dynamic> map) {
    return WalletTransaction(
        id: map['id'] ?? '',
        status: map['status'] == 'COMPLETED'
            ? TransactionStatus.completed
            : TransactionStatus.pending,
        type: map['type'] == 'BALANCE_EXCHANGE'
            ? TransactionType.exchange
            : TransactionType.other,
        reference: map['reference'] ?? '',
        paymentMethod: map['payment_method'] ?? '',
        description: map['description'] ?? '',
        paymentFrom: map['payment_from'] ?? '',
        sourceWallet: map['source_wallet'] ?? '',
        paymentTo: map['payment_to'] ?? '',
        direction: map['direction'] == 'CREDIT'
            ? PaymentDirection.credit
            : PaymentDirection.debit,
        totalAmount: TotalAmount.fromMap(map['total_amount']),
        signedAmountWithCurrency: map['direction'] == 'DEBIT'
            ? '-${TotalAmount.fromMap(map['total_amount']).valueWithCurrency}'
            : TotalAmount.fromMap(map['total_amount']).valueWithCurrency ??
                '0.0',
        fees: Fees.fromMap(map['total_amount']),
        debitedAmount: TotalAmount.fromMap(map['instructed_amount']),
        createdAt: map['created_at']);
  }

  factory WalletTransaction.fromJson(String source) =>
      WalletTransaction.fromMap(json.decode(source));

  @override
  List<Object> get props {
    return [
      id,
      type,
      paymentFrom,
      paymentTo,
      direction,
      totalAmount,
    ];
  }

  @override
  String toString() {
    return 'WalletTransaction(id: $id, type: $type, paymentFrom: $paymentFrom, paymentTo: $paymentTo, direction: $direction, totalAmount: $totalAmount)';
  }
}

class WalletTransactionList {
  WalletTransactionList({required this.list});

  factory WalletTransactionList.fromJson(List parsedJson) {
    final list = parsedJson.map((value) {
      return WalletTransaction.fromMap(value);
    }).toList();
    return WalletTransactionList(list: list);
  }

  final List<WalletTransaction> list;
}
