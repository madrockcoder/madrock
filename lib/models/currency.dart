import 'dart:convert';

import 'package:equatable/equatable.dart';

class Currency extends Equatable {
  final String code;
  final String name;
  final String flag;
  final int decimalPlace;
  final double minInvoiceAmount;
  final double maxInvoiceAmount;
  final bool canBuy;
  final bool canSell;

  const Currency({
    required this.code,
    required this.name,
    required this.flag,
    required this.decimalPlace,
    required this.minInvoiceAmount,
    required this.maxInvoiceAmount,
    required this.canBuy,
    required this.canSell,
  });

  factory Currency.fromMap(Map<String, dynamic> map) {
    return Currency(
        code: map['code'] ?? '',
        name: map['name'] ?? '',
        flag: map['flag'] ?? '',
        decimalPlace: map['decimal_places'] ?? '',
        maxInvoiceAmount:
            double.tryParse(map['max_invoice_amount']) ?? 100000.00,
        minInvoiceAmount: map['min_invoice_amount'].toDouble() ?? 1,
        canBuy: map['can_buy'] ?? false,
        canSell: map['can_sell'] ?? false);
  }

  factory Currency.fromJson(String source) =>
      Currency.fromMap(json.decode(source));

  @override
  List<Object> get props {
    return [
      code,
      name,
      flag,
      decimalPlace,
      maxInvoiceAmount,
    ];
  }

  @override
  String toString() {
    return 'Currency(code: $code, name: $name, flag: $flag, decimalPlace: $decimalPlace, maxInvoiceAmount: $maxInvoiceAmount)';
  }
}

class CurrencyList {
  CurrencyList({required this.list});

  factory CurrencyList.fromJson(List parsedJson) {
    final list = parsedJson.map((value) {
      return Currency.fromMap(value);
    }).toList();
    return CurrencyList(list: list);
  }

  final List<Currency> list;
}
