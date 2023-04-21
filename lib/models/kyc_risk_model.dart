import 'package:equatable/equatable.dart';

class KycRiskAssessment extends Equatable {
  const KycRiskAssessment({
    required this.avgTransactionSize,
    required this.employmentStatus,
    required this.fatcaRelevant,
    this.foreignResidencyTin,
    required this.occupation,
    required this.overseasTransaction,
    required this.pep,
    this.pepType,
    this.pepNotes,
    this.screeningMonitoredSearch,
    required this.sourceofFunds,
    required this.uid,
    required this.usCitizenTaxResident,
    required this.accountPurpose,
  });

  final String uid;
  final String employmentStatus;
  final List<String> sourceofFunds;
  final List<String> accountPurpose;
  final String occupation;
  final bool pep;
  final List<String>? foreignResidencyTin;
  final String? pepType;
  final bool fatcaRelevant;
  final List<String> overseasTransaction;
  final String avgTransactionSize;
  final String? pepNotes;
  final String? screeningMonitoredSearch;
  final bool usCitizenTaxResident;

  Map<String, dynamic> toMap({required bool pep}) {
    if (pep) {
      return {
        "user": uid,
        "employment_status": employmentStatus,
        "source_of_funds": sourceofFunds,
        "pep": pep,
        "pep_type": pepType,
        "fatca_relevant": fatcaRelevant,
        "avg_transaction_size": avgTransactionSize,
        "overseas_transactions": overseasTransaction,
        "occupation": occupation,
        "us_citizen_tax_resident": usCitizenTaxResident,
        // "foreign_residency_tin": foreignResidencyTin,
        'account_purpose': accountPurpose,
      };
    } else {
      return {
        "user": uid,
        "employment_status": employmentStatus,
        "source_of_funds": sourceofFunds,
        "pep": pep,
        "fatca_relevant": fatcaRelevant,
        "avg_transaction_size": avgTransactionSize,
        "overseas_transactions": overseasTransaction,
        "occupation": occupation,
        "us_citizen_tax_resident": usCitizenTaxResident,
        // "foreign_residency_tin": foreignResidencyTin,
        'account_purpose': accountPurpose,
      };
    }
  }

  factory KycRiskAssessment.fromMap(Map<String, dynamic> map) {
    return KycRiskAssessment(
      avgTransactionSize: map[''],
      employmentStatus: map[''],
      fatcaRelevant: map[''],
      occupation: map[''],
      overseasTransaction: map[''],
      pep: map[''],
      sourceofFunds: map[''],
      uid: map[''],
      usCitizenTaxResident: map[''],
      accountPurpose: map[''],
    );
  }
  @override
  List<Object> get props => [
        avgTransactionSize,
        employmentStatus,
        fatcaRelevant,
        occupation,
        overseasTransaction,
        pep,
        sourceofFunds,
        uid,
        usCitizenTaxResident,
      ];
}
