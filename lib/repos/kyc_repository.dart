import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:geniuspay/core/errors/error.dart';
import 'package:geniuspay/core/errors/failure.dart';
import 'package:geniuspay/data_sources/kyc_data_source/kyc_data_source.dart';
import 'package:geniuspay/environment_config.dart';
import 'package:geniuspay/models/kyc.dart';
import 'package:geniuspay/models/kyc_address.dart';
import 'package:geniuspay/models/kyc_risk_model.dart';
import 'package:geniuspay/models/tin.dart';
import 'package:geniuspay/models/verification_status_response.dart';
import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../util/essentials.dart';

abstract class KycRepository {
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

@LazySingleton(as: KycRepository)
class KycRepositoryImpl extends KycRepository {
  KycRepositoryImpl({
    required this.remoteDataSource,
  });

  final KycDataSource remoteDataSource;

  @override
  Future<Either<Failure, String>> initialiseKYC(KYC kyc) async {
    try {
      final result = await remoteDataSource.initialiseKYC(kyc);

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
            message = e.response!.data['errors'][0]['message'] as String;
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
  Future<Either<Failure, String>> kycRisk(KycRiskAssessment kyc) async {
    try {
      final result = await remoteDataSource.kycRisk(kyc);

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
            message = e.response!.data['errors'][0]['message'] as String;
          }

          return Left(
            ServerFailure(
              // ignore: avoid_dynamic_calls
              message: message ?? e.response!.data['message'] as String,
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
  Future<Either<Failure, String>> kycTaxAssesment(TIN tin) async {
    try {
      final result = await remoteDataSource.kycTaxAssesment(tin);

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
            message = e.response!.data['errors'][0]['message'] as String;
          }

          return Left(
            ServerFailure(
              // ignore: avoid_dynamic_calls
              message: message ?? e.response!.data['message'] as String,
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
  Future<Either<Failure, String>> kycAddressVerification(
      KYCAddress address) async {
    try {
      final result = await remoteDataSource.kycAddressVerification(address);

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
            message = e.response!.data['errors'][0]['message'] as String;
          }

          return Left(
            ServerFailure(
              // ignore: avoid_dynamic_calls
              message: message ?? e.response!.data['message'] as String,
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
  Future<Either<Failure, VerificationStatusResponse>> getKycVerificationStatus(
      String uid) async {
    try {
      final result = await remoteDataSource.getKycVerificationStatus(uid);

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
            message = e.response!.data['errors'][0]['message'] as String;
          }

          return Left(
            ServerFailure(
              // ignore: avoid_dynamic_calls
              message: message ?? e.response!.data['error_message'] as String,
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
  Future<Either<Failure, String>> enterManualDetails(
    String uid,
    String firstName,
    String lastName,
    String DOB,
  ) async {
    try {
      final result = await remoteDataSource.enterManualDetails(
          uid, firstName, lastName, DOB);

      return Right(result);
    } catch (e, stackTrace) {
      debugPrint(e);
      if (e.runtimeType != NoInternetException &&
          EnvironmentConfig.env == Flavor.live) {
        final message = e is DioError ? e.response : '';
        unawaited(
          Sentry.captureException(e, stackTrace: stackTrace, hint: message),
        );
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
            message = e.response!.data['errors'][0]['message'] as String;
          }

          return Left(
            ServerFailure(
              // ignore: avoid_dynamic_calls
              message: message ?? e.response!.data['message'] as String,
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
  Future<Either<Failure, String>> choosePlan({
    required String uid,
    required String planString,
  }) async {
    try {
      final result =
          await remoteDataSource.choosePlan(uid: uid, planString: planString);

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
            message = e.response!.data['errors'][0]['message'] as String;
          }

          return Left(
            ServerFailure(
              // ignore: avoid_dynamic_calls
              message: message ?? e.response!.data['message'] as String,
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
