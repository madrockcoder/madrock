import 'package:equatable/equatable.dart';

import 'country.dart';

class CountryFX extends Equatable {
  final Country country;
  final String currency;
  final String currencyISO;
  final double amount;
  final double percentage;
  const CountryFX({
    required this.country,
    required this.currency,
    required this.currencyISO,
    required this.amount,
    required this.percentage,
  });

  @override
  List<Object> get props {
    return [
      country,
      currency,
      currencyISO,
      amount,
      percentage,
    ];
  }

  @override
  String toString() {
    return 'FX(country: $country, currency: $currency, currencyISO: $currencyISO, amount: $amount, percentage: $percentage)';
  }
}
