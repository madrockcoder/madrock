import 'package:flutter/material.dart';
import 'package:geniuspay/app/auth/view_models/select_country_view_model.dart';
import 'package:geniuspay/app/payout/beneficiaries/widgets/add_success_popup.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/core/errors/errors.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/models/country.dart';
import 'package:geniuspay/models/mobile_recipient.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/services/beneficiaries_services.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class MobileRecipientVM extends BaseModel {
  final AuthenticationService _authenticationService =
  sl<AuthenticationService>();
  final BeneficiariesService _beneficiariesService = sl<BeneficiariesService>();
  BaseModelState baseModelState = BaseModelState.loading;
  void changeState(BaseModelState state) {
    baseModelState = state;
    notifyListeners();
  }

  List<MobileRecipient> mobileRecipients = [];
  List<Country> mmtCountries = [];

  Future<void> getMobileRecipients(context) async {
    baseModelState = BaseModelState.loading;
    changeState(baseModelState);
    final SelectCountryViewModel _selectCountryViewModel =
    sl<SelectCountryViewModel>();
    await _selectCountryViewModel.getCountries(context);
    final result = await _beneficiariesService
        .fetchgeniuspayMobileRecipients(_authenticationService.user!.id);
    result.fold((l) {
      changeState(BaseModelState.error);
    }, (r) {
      mobileRecipients = r;
      changeState(BaseModelState.success);
    });
  }

  Future<void> getMMTCountries() async {
    baseModelState = BaseModelState.loading;
    final result = await _beneficiariesService
        .fetchMMTCountries();
    result.fold((l) {
      changeState(BaseModelState.error);
    }, (r) {
      mmtCountries = r;
      changeState(BaseModelState.success);
    });
  }

  Future<void> addMobileRecipient(
      BuildContext context, MobileRecipient mobileRecipient) async {
    baseModelState = BaseModelState.loading;
    final result = await _beneficiariesService.addMobileRecipient(mobileRecipient);
    result.fold((l) {
      PopupDialogs(context).errorMessage(FailureToMessage.mapFailureToMessage(l));
    }, (r) async {
      showDialog(
          context: context,
          builder: (context) {
            return AddSuccessPopup(recipient: r);
          });
    });
  }
}
