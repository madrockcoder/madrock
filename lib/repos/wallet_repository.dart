import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:geniuspay/core/errors/errors.dart';
import 'package:geniuspay/data_sources/wallet_data_source/wallet_data_source.dart';
import 'package:geniuspay/environment_config.dart';
import 'package:geniuspay/models/country.dart';
import 'package:geniuspay/models/currency.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/models/wallet_account_details.dart';
import 'package:geniuspay/models/wallet_transaction.dart';
import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../util/essentials.dart';

abstract class WalletRepository {
  Future<Either<Failure, List<Country>>> fetchCountries(String searchTerm);
  Future<Either<Failure, Wallet>> createWallet(Wallet wallet);
  Future<Either<Failure, List<Wallet>>> fetchWallets({String searchTerm = '', required String uid});
  Future<Either<Failure, Wallet>> fetchIndividualWallet({required String uid, required String walletId});
  Future<Either<Failure, bool>> setDefaultWallet(Wallet wallet, String uid);
  Future<Either<Failure, List<Currency>>> fetchCurrencies();
  Future<Either<Failure, String>> closeWallet(Wallet wallet, String uid);
  Future<Either<Failure, String>> changeWalletStatus(Wallet wallet, String uid, String status);
  Future<Either<Failure, List<WalletTransaction>>> getWalletTransactions(String walletId, String uid, String? pages);
  Future<Either<Failure, List<WalletAccountDetails>>> fetchWalletAccountDetails(String walletId, String uid);
  Future<Either<Failure, String>> updateFriendlyName(String walletId, String friendlyName, String uid);
  Future<Either<Failure, List<Currency>>> searchCurrencies(String searchTerm);
}

@LazySingleton(as: WalletRepository)
class WalletRepositoryImpl extends WalletRepository {
  WalletRepositoryImpl({required this.remoteDataSource});

  final WalletDataSource remoteDataSource;

  @override
  Future<Either<Failure, List<Country>>> fetchCountries(String searchTerm) async {
    try {
      final result = await remoteDataSource.fetchCountries(searchTerm);

      return Right(result);
    } catch (e, stackTrace) {
      if (e.runtimeType != NoInternetException && EnvironmentConfig.env == Flavor.live) {
        final message = e is DioError ? e.response : '';
        unawaited(Sentry.captureException(e, stackTrace: stackTrace, hint: message));
        unawaited(FirebaseCrashlytics.instance.recordError(e, stackTrace, reason: message));
      }
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }
      if (e is DioError) {
        if (e.response != null && e.response!.data != null && e.response!.data != '' && e.response!.data is Map) {
          return Left(
            ServerFailure(
              // ignore: avoid_dynamic_calls
              message: e.response!.data['message'] ?? 'Service unavailable, please try again!',
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
  //2

  @override
  Future<Either<Failure, Wallet>> createWallet(Wallet wallet) async {
    try {
      final result = await remoteDataSource.createWallet(wallet);

      return Right(result);
    } catch (e) {
      debugPrint(e);
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }
      if (e is DioError) {
        debugPrint(e.response);
        if (e.response != null && e.response!.data != null && e.response!.data != '' && e.response!.data is Map) {
          return Left(
            ServerFailure(
              // ignore: avoid_dynamic_calls
              message: e.response!.data['message'] ?? 'Service unavailable, please try again!',
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
  Future<Either<Failure, String>> updateFriendlyName(String walletId, String friendlyName, String uid) async {
    try {
      final result = await remoteDataSource.updateFriendlyName(walletId, friendlyName, uid);

      return Right(result);
    } catch (e, stackTrace) {
      if (e.runtimeType != NoInternetException && EnvironmentConfig.env == Flavor.live) {
        final message = e is DioError ? e.response : '';
        unawaited(Sentry.captureException(e, stackTrace: stackTrace, hint: message));
        unawaited(FirebaseCrashlytics.instance.recordError(e, stackTrace, reason: message));
      }
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }
      if (e is DioError) {
        if (e.response != null && e.response!.data != null && e.response!.data != '' && e.response!.data is Map) {
          return Left(
            ServerFailure(
              // ignore: avoid_dynamic_calls
              message: e.response!.data['message'] ?? 'Service unavailable, please try again!',
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
  Future<Either<Failure, List<Currency>>> fetchCurrencies() async {
    try {
      final result = await remoteDataSource.fetchCurrencies();

      return Right(result);
    } catch (e, stackTrace) {
      debugPrint(e);
      if (e.runtimeType != NoInternetException && EnvironmentConfig.env == Flavor.live) {
        final message = e is DioError ? e.response : '';
        unawaited(Sentry.captureException(e, stackTrace: stackTrace, hint: message));
        unawaited(FirebaseCrashlytics.instance.recordError(e, stackTrace, reason: message));
      }
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }
      if (e is DioError) {
        debugPrint(e.response);
        if (e.response != null && e.response!.data != null && e.response!.data != '' && e.response!.data is Map) {
          return Left(
            ServerFailure(
              // ignore: avoid_dynamic_calls
              message: e.response!.data['message'] ?? 'Service unavailable, please try again!',
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
  Future<Either<Failure, List<Currency>>> searchCurrencies(String searchTerm) async {
    try {
      final result = await remoteDataSource.searchCurrencies(searchTerm);

      return Right(result);
    } catch (e, stackTrace) {
      if (e.runtimeType != NoInternetException && EnvironmentConfig.env == Flavor.live) {
        final message = e is DioError ? e.response : '';
        unawaited(Sentry.captureException(e, stackTrace: stackTrace, hint: message));
        unawaited(FirebaseCrashlytics.instance.recordError(e, stackTrace, reason: message));
      }
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }
      if (e is DioError) {
        if (e.response != null && e.response!.data != null && e.response!.data != '' && e.response!.data is Map) {
          return Left(
            ServerFailure(
              // ignore: avoid_dynamic_calls
              message: e.response!.data['message'] ?? 'Service unavailable, please try again!',
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
  Future<Either<Failure, String>> closeWallet(Wallet wallet, String uid) async {
    try {
      final result = await remoteDataSource.closeWallet(wallet, uid);

      return Right(result);
    } catch (e, stackTrace) {
      debugPrint(e);
      if (e.runtimeType != NoInternetException && EnvironmentConfig.env == Flavor.live) {
        final message = e is DioError ? e.response : '';
        unawaited(Sentry.captureException(e, stackTrace: stackTrace, hint: message));
        unawaited(FirebaseCrashlytics.instance.recordError(e, stackTrace, reason: message));
      }
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }
      if (e is DioError) {
        debugPrint(e.response);
        if (e.response != null && e.response!.data != null && e.response!.data != '' && e.response!.data is Map) {
          return Left(
            ServerFailure(
              // ignore: avoid_dynamic_calls
              message: e.response?.data['error_message'] ?? 'Service unavailable, please try again!',
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
  Future<Either<Failure, String>> changeWalletStatus(Wallet wallet, String uid, String status) async {
    try {
      final result = await remoteDataSource.changeWalletStatus(wallet, uid, status);

      return Right(result);
    } catch (e, stackTrace) {
      if (e.runtimeType != NoInternetException && EnvironmentConfig.env == Flavor.live) {
        final message = e is DioError ? e.response : '';
        unawaited(Sentry.captureException(e, stackTrace: stackTrace, hint: message));
        unawaited(FirebaseCrashlytics.instance.recordError(e, stackTrace, reason: message));
      }
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }
      if (e is DioError) {
        if (e.response != null && e.response!.data != null && e.response!.data != '' && e.response!.data is Map) {
          return Left(
            ServerFailure(
              // ignore: avoid_dynamic_calls
              message: e.response!.data['message'] ?? 'Service unavailable, please try again!',
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
  Future<Either<Failure, bool>> setDefaultWallet(Wallet wallet, String uid) async {
    try {
      final result = await remoteDataSource.setDefaultWallet(wallet, uid);

      return Right(result);
    } catch (e, stackTrace) {
      if (e.runtimeType != NoInternetException && EnvironmentConfig.env == Flavor.live) {
        final message = e is DioError ? e.response : '';
        unawaited(Sentry.captureException(e, stackTrace: stackTrace, hint: message));
        unawaited(FirebaseCrashlytics.instance.recordError(e, stackTrace, reason: message));
      }
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }
      if (e is DioError) {
        if (e.response != null && e.response!.data != null && e.response!.data != '' && e.response!.data is Map) {
          return Left(
            ServerFailure(
              // ignore: avoid_dynamic_calls
              message: e.response!.data['message'] ?? 'Service unavailable, please try again!',
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
  Future<Either<Failure, List<Wallet>>> fetchWallets({String searchTerm = '', required String uid}) async {
    try {
      final result = await remoteDataSource.fetchWallets(searchTerm: searchTerm, uid: uid);

      return Right(result);
    } catch (e, stackTrace) {
      debugPrint(e);
      if (e.runtimeType != NoInternetException && EnvironmentConfig.env == Flavor.live) {
        final message = e is DioError ? e.response : '';
        unawaited(Sentry.captureException(e, stackTrace: stackTrace, hint: message));
        unawaited(FirebaseCrashlytics.instance.recordError(e, stackTrace, reason: message));
      }
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }
      if (e is DioError) {
        debugPrint(e.response);
        if (e.response != null && e.response!.data != null && e.response!.data != '' && e.response!.data is Map) {
          return Left(
            ServerFailure(
              // ignore: avoid_dynamic_calls
              message: e.response!.data['message'] ?? 'Service unavailable, please try again!',
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
  Future<Either<Failure, List<WalletAccountDetails>>> fetchWalletAccountDetails(String walletId, String uid) async {
    try {
      final result = await remoteDataSource.fetchWalletAccountDetails(walletId, uid);

      return Right(result);
    } catch (e, stackTrace) {
      debugPrint(e);
      if (e.runtimeType != NoInternetException && EnvironmentConfig.env == Flavor.live) {
        final message = e is DioError ? e.response : '';
        unawaited(Sentry.captureException(e, stackTrace: stackTrace, hint: message));
        unawaited(FirebaseCrashlytics.instance.recordError(e, stackTrace, reason: message));
      }
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }
      if (e is DioError) {
        debugPrint(e.response);
        if (e.response != null && e.response!.data != null && e.response!.data != '' && e.response!.data is Map) {
          return Left(
            ServerFailure(
              // ignore: avoid_dynamic_calls
              message: e.response!.data['message'] ?? 'Service unavailable, please try again!',
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
  Future<Either<Failure, List<WalletTransaction>>> getWalletTransactions(String walletId, String uid, String? pages) async {
    try {
      final result = await remoteDataSource.getWalletTransactions(walletId, uid, pages);

      return Right(result);
    } catch (e, stackTrace) {
      debugPrint(e);
      if (e.runtimeType != NoInternetException && EnvironmentConfig.env == Flavor.live) {
        final message = e is DioError ? e.response : '';
        unawaited(Sentry.captureException(e, stackTrace: stackTrace, hint: message));
        unawaited(FirebaseCrashlytics.instance.recordError(e, stackTrace, reason: message));
      }
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }
      if (e is DioError) {
        debugPrint(e.response);
        if (e.response != null && e.response!.data != null && e.response!.data != '' && e.response!.data is Map) {
          return Left(
            ServerFailure(
              // ignore: avoid_dynamic_calls
              message: e.response!.data['message'] ?? 'Service unavailable, please try again!',
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
  Future<Either<Failure, Wallet>> fetchIndividualWallet({required String uid, required String walletId}) async {
    try {
      final result = await remoteDataSource.fetchIndividualWallet(uid: uid, walletId: walletId);

      return Right(result);
    } catch (e, stackTrace) {
      debugPrint(e);
      if (e.runtimeType != NoInternetException && EnvironmentConfig.env == Flavor.live) {
        final message = e is DioError ? e.response : '';
        unawaited(Sentry.captureException(e, stackTrace: stackTrace, hint: message));
        unawaited(FirebaseCrashlytics.instance.recordError(e, stackTrace, reason: message));
      }
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }
      if (e is DioError) {
        debugPrint(e.response);
        if (e.response != null && e.response!.data != null && e.response!.data != '' && e.response!.data is Map) {
          return Left(
            ServerFailure(
              // ignore: avoid_dynamic_calls
              message: e.response!.data['message'] ?? 'Service unavailable, please try again!',
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
