import 'package:dartz/dartz.dart';
import 'package:geniuspay/core/errors/errors.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/models/bank_beneficiary.dart';
import 'package:geniuspay/models/bank_beneficiary_requirements.dart';
import 'package:geniuspay/models/country.dart';
import 'package:geniuspay/models/bsb_validator.dart';
import 'package:geniuspay/models/email_recipient.dart';
import 'package:geniuspay/models/iban_validator.dart';
import 'package:geniuspay/models/mobile_recipient.dart';
import 'package:geniuspay/models/ifsc_validator.dart';
import 'package:geniuspay/models/swift_validator.dart';
import 'package:geniuspay/repos/beneficiaries_repository.dart';
import 'package:geniuspay/util/enums.dart';
import 'package:injectable/injectable.dart';

abstract class BeneficiariesService {
  Future<Either<Failure, List<EmailRecipient>>> fetchgeniuspayEmailRecipients(
      String accountId);
  Future<Either<Failure, List<MobileRecipient>>> fetchgeniuspayMobileRecipients(
      String accountId);
  Future<Either<Failure, List<Country>>> fetchMMTCountries();
  Future<Either<Failure, EmailRecipient>> addEmailRecipient(
      String accountId, String email);
  Future<Either<Failure, MobileRecipient>> addMobileRecipient(MobileRecipient mobileRecipient);
  Future<Either<Failure, List<BankBeneficiaryRequirements>>>
      fetchBankBeneficiaryRequirements(
          String currency, String countryIso2, BankRecipientType type);
  Future<Either<Failure, List<BankBeneficiary>>> fetchBankBeneficiary(
      String accountId);
  Future<Either<Failure, BankBeneficiary>> addBankBeneficiary(
      BankBeneficiary beneficiary, String? identifierType);
  Future<Either<Failure, IbanValidatorModel>> validateIban(String iBan);
  Future<Either<Failure, SwiftValidatorModel>> validateSwift(String swift);
  Future<Either<Failure, IfscValidatorModel>> validateIfsc(String ifsc);
  Future<Either<Failure, BsbValidatorModel>> validateBsb(String bsb);
}

@LazySingleton(as: BeneficiariesService)
class BeneficiariesServiceImpl extends BeneficiariesService {
  final BeneficiariesRepository _beneficiariesRepository =
      sl<BeneficiariesRepository>();

  @override
  Future<Either<Failure, List<EmailRecipient>>> fetchgeniuspayEmailRecipients(
      String accountId) async {
    return _beneficiariesRepository.fetchgeniuspayEmailRecipients(accountId);
  }

  @override
  Future<Either<Failure, List<Country>>> fetchMMTCountries() async {
    return _beneficiariesRepository.fetchMMTCountries();
  }

  @override
  Future<Either<Failure, List<MobileRecipient>>> fetchgeniuspayMobileRecipients(
      String accountId) async {
    return _beneficiariesRepository.fetchgeniuspayMobileRecipients(accountId);
  }

  @override
  Future<Either<Failure, EmailRecipient>> addEmailRecipient(
      String accountId, String email) async {
    return _beneficiariesRepository.addEmailRecipient(accountId, email);
  }

  @override
  Future<Either<Failure, MobileRecipient>> addMobileRecipient(MobileRecipient mobileRecipient) async {
    return _beneficiariesRepository.addMobileRecipient(mobileRecipient);
  }

  @override
  Future<Either<Failure, List<BankBeneficiaryRequirements>>>
      fetchBankBeneficiaryRequirements(
          String currency, String countryIso2, BankRecipientType type) async {
    return _beneficiariesRepository.fetchBankBeneficiaryRequirements(
        currency, countryIso2, type);
  }

  @override
  Future<Either<Failure, List<BankBeneficiary>>> fetchBankBeneficiary(
      String accountId) async {
    return _beneficiariesRepository.fetchBankBeneficiary(accountId);
  }

  @override
  Future<Either<Failure, BankBeneficiary>> addBankBeneficiary(
      BankBeneficiary beneficiary, String? identifierType) async {
    return _beneficiariesRepository.addBankBeneficiary(
        beneficiary, identifierType);
  }

  @override
  Future<Either<Failure, IbanValidatorModel>> validateIban(String iBan) async {
    return _beneficiariesRepository.validateIban(iBan);
  }

  @override
  Future<Either<Failure, SwiftValidatorModel>> validateSwift(
      String swift) async {
    return _beneficiariesRepository.validateSwift(swift);
  }

  @override
  Future<Either<Failure, IfscValidatorModel>> validateIfsc(String ifsc) async {
    return _beneficiariesRepository.validateIfsc(ifsc);
  }

  @override
  Future<Either<Failure, BsbValidatorModel>> validateBsb(String bsb) async {
    return _beneficiariesRepository.validateBsb(bsb);
  }
}
