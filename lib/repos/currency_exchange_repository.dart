import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:geniuspay/core/errors/errors.dart';
import 'package:geniuspay/data_sources/currency_exchange_data_source/currency_exchange_data_source.dart';
import 'package:geniuspay/environment_config.dart';
import 'package:geniuspay/models/conversion.dart';
import 'package:geniuspay/models/exchange_rate.dart';
import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import '../util/essentials.dart';

abstract class CurrencyExchangeRepository {
  Future<Either<Failure, ExchangeRate>> fetchExchangeRate(
      String buyCurrency, String sellCurrency, String fixedSide, String amount);
  Future<Either<Failure, Conversion>> createConversion(
      ExchangeRate exchangeRate,
      String uid,
      String buyingWalletId,
      String sellingWalletId);
  Future<Either<Failure, List<Conversion>>> getTransactions(
      {required String uid, String? pages});
}

@LazySingleton(as: CurrencyExchangeRepository)
class CurrencyExchangeRepositoryImpl extends CurrencyExchangeRepository {
  CurrencyExchangeRepositoryImpl({
    required this.remoteDataSource,
  });

  final CurrencyExchangeDataSource remoteDataSource;

  @override
  Future<Either<Failure, ExchangeRate>> fetchExchangeRate(String buyCurrency,
      String sellCurrency, String fixedSide, String amount) async {
    try {
      final result = await remoteDataSource.fetchExchangeRate(
          buyCurrency, sellCurrency, fixedSide, amount);

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
  Future<Either<Failure, Conversion>> createConversion(
      ExchangeRate exchangeRate,
      String uid,
      String buyingWalletId,
      String sellingWalletId) async {
    try {
      final result = await remoteDataSource.createConversion(
          exchangeRate, uid, buyingWalletId, sellingWalletId);

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
  Future<Either<Failure, List<Conversion>>> getTransactions(
      {required String uid, String? pages}) async {
    try {
      final result =
          await remoteDataSource.getTransactions(uid: uid, pages: pages);

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
