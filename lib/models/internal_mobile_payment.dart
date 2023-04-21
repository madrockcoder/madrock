import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:geniuspay/app/auth/view_models/select_country_view_model.dart';
import 'package:geniuspay/core/injections/injections.dart';
import 'package:geniuspay/models/country.dart';
import 'package:geniuspay/models/total_amount.dart';

class InternalMobilePayment extends Equatable {
  final String country;
  final String mobileNetwork;
  final String payerID;
  final String payeeID;
  final TotalAmount amount;
  final String sendingReason;
  const InternalMobilePayment({
    required this.country,
    required this.sendingReason,
    required this.mobileNetwork,
    required this.payerID,
    required this.payeeID,
    required this.amount,
  });

  Map<String, dynamic> toMap() {
    return {
      "country": country,
      "mobile_network": mobileNetwork,
      "payer": payerID,
      "payee": payeeID,
      "currency": amount.currency,
      "amount": amount.value,
      "sending_reason": sendingReason
    };
  }

  String toJson() => json.encode(toMap());

  static Country countryModel(iso2){
    final SelectCountryViewModel _selectCountryViewModel =
    sl<SelectCountryViewModel>();
    Country countryModel = _selectCountryViewModel.countries
        .where((element) => element.iso2 == iso2)
        .first;
    return countryModel;
  }

  @override
  List<Object> get props {
    return [
      country,
      mobileNetwork,
      payerID,
      payeeID,
      amount,
      sendingReason
    ];
  }

  @override
  String toString() {
    return 'InternalPayment(payerID: $payerID, payeeID: $payeeID, amount: $amount)';
  }
}
