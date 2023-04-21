import 'package:dio/dio.dart';
import 'package:geniuspay/core/errors/error.dart';
import 'package:geniuspay/core/network/http_requester.dart';
import 'package:geniuspay/core/network/network_info.dart';
import 'package:geniuspay/models/kyc.dart';
import 'package:geniuspay/models/kyc_address.dart';
import 'package:geniuspay/models/kyc_risk_model.dart';
import 'package:geniuspay/models/tin.dart';
import 'package:geniuspay/models/verification_status_response.dart';
import 'package:geniuspay/repos/api_path.dart';
import 'package:geniuspay/repos/local_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

abstract class KycDataSource {
  Future<String> initialiseKYC(KYC kyc);
  Future<String> kycRisk(KycRiskAssessment kyc);
  Future<String> kycTaxAssesment(TIN tin);
  Future<String> kycAddressVerification(KYCAddress address);
  Future<VerificationStatusResponse> getKycVerificationStatus(String uid);
  Future<String> enterManualDetails(
      String uid, String firstName, String lastName, String DOB);
  Future<String> choosePlan({
    required String uid,
    required String planString,
  });
}

@LazySingleton(as: KycDataSource)
class KycDataSourceImpl implements KycDataSource {
  KycDataSourceImpl(
      {required this.networkInfo,
      required this.localDataStorage,
      required this.dio,
      required this.httpClient})
      : super();

  final NetworkInfo networkInfo;
  final LocalBase localDataStorage;
  final Dio dio;
  final HttpServiceRequester httpClient;

  @override
  Future<String> initialiseKYC(KYC kyc) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();

      final result = await httpClient.post(
        uuid: uuid,
        endpoint: APIPath.initialiseKYC,
        body: kyc.toMap(),
      );
      final body = result.data['url'];
      return body;
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<String> kycRisk(KycRiskAssessment kyc) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      // final result = await httpClient.post(
      //   uuid: uuid,
      //   endpoint: APIPath.kycRisk,
      //   body: kyc.toMap(),
      // );
      // final body = result.data['id '];
      final result = await httpClient.post(
        uuid: uuid,
        endpoint: APIPath.kycRisk,
        body: kyc.toMap(pep: kyc.pep),
      );
      return result.data['id'];
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<String> kycTaxAssesment(TIN tin) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      final result = await httpClient.post(
          uuid: uuid, endpoint: APIPath.taxResidence, body: tin.toMap());
      final body = result.data['id'];

      return body;
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<String> kycAddressVerification(KYCAddress address) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      final result = await httpClient.post(
        uuid: uuid,
        endpoint: APIPath.kycAddressVerification,
        body: {
          "user": address.userId,
          "address_line_1": address.addressLine1,
          "state_or_province": address.state,
          "zip_code": address.postCode,
          "city": address.city
        },
      );
      final body = result.data;
      return body['address'];
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<VerificationStatusResponse> getKycVerificationStatus(
      String uid) async {
    if (await networkInfo.isConnected) {
      final result = await httpClient.getRequest(
        endpoint: APIPath.getKycVerificationStatus(uid),
      );
      final body = result.data;
      return VerificationStatusResponse.fromMap(body);
      // final result = await httpClient.getRequest(endpoint: APIPath.getUser);
      // final user = User.fromMap(result.data);
      // return user.userProfile.verificationStatus;
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<String> enterManualDetails(
      String uid, String firstName, String lastName, String DOB) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      final result = await httpClient.post(
        uuid: uuid,
        endpoint: APIPath.kycEnterManualDetails,
        body: {
          "first_name_user_provided": firstName,
          "last_name_user_provided": lastName,
          "birth_date_user_provided": DOB,
          "user": uid
        },
      );
      final body = result.data;
      return body['id'];
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<String> choosePlan({
    required String uid,
    required String planString,
  }) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      // final payload = userType == UserType.business
      //     ? {
      //         // "account_type": userType.name.toUpperCase(),
      //         "business_type": businessType == BusinessType.company
      //             ? 'LEGAL_ENTITY'
      //             : 'FREELANCER',
      //         "subscription_plan": planName.toUpperCase()
      //       }
      //     : {
      //         // "account_type": userType.name.toUpperCase(),
      //         "subscription_plan": planName.toUpperCase()
      //       };
      final payload = {
        // "account_type": userType.name.toUpperCase(),
        "subscription_plan": planString
      };

      final result = await httpClient.post(
        uuid: uuid,
        endpoint: APIPath.choosePlan(uid),
        body: payload,
      );
      final body = result.data;
      return body['subscription_plan'];
    } else {
      throw NoInternetException();
    }
  }
}
