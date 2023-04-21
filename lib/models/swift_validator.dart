import 'dart:convert';

import 'package:equatable/equatable.dart';

class SwiftValidatorModel extends Equatable {
  final String swiftCode;
  final String? country;
  final String institutionName;
  final String? city;
  final String? branch;

  const SwiftValidatorModel(
      {required this.swiftCode,
      required this.country,
      required this.institutionName,
      this.city,
      this.branch});

  Map<String, String> toMap() {
    return {
      'Bank name': institutionName,
      if (city != null && city!.isNotEmpty) 'City': city!,
      if (branch != null && branch!.isNotEmpty) 'Branch': branch!,
      if (country != null && country!.isNotEmpty) 'Country': country!
    };
  }

  factory SwiftValidatorModel.fromMap(Map<String, dynamic> map) {
    return SwiftValidatorModel(
        swiftCode: map['swift_code'],
        country: map['country'],
        institutionName: map['institution_name'],
        city: map['city'],
        branch: map['branch']);
  }
  String toJson() => json.encode(toMap());

  @override
  List<Object> get props {
    return [];
  }
}
