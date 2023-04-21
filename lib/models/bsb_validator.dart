import 'dart:convert';

import 'package:equatable/equatable.dart';

class BsbValidatorModel extends Equatable {
  final String institutionName;

  final String? bankAddress;
  final String? city;
  final String? state;

  const BsbValidatorModel({
    required this.state,
    required this.institutionName,
    this.bankAddress,
    this.city,
  });

  Map<String, String> toMap() {
    return {
      'Bank name': institutionName,
      if (bankAddress != null && bankAddress!.isNotEmpty)
        'Address': bankAddress!,
      if (city != null && city!.isNotEmpty) 'City': city!,
      if (state != null && state!.isNotEmpty) 'state': state!
    };
  }

  factory BsbValidatorModel.fromMap(Map<String, dynamic> map) {
    return BsbValidatorModel(
      state: map['state'] as String,
      institutionName: map['name'] as String,
      bankAddress: map['address'] as String,
      city: map['city'] as String,
    );
  }
  String toJson() => json.encode(toMap());

  @override
  List<Object> get props {
    return [];
  }
}
