// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:geniuspay/models/user_profile.dart';

class WalletAccountDetails extends Equatable {
  final String? id;
  final String currency;
  final String? account_holder_name;
  final String? status;
  final List<FundingAccounts> funding_accounts;

  const WalletAccountDetails({
    this.id,
    required this.currency,
    this.account_holder_name,
    required this.status,
    required this.funding_accounts,
  });

  @override
  List<Object> get props {
    return [currency, funding_accounts];
  }

  Map<String, dynamic> toMap() {
    return {
      // 'walletId': walletId,
      'id': id,
      'currency': currency,
      'account_holder_name': account_holder_name,
      'status': status,
      'funding_accounts': funding_accounts,
    };
  }

  String toJson() => json.encode(toMap());

  factory WalletAccountDetails.fromMap(Map<String, dynamic> map) {
    return WalletAccountDetails(
      id: map['id'] ?? '',
      currency: map['currency'] ?? '',
      account_holder_name: map['account_holder_name'] ?? '',
      status: map['status'] ?? '',
      funding_accounts: map['funding_accounts'] == null
          ? []
          : List<FundingAccounts>.from(
              map['funding_accounts']?.map((x) => FundingAccounts.fromMap(x))),
    );
  }

  factory WalletAccountDetails.fromJson(String source) =>
      WalletAccountDetails.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WalletAccountDetails(id: $id, currency: $currency, account_holder_name: $account_holder_name, status: $status, funding_accounts: $funding_accounts)';
  }
}

class WalletAccountDetailsList {
  WalletAccountDetailsList({required this.list});

  factory WalletAccountDetailsList.fromJson(List parsedJson) {
    final list = parsedJson.map((value) {
      return WalletAccountDetails.fromMap(value);
    }).toList();
    return WalletAccountDetailsList(list: list);
  }

  final List<WalletAccountDetails> list;
}

String _getAccountNumberType(String accNo) {
  if (accNo == 'ACCOUNT_NUMBER') {
    return 'Account Number';
  } else {
    return accNo;
  }
}

String _getLocalOrInternational(String paymentType) {
  if (paymentType == 'REGULAR') {
    return 'Local';
  } else if (paymentType == 'PRIORITY') {
    return 'International';
  } else {
    return 'Local';
  }
}

class FundingAccounts extends Equatable {
  final String? bank_name;
  final Address bank_address;
  final String? payment_type;
  final String identifier_type;
  final String identifier_value;
  final String account_number_type;
  final String account_number;
  final String? status;
  final String localOrInternational;
  const FundingAccounts({
    this.bank_name,
    required this.bank_address,
    this.payment_type,
    required this.identifier_type,
    required this.identifier_value,
    required this.account_number_type,
    required this.account_number,
    required this.localOrInternational,
    this.status,
  });

  bool get isLocal => localOrInternational.toLowerCase() == "local";

  factory FundingAccounts.fromMap(Map<String, dynamic> map) {
    return FundingAccounts(
        bank_name: map['bank_name'] ?? '',
        bank_address: Address.fromMap(map['bank_address']),
        payment_type: map['payment_type'] ?? '',
        identifier_type: map['identifier_type'] ?? '',
        identifier_value: map['identifier_value'] ?? '',
        account_number_type:
            _getAccountNumberType(map['account_number_type'] ?? ''),
        account_number: map['account_number'] ?? '',
        status: map['status'] ?? '',
        localOrInternational:
            _getLocalOrInternational(map['payment_type'] ?? ''));
  }

  factory FundingAccounts.fromJson(String source) =>
      FundingAccounts.fromMap(json.decode(source));

  @override
  List<Object> get props => [
        bank_address,
        identifier_type,
        identifier_value,
        account_number,
      ];

  @override
  String toString() =>
      'FundingAccounts(bank_name: $bank_name, bank_address: $bank_address,payment_type: $payment_type, identifier_type: $identifier_type,identifier_value: $identifier_value, account_number_type: $account_number_type,account_number: $account_number, status: $status)';
}
