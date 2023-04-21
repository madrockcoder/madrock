import 'package:equatable/equatable.dart';
import 'package:geniuspay/util/enums.dart';

class VerificationStatusResponse extends Equatable {
  final String id;
  final KYCVerificationStatus verificationStatus;
  final String startedTime;
  final String submittedTime;
  final String acceptanceTime;
  final String decisionTime;

  const VerificationStatusResponse(
      {required this.id,
      required this.verificationStatus,
      required this.startedTime,
      required this.submittedTime,
      required this.acceptanceTime,
      required this.decisionTime});

  factory VerificationStatusResponse.fromMap(Map<String, dynamic> map) {
    return VerificationStatusResponse(
      id: map['id'] ?? '',
      verificationStatus: getVerificationStatusEnum(map['verification_status']),
      startedTime: map['started_time'] ?? '',
      submittedTime: map['submitted_time'] ?? '',
      acceptanceTime: map['acceptance_time'] ?? '',
      decisionTime: map['decision_time'] ?? '',
    );
  }

  @override
  List<Object> get props {
    return [id, verificationStatus];
  }
}

KYCVerificationStatus getVerificationStatusEnum(String verifStatus) {
  switch (verifStatus) {
    case 'VERIFIED':
      return KYCVerificationStatus.verified;
    case 'ID_VERIFIED':
      return KYCVerificationStatus.verified;
    case 'PENDING':
      return KYCVerificationStatus.pending;
    case 'IDV_PENDING':
      return KYCVerificationStatus.pending;
    case 'IDV_SUBMITTED':
      return KYCVerificationStatus.idSumbitted;
    case 'REJECTED':
      return KYCVerificationStatus.rejected;
    default:
      return KYCVerificationStatus.pending;
  }
}
