import 'package:flutter/material.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/app/shared_widgets/transfer_result_screen.dart';
import 'package:geniuspay/core/injections/injections.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/services/deposit_funds_service.dart';
import 'package:geniuspay/util/converter.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

@lazySingleton
class CardTransferViewModel extends BaseModel {
  BaseModelState baseModelState = BaseModelState.loading;
  final DepositFundsService _depositFundsService = sl<DepositFundsService>();
  final AuthenticationService _auth = sl<AuthenticationService>();

  String get userID => _auth.user!.id;

  String? amount;
  String? currency;
  String? payInRequestId;
  Wallet? wallet;
  String? reference;

  bool isMoneySuccessfullyDeductedFromUserAccount = false;
  Map<String, dynamic>? cardTransferResponse;

  void changeState(BaseModelState state) {
    baseModelState = state;
    notifyListeners();
  }

  void resetTransaction() {
    amount = null;
    currency = null;
    payInRequestId = null;
    wallet = null;
    reference = null;
  }

  void setTransaction(String _amount, String _currency, Wallet _wallet) {
    amount = _amount;
    currency = _currency;
    wallet = _wallet;
  }

  Future<void> initiateTransfer(BuildContext context) async {
    baseModelState = BaseModelState.loading;
    final result = await _depositFundsService.initiateCardTransfer(
        amount!, currency!, userID, wallet!.walletID!);

    await result.fold((l) {
      PopupDialogs(context)
          .errorMessage('Unable to initiate deposit, Please try again');
    }, (r) async {
      baseModelState = BaseModelState.success;
      payInRequestId = r['id'];
      reference = r['reference'];
    });
  }

  Future<void> createCardTransferPayment(BuildContext context) async {
    baseModelState = BaseModelState.loading;
    final result =
        await _depositFundsService.createCardPayment(amount!, currency!);

    await result.fold((l) {
      PopupDialogs(context)
          .errorMessage('Unable to initiate deposit, Please try again');
      showPendingScreen(context);
    }, (r) async {
      baseModelState = BaseModelState.success;
      isMoneySuccessfullyDeductedFromUserAccount = true;
      cardTransferResponse = r;
      PopupDialogs(context).informationMessage('Confirming the transaction');
    });
  }

  Future<void> confirmTransfer(BuildContext context) async {
    baseModelState = BaseModelState.loading;
    final object = cardTransferResponse!;
    final result = await _depositFundsService.confirmCardTransfer(
      userID,
      payInRequestId!,
      object,
    );

    await result.fold((l) {
      PopupDialogs(context)
          .errorMessage('Unable to confirm deposit, Please try again');
      showPendingScreen(context);
    }, (r) async {
      baseModelState = BaseModelState.success;
      PopupDialogs(context).errorMessage('Transaction successful');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        TransferResultScreen.show(
            context: context,
            status: 1,
            title: 'Transfer Successful!',
            referenceNumber: reference,
            points: '',
            to: '${currency!} Wallet',
            description: 'You have deposited',
            date: DateFormat('dd MMM yyyy').format(DateTime.now()),
            amount: '${Converter().getCurrency(currency!)} $amount',
            redirectWallet: wallet!.walletID);
      });
    });
  }

  void showErrorScreen(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      TransferResultScreen.show(
          context: context,
          status: 2,
          referenceNumber: reference,
          title: 'Transfer Failed',
          from: null,
          to: currency! + ' Wallet',
          points: '',
          description:
              'Please try again later or use different transfer method',
          date: DateFormat('dd MMM yyyy').format(DateTime.now()),
          amount: '${Converter().getCurrency(currency!)} $amount',
          redirectWallet: wallet!.walletID);
    });
  }

  void showPendingScreen(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      TransferResultScreen.show(
        context: context,
        status: 3,
        referenceNumber: reference,
        title: 'Transfer Pending',
        from: null,
        to: '${currency!} Wallet',
        points: '',
        description: 'Please try again later or use different transfer method',
        date: DateFormat('dd MMM yyyy').format(DateTime.now()),
        amount: '${Converter().getCurrency(currency!)} $amount',
        redirectWallet: wallet!.walletID,
      );
    });
  }
}
