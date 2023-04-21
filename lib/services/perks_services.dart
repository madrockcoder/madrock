import 'package:dartz/dartz.dart';
import 'package:geniuspay/core/errors/errors.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/models/perk.dart';
import 'package:geniuspay/repos/perks_repository.dart';
import 'package:injectable/injectable.dart';

abstract class PerksService {
  Future<Either<Failure, List<Perk>>> getPerkList();
  Future<Either<Failure, String>> claimPerk(String accountId, String perkId);
  Future<Either<Failure, List<String>>> getPerksCategories();
}

@LazySingleton(as: PerksService)
class PerksServiceImpl extends PerksService {
  final PerksRepository _transactionRepository = sl<PerksRepository>();

  @override
  Future<Either<Failure, List<Perk>>> getPerkList() async {
    return _transactionRepository.getPerkList();
  }

  @override
  Future<Either<Failure, String>> claimPerk(
      String accountId, String perkId) async {
    return _transactionRepository.claimPerk(accountId, perkId);
  }

  @override
  Future<Either<Failure, List<String>>> getPerksCategories() async {
    return _transactionRepository.getPerksCategories();
  }
}
