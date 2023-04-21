import 'dart:convert';

import 'package:equatable/equatable.dart';

class IfscValidatorModel extends Equatable {
  final String institutionName;
  final String? branch;
  final String? bankAddress;
  final String? city;
  final String? country;

  const IfscValidatorModel(
      {required this.country,
      required this.institutionName,
      this.bankAddress,
      this.city,
      this.branch});

  Map<String, String> toMap() {
    return {
      'Bank name': institutionName,
      if (bankAddress != null && bankAddress!.isNotEmpty)
        'Address': bankAddress!,
      if (city != null && city!.isNotEmpty) 'City': city!,
      if (branch != null && branch!.isNotEmpty) 'Branch': branch!,
      if (country != null && country!.isNotEmpty) 'Country': country!
    };
  }

  factory IfscValidatorModel.fromMap(Map<String, dynamic> map) {
    return IfscValidatorModel(
        country: map['country'],
        institutionName: map['institution_name'],
        bankAddress: map['address'],
        city: map['city'],
        branch: map['branch']);
  }
  String toJson() => json.encode(toMap());

  @override
  List<Object> get props {
    return [];
  }
}
