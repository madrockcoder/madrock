import 'package:dartz/dartz.dart';
import 'package:geniuspay/core/errors/errors.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/models/kyc.dart';
import 'package:geniuspay/models/kyc_address.dart';
import 'package:geniuspay/models/kyc_risk_model.dart';
import 'package:geniuspay/models/tin.dart';
import 'package:geniuspay/models/verification_status_response.dart';
import 'package:geniuspay/repos/kyc_repository.dart';
import 'package:injectable/injectable.dart';

abstract class Kycservice {
  Future<Either<Failure, String>> initialiseKYC(KYC kyc);
  Future<Either<Failure, String>> kycRisk(KycRiskAssessment kyc);
  Future<Either<Failure, String>> kycTaxAssesment(TIN tin);
  Future<Either<Failure, String>> kycAddressVerification(KYCAddress address);
  Future<Either<Failure, VerificationStatusResponse>> getKycVerificationStatus(
      String uid);
  Future<Either<Failure, String>> enterManualDetails(
      String uid, String firstName, String lastName, String DOB);
  Future<Either<Failure, String>> choosePlan({
    required String uid,
    required String planString,
  });
}

@LazySingleton(as: Kycservice)
class KycserviceImpl extends Kycservice {
  final KycRepository _kycRepository = sl<KycRepository>();

  @override
  Future<Either<Failure, String>> initialiseKYC(KYC kyc) async {
    return _kycRepository.initialiseKYC(kyc);
  }

  @override
  Future<Either<Failure, String>> kycRisk(KycRiskAssessment kyc) {
    return _kycRepository.kycRisk(kyc);
  }

  @override
  Future<Either<Failure, String>> kycTaxAssesment(tin) {
    return _kycRepository.kycTaxAssesment(tin);
  }

  @override
  Future<Either<Failure, String>> kycAddressVerification(KYCAddress address) {
    return _kycRepository.kycAddressVerification(address);
  }

  @override
  Future<Either<Failure, VerificationStatusResponse>> getKycVerificationStatus(
      String uid) {
    return _kycRepository.getKycVerificationStatus(uid);
  }

  @override
  Future<Either<Failure, String>> enterManualDetails(
      String uid, String firstName, String lastName, String DOB) {
    return _kycRepository.enterManualDetails(uid, firstName, lastName, DOB);
  }

  @override
  Future<Either<Failure, String>> choosePlan({
    required String uid,
    required String planString,
  }) {
    return _kycRepository.choosePlan(uid: uid, planString: planString);
  }
}
