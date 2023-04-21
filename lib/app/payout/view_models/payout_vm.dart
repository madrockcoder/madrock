import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geniuspay/app/auth/pages/passcode/pin_code_page.dart';
import 'package:geniuspay/app/shared_widgets/transfer_result_screen.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/models/email_recipient.dart';
import 'package:geniuspay/models/internal_mobile_payment.dart';
import 'package:geniuspay/models/internal_payment.dart';
import 'package:geniuspay/models/mobile_recipient.dart';
import 'package:geniuspay/models/total_amount.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/services/payout_services.dart';
import 'package:geniuspay/util/converter.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

@lazySingleton
class PayoutVM extends BaseModel {
  final AuthenticationService _authenticationService =
      sl<AuthenticationService>();
  final PayoutService _payoutService = sl<PayoutService>();
  BaseModelState baseModelState = BaseModelState.loading;
  void changeState(BaseModelState state) {
    baseModelState = state;
    notifyListeners();
  }

  List<EmailRecipient> emailRecipients = [];

  Future<void> createp2pTransfer(BuildContext context, dynamic recipient,
      String amount, Wallet wallet, String description) async {
    PINCodeSettingPage.show(
        context: context,
        replaceScreen: true,
        isLogin: true,
        passcodeTitle: 'Enter your Passcode\nto approve transaction',
        onVerified: (pinContext) async {
          String desc = description.isEmpty ? 'geniuspay transfer' : description;
          switch(recipient.runtimeType){
            case EmailRecipient:
              final data = InternalPayment(
                  sourceID: wallet.walletID!,
                  payerID: _authenticationService.user!.id,
                  payeeID: recipient.payeeId,
                  amount: TotalAmount(
                      value: double.parse(amount), currency: wallet.currency),
                  description: desc);
              final result = await _payoutService.createp2pTransfer(data);
              result.fold((l) {
                // TransferFailedPage.show(context);
                TransferResultScreen.show(
                    context: pinContext,
                    status: 2,
                    points: '',
                    title: 'Transfer Failed',
                    from: wallet.currency + ' Wallet',
                    to: "${recipient.firstName} ${recipient.lastName}",
                    description:
                    "Please try again later or use different transfer method",
                    date: DateFormat('dd MMM yyyy').format(DateTime.now()),
                    amount: '${Converter().getCurrency(wallet.currency)} $amount',
                    redirectWallet: wallet.walletID,
                    replacescreen: true);
              }, (r) {
                TransferResultScreen.show(
                    context: pinContext,
                    status: 1,
                    points: '',
                    referenceNumber: r,
                    title: 'Transfer Success',
                    from: wallet.currency + ' Wallet',
                    to: "${recipient.firstName} ${recipient.lastName}",
                    description: "You have sent",
                    date: DateFormat('dd MMM yyyy').format(DateTime.now()),
                    amount: '${Converter().getCurrency(wallet.currency)} $amount',
                    redirectWallet: wallet.walletID);
              });
              break;
            case MobileRecipient:
              final data = InternalMobilePayment(
                  sendingReason: recipient.sendingReason,
                  country: recipient.country,
                  mobileNetwork: recipient.mobileNetwork,
                  payerID: _authenticationService.user!.id,
                  payeeID: recipient.payeeId,
                  amount: TotalAmount(
                      value: double.parse(amount), currency: wallet.currency));
              final result = await _payoutService.createp2pMobileTransfer(data);
              result.fold((l) {
                // TransferFailedPage.show(context);
                TransferResultScreen.show(
                    context: pinContext,
                    status: 2,
                    points: '',
                    title: 'Transfer Failed',
                    from: wallet.currency + ' Wallet',
                    to: "${recipient.firstName} ${recipient.lastName}",
                    description:
                    "Please try again later or use different transfer method",
                    date: DateFormat('dd MMM yyyy').format(DateTime.now()),
                    amount: '${Converter().getCurrency(wallet.currency)} $amount',
                    redirectWallet: wallet.walletID,
                    replacescreen: true);
              }, (r) {
                TransferResultScreen.show(
                    context: pinContext,
                    status: 1,
                    referenceNumber: r,
                    points: '',
                    title: 'Transfer Success',
                    from: wallet.currency + ' Wallet',
                    to: "${recipient.firstName} ${recipient.lastName}",
                    description: "You have sent",
                    date: DateFormat('dd MMM yyyy').format(DateTime.now()),
                    amount: '${Converter().getCurrency(wallet.currency)} $amount',
                    redirectWallet: wallet.walletID);
              });
              break;
          }
        });
  }
}
