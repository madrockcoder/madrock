import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'country.dart';

class TaxCountry extends Equatable {
  final String userID;
  final String nationalID;
  final Country country;
  final String tin;
  final String? reasonNoTin;
  final bool? primary;
  const TaxCountry({
    required this.userID,
    required this.nationalID,
    required this.country,
    required this.tin,
    this.reasonNoTin,
    this.primary = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'user': userID,
      'country': country.iso2,
      if (nationalID.isNotEmpty) 'id_card_number': nationalID,
      if (tin.isNotEmpty) 'number': tin,
      if (tin.isEmpty) 'reason_no_tin': reasonNoTin,
      'primary': primary,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object> get props {
    return [
      userID,
      country,
      tin,
    ];
  }

  @override
  String toString() {
    return 'TaxCountry(userID: $userID, nationalID: $nationalID, country: $country, tin: $tin, reasonNoTin: $reasonNoTin, primary: $primary)';
  }
}
