import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:geniuspay/models/user_profile.dart';
import 'package:geniuspay/util/enums.dart';

class BankBeneficiaryRequirements extends Equatable {
  String? bankAccountCountryIso2;
  BankRecipientType beneficiaryEntityType;
  PaymentType paymentType;

  // BankBankRecipientType bankBankRecipientType;
  Address? beneficiaryAddress;

  String? beneficiaryCountry;
  String? bankCode;
  String? branchCode;

  String? iBan;
  String? bicSwift;
  String? accountNumber;
  String? sortCode;
  String? bsbCode;
  String? ifsc;
  String? aba;
  String? cnaps;
  String? clabe;

  String? institutionCode;

  BankBeneficiaryRequirements({
    this.bankAccountCountryIso2,
    required this.beneficiaryEntityType,
    required this.paymentType,
    this.accountNumber,
    this.iBan,
    this.bicSwift,
    this.sortCode,
    this.bsbCode,
    this.ifsc,
    // BankBankRecipientType bankBankRecipientType,
    this.beneficiaryAddress,
    this.beneficiaryCountry,
    this.bankCode,
    this.branchCode,
    this.aba,
    this.cnaps,
    this.clabe,
    this.institutionCode,
  });

  Map<String, dynamic> toMap() {
    return {};
  }

  factory BankBeneficiaryRequirements.fromMap(Map<String, dynamic> map) {
    return BankBeneficiaryRequirements(
        accountNumber: map['acct_number'] as String,
        iBan: map['iban'] as String,
        sortCode: map['sort_code'] as String,
        bsbCode: map['bsb_code'] as String,
        ifsc: map['ifsc'] as String,
        bankAccountCountryIso2: map['bank_account_country'] as String,
        bicSwift: map['bic_swift'] as String,
        aba: map['aba'] as String,
        cnaps: map['cnaps'] as String,
        clabe: map['clabe'] as String,
        beneficiaryCountry: map['beneficiary_country'] as String,
        beneficiaryAddress: map['beneficiary_address'] == null
            ? null
            : Address(
                id: 'id',
                addressLine1: map['beneficiary_address'] as String,
                state: map['beneficiary_state_or_province'] as String,
                city: map['beneficiary_city'] as String,
                countryIso2: map['beneficiary_country'] as String,
                status: 'status',
                zipCode: map['beneficiary_zip_code'] as String,
                addressLine2: '',
              ),
        bankCode: map['bank_code'] as String,
        branchCode: map['branch_code'] as String,
        beneficiaryEntityType: map['beneficiary_entity_type'] == 'individual'
            ? BankRecipientType.individual
            : BankRecipientType.company,
        institutionCode: map['institution_no'] as String,
        paymentType: map['payment_type'] == 'priority'
            ? PaymentType.priority
            : PaymentType.regular);
  }

  String toJson() => json.encode(toMap());

  factory BankBeneficiaryRequirements.fromJson(String source) =>
      BankBeneficiaryRequirements.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props {
    return [];
  }
}

class BankBeneficiaryRequirementsList {
  BankBeneficiaryRequirementsList({required this.list});

  factory BankBeneficiaryRequirementsList.fromJson(List parsedJson) {
    final list = parsedJson.map((value) {
      return BankBeneficiaryRequirements.fromMap(value as Map<String, dynamic>);
    }).toList();
    return BankBeneficiaryRequirementsList(list: list);
  }

  final List<BankBeneficiaryRequirements> list;
}
