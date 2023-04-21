import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:geniuspay/core/errors/errors.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/data_sources/auth_data_source/auth_data_source.dart';
import 'package:geniuspay/environment_config.dart';
import 'package:geniuspay/models/country.dart';
import 'package:geniuspay/models/points_stat.dart';
import 'package:geniuspay/models/user.dart';
import 'package:geniuspay/repos/local_repo.dart';
import 'package:geniuspay/util/essentials.dart';
import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool>> checkEmailExists(String email);
  Future<Either<Failure, String>> emailOTPSignIn({
    required String email,
    required String country,
    required String citizenship,
    required String birthCountry,
    String? invitationCode,
  });
  Future<Either<Failure, String>> emailOTPLogin({required String email});
  Future<Either<Failure, String>> lockUserAccount({required String userId});
  Future<Either<Failure, User>> getUser();
  Future<Either<Failure, List<Country>>> fetchCountries();
  Future<Either<Failure, List<Country>>> searchCountry(String keyword);
  Future<Either<Failure, Country>> searchCountryIso(String iso);
  Future<Either<Failure, String>> verifyOTP({
    required String email,
    required String otp,
  });
  Future<Either<Failure, bool>> verifyPin({
    required String userId,
    required String pin,
  });

  Future<Either<Failure, String>> changeMobileNumber({
    required String mobileNumber,
    required String userId,
    required String mobileNumberId,
  });
  Future<Either<Failure, bool>> checkMobileNumberExists({
    required String mobileNumber,
  });
  Future<Either<Failure, String>> sendMobileNumberOtp(
      {required String accountId, required String mobileNumber});
  Future<Either<Failure, bool>> confirmMobileNumberOtp(
      {required String mobileNumber,
      required String otp,
      required String accountId});
  Future<Either<Failure, String>> setPIN({
    required String uid,
    required String pin,
  });
  Future<Either<Failure, String>> updateUserCountry(
      String country, String citizenship, String birthCountry);
  Future<Either<Failure, bool>> isPermittedCountry(String countryISO);
  Future<Either<Failure, String>> addWaitlistUser(String email, String country);
  Future<Either<Failure, bool>> closeAccountCheck(String uid);

  Future<Either<Failure, String>> closeAccount(String uid, String reason);
  Future<Either<Failure, void>> setUserDeviceInfo(User? user, String token);
  Future<Either<Failure, String>> updatePassCode(
      String accountId, String oldPassCode, String newPassCode);
  Future<Either<Failure, String>> getSupportPIN(String accountId);
  Future<Either<Failure, String>> uploadAddressProof(
      String accountId, String proofType, String base64);
  Future<Either<Failure, List<PointStat>>> getPoints(String accountId);
  Future<Either<Failure, bool>> joinBeta(String accountId);
  Future<Either<Failure, bool>> checkAuthToken(String token);
  Future<Either<Failure, String>> updateUserCurrency(
      String currency, String accountId);
  Future<Either<Failure, String>> uploadAvatar(String accountId, String base64);
}

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl({
    required this.remoteDataSource,
  });

  final AuthDataSourse remoteDataSource;

  @override
  Future<Either<Failure, bool>> checkEmailExists(String email) async {
    try {
      final result = await remoteDataSource.checkEmailExists(email);

      return Right(result);
    } catch (e, stackTrace) {
      debugPrint(e);
      if (e.runtimeType != NoInternetException &&
          EnvironmentConfig.env == Flavor.live) {
        final message = e is DioError ? e.response : '';
        unawaited(
            Sentry.captureException(e, stackTrace: stackTrace, hint: message));
        unawaited(FirebaseCrashlytics.instance
            .recordError(e, stackTrace, reason: message));
        unawaited(FirebaseCrashlytics.instance
            .recordError(e, stackTrace, reason: message));
      }
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }
      if (e is DioError) {
        debugPrint(e.response);
        if (e.response != null &&
            e.response!.data != null &&
            e.response!.data != '' &&
            e.response!.data is Map) {
          return Left(
            ServerFailure(
              // ignore: avoid_dynamic_calls
              message: e.response!.data['message'] ??
                  'Service unavailable, please try again!',
            ),
          );
        } else {
          return const Left(
            ServerFailure(
              message: 'Server error, please try again',
            ),
          );
        }
      }
      if (e is ServerException) {
        return Left(ServerFailure(message: e.message));
      }
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<Country>>> fetchCountries() async {
    try {
      final result = await remoteDataSource.fetchCountries();

      return Right(result);
    } catch (e, stackTrace) {
      if (e.runtimeType != NoInternetException &&
          EnvironmentConfig.env == Flavor.live) {
        final message = e is DioError ? e.response : '';
        unawaited(
            Sentry.captureException(e, stackTrace: stackTrace, hint: message));
        unawaited(FirebaseCrashlytics.instance
            .recordError(e, stackTrace, reason: message));
      }
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }
      if (e is DioError) {
        if (e.response != null &&
            e.response!.data != null &&
            e.response!.data != '' &&
            e.response!.data is Map) {
          return Left(
            ServerFailure(
              // ignore: avoid_dynamic_calls
              message: e.response!.data['message'] ??
                  'Service unavailable, please try again!',
            ),
          );
        } else {
          return const Left(
            ServerFailure(
              message: 'Server error, please try again',
            ),
          );
        }
      }
      if (e is ServerException) {
        return Left(ServerFailure(message: e.message));
      }
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<Country>>> searchCountry(String keyword) async {
    try {
      final result = await remoteDataSource.seearchCountry(keyword);

      return Right(result);
    } catch (e, stackTrace) {
      if (e.runtimeType != NoInternetException &&
          EnvironmentConfig.env == Flavor.live) {
        final message = e is DioError ? e.response : '';
        unawaited(
            Sentry.captureException(e, stackTrace: stackTrace, hint: message));
        unawaited(FirebaseCrashlytics.instance
            .recordError(e, stackTrace, reason: message));
      }
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }
      if (e is DioError) {
        if (e.response != null &&
            e.response!.data != null &&
            e.response!.data != '' &&
            e.response!.data is Map) {
          return Left(
            ServerFailure(
              message: e.response!.data['message'] ??
                  'Service unavailable, please try again!',
            ),
          );
        } else {
          return const Left(
            ServerFailure(
              message: 'Server error, please try again',
            ),
          );
        }
      }
      if (e is ServerException) {
        return Left(ServerFailure(message: e.message));
      }
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, Country>> searchCountryIso(String iso) async {
    try {
      final result = await remoteDataSource.searchCountryIso(iso);

      return Right(result);
    } catch (e, stackTrace) {
      if (e.runtimeType != NoInternetException &&
          EnvironmentConfig.env == Flavor.live) {
        final message = e is DioError ? e.response : '';
        unawaited(
            Sentry.captureException(e, stackTrace: stackTrace, hint: message));
        unawaited(FirebaseCrashlytics.instance
            .recordError(e, stackTrace, reason: message));
      }
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }
      if (e is DioError) {
        if (e.response != null &&
            e.response!.data != null &&
            e.response!.data != '' &&
            e.response!.data is Map) {
          return Left(
            ServerFailure(
              // ignore: avoid_dynamic_calls
              message: e.response!.data['message'] ??
                  'Service unavailable, please try again!',
            ),
          );
        } else {
          return const Left(
            ServerFailure(
              message: 'Server error, please try again',
            ),
          );
        }
      }
      if (e is ServerException) {
        return Left(ServerFailure(message: e.message));
      }
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, String>> emailOTPSignIn({
    required String email,
    required String country,
    required String citizenship,
    required String birthCountry,
    String? invitationCode,
  }) async {
    try {
      final result = await remoteDataSource.emailOTPSignIn(
        email: email,
        country: country,
        invitationCode: invitationCode,
        birthCountry: birthCountry,
        citizenship: citizenship,
      );

      return Right(result);
    } catch (e, stackTrace) {
      debugPrint(e);
      if (e.runtimeType != NoInternetException &&
          EnvironmentConfig.env == Flavor.live) {
        final message = e is DioError ? e.response : '';
        unawaited(
            Sentry.captureException(e, stackTrace: stackTrace, hint: message));
        unawaited(FirebaseCrashlytics.instance
            .recordError(e, stackTrace, reason: message));
      }
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }
      if (e is DioError) {
        debugPrint(e.response!.data['message']);
        if (e.response != null &&
            e.response!.data != null &&
            e.response!.data != '' &&
            e.response!.data is Map) {
          return Left(
            ServerFailure(
              // ignore: avoid_dynamic_calls
              message: e.response!.data['message'] ??
                  'Service unavailable, please try again!',
            ),
          );
        } else {
          return const Left(
            ServerFailure(
              message: 'Server error, please try again',
            ),
          );
        }
      }
      if (e is ServerException) {
        return Left(ServerFailure(message: e.message));
      }
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> checkMobileNumberExists({
    required String mobileNumber,
  }) async {
    try {
      final result = await remoteDataSource.checkMobileNumberExists(
          mobileNumber: mobileNumber);

      return Right(result);
    } catch (e, stackTrace) {
      if (e.runtimeType != NoInternetException &&
          EnvironmentConfig.env == Flavor.live) {
        final message = e is DioError ? e.response : '';
        unawaited(
            Sentry.captureException(e, stackTrace: stackTrace, hint: message));
        unawaited(FirebaseCrashlytics.instance
            .recordError(e, stackTrace, reason: message));
      }
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }
      if (e is DioError) {
        if (e.response != null &&
            e.response!.data != null &&
            e.response!.data != '' &&
            e.response!.data is Map) {
          return Left(
            ServerFailure(
              // ignore: avoid_dynamic_calls
              message: e.response!.data['message'] ??
                  'Service unavailable, please try again!',
            ),
          );
        } else {
          return const Left(
            ServerFailure(
              message: 'Server error, please try again',
            ),
          );
        }
      }
      if (e is ServerException) {
        return Left(ServerFailure(message: e.message));
      }
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, String>> sendMobileNumberOtp(
      {required String accountId, required String mobileNumber}) async {
    try {
      final result = await remoteDataSource.sendMobileNumberOtp(
          mobileNumber: mobileNumber, accountId: accountId);

      return Right(result);
    } catch (e, stackTrace) {
      debugPrint(e);
      if (e.runtimeType != NoInternetException &&
          EnvironmentConfig.env == Flavor.live) {
        final message = e is DioError ? e.response : '';
        unawaited(
            Sentry.captureException(e, stackTrace: stackTrace, hint: message));
        unawaited(FirebaseCrashlytics.instance
            .recordError(e, stackTrace, reason: message));
      }
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }
      if (e is DioError) {
        debugPrint(e.response);
        if (e.response != null &&
            e.response!.data != null &&
            e.response!.data != '' &&
            e.response!.data is Map) {
          return Left(
            ServerFailure(
              // ignore: avoid_dynamic_calls
              message: e.response!.data['message'] ??
                  'Service unavailable, please try again!',
            ),
          );
        } else {
          return const Left(
            ServerFailure(
              message: 'Server error, please try again',
            ),
          );
        }
      }
      if (e is ServerException) {
        return Left(ServerFailure(message: e.message));
      }
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> confirmMobileNumberOtp(
      {required String mobileNumber,
      required String otp,
      required String accountId}) async {
    try {
      final result = await remoteDataSource.confirmMobileNumberOtp(
          mobileNumber: mobileNumber, otp: otp, accountId: accountId);

      return Right(result);
    } catch (e, stackTrace) {
      debugPrint(e);
      if (e.runtimeType != NoInternetException &&
          EnvironmentConfig.env == Flavor.live) {
        final message = e is DioError ? e.response : '';
        unawaited(
            Sentry.captureException(e, stackTrace: stackTrace, hint: message));
        unawaited(FirebaseCrashlytics.instance
            .recordError(e, stackTrace, reason: message));
      }
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }
      if (e is DioError) {
        debugPrint(e.response);
        if (e.response != null &&
            e.response!.data != null &&
            e.response!.data != '' &&
            e.response!.data is Map) {
          String? message;
          if (e.response!.data['errors'] != null) {
            message = e.response!.data['errors'][0]['message'];
          }

          return Left(
            ServerFailure(
              // ignore: avoid_dynamic_calls
              message: message ?? e.response!.data['message'],
            ),
          );
        } else {
          return const Left(
            ServerFailure(
              message: 'Server error, please try again',
            ),
          );
        }
      }
      if (e is ServerException) {
        return Left(ServerFailure(message: e.message));
      }
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, String>> changeMobileNumber(
      {required String mobileNumber,
      required String userId,
      required String mobileNumberId}) async {
    try {
      final result = await remoteDataSource.changeMobileNumber(
          mobileNumber: mobileNumber,
          userId: userId,
          mobileNumberId: mobileNumberId);

      return Right(result);
    } catch (e, stackTrace) {
      if (e.runtimeType != NoInternetException &&
          EnvironmentConfig.env == Flavor.live) {
        final message = e is DioError ? e.response : '';
        unawaited(
            Sentry.captureException(e, stackTrace: stackTrace, hint: message));
        unawaited(FirebaseCrashlytics.instance
            .recordError(e, stackTrace, reason: message));
      }
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }
      if (e is DioError) {
        if (e.response != null &&
            e.response!.data != null &&
            e.response!.data != '' &&
            e.response!.data is Map) {
          String? message;
          if (e.response!.data['errors'] != null) {
            message = e.response!.data['errors'][0]['message'];
          }

          return Left(
            ServerFailure(
              // ignore: avoid_dynamic_calls
              message: message ?? e.response!.data['message'],
            ),
          );
        } else {
          return const Left(
            ServerFailure(
              message: 'Server error, please try again',
            ),
          );
        }
      }
      if (e is ServerException) {
        return Left(ServerFailure(message: e.message));
      }
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, String>> setPIN(
      {required String uid, required String pin}) async {
    try {
      final result = await remoteDataSource.setPIN(uid: uid, pin: pin);

      return Right(result);
    } catch (e, stackTrace) {
      debugPrint(e);
      if (e.runtimeType != NoInternetException &&
          EnvironmentConfig.env == Flavor.live) {
        final message = e is DioError ? e.response : '';
        unawaited(
            Sentry.captureException(e, stackTrace: stackTrace, hint: message));
        unawaited(FirebaseCrashlytics.instance
            .recordError(e, stackTrace, reason: message));
      }
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }
      if (e is DioError) {
        debugPrint(e.response);
        if (e.response != null &&
            e.response!.data != null &&
            e.response!.data != '' &&
            e.response!.data is Map) {
          String? message;
          if (e.response!.data['errors'] != null) {
            message = e.response!.data['errors'][0]['message'];
          }

          return Left(
            ServerFailure(
              // ignore: avoid_dynamic_calls
              message: message ?? e.response!.data['message'],
            ),
          );
        } else {
          return const Left(
            ServerFailure(
              message: 'Server error, please try again',
            ),
          );
        }
      }
      if (e is ServerException) {
        return Left(ServerFailure(message: e.message));
      }
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, String>> verifyOTP(
      {required String email, required String otp}) async {
    try {
      final result = await remoteDataSource.verifyOTP(email: email, otp: otp);

      return Right(result);
    } catch (e, stackTrace) {
      debugPrint(e);
      if (e.runtimeType != NoInternetException &&
          EnvironmentConfig.env == Flavor.live) {
        final message = e is DioError ? e.response : '';
        unawaited(
            Sentry.captureException(e, stackTrace: stackTrace, hint: message));
        unawaited(FirebaseCrashlytics.instance
            .recordError(e, stackTrace, reason: message));
      }
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }
      if (e is DioError) {
        debugPrint(e.response);
        if (e.response != null &&
            e.response!.data != null &&
            e.response!.data != '' &&
            e.response!.data is Map) {
          return Left(
            ServerFailure(
              // ignore: avoid_dynamic_calls
              message: e.response!.data['message'] ??
                  'Service unavailable, please try again!',
            ),
          );
        } else {
          return const Left(
            ServerFailure(
              message: 'Server error, please try again',
            ),
          );
        }
      }
      if (e is ServerException) {
        return Left(ServerFailure(message: e.message));
      }
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, User>> getUser() async {
    try {
      final result = await remoteDataSource.getUser();

      return Right(result);
    } catch (e, stackTrace) {
      debugPrint(e);
      if (e.runtimeType != NoInternetException &&
          EnvironmentConfig.env == Flavor.live) {
        final message = e is DioError ? e.response : '';
        unawaited(
            Sentry.captureException(e, stackTrace: stackTrace, hint: message));
        unawaited(FirebaseCrashlytics.instance
            .recordError(e, stackTrace, reason: message));
      }
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }
      if (e is DioError) {
        debugPrint(e.response);
        if (e.response != null &&
            e.response!.data != null &&
            e.response!.data != '' &&
            e.response!.data is Map) {
          if (e.response?.data['code'] == 4002) {
            final localBase = sl<LocalBase>();
            try {
              debugPrint(1);
              debugPrint(localBase.getToken());
              final result2 =
                  await remoteDataSource.checkAuthToken(localBase.getToken()!);
              debugPrint(2);
              debugPrint(result2);
              if (result2) {
                return Left(
                  BlockedUser(
                    // ignore: avoid_dynamic_calls
                    message:
                        e.response!.data['message'] ?? 'User has been blocked',
                  ),
                );
              } else {
                return const Left(
                  SessionTimeOut(
                    // ignore: avoid_dynamic_calls
                    message: 'User session has expired',
                  ),
                );
              }
            } catch (e2) {
              debugPrint(3);
              debugPrint(e2);
              if (e2 is DioError) {
                debugPrint(e2.response);
              }
              return Left(
                BlockedUser(
                  // ignore: avoid_dynamic_calls
                  message:
                      e.response!.data['message'] ?? 'User has been blocked',
                ),
              );
            }
          }
          return Left(
            ServerFailure(
              // ignore: avoid_dynamic_calls
              message: e.response!.data['message'] ??
                  'Service unavailable, please try again!',
            ),
          );
        } else {
          return const Left(
            ServerFailure(
              message: 'Server error, please try again',
            ),
          );
        }
      }
      if (e is ServerException) {
        return Left(ServerFailure(message: e.message));
      }
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, String>> emailOTPLogin({required String email}) async {
    try {
      final result = await remoteDataSource.emailOTPLogin(
        email: email,
      );

      return Right(result);
    } catch (e, stackTrace) {
      debugPrint(e);
      if (e.runtimeType != NoInternetException &&
          EnvironmentConfig.env == Flavor.live) {
        final message = e is DioError ? e.response : '';
        unawaited(
            Sentry.captureException(e, stackTrace: stackTrace, hint: message));
        unawaited(FirebaseCrashlytics.instance
            .recordError(e, stackTrace, reason: message));
      }
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }
      if (e is DioError) {
        debugPrint(e.response);
        if (e.response != null &&
            e.response!.data != null &&
            e.response!.data != '' &&
            e.response!.data is Map) {
          return Left(
            ServerFailure(
              // ignore: avoid_dynamic_calls
              message: e.response!.data['message'] ??
                  'Service unavailable, please try again!',
            ),
          );
        } else {
          return const Left(
            ServerFailure(
              message: 'Server error, please try again',
            ),
          );
        }
      }
      if (e is ServerException) {
        return Left(ServerFailure(message: e.message));
      }
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> verifyPin(
      {required String userId, required String pin}) async {
    try {
      final result = await remoteDataSource.verifyPin(userId: userId, pin: pin);

      return Right(result);
    } catch (e, stackTrace) {
      if (e.runtimeType != NoInternetException &&
          EnvironmentConfig.env == Flavor.live) {
        final message = e is DioError ? e.response : '';
        unawaited(
            Sentry.captureException(e, stackTrace: stackTrace, hint: message));
        unawaited(FirebaseCrashlytics.instance
            .recordError(e, stackTrace, reason: message));
      }
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }
      if (e is DioError) {
        if (e.response != null &&
            e.response!.data != null &&
            e.response!.data != '' &&
            e.response!.data is Map) {
          String? message;
          if (e.response?.data['errors'] != null) {
            message = e.response!.data['errors'][0]['message'];
          }

          return Left(
            ServerFailure(
              // ignore: avoid_dynamic_calls
              message: message ?? e.response?.data['message'],
            ),
          );
        } else {
          return const Left(
            ServerFailure(
              message: 'Server error, please try again',
            ),
          );
        }
      }
      if (e is ServerException) {
        return Left(ServerFailure(message: e.message));
      }
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, String>> lockUserAccount(
      {required String userId}) async {
    try {
      final result = await remoteDataSource.lockUserAccount(
        userId: userId,
      );

      return Right(result);
    } catch (e, stackTrace) {
      if (e.runtimeType != NoInternetException &&
          EnvironmentConfig.env == Flavor.live) {
        final message = e is DioError ? e.response : '';
        unawaited(
            Sentry.captureException(e, stackTrace: stackTrace, hint: message));
        unawaited(FirebaseCrashlytics.instance
            .recordError(e, stackTrace, reason: message));
      }
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }
      if (e is DioError) {
        if (e.response != null &&
            e.response!.data != null &&
            e.response!.data != '' &&
            e.response!.data is Map) {
          String? message;
          if (e.response!.data['errors'] != null) {
            message = e.response!.data['errors'][0]['message'];
          }

          return Left(
            ServerFailure(
              // ignore: avoid_dynamic_calls
              message: message ?? e.response!.data['message'],
            ),
          );
        } else {
          return const Left(
            ServerFailure(
              message: 'Server error, please try again',
            ),
          );
        }
      }
      if (e is ServerException) {
        return Left(ServerFailure(message: e.message));
      }
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, String>> updateUserCountry(
      String country, String citizenship, String birthCountry) async {
    try {
      final result = await remoteDataSource.updateUserCountry(
          country, citizenship, birthCountry);

      return Right(result);
    } catch (e, stackTrace) {
      if (e.runtimeType != NoInternetException &&
          EnvironmentConfig.env == Flavor.live) {
        final message = e is DioError ? e.response : '';
        unawaited(
            Sentry.captureException(e, stackTrace: stackTrace, hint: message));
        unawaited(FirebaseCrashlytics.instance
            .recordError(e, stackTrace, reason: message));
      }
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }
      if (e is DioError) {
        if (e.response != null &&
            e.response!.data != null &&
            e.response!.data != '' &&
            e.response!.data is Map) {
          String? message;
          if (e.response!.data['errors'] != null) {
            message = e.response!.data['errors'][0]['message'];
          }

          return Left(
            ServerFailure(
              // ignore: avoid_dynamic_calls
              message: message ?? e.response!.data['message'],
            ),
          );
        } else {
          return const Left(
            ServerFailure(
              message: 'Server error, please try again',
            ),
          );
        }
      }
      if (e is ServerException) {
        return Left(ServerFailure(message: e.message));
      }
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, String>> updateUserCurrency(
      String currency, String accountId) async {
    try {
      final result =
          await remoteDataSource.updateUserCurrency(currency, accountId);

      return Right(result);
    } catch (e, stackTrace) {
      if (e.runtimeType != NoInternetException &&
          EnvironmentConfig.env == Flavor.live) {
        final message = e is DioError ? e.response : '';
        unawaited(
            Sentry.captureException(e, stackTrace: stackTrace, hint: message));
        unawaited(FirebaseCrashlytics.instance
            .recordError(e, stackTrace, reason: message));
      }
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }
      if (e is DioError) {
        if (e.response != null &&
            e.response!.data != null &&
            e.response!.data != '' &&
            e.response!.data is Map) {
          String? message;
          if (e.response!.data['errors'] != null) {
            message = e.response!.data['errors'][0]['message'];
          }

          return Left(
            ServerFailure(
              // ignore: avoid_dynamic_calls
              message: message ?? e.response!.data['message'],
            ),
          );
        } else {
          return const Left(
            ServerFailure(
              message: 'Server error, please try again',
            ),
          );
        }
      }
      if (e is ServerException) {
        return Left(ServerFailure(message: e.message));
      }
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> isPermittedCountry(String countryISO) async {
    try {
      final result = await remoteDataSource.isPermittedCountry(countryISO);

      return Right(result);
    } catch (e, stackTrace) {
      debugPrint(e);
      if (e.runtimeType != NoInternetException &&
          EnvironmentConfig.env == Flavor.live) {
        final message = e is DioError ? e.response : '';
        unawaited(
            Sentry.captureException(e, stackTrace: stackTrace, hint: message));
        unawaited(FirebaseCrashlytics.instance
            .recordError(e, stackTrace, reason: message));
      }
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }
      if (e is DioError) {
        debugPrint("DioError: ${e.response}");
        if (e.response != null &&
            e.response!.data != null &&
            e.response!.data != '' &&
            e.response!.data is Map) {
          String? message;
          if (e.response!.data['errors'] != null) {
            message = e.response!.data['errors'][0]['message'];
          }

          return Left(
            ServerFailure(
              // ignore: avoid_dynamic_calls
              message: message ?? e.response!.data['message'],
            ),
          );
        } else {
          return const Left(
            ServerFailure(
              message: 'Server error, please try again',
            ),
          );
        }
      }
      if (e is ServerException) {
        return Left(ServerFailure(message: e.message));
      }

      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, String>> addWaitlistUser(
      String email, String country) async {
    try {
      final result = await remoteDataSource.addWaitlistUser(email, country);

      return Right(result);
    } catch (e, stackTrace) {
      if (e.runtimeType != NoInternetException &&
          EnvironmentConfig.env == Flavor.live) {
        final message = e is DioError ? e.response : '';
        unawaited(
            Sentry.captureException(e, stackTrace: stackTrace, hint: message));
        unawaited(FirebaseCrashlytics.instance
            .recordError(e, stackTrace, reason: message));
      }
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }
      if (e is DioError) {
        if (e.response != null &&
            e.response!.data != null &&
            e.response!.data != '' &&
            e.response!.data is Map) {
          String? message;
          if (e.response!.data['errors'] != null) {
            message = e.response!.data['errors'][0]['message'];
          }

          return Left(
            ServerFailure(
              // ignore: avoid_dynamic_calls
              message: message ?? e.response!.data['message'],
            ),
          );
        } else {
          return const Left(
            ServerFailure(
              message: 'Server error, please try again',
            ),
          );
        }
      }
      if (e is ServerException) {
        return Left(ServerFailure(message: e.message));
      }
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> closeAccountCheck(String uid) async {
    try {
      final result = await remoteDataSource.closeAccountCheck(uid);

      return Right(result);
    } catch (e, stackTrace) {
      debugPrint(e);
      if (e.runtimeType != NoInternetException &&
          EnvironmentConfig.env == Flavor.live) {
        final message = e is DioError ? e.response : '';
        unawaited(
            Sentry.captureException(e, stackTrace: stackTrace, hint: message));
        unawaited(FirebaseCrashlytics.instance
            .recordError(e, stackTrace, reason: message));
      }
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }
      if (e is DioError) {
        debugPrint(e.response);
        if (e.response != null &&
            e.response!.data != null &&
            e.response!.data != '' &&
            e.response!.data is Map) {
          String? message;
          if (e.response!.data['errors'] != null) {
            message = e.response!.data['errors'][0]['message'];
          }

          return Left(
            ServerFailure(
              // ignore: avoid_dynamic_calls
              message: message ?? e.response!.data['message'],
            ),
          );
        } else {
          return const Left(
            ServerFailure(
              message: 'Server error, please try again',
            ),
          );
        }
      }
      if (e is ServerException) {
        return Left(ServerFailure(message: e.message));
      }
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, String>> closeAccount(
      String uid, String reason) async {
    try {
      final result = await remoteDataSource.closeAccount(uid, reason);

      return Right(result);
    } catch (e, stackTrace) {
      debugPrint(e);
      if (e.runtimeType != NoInternetException &&
          EnvironmentConfig.env == Flavor.live) {
        final message = e is DioError ? e.response : '';
        unawaited(
            Sentry.captureException(e, stackTrace: stackTrace, hint: message));
        unawaited(FirebaseCrashlytics.instance
            .recordError(e, stackTrace, reason: message));
      }
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }
      if (e is DioError) {
        debugPrint(e.response);
        if (e.response != null &&
            e.response!.data != null &&
            e.response!.data != '' &&
            e.response!.data is Map) {
          String? message;
          if (e.response!.data['errors'] != null) {
            message = e.response!.data['errors'][0]['message'];
          }

          return Left(
            ServerFailure(
              // ignore: avoid_dynamic_calls
              message: message ?? e.response!.data['message'],
            ),
          );
        } else {
          return const Left(
            ServerFailure(
              message: 'Server error, please try again',
            ),
          );
        }
      }
      if (e is ServerException) {
        return Left(ServerFailure(message: e.message));
      }
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> setUserDeviceInfo(
      User? user, String token) async {
    try {
      final result = await remoteDataSource.setUserDeviceInfo(user, token);

      return Right(result);
    } catch (e, stackTrace) {
      if (e.runtimeType != NoInternetException &&
          EnvironmentConfig.env == Flavor.live) {
        final message = e is DioError ? e.response : '';
        unawaited(
            Sentry.captureException(e, stackTrace: stackTrace, hint: message));
        unawaited(FirebaseCrashlytics.instance
            .recordError(e, stackTrace, reason: message));
      }
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }
      if (e is DioError) {
        if (e.response != null &&
            e.response!.data != null &&
            e.response!.data != '' &&
            e.response!.data is Map) {
          String? message;
          if (e.response!.data['errors'] != null) {
            message = e.response!.data['errors'][0]['message'];
          }

          return Left(
            ServerFailure(
              // ignore: avoid_dynamic_calls
              message: message ?? e.response!.data['message'],
            ),
          );
        } else {
          return const Left(
            ServerFailure(
              message: 'Server error, please try again',
            ),
          );
        }
      }
      if (e is ServerException) {
        return Left(ServerFailure(message: e.message));
      }
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, String>> updatePassCode(
      String accountId, String oldPassCode, String newPassCode) async {
    try {
      final result = await remoteDataSource.updatePassCode(
          accountId, oldPassCode, newPassCode);

      return Right(result);
    } catch (e, stackTrace) {
      debugPrint(e);
      if (e.runtimeType != NoInternetException &&
          EnvironmentConfig.env == Flavor.live) {
        final message = e is DioError ? e.response : '';
        unawaited(
            Sentry.captureException(e, stackTrace: stackTrace, hint: message));
        unawaited(FirebaseCrashlytics.instance
            .recordError(e, stackTrace, reason: message));
      }
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }
      if (e is DioError) {
        debugPrint(e.response);
        if (e.response != null &&
            e.response!.data != null &&
            e.response!.data != '' &&
            e.response!.data is Map) {
          String? message;
          if (e.response!.data['errors'] != null) {
            message = e.response!.data['errors'][0]['message'];
          }

          return Left(
            ServerFailure(
              // ignore: avoid_dynamic_calls
              message: message ?? e.response!.data['message'],
            ),
          );
        } else {
          return const Left(
            ServerFailure(
              message: 'Server error, please try again',
            ),
          );
        }
      }
      if (e is ServerException) {
        return Left(ServerFailure(message: e.message));
      }
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getSupportPIN(String accountId) async {
    try {
      final result = await remoteDataSource.getSupportPIN(accountId);

      return Right(result);
    } catch (e, stackTrace) {
      debugPrint(e);
      if (e.runtimeType != NoInternetException &&
          EnvironmentConfig.env == Flavor.live) {
        final message = e is DioError ? e.response : '';
        unawaited(
            Sentry.captureException(e, stackTrace: stackTrace, hint: message));
        unawaited(FirebaseCrashlytics.instance
            .recordError(e, stackTrace, reason: message));
      }
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }
      if (e is DioError) {
        debugPrint(e.response);
        if (e.response != null &&
            e.response!.data != null &&
            e.response!.data != '' &&
            e.response!.data is Map) {
          String? message;
          if (e.response!.data['errors'] != null) {
            message = e.response!.data['errors'][0]['message'];
          }

          return Left(
            ServerFailure(
              // ignore: avoid_dynamic_calls
              message: message ?? e.response!.data['message'] ?? '',
            ),
          );
        } else {
          return const Left(
            ServerFailure(
              message: 'Server error, please try again',
            ),
          );
        }
      }
      if (e is ServerException) {
        return Left(ServerFailure(message: e.message));
      }
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, String>> uploadAddressProof(
      String accountId, String proofType, String base64) async {
    try {
      final result = await remoteDataSource.uploadAddressProof(
          accountId, proofType, base64);

      return Right(result);
    } catch (e, stackTrace) {
      debugPrint(e);
      if (e.runtimeType != NoInternetException &&
          EnvironmentConfig.env == Flavor.live) {
        final message = e is DioError ? e.response : '';
        unawaited(
            Sentry.captureException(e, stackTrace: stackTrace, hint: message));
        unawaited(FirebaseCrashlytics.instance
            .recordError(e, stackTrace, reason: message));
      }
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }
      if (e is DioError) {
        debugPrint(e.response);
        if (e.response != null &&
            e.response!.data != null &&
            e.response!.data != '' &&
            e.response!.data is Map) {
          String? message;
          if (e.response!.data['errors'] != null) {
            message = e.response!.data['errors'][0]['message'];
          }

          return Left(
            ServerFailure(
              // ignore: avoid_dynamic_calls
              message: message ?? e.response!.data['message'],
            ),
          );
        } else {
          return const Left(
            ServerFailure(
              message: 'Server error, please try again',
            ),
          );
        }
      }
      if (e is ServerException) {
        return Left(ServerFailure(message: e.message));
      }
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<PointStat>>> getPoints(String accountId) async {
    try {
      final result = await remoteDataSource.getPoints(accountId);

      return Right(result);
    } catch (e, stackTrace) {
      debugPrint(e);
      if (e.runtimeType != NoInternetException &&
          EnvironmentConfig.env == Flavor.live) {
        final message = e is DioError ? e.response : '';
        unawaited(
            Sentry.captureException(e, stackTrace: stackTrace, hint: message));
        unawaited(FirebaseCrashlytics.instance
            .recordError(e, stackTrace, reason: message));
      }
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }
      if (e is DioError) {
        debugPrint(e.response);
        if (e.response != null &&
            e.response!.data != null &&
            e.response!.data != '' &&
            e.response!.data is Map) {
          String? message;
          if (e.response!.data['errors'] != null) {
            message = e.response!.data['errors'][0]['message'];
          }

          return Left(
            ServerFailure(
              // ignore: avoid_dynamic_calls
              message: message ?? e.response!.data['message'],
            ),
          );
        } else {
          return const Left(
            ServerFailure(
              message: 'Server error, please try again',
            ),
          );
        }
      }
      if (e is ServerException) {
        return Left(ServerFailure(message: e.message));
      }
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> joinBeta(String accountId) async {
    try {
      final result = await remoteDataSource.joinBeta(accountId);

      return Right(result);
    } catch (e, stackTrace) {
      debugPrint(e);
      if (e.runtimeType != NoInternetException &&
          EnvironmentConfig.env == Flavor.live) {
        final message = e is DioError ? e.response : '';
        unawaited(
            Sentry.captureException(e, stackTrace: stackTrace, hint: message));
        unawaited(FirebaseCrashlytics.instance
            .recordError(e, stackTrace, reason: message));
      }
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }
      if (e is DioError) {
        debugPrint(e.response);
        if (e.response != null &&
            e.response!.data != null &&
            e.response!.data != '' &&
            e.response!.data is Map) {
          String? message;
          if (e.response!.data['errors'] != null) {
            message = e.response!.data['errors'][0]['message'];
          }

          return Left(
            ServerFailure(
              // ignore: avoid_dynamic_calls
              message: message ?? e.response!.data['message'],
            ),
          );
        } else {
          return const Left(
            ServerFailure(
              message: 'Server error, please try again',
            ),
          );
        }
      }
      if (e is ServerException) {
        return Left(ServerFailure(message: e.message));
      }
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> checkAuthToken(String token) async {
    try {
      final result = await remoteDataSource.checkAuthToken(token);

      return Right(result);
    } catch (e, stackTrace) {
      debugPrint(e);
      if (e.runtimeType != NoInternetException &&
          EnvironmentConfig.env == Flavor.live) {
        final message = e is DioError ? e.response : '';
        unawaited(
            Sentry.captureException(e, stackTrace: stackTrace, hint: message));
        unawaited(FirebaseCrashlytics.instance
            .recordError(e, stackTrace, reason: message));
      }
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }
      if (e is DioError) {
        debugPrint(e.response);
        if (e.response != null &&
            e.response!.data != null &&
            e.response!.data != '' &&
            e.response!.data is Map) {
          String? message;
          if (e.response!.data['errors'] != null) {
            message = e.response!.data['errors'][0]['message'];
          }

          return Left(
            ServerFailure(
              // ignore: avoid_dynamic_calls
              message: message ?? e.response!.data['message'],
            ),
          );
        } else {
          return const Left(
            ServerFailure(
              message: 'Server error, please try again',
            ),
          );
        }
      }
      if (e is ServerException) {
        return Left(ServerFailure(message: e.message));
      }
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, String>> uploadAvatar(
      String accountId, String base64) async {
    try {
      final result = await remoteDataSource.uploadAvatar(accountId, base64);

      return Right(result);
    } catch (e, stackTrace) {
      debugPrint(e);
      if (e.runtimeType != NoInternetException &&
          EnvironmentConfig.env == Flavor.live) {
        final message = e is DioError ? e.response : '';
        unawaited(
            Sentry.captureException(e, stackTrace: stackTrace, hint: message));
        unawaited(FirebaseCrashlytics.instance
            .recordError(e, stackTrace, reason: message));
      }
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }
      if (e is DioError) {
        debugPrint(e.response);
        if (e.response != null &&
            e.response!.data != null &&
            e.response!.data != '' &&
            e.response!.data is Map) {
          String? message;
          if (e.response!.data['errors'] != null) {
            message = e.response!.data['errors'][0]['message'];
          }

          return Left(
            ServerFailure(
              // ignore: avoid_dynamic_calls
              message: message ?? e.response!.data['message'],
            ),
          );
        } else {
          return const Left(
            ServerFailure(
              message: 'Server error, please try again',
            ),
          );
        }
      }
      if (e is ServerException) {
        return Left(ServerFailure(message: e.message));
      }
      return Left(UnknownFailure());
    }
  }
}
