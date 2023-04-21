import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:geniuspay/models/user_profile.dart';
import 'package:geniuspay/util/enums.dart';

class BankBeneficiary extends Equatable {
  BankBeneficiary(
      {this.ownedByUser = false,
      this.id,
      required this.user,
      this.friendlyName,
      this.paymentType,
      required this.currency,
      required this.bankCountryIso2,
      this.isdefault,
      this.idenitifierType,
      this.identifierValue,
      required this.beneficiaryType,
      this.beneficiaryFirstName,
      this.beneficiaryLastName,
      this.companyName,
      this.accountNumber,
      this.iBan,
      this.bicSwift,
      this.sortCode,
      this.bsbCode,
      this.ifsc,
      this.beneficiaryAddress,
      required this.beneficiaryCountry,
      this.bankCode,
      this.branchCode,
      this.bankName,
      this.lastUsed,
      this.hashedIban});

  factory BankBeneficiary.fromMap(Map<String, dynamic> map) {
    return BankBeneficiary(
      id: map['id'] as String,
      user: map['user'] as String,
      friendlyName: map['friendly_name'] as String,
      currency: map['currency'] as String,
      isdefault: map['default'] as bool,
      bankCountryIso2: map['bank_country'] as String,
      identifierValue: map['identifier_value'] as String,
      beneficiaryType: map['beneficiary_entity_type'] == 'INDIVIDUAL'
          ? BankRecipientType.individual
          : BankRecipientType.company,
      beneficiaryFirstName: map['beneficiary_first_name'] as String,
      beneficiaryLastName: map['beneficiary_last_name'] as String,
      companyName: map['beneficiary_company_name'] as String,
      accountNumber: map['account_number'] as String,
      iBan: map['iban'] as String,
      hashedIban: map['hashed_iban'] as String,
      idenitifierType: map['identifier_type'] == null
          ? null
          : getIdentifierType(map['identifier_type'] as String),
      beneficiaryCountry: map['beneficiary_country'] as String,
      bankName: map['bank_name'] as String,
      lastUsed: map['last_used_at'] as String,
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
    );
  }

  factory BankBeneficiary.fromJson(String source) =>
      BankBeneficiary.fromMap(json.decode(source) as Map<String, dynamic>);
  bool ownedByUser;
  String? id;
  String user;
  String? friendlyName;
  PaymentType? paymentType;
  String currency;
  String bankCountryIso2;
  BankIdentifierType? idenitifierType;
  String? identifierValue;
  bool? isdefault;

  BankRecipientType beneficiaryType;
  String? beneficiaryFirstName;
  String? beneficiaryLastName;
  String? companyName;

  // BankBankRecipientType bankBankRecipientType;
  Address? beneficiaryAddress;

  String beneficiaryCountry;
  String? bankCode;
  String? branchCode;

  String? iBan;
  String? bicSwift;
  String? accountNumber;
  String? sortCode;
  String? bsbCode;
  String? ifsc;
  String? bankName;
  String? hashedIban;
  String? lastUsed;

  Map<String, dynamic> toMap() {
    return {};
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props {
    return [];
  }
}

class BankBeneficiaryList {
  BankBeneficiaryList({required this.list});

  factory BankBeneficiaryList.fromJson(List parsedJson) {
    final list = parsedJson.map((value) {
      return BankBeneficiary.fromMap(value as Map<String, dynamic>);
    }).toList();
    return BankBeneficiaryList(list: list);
  }

  final List<BankBeneficiary> list;
}

BankIdentifierType getIdentifierType(String id) {
  switch (id) {
    case 'SORT_CODE':
      return BankIdentifierType.sortCode;
    case 'BIC_SWIFT':
      return BankIdentifierType.bicSwift;
    case 'ROUTING_NUMBER':
      return BankIdentifierType.routingNo;
    case 'EMAIL':
      return BankIdentifierType.email;
    case 'BSB_CODE':
      return BankIdentifierType.bsbCode;
    case 'IFSC':
      return BankIdentifierType.ifsc;
    case 'NSC_NUMBER':
      return BankIdentifierType.nscNumber;
    case 'NCC_CODE':
      return BankIdentifierType.nccCode;
    case 'CLABE':
      return BankIdentifierType.clabe;
    case 'BRANCH_CODE':
      return BankIdentifierType.branchCode;
    case 'BANK_CODE':
      return BankIdentifierType.bankCode;
    case 'INSTITUTION_CODE':
      return BankIdentifierType.institutionCode;
    case 'ABA':
      return BankIdentifierType.aba;
    default:
      return BankIdentifierType.bicSwift;
  }
}
