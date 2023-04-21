import 'package:dartz/dartz.dart';
import 'package:geniuspay/core/errors/errors.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/models/connect_bank_response.dart';
import 'package:geniuspay/models/nordigen_bank.dart';
import 'package:geniuspay/repos/connect_bank_repository.dart';
import 'package:injectable/injectable.dart';

abstract class ConnectBankService {
  Future<Either<Failure, ConnectBankResponse>> initiateRequisition(
      String accountId, String aspsp);
  Future<Either<Failure, List<NordigenBank>>> getBankAccountsFromCountry(
      String country);
  Future<Either<Failure, ConnectBankResponse>> getStatus(String aspsp);
}

@LazySingleton(as: ConnectBankService)
class ConnectBankServiceImpl extends ConnectBankService {
  final ConnectBankRepository _connectBankRepository =
      sl<ConnectBankRepository>();

  @override
  Future<Either<Failure, ConnectBankResponse>> initiateRequisition(
      String accountId, String aspsp) async {
    return _connectBankRepository.initiateRequisition(accountId, aspsp);
  }

  @override
  Future<Either<Failure, List<NordigenBank>>> getBankAccountsFromCountry(
      String country) {
    return _connectBankRepository.getBankAccountsFromCountry(country);
  }

  @override
  Future<Either<Failure, ConnectBankResponse>> getStatus(String aspsp) {
    return _connectBankRepository.getStatus(aspsp);
  }
}
