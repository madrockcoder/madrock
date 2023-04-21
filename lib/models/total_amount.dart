import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:geniuspay/util/widgets_util.dart';

class TotalAmount extends Equatable {
  final double value;
  final String currency;
  final String? valueWithCurrency;

  const TotalAmount({
    required this.value,
    required this.currency,
    this.valueWithCurrency,
  });

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'currency': currency,
    };
  }

  factory TotalAmount.fromMap(Map<String, dynamic> map) {
    final valueWithCurrency =
        '${WidgetsUtil.getCurrency(map['currency'])} ${map['value']}';

    return TotalAmount(
      value: map['value'] ?? 0,
      currency: map['currency'] ?? '',
      valueWithCurrency: valueWithCurrency,
    );
  }

  factory TotalAmount.fromJson(String source) =>
      TotalAmount.fromMap(json.decode(source));

  @override
  List<Object?> get props => [value, currency, valueWithCurrency];

  @override
  String toString() =>
      'TotalAmount(value: $value, currency: $currency, valueWithCurrency: $valueWithCurrency)';
}

// class TotalAmount extends Equatable {
//   final double amount;
//   final String currency;
//   final String? valueWithCurrency;
//   const TotalAmount({
//     required this.amount,
//     required this.currency,
//     this.valueWithCurrency,
//   });

//   factory TotalAmount.fromMap(Map<String, dynamic> map) {
//     final valArr = (map['amount'] ?? 0.0).toStringAsFixed(2).split('-');
//     final val = double.tryParse(valArr.last ?? '0.00');
//     final valueWithCurrency =
//         '${WidgetsUtil.getCurrency(map['currency'])} ${val?.toStringAsFixed(2)}';

//     return TotalAmount(
//       amount: val!,
//       currency: map['currency'] ?? '',
//       valueWithCurrency: valueWithCurrency,
//     );
//   }

//   factory TotalAmount.fromJson(String source) =>
//       TotalAmount.fromMap(json.decode(source));

//   @override
//   List<Object?> get props => [amount, currency, valueWithCurrency];

//   @override
//   String toString() =>
//       'TotalAmount(amount: $amount, currency: $currency, valueWithCurrency: $valueWithCurrency)';
// }
