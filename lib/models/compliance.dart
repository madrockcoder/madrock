import 'dart:convert';

import 'package:equatable/equatable.dart';

class Compliance extends Equatable {
  const Compliance({
    required this.uid,
    required this.sourceOfFunds,
    required this.isPep,
    required this.fatca,
    required this.employmentStatus,
    required this.occupation,
    required this.avgTransactionSize,
    required this.overseasTransactions,
    this.pepType,
  });

  final String uid;
  final List<String> sourceOfFunds;
  final bool isPep;
  final String? pepType;
  final bool fatca;
  final String employmentStatus;
  final String occupation;
  final String avgTransactionSize;
  final List<String> overseasTransactions;

  Map<String, dynamic> toMap() {
    return {
      'user': uid,
      'source_of_funds': sourceOfFunds,
      'pep': isPep,
      if (isPep) 'pep_type': pepType,
      'fatca_relevant': fatca,
      'occupation': occupation,
      'employment_status': employmentStatus,
      'avg_transaction_size': avgTransactionSize,
      'overseas_transactions': overseasTransactions,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object> get props {
    return [
      uid,
      sourceOfFunds,
      isPep,
      fatca,
      employmentStatus,
      occupation,
      avgTransactionSize,
      overseasTransactions,
    ];
  }

  @override
  String toString() {
    return 'Compliance(uid: $uid, sourceOfFunds: $sourceOfFunds, isPep: $isPep, pepType: $pepType, fatca: $fatca, employmentStatus: $employmentStatus, occupation: $occupation, avgTransactionSize: $avgTransactionSize, overseasTransactions: $overseasTransactions)';
  }
}
