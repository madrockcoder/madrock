import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:geniuspay/models/total_amount.dart';
import 'package:geniuspay/util/enums.dart';

class InternationalTransferModel extends Equatable {
  final String user;
  final String? currency;
  final TotalAmount amount;
  final TotalAmount? fees;
  final TotalAmount? totalAmount;
  final TotalAmount? receivingAmount;
  final String? description;
  final String beneficiaryId;
  final String? purposeCode;
  final String? paymentReference;
  final PaymentDeliveryTime paymentType;
  final bool? scheduled;
  final String? paymentDate;
  final String? paymentFrequency;
  final String? lastPaymentDate;

  final String? paymentMethod;
  String? quotation;

  InternationalTransferModel(
      {required this.user,
      this.currency,
      required this.amount,
      this.description,
      required this.beneficiaryId,
      this.receivingAmount,
      this.purposeCode,
      this.paymentReference,
      required this.paymentType,
      this.paymentMethod,
      this.totalAmount,
      this.fees,
      this.quotation,
      this.scheduled,
      this.paymentDate,
      this.paymentFrequency,
      this.lastPaymentDate});

  Map<String, dynamic> toMap() {
    return {
      'user': user,
      if (currency != null) 'currency': currency,
      'amount': amount.toMap(),
      if (description != null) 'description': description,
      'beneficiary': beneficiaryId,
      // if (purposeCode != null) 'purpose_code': purposeCode,
      if (paymentReference != null) 'payment_reference': paymentReference,
      'payment_type': getPaymentDeliveryTime(paymentType),

      'payment_method': paymentMethod,
      if (quotation != null) 'quotation': quotation,
      if (scheduled != null) 'scheduled': scheduled,
      if (paymentDate != null) 'payment_date': paymentDate,
      if (paymentFrequency != null)
        'payment_frequency': paymentFrequency!.toUpperCase(),
      if (description != null) 'description': description,
      if (lastPaymentDate != null) 'last_payment_date': lastPaymentDate
    };
  }

  factory InternationalTransferModel.fromMap(Map<String, dynamic> map) {
    return InternationalTransferModel(
        amount: TotalAmount.fromMap(map['sending_amount']),
        user: map['user'],
        fees: TotalAmount.fromMap(map['fees']),
        quotation: map['quotation'],
        totalAmount: TotalAmount.fromMap(map['total_amount']),
        receivingAmount: map['receiving_amount'] == null
            ? null
            : TotalAmount.fromMap(map['receiving_amount']),
        scheduled: map['scheduled'],
        paymentDate: map['payment_date'],
        paymentFrequency: map['payment_frequency'],
        lastPaymentDate: map['last_payment_date'],
        beneficiaryId: map['beneficiary'],
        description: map['description'],
        paymentType: getDeliveryTimeEnum(map['payment_type']),
        paymentReference: map['payment_reference'],
        paymentMethod: map['payment_method']);
  }
  String toJson() => json.encode(toMap());

  @override
  List<Object> get props {
    return [];
  }
}
