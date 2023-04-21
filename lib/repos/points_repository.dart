import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:geniuspay/core/errors/errors.dart';
import 'package:geniuspay/data_sources/points_data_source/points_data_source.dart';
import 'package:geniuspay/environment_config.dart';
import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

abstract class PointsRepository {
  Future<Either<Failure, String>> getPoints();
}

@LazySingleton(as: PointsRepository)
class PointsRepositoryImpl extends PointsRepository {
  PointsRepositoryImpl({
    required this.remoteDataSource,
  });

  final PointsDataSource remoteDataSource;

  @override
  Future<Either<Failure, String>> getPoints() async {
    try {
      final result = await remoteDataSource.getPoints();
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
}
