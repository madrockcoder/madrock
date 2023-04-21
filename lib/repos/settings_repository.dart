import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:geniuspay/core/errors/errors.dart';
import 'package:geniuspay/data_sources/settings_data_source/settings_data_source.dart';
import 'package:geniuspay/environment_config.dart';
import 'package:geniuspay/models/notification_option.dart';
import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import '../util/essentials.dart';

abstract class SettingsRepository {
  Future<Either<Failure, NotificationOption>> updateNotifcationOptin(
      String id, NotificationOption notificationOption);
}

@LazySingleton(as: SettingsRepository)
class SettingsRepositoryImpl extends SettingsRepository {
  SettingsRepositoryImpl({
    required this.remoteDataSource,
  });

  final SettingsDataSource remoteDataSource;

  @override
  Future<Either<Failure, NotificationOption>> updateNotifcationOptin(
      String id, NotificationOption notificationOption) async {
    try {
      final result =
          await remoteDataSource.updateNotifcationOptin(id, notificationOption);
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
}
