import 'package:flutter/material.dart';
import 'package:geniuspay/app/auth/view_models/select_country_view_model.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/app/wallet/connect_bank_account/go_further_page.dart';
import 'package:geniuspay/app/wallet/connect_bank_account/results_page.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/models/country.dart';
import 'package:geniuspay/models/nordigen_bank.dart';
import 'package:geniuspay/models/user.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/services/connect_bank_services.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SelectBankVM extends BaseModel {
  //list of all country
  final AuthenticationService _authenticationService =
      sl<AuthenticationService>();

  final SelectCountryViewModel _selectCountryViewModel =
      sl<SelectCountryViewModel>();

  final ConnectBankService _connectBankService = sl<ConnectBankService>();

  User? get user => _authenticationService.user;
  List<NordigenBank> bankList = [];
  Country? country;
  BaseModelState baseModelState = BaseModelState.loading;
  void changeState(BaseModelState state) {
    baseModelState = state;
    notifyListeners();
  }

  void changeCountry(Country _country) {
    country = _country;
    notifyListeners();
    getBanks(country!.iso2);
  }

  Future<void> getCountry(BuildContext context) async {
    country = await _selectCountryViewModel.getCountryFromIso(context, 'GB');
    notifyListeners();
    getBanks(country!.iso2);
  }

  Future<void> getBanks(String country) async {
    final result =
        await _connectBankService.getBankAccountsFromCountry(country);
    result.fold((l) => null, (r) {
      bankList = r;
      changeState(BaseModelState.success);
    });
  }

  Future<void> initiateRequisition(
      BuildContext context, NordigenBank bank) async {
    if (_authenticationService.user!.userProfile.aisConsent == null) {
      final result = await _connectBankService.initiateRequisition(
          _authenticationService.user!.id, bank.id);
      result.fold((l) {
        PopupDialogs(context).errorMessage('Unable to initiate request');
      }, (r) {
        GoFurtherPage.show(context, r, bank);
      });
    } else {
      GoFurtherPage.show(
          context, _authenticationService.user!.userProfile.aisConsent!, bank);
    }
  }

  Future<void> getStatus(
      BuildContext context, String consentId, NordigenBank bank) async {
    final result = await _connectBankService.getStatus(consentId);
    result.fold((l) {
      PopupDialogs(context).errorMessage('Error Fetching status');
    }, (r) {
      if (r.status == 'LN') {
        ResultsPage.show(
            context, 'Your account was successfully linked to geniuspay', bank);
      } else {
        PopupDialogs(context)
            .errorMessage('Bank account connection unsuccessful');
      }
    });
  }
}
