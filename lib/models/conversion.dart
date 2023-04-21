import 'dart:convert';

import 'package:equatable/equatable.dart';

class Conversion extends Equatable {
  const Conversion({
    required this.user,
    required this.buyCurrency,
    required this.sellCurrency,
    required this.amount,
    this.buyAmount,
    required this.reference,
    required this.conversionDate,
    this.status,
    this.pointsEarned,
  });

  factory Conversion.fromMap(Map<String, dynamic> map) {
    return Conversion(
      user: map['user'] as String,
      buyCurrency: map['buy_currency'] as String,
      sellCurrency: map['sell_currency'] as String,
      amount: map['amount'] as String,
      buyAmount: map['client_buy_amount'] as String,
      reference: map['reference'] as String,
      pointsEarned: map['points_earned'].toString(),
      status: map['status'] as String,
      conversionDate: map['conversion_date'] as String,
    );
  }

  factory Conversion.fromJson(String source) =>
      Conversion.fromMap(json.decode(source) as Map<String, dynamic>);
  final String user;
  final String buyCurrency;
  final String sellCurrency;
  final String amount;
  final String? buyAmount;
  final String reference;
  final String conversionDate;
  final String? pointsEarned;
  final String? status;

  Map<String, dynamic> toMap() {
    return {
      'user': user,
      'buy_currency': buyCurrency,
      'sell_currency': sellCurrency,
      'amount': amount,
      'client_buy_amount': buyAmount,
      'reference': reference,
      'conversion_date': conversionDate,
      'points_earned': pointsEarned,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props {
    return [
      user,
      buyCurrency,
      sellCurrency,
      amount,
      buyAmount,
    ];
  }
}

class ConversionList {
  ConversionList({required this.list});

  factory ConversionList.fromJson(List parsedJson) {
    final list = parsedJson.map((value) {
      return Conversion.fromMap(value as Map<String, dynamic>);
    }).toList();
    return ConversionList(list: list);
  }

  final List<Conversion> list;
}
