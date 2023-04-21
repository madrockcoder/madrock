import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:geniuspay/core/errors/error.dart';
import 'package:geniuspay/core/network/http_requester.dart';
import 'package:geniuspay/core/network/network_info.dart';
import 'package:geniuspay/models/country.dart';
import 'package:geniuspay/models/points_stat.dart';
import 'package:geniuspay/models/user.dart';
import 'package:geniuspay/models/user_profile.dart';
import 'package:geniuspay/repos/api_path.dart';
import 'package:geniuspay/repos/local_repo.dart';
import 'package:geniuspay/services/mixpanel_service.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../../util/essentials.dart';

abstract class AuthDataSourse {
  Future<List<Country>> fetchCountries();
  Future<List<Country>> seearchCountry(String keyword);
  Future<Country> searchCountryIso(String iso);
  Future<String> emailOTPSignIn({
    required String email,
    required String country,
    required String citizenship,
    required String birthCountry,
    String? invitationCode,
  });
  Future<String> emailOTPLogin({
    required String email,
  });
  Future<String> lockUserAccount({
    required String userId,
  });

  Future<bool> checkEmailExists(String email);
  Future<String> verifyOTP({required String email, required String otp});
  Future<bool> verifyPin({required String userId, required String pin});

  Future<String> changeMobileNumber({
    required String mobileNumber,
    required String userId,
    required String mobileNumberId,
  });
  Future<bool> checkMobileNumberExists({
    required String mobileNumber,
  });
  Future<String> sendMobileNumberOtp({required String accountId, required String mobileNumber});
  Future<bool> confirmMobileNumberOtp({required String mobileNumber, required String otp, required String accountId});
  Future<String> setPIN({required String uid, required String pin});
  Future<User> getUser();
  Future<String> updateUserCountry(String country, String citizenship, String birthCountry);
  Future<bool> isPermittedCountry(String countryISO);

  Future<String> addWaitlistUser(String email, String country);

  Future<bool> closeAccountCheck(String uid);

  Future<String> closeAccount(String uid, String reason);
  Future<void> setUserDeviceInfo(User? user, String token);
  Future<String> updatePassCode(String accountId, String oldPassCode, String newPassCode);
  Future<String> getSupportPIN(String accountId);

  Future<String> uploadAddressProof(String accountId, String proofType, String base64);
  Future<List<PointStat>> getPoints(String accountId);
  Future<bool> joinBeta(String accountId);
  Future<bool> checkAuthToken(String token);
  Future<String> updateUserCurrency(String currency, String accountId);
  Future<String> uploadAvatar(String accountId, String base64);
}

@LazySingleton(as: AuthDataSourse)
class AuthDataSourseImpl implements AuthDataSourse {
  AuthDataSourseImpl({required this.networkInfo, required this.localDataStorage, required this.dio, required this.httpClient})
      : super();

  final NetworkInfo networkInfo;
  final LocalBase localDataStorage;
  final Dio dio;
  final HttpServiceRequester httpClient;

  @override
  Future<String> getSupportPIN(String accountId) async {
    if (await networkInfo.isConnected) {
      final result = await httpClient.getRequest(endpoint: APIPath.getSupportPIN(accountId));
      return result.data['support_pin'];
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<bool> joinBeta(String accountId) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      final result =
          await httpClient.post(endpoint: APIPath.joinBeta, uuid: uuid, body: {"user": accountId, "opt_for_beta_testing": true});
      return result.data['opt_for_beta_testing'];
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<bool> checkEmailExists(String email) async {
    if (await networkInfo.isConnected) {
      final result = await httpClient.getRequest(endpoint: APIPath.checkEmailExists(email));
      debugPrint('hey $result');
      return result.data['status'];
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<bool> checkAuthToken(String token) async {
    if (await networkInfo.isConnected) {
      final result = await httpClient.getRequest(endpoint: APIPath.checkAuthToken(token), removeToken: true);
      return result.data['status'];
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<String> emailOTPSignIn({
    required String email,
    required String country,
    required String citizenship,
    required String birthCountry,
    String? invitationCode,
  }) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      final data = {
        "email": email,
        "invite_code": invitationCode ?? 'DIRECT',
        "country": country,
        "citizenship": citizenship,
        "country_of_birth": birthCountry,
      };
      final result = await httpClient.post(
        uuid: uuid,
        endpoint: APIPath.emailOTPSignIn,
        body: data,
      );

      final body = result.data['detail'];

      return body;
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<List<Country>> fetchCountries() async {
    if (await networkInfo.isConnected) {
      final result = await httpClient.getRequest(endpoint: APIPath.fetchCountries('50'));
      final body = result.data['results'];

      return CountrylList.fromJson(body).list;
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<List<Country>> seearchCountry(String keyword) async {
    if (await networkInfo.isConnected) {
      final result = await httpClient.getRequest(endpoint: APIPath.searchCountries(keyword));
      final body = result.data['results'];

      return CountrylList.fromJson(body).list;
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<Country> searchCountryIso(String keyword) async {
    if (await networkInfo.isConnected) {
      final result = await httpClient.getRequest(endpoint: APIPath.searchCountryIso(keyword));
      final body = result.data['results'];
      return CountrylList.fromJson(body).list.first;
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<String> verifyOTP({required String email, required String otp}) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      final result = await httpClient.post(
        uuid: uuid,
        endpoint: APIPath.verifyOTP,
        body: {
          'email': email,
          'token': otp,
        },
      );

      final token = result.data['token'];
      localDataStorage.setToken(token);
      return token;
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<bool> checkMobileNumberExists({
    required String mobileNumber,
  }) async {
    if (await networkInfo.isConnected) {
      final result = await httpClient.getRequest(endpoint: APIPath.checkMobileNumberExists(mobileNumber));
      return result.data['status'];
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<String> sendMobileNumberOtp({required String accountId, required String mobileNumber}) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      // final getNumber = await httpClient.getRequest(
      //   endpoint: APIPath.getMobileNumber(id),
      // );
      // var newResult = getNumber.data['results'] as List;
      // final number = UserProfileMobileNumber.fromMap(newResult.first);
      final result = await httpClient
          .post(uuid: uuid, endpoint: APIPath.authorizeMobileNumber(accountId), body: {"number": mobileNumber, "channel": "sms"});
      return result.data['id'];
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<bool> confirmMobileNumberOtp({required String mobileNumber, required String otp, required String accountId}) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      final result = await httpClient
          .post(endpoint: APIPath.confirmMobileNumber(accountId), uuid: uuid, body: {"number": mobileNumber, "token": otp});
      return result.data['verified'];
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<String> changeMobileNumber(
      {required String mobileNumber, required String userId, required String mobileNumberId}) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      final result = await httpClient.putRequest(
        uuid: uuid,
        endpoint: APIPath.changeMobileNumber(mobileNumberId),
        body: {'number': mobileNumber, 'user': userId},
      );

      return '';
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<String> setPIN({
    required String uid,
    required String pin,
  }) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      final result = await httpClient.post(
        uuid: uuid,
        endpoint: APIPath.setPIN,
        body: {"user": uid, "passcode": pin},
      );
      return '';
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<User> getUser() async {
    if (await networkInfo.isConnected) {
      final result = await httpClient.getRequest(endpoint: APIPath.getUser);
      // final channel = await httpClient.getWebsocketStream(
      //     endpoint: APIPath.webSocketStream);
      // channel.stream.listen((message) {
      //   print('received');
      //   channel.sink.add('received!');
      // }, onError: (err) {
      //   print('ERROR');
      //   print(err);
      // });
      UserProfileMobileNumber? newMobileNumber;
      // if (result.data['profile']['mobile_number'] != null) {

      //   final mobileNumberNumber = await httpClient.getRequest(
      //     endpoint:
      //         APIPath.getMobileNumber(result.data['profile']['mobile_number']),
      //   );
      //   newMobileNumber =
      //       UserProfileMobileNumber.fromMap(mobileNumberNumber.data);
      // }
      log(result.data.toString());
      // print(result.data['profile']['verification_status']);
      // print(result.data['profile']['earnings']);
      final user = User.fromMap(result.data);

      MixPanelService.setUserIdentifier(user.id); // set user id
      MixPanelService.setOnceProperty({
        'name': user.name,
        'email': user.email,
      }); // set once property
      MixPanelService.updateUserActivity('LoggedIn');
      return user;
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<String> emailOTPLogin({required String email}) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();

      // var checkResult =
      //     await httpClient.getRequest(endpoint: APIPath.checkIdempotency(uuid));
      // var checkUuid = checkResult.data['result'] as bool;
      // if (checkUuid) {
      final result = await httpClient.post(
        uuid: uuid,
        endpoint: APIPath.emailOTPSignIn,
        body: {
          "email": email,
        },
      );
      // }

      // final body = result.data['detail'];

      return 'body';
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<bool> verifyPin({
    required String userId,
    required String pin,
  }) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      final result = await httpClient.post(
        uuid: uuid,
        endpoint: APIPath.verifyUserPin(userId),
        body: {"passcode": pin},
      );
      return result.data;
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<String> lockUserAccount({required String userId}) async {
    // TODO: implement lockUserAccount
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      final result = await httpClient.post(
        uuid: uuid,
        endpoint: APIPath.lockUserAcc(userId),
        body: null,
      );

      return '';
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<String> updateUserCountry(String country, String citizenship, String birthCountry) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      final data = {
        "country": country,
        "citizenship": citizenship,
        "country_of_birth": birthCountry,
      };
      final result = await httpClient.post(uuid: uuid, endpoint: APIPath.updateUserCountry, body: data);
      final body = result.data['country'];
      return body;
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<String> updateUserCurrency(String currency, String accountId) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      final data = {
        "default_currency": currency,
      };
      final result = await httpClient.post(uuid: uuid, endpoint: APIPath.updateProfile(accountId), body: data);
      final body = result.data['default_currency'];
      return body;
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<bool> isPermittedCountry(String countryISO) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      final result = await httpClient.getRequest(
        endpoint: APIPath.permittedCountry(countryISO),
      );
      final body = result.data['accept_signup'];
      return body;
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<String> addWaitlistUser(String email, String country) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      final result = await httpClient.post(uuid: uuid, endpoint: APIPath.addWaitlistUser, body: {
        "email": email,
        "country": country,
      });
      return result.data.toString();
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<bool> closeAccountCheck(String uid) async {
    if (await networkInfo.isConnected) {
      final result = await httpClient.getRequest(endpoint: APIPath.closeAccountCheck(uid));
      final body = result.data['can_close'];
      if ("$body".contains('true')) {
        return true;
      } else {
        return false;
      }
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<String> closeAccount(String uid, String reason) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      final result = await httpClient.post(endpoint: APIPath.closeAccount(uid), uuid: uuid, body: {"reason_for_closure": reason});
      return result.data['id'];
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<void> setUserDeviceInfo(User? user, String token) async {
    if (await networkInfo.isConnected) {
      String device = Platform.isIOS ? 'ios' : 'android';
      var uuid = const Uuid().v4();
      Map<String, dynamic> data = {
        "name": user?.name,
        "registration_id": token,
        "device_id": user?.id,
        "active": true,
        "type": device
      };
      final result = await httpClient.post(endpoint: APIPath.setUserDeviceInfo, uuid: uuid, body: data);
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<String> updatePassCode(String accountId, String oldPassCode, String newPassCode) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      final result = await httpClient.post(
          endpoint: APIPath.updatePIN(accountId), uuid: uuid, body: {"authorization_code": oldPassCode, "passcode": newPassCode});
      return result.data['id'];
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<String> uploadAddressProof(String accountId, String proofType, String base64) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      final result = await httpClient.post(
          endpoint: APIPath.uploadAddressProof,
          uuid: uuid,
          body: {"user": accountId, "address_proof_type": proofType, "address_proof_document": base64});
      return result.data['id'];
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<List<PointStat>> getPoints(String accountId) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      final result = await httpClient.getRequest(endpoint: APIPath.getPointsList(accountId));
      return PointsList.fromJson(result.data['results']).list;
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<String> uploadAvatar(String accountId, String base64) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      final result = await httpClient.post(endpoint: APIPath.uploadAvatar(accountId), uuid: uuid, body: {"avatar": base64});
      return result.data['avatar'];
    } else {
      throw NoInternetException();
    }
  }
}
