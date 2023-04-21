import 'package:flutter/material.dart';
import 'package:geniuspay/app/payout/beneficiaries/widgets/add_success_popup.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/models/email_recipient.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/services/beneficiaries_services.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class BorderLessRecipientVM extends BaseModel {
  final AuthenticationService _authenticationService =
      sl<AuthenticationService>();
  final BeneficiariesService _beneficiariesService = sl<BeneficiariesService>();
  BaseModelState baseModelState = BaseModelState.loading;
  void changeState(BaseModelState state) {
    baseModelState = state;
    notifyListeners();
  }

  List<EmailRecipient> emailRecipients = [];

  Future<void> getEmailRecipients() async {
    baseModelState = BaseModelState.loading;
    final result = await _beneficiariesService
        .fetchgeniuspayEmailRecipients(_authenticationService.user!.id);
    result.fold((l) {
      changeState(BaseModelState.error);
    }, (r) {
      emailRecipients = r;
      changeState(BaseModelState.success);
    });
  }

  Future<void> addEmailRecipient(BuildContext context, String email) async {
    baseModelState = BaseModelState.loading;
    final result = await _beneficiariesService.addEmailRecipient(
        _authenticationService.user!.id, email);
    result.fold((l) {
      PopupDialogs(context)
          .errorMessage('Unable to add beneficiary. ${l.props[0]}');
    }, (r) async {
      showDialog(
          context: context,
          builder: (context) {
            return AddSuccessPopup(recipient: r, wallet: null);
          });
    });
  }
}
