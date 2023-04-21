import 'package:flutter/material.dart';
import 'package:geniuspay/app/deposit_funds/pages/trustly/trustly_confirm_page.dart';
import 'package:geniuspay/app/deposit_funds/widgets/payment_webview_template.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/app/shared_widgets/transfer_result_screen.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/services/deposit_funds_service.dart';
import 'package:geniuspay/services/remote_config_service.dart';
import 'package:geniuspay/util/converter.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

@lazySingleton
class TrustlyViewModel extends BaseModel {
  BaseModelState baseModelState = BaseModelState.loading;
  final DepositFundsService _depositFundsService = sl<DepositFundsService>();
  final AuthenticationService _authenticationService =
      sl<AuthenticationService>();
  void changeState(BaseModelState state) {
    baseModelState = state;
    notifyListeners();
  }

  Future<void> initiatePayment(BuildContext context, String paymentUrl,
      String amount, Wallet wallet, String trustlyId) async {
    final baseUrl = RemoteConfigService.getRemoteData.baseUrl ??
        'https://8b84-2a01-114f-400c-3800-b4a9-6ce9-ba01-5a42.ngrok.io';
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PaymentWebViewTemplate(
                url: paymentUrl,
                completedUrl: '$baseUrl/events/trustly',
              )),
    );
    final result = await _depositFundsService.trustlyPaymentStatus(trustlyId);

    result.fold((l) {
      TransferResultScreen.show(
          context: context,
          status: 2,
          title: 'Transfer Failed',
          from: null,
          points: '',
          to: wallet.currency + ' Wallet',
          description:
              "Please try again later or use different transfer method",
          date: DateFormat('dd MMM yyyy').format(DateTime.now()),
          amount: '${Converter().getCurrency(wallet.currency)} $amount',
          redirectWallet: wallet.walletID);

      // DepositFailedTemplate.show(context, wallet.walletID!);
    }, (r) async {
      if (r.status == 'PENDING' || r.status == 'AWAITING_FUNDS') {
        TransferResultScreen.show(
            context: context,
            status: 3,
            title: 'Transfer Pending!',
            from: null,
            to: wallet.currency + ' Wallet',
            referenceNumber: r.reference,
            points: '',
            description:
                "Your transaction is pending. We will notify you when it is completed.",
            date: DateFormat('dd MMM yyyy').format(DateTime.now()),
            amount: '${Converter().getCurrency(wallet.currency)} $amount',
            redirectWallet: wallet.walletID);
      } else if (r.status == 'COMPLETED') {
        TransferResultScreen.show(
            context: context,
            status: 1,
            title: 'Transfer Successful!',
            referenceNumber: r.reference,
            from: null,
            to: wallet.currency + ' Wallet',
            points: '',
            description: "You have deposited",
            date: DateFormat('dd MMM yyyy').format(DateTime.now()),
            amount: '${Converter().getCurrency(wallet.currency)} $amount',
            redirectWallet: wallet.walletID);
      } else {
        TransferResultScreen.show(
            context: context,
            status: 2,
            title: 'Transfer Failed',
            points: '',
            from: null,
            to: wallet.currency + ' Wallet',
            description:
                "Please try again later or use different transfer method",
            date: DateFormat('dd MMM yyyy').format(DateTime.now()),
            amount: '${Converter().getCurrency(wallet.currency)} $amount',
            redirectWallet: wallet.walletID);
        // DepositFailedTemplate.show(context, wallet.walletID!);

      }
    });
  }

  void testApi() async {
    await _depositFundsService
        .trustlyPaymentStatus('dcc3a380-361e-4b3d-8844-516dcf9c5cb9');
  }

  Future<void> createTrustlyPayment(
      BuildContext context, String amount, Wallet wallet) async {
    baseModelState = BaseModelState.loading;
    final result = await _depositFundsService.createTrustlyPayment(
        amount, _authenticationService.user!.id, wallet);

    result.fold((l) {
      PopupDialogs(context).errorMessage(
          'Unable to initiate deposit, ${l.props[0] ?? 'Please try again'}');
    }, (r) async {
      TrustlyConfirmDepositPage.show(context, wallet, r);
    });
  }
}
