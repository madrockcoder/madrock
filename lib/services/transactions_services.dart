import 'package:dartz/dartz.dart';
import 'package:geniuspay/core/errors/errors.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/models/transaction.dart';
import 'package:geniuspay/repos/transactions_repository.dart';
import 'package:injectable/injectable.dart';

abstract class AccountTransactionsService {
  Future<Either<Failure, List<DatedTransaction>>> fetchAccountTransactions(
      String uid, String? pages, String? walletId);
}

@LazySingleton(as: AccountTransactionsService)
class AccountTransactionsServiceImpl extends AccountTransactionsService {
  final AccountTransactionsRepository _transactionRepository =
      sl<AccountTransactionsRepository>();

  @override
  Future<Either<Failure, List<DatedTransaction>>> fetchAccountTransactions(
      String uid, String? pages, String? walletId) async {
    return _transactionRepository.fetchAccountTransactions(
        uid, pages, walletId);
  }
}
