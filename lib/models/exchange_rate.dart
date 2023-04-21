import 'dart:convert';

import 'package:equatable/equatable.dart';

enum FixedSide { buy, sell }

class ExchangeRate extends Equatable {
  // final double ask;
  // final double bid;
  final String settlementTime;
  final String sellAmount;
  final String buyCurrency;
  final String sellCurrency;
  final String fixedSide;
  final String rate;
  final String buyAmount;
  final String currencyPair;
  final String fees;
  const ExchangeRate(
      {required this.settlementTime,
      required this.sellAmount,
      required this.buyCurrency,
      required this.sellCurrency,
      required this.fixedSide,
      required this.rate,
      required this.buyAmount,
      required this.currencyPair,
      required this.fees});

  Map<String, dynamic> toMap() {
    return {
      'settlement_cut_off_time': settlementTime,
      'client_rate': rate,
      'fixed_side': fixedSide,
      'client_buy_amount': buyAmount,
      'client_sell_amount': sellAmount,
      'client_buy_currency': buyCurrency,
      'currency_pair': currencyPair,
      'client_sell_currency': sellCurrency,
    };
  }

  factory ExchangeRate.fromMap(Map<String, dynamic> map) {
    return ExchangeRate(
        settlementTime: map['settlement_cut_off_time'],
        rate: map['client_rate'],
        fixedSide: map['fixed_side'],
        buyAmount: map['client_buy_amount'],
        sellAmount: map['client_sell_amount'],
        buyCurrency: map['client_buy_currency'],
        currencyPair: map['currency_pair'],
        fees: map['fees'] ?? '',
        sellCurrency: map['client_sell_currency']);
  }

  String toJson() => json.encode(toMap());

  factory ExchangeRate.fromJson(String source) =>
      ExchangeRate.fromMap(json.decode(source));

  @override
  List<Object?> get props {
    return [
      sellAmount,
      buyCurrency,
      sellCurrency,
      fixedSide,
      rate,
      buyAmount,
    ];
  }
}
