import 'package:equatable/equatable.dart';
import 'package:geniuspay/models/verification_status_response.dart';
import 'package:geniuspay/util/enums.dart';

class KYCVerification extends Equatable {
  final KYCAddressVerification? addressVerificatiom;
  // final KycRiskAssessment? riskAssessment;
  final KYCVerificationStatus? verificationStatus;

  const KYCVerification({
    this.addressVerificatiom,
    // this.riskAssessment,
    this.verificationStatus,
  });

  factory KYCVerification.fromMap(Map<String, dynamic> map) {
    return KYCVerification(
        addressVerificatiom: map['address_verification'] == null
            ? null
            : KYCAddressVerification.fromMap(map['address_verification']),
        // riskAssessment: KycRiskAssessment.fromMap(map['risk_assessment']),
        verificationStatus:
            getVerificationStatusEnum(map['verification_status']));
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class KYCAddressVerification extends Equatable {
  final String? status;
  final String? addressProof;

  const KYCAddressVerification(
      {required this.status, required this.addressProof});

  factory KYCAddressVerification.fromMap(Map<String, dynamic> map) {
    return KYCAddressVerification(
        status: map['status'], addressProof: map['address_proof_type']);
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
