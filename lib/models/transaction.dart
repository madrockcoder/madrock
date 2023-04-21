import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:geniuspay/util/enums.dart';

import '../util/widgets_util.dart';
import 'total_amount.dart';

enum PaymentDirection { credit, debit }

enum TransactionStatus { pending, completed }

class DatedTransaction extends Equatable {
  final String createdDate;
  final List<Transaction> transactions;

  const DatedTransaction({
    required this.createdDate,
    required this.transactions,
  });

  factory DatedTransaction.fromMap(Map<String, dynamic> map) {
    return DatedTransaction(
      createdDate: map['created_date'] ?? '',
      transactions: List<Transaction>.from(
          map['transactions']?.map((x) => Transaction.fromMap(x))),
    );
  }

  factory DatedTransaction.fromJson(String source) =>
      DatedTransaction.fromMap(json.decode(source));

  @override
  List<Object> get props => [createdDate, transactions];

  @override
  String toString() =>
      'DatedTransaction(createdDate: $createdDate, transactions: $transactions)';
}

class DatedTransactionList {
  DatedTransactionList({required this.list});

  factory DatedTransactionList.fromJson(List parsedJson) {
    final list = parsedJson.map((value) {
      return DatedTransaction.fromMap(value);
    }).toList();
    return DatedTransactionList(list: list);
  }

  final List<DatedTransaction> list;
}

class Transaction extends Equatable {
  final String id;
  final TransactionType type;
  final String paymentMethod;
  final PaymentMetaData? paymentMetaData;
  final TransactionStatus status;
  final String description;
  final String paymentFrom;
  final String paymentTo;
  final PaymentDirection direction;
  final TotalAmount totalAmount;
  final String? signedAmountWithCurrency;
  final String reference;
  final String? beneficiary;
  final Fees fees;
  final String sourceWalletRef;
  final String? targetWalletRef;
  final String? createdAt;
  final String? completedAt;
  final TotalAmount debitedAmount;

  const Transaction({
    required this.id,
    required this.type,
    required this.paymentMethod,
    this.paymentMetaData,
    required this.status,
    required this.description,
    required this.paymentFrom,
    required this.paymentTo,
    required this.direction,
    required this.totalAmount,
    required this.signedAmountWithCurrency,
    required this.reference,
    this.beneficiary,
    required this.fees,
    required this.sourceWalletRef,
    required this.debitedAmount,
    this.targetWalletRef,
    this.createdAt,
    this.completedAt,
  });

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
        id: map['id'] ?? '',
        type: getTransactionType(map['type']),
        paymentMethod: map['payment_method'] ?? '',
        paymentMetaData: map['payment_metadata'] != null
            ? PaymentMetaData.fromJson(map['payment_metadata']
                [map['payment_method'].toLowerCase() ?? ''])
            : null,
        status: map['status'] == 'COMPLETED'
            ? TransactionStatus.completed
            : TransactionStatus.pending,
        description: map['description'] ?? '',
        beneficiary: map['beneficiary'] ?? '',
        reference: map['reference'] ?? '',
        paymentFrom: map['payment_from'] ?? '',
        sourceWalletRef: map['source_wallet_ref'] ?? '',
        paymentTo: map['payment_to'] ?? '',
        direction: map['direction'] == 'DEBIT'
            ? PaymentDirection.debit
            : PaymentDirection.credit,
        totalAmount: TotalAmount.fromMap(map['total_amount']),
        signedAmountWithCurrency: map['direction'] == 'DEBIT'
            ? '-${TotalAmount.fromMap(map['total_amount']).valueWithCurrency}'
            : TotalAmount.fromMap(map['total_amount']).valueWithCurrency ??
                '0.0',
        fees: Fees.fromMap(map['fees']),
        completedAt: map['completed_at'],
        createdAt: map['created_at'],
        targetWalletRef: map['target_wallet_ref'] ?? '',
        debitedAmount: TotalAmount.fromMap(map['instructed_amount']));
  }

  factory Transaction.fromJson(String source) =>
      Transaction.fromMap(json.decode(source));

  @override
  List<Object?> get props {
    return [
      id,
      type,
      paymentMethod,
      status,
      description,
      paymentFrom,
      paymentTo,
      beneficiary,
      sourceWalletRef,
      direction,
      totalAmount,
      fees,
      createdAt,
      reference,
      completedAt,
    ];
  }

  @override
  String toString() {
    return 'Transaction(id: $id, type: $type, paymentMethod: $paymentMethod, status: $status, description: $description, paymentFrom: $paymentFrom, sourceWalletRef: $sourceWalletRef, beneficiary: $beneficiary, paymentTo: $paymentTo, direction: $direction, totalAmount: $totalAmount, reference: $reference, fees: $fees, createdAt: $createdAt, completedAt: $completedAt)';
  }
}

TransactionType getTransactionType(String transactionType) {
  switch (transactionType) {
    case 'DEPOSIT':
      return TransactionType.deposit;
    case 'REMITTANCE':
      return TransactionType.remittance;
    case 'WIRE_TRANSFER':
      return TransactionType.wireTransfer;
    case 'INTERNAL_TRANSFER':
      return TransactionType.internalTransfer;
    case 'CURRENCY_EXCHANGE':
      return TransactionType.currencyExchange;
    case 'BALANCE_TRANSFER':
      return TransactionType.balanceTransfer;
    case 'BALANCE_EXCHANGE':
      return TransactionType.exchange;
    case 'INTERNET_PURCHASE':
      return TransactionType.internetPurchase;
    case 'PAYOUT_WITHDRAWAL':
      return TransactionType.payoutWithdrawal;
    case 'WALLET_FUND_TRANSFER':
      return TransactionType.walletFundTransfer;
    case 'WALLET_REFUND':
      return TransactionType.walletRefund;
    case 'VOUCHER_DEPOSIT':
      return TransactionType.voucherDeposit;
    case 'INVOICE_SETTLEMENT':
      return TransactionType.invoiceSettlement;
    case 'FEE_DEBIT':
      return TransactionType.feeDebit;
    case 'FEE_REVERSAL':
      return TransactionType.feeReversal;
    case 'FEE_WAIVER':
      return TransactionType.feeWaiver;
    default:
      return TransactionType.other;
  }
}

class PaymentMetaData {
  String? brand;
  Checks? checks;
  String? country;
  int? expMonth;
  int? expYear;
  String? fingerprint;
  String? funding;
  String? installments;
  String? last4;
  String? mandate;
  String? network;
  String? threeDSecure;
  String? wallet;

  PaymentMetaData(
      {this.brand,
      this.checks,
      this.country,
      this.expMonth,
      this.expYear,
      this.fingerprint,
      this.funding,
      this.installments,
      this.last4,
      this.mandate,
      this.network,
      this.threeDSecure,
      this.wallet});

  PaymentMetaData.fromJson(Map<String, dynamic> json) {
    brand = json['brand'] as String;
    checks = json['checks'] != null
        ? Checks.fromJson(json['checks'] as Map<String, dynamic>)
        : null;
    country = json['country'] as String;
    expMonth = json['exp_month'] as int;
    expYear = json['exp_year'] as int;
    fingerprint = json['fingerprint'] as String;
    funding = json['funding'] as String;
    installments = json['installments'] as String;
    last4 = json['last4'] as String;
    mandate = json['mandate'] as String;
    network = json['network'] as String;
    threeDSecure = json['three_d_secure'] as String;
    wallet = json['wallet'] as String;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['brand'] = brand;
    if (checks != null) {
      data['checks'] = checks!.toJson();
    }
    data['country'] = country;
    data['exp_month'] = expMonth;
    data['exp_year'] = expYear;
    data['fingerprint'] = fingerprint;
    data['funding'] = funding;
    data['installments'] = installments;
    data['last4'] = last4;
    data['mandate'] = mandate;
    data['network'] = network;
    data['three_d_secure'] = threeDSecure;
    data['wallet'] = wallet;
    return data;
  }
}

class Checks {
  String? addressLine1Check;
  String? addressPostalCodeCheck;
  String? cvcCheck;

  Checks({this.addressLine1Check, this.addressPostalCodeCheck, this.cvcCheck});

  Checks.fromJson(Map<String, dynamic> json) {
    addressLine1Check = json['address_line1_check'] as String;
    addressPostalCodeCheck = json['address_postal_code_check'] as String;
    cvcCheck = json['cvc_check'] as String;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['address_line1_check'] = addressLine1Check;
    data['address_postal_code_check'] = addressPostalCodeCheck;
    data['cvc_check'] = cvcCheck;
    return data;
  }
}

class Fees extends TotalAmount {
  const Fees(
      {required double value,
      required String currency,
      required String valueWithCurrency})
      : super(
            value: value,
            currency: currency,
            valueWithCurrency: valueWithCurrency);

  factory Fees.fromMap(Map<String, dynamic> map) {
    final valArr = (map['value'] ?? 0.0).toStringAsFixed(2).split('-');
    final val = double.tryParse(valArr.last as String);
    final valueWithCurrency =
        '${WidgetsUtil.getCurrency(map['currency'] as String)}${val?.toStringAsFixed(2)}';
    return Fees(
      value: val!,
      currency: map['currency'] as String,
      valueWithCurrency: valueWithCurrency,
    );
  }

  factory Fees.fromJson(String source) =>
      Fees.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object> get props => [value, currency];
}
