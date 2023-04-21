import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:geniuspay/app/devices/model/device_model.dart';
import 'package:geniuspay/core/errors/error.dart';
import 'package:geniuspay/core/errors/failure.dart';
import 'package:geniuspay/data_sources/devices_data_source/devices_data_source.dart';
import 'package:geniuspay/environment_config.dart';
import 'package:geniuspay/util/essentials.dart';
import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

abstract class DevicesRepository {
  Future<Either<Failure, List<DeviceModel>>> fetchDevices(
    String searchTerm,
    int pageNumber,
    int pageSize,
  );

  Future<Either<Failure, DeviceModel>> createDevice(
    String deviceID, {
    required String name,
    required String registrationID,
    required bool active,
    required String type,
  });
}

@LazySingleton(as: DevicesRepository)
class DevicesRepositoryImpl implements DevicesRepository {
  final DevicesDataSource devicesDataSource;

  DevicesRepositoryImpl({
    required this.devicesDataSource,
  });

  @override
  Future<Either<Failure, DeviceModel>> createDevice(
    String deviceID, {
    required String name,
    required String registrationID,
    required bool active,
    required String type,
  }) async {
    try {
      final result = await devicesDataSource.createDevice(
        deviceID,
        name: name,
        registrationID: registrationID,
        active: active,
        type: type,
      );
      return Right(result!);
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
  Future<Either<Failure, List<DeviceModel>>> fetchDevices(
      String searchTerm, int pageNumber, int pageSize) async {
    try {
      final result = await devicesDataSource.fetchAllDevices(
          searchTerm, pageNumber, pageSize);
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
