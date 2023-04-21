import 'dart:convert';

import 'package:equatable/equatable.dart';

class IbanValidatorModel extends Equatable {
  final bool isValid;
  final String iBan;
  final String? iBanCompact;
  final String? bban;
  final String? bankCode;
  final String? branchCode;
  final String? accountCode;
  final String? bankName;
  final String? bankShortName;
  final String? bic;
  final String? countryCode;

  const IbanValidatorModel(
      {required this.isValid,
      required this.iBan,
      this.iBanCompact,
      this.bban,
      this.bankCode,
      this.branchCode,
      this.accountCode,
      this.bankName,
      this.bankShortName,
      this.bic,
      this.countryCode});

  Map<String, String> toMap() {
    return {
      if (bic != null && bic!.isNotEmpty) 'BIC': bic!,
      if (bankName != null && bankName!.isNotEmpty) 'Bank name': bankName!,
      if (countryCode != null && countryCode!.isNotEmpty)
        'Country': countryCode!
    };
  }

  factory IbanValidatorModel.fromMap(Map<String, dynamic> map) {
    return IbanValidatorModel(
        isValid: map['is_valid'],
        iBan: map['iban'],
        bic: map['bic'],
        bankName: map['bank_name'],
        countryCode: map['country_code'],
        bankShortName: map['bank_short_name']);
  }
  String toJson() => json.encode(toMap());

  @override
  List<Object> get props {
    return [];
  }
}
