import 'package:dartz/dartz.dart';
import 'package:geniuspay/core/errors/errors.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/models/country.dart';
import 'package:geniuspay/models/points_stat.dart';
import 'package:geniuspay/models/user.dart';
import 'package:geniuspay/repos/auth_repo/auth_repository.dart';
import 'package:injectable/injectable.dart';

abstract class AuthenticationService {
  List<Country> _countries = <Country>[];
  List<Country> get countries => _countries;
  User? _user;
  User? get user => _user;
  Future<Either<Failure, List<Country>>> fetchCountries();
  Future<Either<Failure, List<Country>>> searchCountry(String keyword);
  Future<Either<Failure, Country>> searchCountryIso(String iso);
  Future<Either<Failure, bool>> checkEmailExists(String email);
  Future<Either<Failure, String>> lockUserAccount();

  Future<Either<Failure, String>> emailOTPSignIn({
    required String email,
    required String country,
    required String citizenship,
    required String birthCountry,
    String? invitationCode,
  });
  Future<Either<Failure, String>> emailOTPLogin({
    required String email,
  });
  Future<Either<Failure, User>> getUser();
  Future<Either<Failure, String>> verifyOTP({
    required String email,
    required String otp,
  });
  Future<Either<Failure, bool>> checkMobileNumberExists({
    required String mobileNumber,
  });
  Future<Either<Failure, String>> sendMobileNumberOtp({required String accountId, required String mobileNumber});
  Future<Either<Failure, bool>> confirmMobileNumberOtp(
      {required String mobileNumber, required String otp, required String accountId});
  Future<Either<Failure, String>> changeMobileNumber({
    required String mobileNumber,
    required String mobileNumberId,
  });
  Future<Either<Failure, String>> setPIN({required String pin});
  Future<Either<Failure, bool>> verifyPin({required String pin});
  Future<Either<Failure, String>> updateUserCountry(String country, String citizenship, String birthCountry);
  Future<Either<Failure, bool>> isPermittedCountry(String countryISO);
  Future<Either<Failure, String>> addWaitlistUser(String email, String country);
  Future<Either<Failure, bool>> closeAccountCheck(String uid);

  Future<Either<Failure, String>> closeAccount(String uid, String reason);
  Future<Either<Failure, void>> setUserDeviceInfo(User? user, String token);
  Future<Either<Failure, String>> updatePassCode(String accountId, String oldPassCode, String newPassCode);
  Future<Either<Failure, String>> getSupportPIN(String accountId);
  Future<Either<Failure, String>> uploadAddressProof(String accountId, String proofType, String base64);
  Future<Either<Failure, List<PointStat>>> getPoints(String accountId);
  Future<Either<Failure, bool>> joinBeta(String accountId);
  Future<Either<Failure, bool>> checkAuthToken(String token);
  Future<Either<Failure, String>> updateUserCurrency(String currency, String accountId);
  Future<Either<Failure, String>> uploadAvatar(String accountId, String base64);
}

@LazySingleton(as: AuthenticationService)
class AuthenticationServiceImpl extends AuthenticationService {
  final AuthRepository _authRepository = sl<AuthRepository>();

  @override
  Future<Either<Failure, List<Country>>> fetchCountries() async {
    final result = await _authRepository.fetchCountries();
    result.fold((l) => null, (r) {
      _countries = r;
    });

    return result;
  }

  @override
  Future<Either<Failure, List<Country>>> searchCountry(String keyword) {
    return _authRepository.searchCountry(keyword);
  }

  @override
  Future<Either<Failure, Country>> searchCountryIso(String iso) {
    return _authRepository.searchCountryIso(iso);
  }

  @override
  Future<Either<Failure, bool>> checkEmailExists(String email) async {
    return _authRepository.checkEmailExists(email);
  }

  @override
  Future<Either<Failure, String>> emailOTPSignIn({
    required String email,
    required String country,
    required String citizenship,
    required String birthCountry,
    String? invitationCode,
  }) async {
    return _authRepository.emailOTPSignIn(
        email: email, country: country, invitationCode: invitationCode, citizenship: citizenship, birthCountry: birthCountry);
  }

  @override
  Future<Either<Failure, bool>> checkMobileNumberExists({required String mobileNumber}) async {
    return _authRepository.checkMobileNumberExists(mobileNumber: mobileNumber);
  }

  @override
  Future<Either<Failure, String>> sendMobileNumberOtp({required String accountId, required String mobileNumber}) async {
    return _authRepository.sendMobileNumberOtp(mobileNumber: mobileNumber, accountId: accountId);
  }

  @override
  Future<Either<Failure, User>> getUser() async {
    final result = await _authRepository.getUser();

    result.fold((l) {}, (r) {
      _user = r;
    });

    return result;
  }

  @override
  Future<Either<Failure, bool>> confirmMobileNumberOtp(
      {required String mobileNumber, required String otp, required String accountId}) async {
    final result = await _authRepository.confirmMobileNumberOtp(mobileNumber: mobileNumber, otp: otp, accountId: accountId);
    result.fold((l) => null, (r) async {
      getUser();
    });

    return result;
  }

  @override
  Future<Either<Failure, String>> changeMobileNumber({
    required String mobileNumber,
    required String mobileNumberId,
  }) async {
    final result =
        await _authRepository.changeMobileNumber(mobileNumber: mobileNumber, userId: _user!.id, mobileNumberId: mobileNumberId);
    result.fold((l) => null, (r) async {
      await getUser();
    });

    return result;
  }

  @override
  Future<Either<Failure, String>> setPIN({required String pin}) async {
    return _authRepository.setPIN(uid: _user!.id, pin: pin);
  }

  @override
  Future<Either<Failure, String>> verifyOTP({required String email, required String otp}) async {
    final result = await _authRepository.verifyOTP(
      email: email,
      otp: otp,
    );
    result.fold((l) => null, (r) async {
      await getUser();
    });
    return result;
  }

  @override
  Future<Either<Failure, String>> emailOTPLogin({required String email}) async {
    return _authRepository.emailOTPLogin(email: email);
  }

  @override
  Future<Either<Failure, bool>> verifyPin({required String pin}) async {
    return _authRepository.verifyPin(userId: _user!.id, pin: pin);
  }

  @override
  Future<Either<Failure, String>> lockUserAccount() {
    return _authRepository.lockUserAccount(userId: _user!.id);
  }

  @override
  Future<Either<Failure, String>> updateUserCountry(String country, String citizenship, String birthCountry) {
    return _authRepository.updateUserCountry(country, citizenship, birthCountry);
  }

  @override
  Future<Either<Failure, String>> updateUserCurrency(String currency, String accountId) {
    return _authRepository.updateUserCurrency(currency, accountId);
  }

  @override
  Future<Either<Failure, bool>> isPermittedCountry(String countryISO) {
    return _authRepository.isPermittedCountry(countryISO);
  }

  @override
  Future<Either<Failure, String>> addWaitlistUser(String email, String country) {
    return _authRepository.addWaitlistUser(email, country);
  }

  @override
  Future<Either<Failure, bool>> closeAccountCheck(String uid) {
    return _authRepository.closeAccountCheck(uid);
  }

  @override
  Future<Either<Failure, String>> closeAccount(String uid, String reason) {
    return _authRepository.closeAccount(uid, reason);
  }

  @override
  Future<Either<Failure, void>> setUserDeviceInfo(User? user, String token) {
    return _authRepository.setUserDeviceInfo(user, token);
  }

  @override
  Future<Either<Failure, String>> updatePassCode(String accountId, String oldPassCode, String newPassCode) {
    return _authRepository.updatePassCode(accountId, oldPassCode, newPassCode);
  }

  @override
  Future<Either<Failure, String>> getSupportPIN(String accountId) {
    return _authRepository.getSupportPIN(accountId);
  }

  @override
  Future<Either<Failure, String>> uploadAddressProof(String accountId, String proofType, String base64) {
    return _authRepository.getSupportPIN(accountId);
  }

  @override
  Future<Either<Failure, List<PointStat>>> getPoints(String accountId) {
    return _authRepository.getPoints(accountId);
  }

  @override
  Future<Either<Failure, bool>> joinBeta(String accountId) {
    return _authRepository.joinBeta(accountId);
  }

  @override
  Future<Either<Failure, bool>> checkAuthToken(String token) {
    return _authRepository.checkAuthToken(token);
  }

  @override
  Future<Either<Failure, String>> uploadAvatar(String accountId, String base64) {
    return _authRepository.uploadAvatar(accountId, base64);
  }
}

class Abc extends AuthenticationService {
  @override
  Future<Either<Failure, String>> addWaitlistUser(String email, String country) {
    // TODO: implement addWaitlistUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> changeMobileNumber({required String mobileNumber, required String mobileNumberId}) {
    // TODO: implement changeMobileNumber
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> checkAuthToken(String token) {
    // TODO: implement checkAuthToken
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> checkEmailExists(String email) {
    // TODO: implement checkEmailExists
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> checkMobileNumberExists({required String mobileNumber}) {
    // TODO: implement checkMobileNumberExists
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> closeAccount(String uid, String reason) {
    // TODO: implement closeAccount
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> closeAccountCheck(String uid) {
    // TODO: implement closeAccountCheck
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> confirmMobileNumberOtp(
      {required String mobileNumber, required String otp, required String accountId}) {
    // TODO: implement confirmMobileNumberOtp
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> emailOTPLogin({required String email}) {
    // TODO: implement emailOTPLogin
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> emailOTPSignIn(
      {required String email,
      required String country,
      required String citizenship,
      required String birthCountry,
      String? invitationCode}) {
    // TODO: implement emailOTPSignIn
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Country>>> fetchCountries() {
    // TODO: implement fetchCountries
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<PointStat>>> getPoints(String accountId) {
    // TODO: implement getPoints
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> getSupportPIN(String accountId) {
    // TODO: implement getSupportPIN
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> isPermittedCountry(String countryISO) {
    // TODO: implement isPermittedCountry
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> joinBeta(String accountId) {
    // TODO: implement joinBeta
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> lockUserAccount() {
    // TODO: implement lockUserAccount
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Country>>> searchCountry(String keyword) {
    // TODO: implement searchCountry
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Country>> searchCountryIso(String iso) {
    // TODO: implement searchCountryIso
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> sendMobileNumberOtp({required String accountId, required String mobileNumber}) {
    // TODO: implement sendMobileNumberOtp
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> setPIN({required String pin}) {
    // TODO: implement setPIN
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> setUserDeviceInfo(User? user, String token) {
    // TODO: implement setUserDeviceInfo
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> updatePassCode(String accountId, String oldPassCode, String newPassCode) {
    // TODO: implement updatePassCode
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> updateUserCountry(String country, String citizenship, String birthCountry) {
    // TODO: implement updateUserCountry
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> updateUserCurrency(String currency, String accountId) {
    // TODO: implement updateUserCurrency
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> uploadAddressProof(String accountId, String proofType, String base64) {
    // TODO: implement uploadAddressProof
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> uploadAvatar(String accountId, String base64) {
    // TODO: implement uploadAvatar
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> verifyOTP({required String email, required String otp}) {
    // TODO: implement verifyOTP
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> verifyPin({required String pin}) {
    // TODO: implement verifyPin
    throw UnimplementedError();
  }
}
