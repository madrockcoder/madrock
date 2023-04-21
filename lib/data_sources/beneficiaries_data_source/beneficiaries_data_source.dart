import 'package:dio/dio.dart';
import 'package:geniuspay/core/errors/error.dart';
import 'package:geniuspay/core/network/http_requester.dart';
import 'package:geniuspay/core/network/network_info.dart';
import 'package:geniuspay/models/bank_beneficiary.dart';
import 'package:geniuspay/models/bank_beneficiary_requirements.dart';
import 'package:geniuspay/models/bsb_validator.dart';
import 'package:geniuspay/models/country.dart';
import 'package:geniuspay/models/email_recipient.dart';
import 'package:geniuspay/models/iban_validator.dart';
import 'package:geniuspay/models/ifsc_validator.dart';
import 'package:geniuspay/models/mobile_recipient.dart';
import 'package:geniuspay/models/swift_validator.dart';
import 'package:geniuspay/repos/api_path.dart';
import 'package:geniuspay/repos/local_repo.dart';
import 'package:geniuspay/util/enums.dart';
import 'package:geniuspay/util/security.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

abstract class BeneficiariesDataSource {
  Future<List<Country>> fetchMMTCountries();
  Future<List<EmailRecipient>> fetchgeniuspayEmailRecipients(String accountId);
  Future<List<MobileRecipient>> fetchgeniuspayMobileRecipients(String accountId);
  Future<EmailRecipient> addEmailRecipient(String accountId, String email);
  Future<MobileRecipient> addMobileRecipient(MobileRecipient mobileRecipient);

  Future<List<BankBeneficiary>> fetchBankBeneficiary(String accountId);
  Future<List<BankBeneficiaryRequirements>> fetchBankBeneficiaryRequirements(
      String currency, String countryIso2, BankRecipientType type);
  Future<BankBeneficiary> addBankBeneficiary(
      BankBeneficiary beneficiary, String? identifierType);
  Future<IbanValidatorModel> validateIban(String iBan);
  Future<SwiftValidatorModel> validateSwift(String swift);
  Future<IfscValidatorModel> validateIfsc(String ifsc);
  Future<BsbValidatorModel> validateBsb(String bsb);
}

@LazySingleton(as: BeneficiariesDataSource)
class BeneficiariesDataSourceImpl
    with HMACSecurity
    implements BeneficiariesDataSource {
  BeneficiariesDataSourceImpl(
      {required this.networkInfo,
      required this.localDataStorage,
      required this.dio,
      required this.httpClient});
  final NetworkInfo networkInfo;
  final LocalBase localDataStorage;
  final Dio dio;
  final HttpServiceRequester httpClient;

  @override
  Future<List<Country>> fetchMMTCountries() async {
    if (await networkInfo.isConnected) {
      final result =
          await httpClient.getRequest(endpoint: APIPath.fetchMMTCountries);
      final body = result.data['results'];
      return CountrylList.fromJson(body).list;
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<List<EmailRecipient>> fetchgeniuspayEmailRecipients(
      String accountId) async {
    if (await networkInfo.isConnected) {
      final result = await httpClient.getRequest(
          endpoint: APIPath.fetchUserRecipients(accountId));
      final body = result.data['results'];
      return EmailRecipientList.fromJson(body).list;
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<List<MobileRecipient>> fetchgeniuspayMobileRecipients(
      String accountId) async {
    if (await networkInfo.isConnected) {
      final result = await httpClient.getRequest(
          endpoint: APIPath.fetchUserMobileRecipients(accountId));
      final body = result.data['results'];
      return MobileRecipientList.fromJson(body).list;
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<EmailRecipient> addEmailRecipient(
      String accountId, String email) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      final result = await httpClient.post(
          endpoint: APIPath.addEmailRecipient,
          uuid: uuid,
          body: {"user": accountId, "email": email});
      return EmailRecipient.fromMap(result.data);
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<MobileRecipient> addMobileRecipient(
      MobileRecipient mobileRecipient) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      var mobileRecipientMap = mobileRecipient.toMap();
      mobileRecipientMap
          .removeWhere((key, value) => value == null || value == '');
      final result = await httpClient.post(
          endpoint: APIPath.addMobileRecipient,
          uuid: uuid,
          body: mobileRecipientMap);
      return MobileRecipient.fromMap(result.data);
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<List<BankBeneficiary>> fetchBankBeneficiary(String accountId) async {
    if (await networkInfo.isConnected) {
      final result = await httpClient.getRequest(
          endpoint: APIPath.fetchBankBeneficiaries(accountId));
      final body = result.data['results'];
      print(body[2]);
      return BankBeneficiaryList.fromJson(body).list;
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<List<BankBeneficiaryRequirements>> fetchBankBeneficiaryRequirements(
      String currency, String countryIso2, BankRecipientType type) async {
    if (await networkInfo.isConnected) {
      final result = await httpClient.getRequest(
          endpoint: APIPath.getBankBeneficiaryRequirements(
        currency,
        countryIso2,
      ));
      final body = result.data;
      final list = BankBeneficiaryRequirementsList.fromJson(body).list;
      if (list.isNotEmpty) {
        list.removeWhere((element) => element.beneficiaryEntityType != type);
      } else {
        list.add(BankBeneficiaryRequirements(
            beneficiaryEntityType: type,
            paymentType: PaymentType.regular,
            beneficiaryCountry: countryIso2,
            iBan: ''));
      }
      return list;
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<BankBeneficiary> addBankBeneficiary(
      BankBeneficiary beneficiary, String? identifierType) async {
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      final body = {
        "owned_by_user": beneficiary.ownedByUser,
        "user": beneficiary.user,
        "friendly_name": beneficiary.friendlyName,
        "currency": beneficiary.currency,
        if (identifierType != null) "bank_country": beneficiary.bankCountryIso2,
        if (identifierType != null) "identifier_type": identifierType,
        if (beneficiary.identifierValue != null)
          "identifier_value": beneficiary.identifierValue,
        "beneficiary_entity_type": bankEnumString(beneficiary.beneficiaryType),
        if (beneficiary.beneficiaryFirstName != null)
          "beneficiary_first_name": beneficiary.beneficiaryFirstName,
        if (beneficiary.beneficiaryLastName != null)
          "beneficiary_last_name": beneficiary.beneficiaryLastName,
        if (beneficiary.companyName != null)
          "beneficiary_company_name": beneficiary.companyName,
        if (beneficiary.accountNumber != null)
          "account_number": beneficiary.accountNumber,
        if (beneficiary.iBan != null) "iban": beneficiary.iBan,
        if (beneficiary.beneficiaryAddress != null)
          "beneficiary_address": beneficiary.beneficiaryAddress?.addressLine1,
        if (beneficiary.beneficiaryAddress != null)
          "beneficiary_city": beneficiary.beneficiaryAddress?.city,
        if (beneficiary.beneficiaryAddress != null)
          "beneficiary_state_or_province":
              beneficiary.beneficiaryAddress?.state,
        if (beneficiary.beneficiaryAddress != null)
          "beneficiary_zip_code": beneficiary.beneficiaryAddress?.zipCode,
        "beneficiary_country": beneficiary.bankCountryIso2,
        if (beneficiary.bankCode != null) "bank_code": beneficiary.bankCode,
        if (beneficiary.branchCode != null)
          "branch_code": beneficiary.branchCode
      };
      final result = await httpClient.post(
          endpoint: identifierType == null
              ? APIPath.addIbanBankBeneficiary
              : APIPath.addBankBeneficiary,
          uuid: uuid,
          body: body);
      return BankBeneficiary.fromMap(result.data);
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<IbanValidatorModel> validateIban(String iBan) async {
    if (await networkInfo.isConnected) {
      final result =
          await httpClient.getRequest(endpoint: APIPath.validateIban(iBan));
      final body = result.data;
      return IbanValidatorModel.fromMap(body);
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<SwiftValidatorModel> validateSwift(String swift) async {
    if (await networkInfo.isConnected) {
      final result =
          await httpClient.getRequest(endpoint: APIPath.validateSwift(swift));
      final body = result.data;
      return SwiftValidatorModel.fromMap(body);
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<IfscValidatorModel> validateIfsc(String ifsc) async {
    if (await networkInfo.isConnected) {
      final result =
          await httpClient.getRequest(endpoint: APIPath.validateIfsc(ifsc));
      final body = result.data;
      return IfscValidatorModel.fromMap(body);
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<BsbValidatorModel> validateBsb(String bsb) async {
    if (await networkInfo.isConnected) {
      final result =
          await httpClient.getRequest(endpoint: APIPath.validateBsb(bsb));
      final body = result.data;
      return BsbValidatorModel.fromMap(body);
    } else {
      throw NoInternetException();
    }
  }
}
