import 'package:flutter/material.dart';
import 'package:geniuspay/app/deposit_funds/pages/payu/payu_confirm_page.dart';
import 'package:geniuspay/app/deposit_funds/widgets/payment_webview_template.dart';
import 'package:geniuspay/app/deposit_funds/widgets/deposit_failed_template.dart';
import 'package:geniuspay/app/deposit_funds/widgets/deposit_success_template.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/services/deposit_funds_service.dart';
import 'package:geniuspay/util/converter.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PayUViewModel extends BaseModel {
  BaseModelState baseModelState = BaseModelState.loading;
  final DepositFundsService _depositFundsService = sl<DepositFundsService>();
  final AuthenticationService _authenticationService =
      sl<AuthenticationService>();
  void changeState(BaseModelState state) {
    baseModelState = state;
    notifyListeners();
  }

  Future<void> initiatePayment(BuildContext context, String paymentUrl,
      String amount, Wallet wallet, String payUId) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PaymentWebViewTemplate(
                url: paymentUrl,
                completedUrl: 'https://8b84-2a01-114f-400c-3800-b4a9-6ce9-ba01-5a42.ngrok.io/events/payu-continue',
              )),
    );
    final result = await _depositFundsService.payUpaymentStatus(payUId);

    result.fold((l) {
      DepositFailedTemplate.show(context, wallet.walletID!);
    }, (r) async {
      if (r.status == 'COMPLETED' || r.status == 'PENDING') {
        DepositSuccessTemplate.show(context, amount, wallet, wallet.currency,
            Converter().getCurrency(wallet.currency));
      } else {
        DepositFailedTemplate.show(context, wallet.walletID!);
      }
    });
  }

  Future<void> createPayUPayment(
      BuildContext context, String amount, Wallet wallet) async {
    baseModelState = BaseModelState.loading;
    final result = await _depositFundsService.createPayUPayment(
        amount, _authenticationService.user!.id, wallet.walletID!);
    result.fold((l) {
      PopupDialogs(context)
          .errorMessage('Unable to initiate deposit, Please try again');
    }, (r) async {
      PayUConfirmDepositPage.show(context, wallet, r);
    });
  }
}
