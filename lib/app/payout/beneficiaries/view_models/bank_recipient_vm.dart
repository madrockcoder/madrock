import 'package:flutter/material.dart';
import 'package:geniuspay/app/payout/beneficiaries/screens/bank_beneficiary/bank_add_account_details.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/models/bank_beneficiary.dart';
import 'package:geniuspay/models/bank_beneficiary_requirements.dart';
import 'package:geniuspay/models/bsb_validator.dart';
import 'package:geniuspay/models/country.dart';
import 'package:geniuspay/models/iban_validator.dart';
import 'package:geniuspay/models/ifsc_validator.dart';
import 'package:geniuspay/models/swift_validator.dart';
import 'package:geniuspay/models/user_profile.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/services/beneficiaries_services.dart';
import 'package:geniuspay/util/converter.dart';
import 'package:geniuspay/util/enum_converter.dart';
import 'package:geniuspay/util/enums.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class BankRecipientVM extends BaseModel with EnumConverter {
  final AuthenticationService _authenticationService =
      sl<AuthenticationService>();
  final BeneficiariesService _beneficiariesService = sl<BeneficiariesService>();
  BaseModelState baseModelState = BaseModelState.loading;
  void changeState(BaseModelState state) {
    baseModelState = state;
    notifyListeners();
  }

  BankBeneficiary bankBeneficiary = BankBeneficiary(
      user: '',
      currency: '',
      bankCountryIso2: '',
      beneficiaryType: BankRecipientType.individual,
      beneficiaryFirstName: '',
      beneficiaryLastName: '',
      beneficiaryCountry: '');

  List<BankBeneficiary> bankBeneficiaries = [];
  List<BankBeneficiary> allBankBeneficiaries = [];
  BankBeneficiary? lastUsedBankBeneficiary;

  Future<void> getBankBeneficiaries() async {
    baseModelState = BaseModelState.loading;
    final result = await _beneficiariesService
        .fetchBankBeneficiary(_authenticationService.user!.id);
    result.fold((l) {
      changeState(BaseModelState.error);
    }, (r) {
      bankBeneficiaries = r;
      allBankBeneficiaries = r;
      try {
        lastUsedBankBeneficiary = r.reduce((a, b) => Converter()
                .getDateFormatFromString(a.lastUsed!)
                .isAfter(Converter().getDateFormatFromString(b.lastUsed!))
            ? a
            : b);
      } catch (e) {}

      changeState(BaseModelState.success);
    });
  }

  Future<void> searchBeneficiary(String searchTerm) async {
    searchTerm = searchTerm.toLowerCase();
    if (searchTerm.isNotEmpty) {
      final result = bankBeneficiaries
          .where((element) =>
              (element.friendlyName?.toLowerCase().contains(searchTerm) ??
                  false) ||
              (element.beneficiaryFirstName
                      ?.toLowerCase()
                      .contains(searchTerm) ??
                  false) ||
              (element.beneficiaryLastName
                      ?.toLowerCase()
                      .contains(searchTerm) ??
                  false) ||
              (element.companyName?.toLowerCase().contains(searchTerm) ??
                  false))
          .toList();
      bankBeneficiaries = result;
    } else {
      bankBeneficiaries = allBankBeneficiaries;
    }
    notifyListeners();
  }

  Future<void> addBankBeneficiary(
      BuildContext context, Function(BankBeneficiary) onselected) async {
    bankBeneficiary.user = _authenticationService.user!.id;
    final result = await _beneficiariesService.addBankBeneficiary(
        bankBeneficiary,
        bankBeneficiary.idenitifierType == null
            ? null
            : getBankIdentifierType(bankBeneficiary.idenitifierType!));
    result.fold((l) {
      PopupDialogs(context).errorMessage(
          'Unable to add this account. Please try again later ${l.props[0]}');
    }, (r) {
      Navigator.pop(context);
      onselected(r);
    });
  }

  void changeSelf(bool isSelf) {
    bankBeneficiary.ownedByUser = isSelf;
    notifyListeners();
  }

  void setIndividual(String firstName, String lastName, String nickName) {
    bankBeneficiary.beneficiaryFirstName = firstName;
    bankBeneficiary.beneficiaryLastName = lastName;
    if (nickName.isNotEmpty) {
      bankBeneficiary.friendlyName = nickName;
    }
    notifyListeners();
  }

  void setCompany(String companyName, String nickName) {
    bankBeneficiary.companyName = companyName;
    if (nickName.isNotEmpty) {
      bankBeneficiary.friendlyName = nickName;
    }
    notifyListeners();
  }

  Future<void> fetchBankBeneficiaryRequirements(
      BuildContext context,
      Country country,
      BankRecipientType type,
      BankRecipientVM viewModel,
      Function(BankBeneficiary?) onselected) async {
    bankBeneficiary.bankCountryIso2 = country.iso2;
    bankBeneficiary.beneficiaryCountry = country.iso2;
    bankBeneficiary.currency = country.currencyISO;
    bankBeneficiary.beneficiaryType = type;

    final result = await _beneficiariesService.fetchBankBeneficiaryRequirements(
        country.currencyISO, country.iso2, type);
    result.fold((l) {
      PopupDialogs(context)
          .errorMessage('Unable to proceed. Please try again later');
    }, (r) {
      BankAddAccountDetails.show(context, viewModel, r.first, onselected);
    });
  }

  void setIdentifier(BankBeneficiaryRequirements requirements, String value) {
    if (requirements.sortCode != null) {
      bankBeneficiary.idenitifierType = BankIdentifierType.sortCode;
    } else if (requirements.bicSwift != null) {
      bankBeneficiary.idenitifierType = BankIdentifierType.bicSwift;
    } else if (requirements.bsbCode != null) {
      bankBeneficiary.idenitifierType = BankIdentifierType.bsbCode;
    } else if (requirements.ifsc != null) {
      bankBeneficiary.idenitifierType = BankIdentifierType.ifsc;
    } else if (requirements.clabe != null) {
      bankBeneficiary.idenitifierType = BankIdentifierType.clabe;
    } else if (requirements.branchCode != null) {
      bankBeneficiary.idenitifierType = BankIdentifierType.branchCode;
    } else if (requirements.bankCode != null) {
      bankBeneficiary.idenitifierType = BankIdentifierType.bankCode;
    } else if (requirements.institutionCode != null) {
      bankBeneficiary.idenitifierType = BankIdentifierType.institutionCode;
    } else if (requirements.aba != null) {
      bankBeneficiary.idenitifierType = BankIdentifierType.aba;
    }
    bankBeneficiary.identifierValue = value;
    notifyListeners();
  }

  void setAddress(String street, String city, String postCode, String state) {
    bankBeneficiary.beneficiaryAddress = Address(
        id: 'id',
        addressLine1: 'street',
        state: state,
        city: city,
        countryIso2: bankBeneficiary.beneficiaryCountry,
        status: 'status',
        zipCode: postCode,
        addressLine2: '');
    notifyListeners();
  }

  void setIban(String iban) {
    bankBeneficiary.iBan = iban;
    notifyListeners();
  }

  void setAccountNumber(String accountNumber) {
    bankBeneficiary.accountNumber = accountNumber;
    notifyListeners();
  }

  Future<IbanValidatorModel?> verifyIban(
      BuildContext context, String iBan) async {
    final result = await _beneficiariesService.validateIban(iBan);
    if (result.isLeft()) {
      result.fold((l) {
        PopupDialogs(context).errorMessage('Unable to validate Iban. $l');
      }, (r) => null);

      return null;
    } else {
      IbanValidatorModel? validator;
      result.foldRight(IbanValidatorModel, (r, previous) => validator = r);
      if (!validator!.isValid) {
        PopupDialogs(context).errorMessage('This is an invalid IBAN');
      }
      return validator;
    }
  }

  List<String> sepaCurrencies = [
    "EUR",
    "BGN",
    "HRK",
    "CZK",
    "DKK",
    "GIP",
    "GBP",
    "HUF",
    "ISK",
    "CHF",
    "NOK",
    "PLN",
    "RON",
    "SEK"
  ];

  Future<SwiftValidatorModel?> verifySwift(
      BuildContext context, String swift) async {
    final result = await _beneficiariesService.validateSwift(swift);
    if (result.isLeft()) {
      result.fold((l) {
        PopupDialogs(context)
            .errorMessage('Unable to validate Iban. ${l.props[0]}');
      }, (r) => null);

      return null;
    } else {
      SwiftValidatorModel? validator;
      result.foldRight(IbanValidatorModel, (r, previous) => validator = r);
      return validator;
    }
  }

  Future<IfscValidatorModel?> verifyIfsc(
      BuildContext context, String ifsc) async {
    final result = await _beneficiariesService.validateIfsc(ifsc);
    if (result.isLeft()) {
      result.fold((l) {
        PopupDialogs(context)
            .errorMessage('Unable to validate Iban. ${l.props[0]}');
      }, (r) => null);

      return null;
    } else {
      IfscValidatorModel? validator;
      result.foldRight(IbanValidatorModel, (r, previous) => validator = r);
      return validator;
    }
  }

  Future<BsbValidatorModel?> verifyBsb(BuildContext context, String bsb) async {
    final result = await _beneficiariesService.validateBsb(bsb);
    if (result.isLeft()) {
      result.fold((l) {
        PopupDialogs(context)
            .errorMessage('Unable to validate Iban. ${l.props[0]}');
      }, (r) => null);

      return null;
    } else {
      BsbValidatorModel? validator;
      result.foldRight(IbanValidatorModel, (r, previous) => validator = r);
      return validator;
    }
  }
}
