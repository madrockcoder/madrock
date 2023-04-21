import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:geniuspay/core/errors/errors.dart';
import 'package:geniuspay/data_sources/transactions_data_source/transactions_data_source.dart';
import 'package:geniuspay/environment_config.dart';
import 'package:geniuspay/models/transaction.dart';
import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import '../util/essentials.dart';

abstract class AccountTransactionsRepository {
  Future<Either<Failure, List<DatedTransaction>>> fetchAccountTransactions(
      String uid, String? pages, String? walletId);
}

@LazySingleton(as: AccountTransactionsRepository)
class AccountTransactionsRepositoryImpl extends AccountTransactionsRepository {
  AccountTransactionsRepositoryImpl({
    required this.remoteDataSource,
  });

  final TransactionsDataSource remoteDataSource;

  @override
  Future<Either<Failure, List<DatedTransaction>>> fetchAccountTransactions(
      String uid, String? pages, String? walletId) async {
    try {
      final result =
          await remoteDataSource.fetchAccountTransactions(uid, pages, walletId);
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
