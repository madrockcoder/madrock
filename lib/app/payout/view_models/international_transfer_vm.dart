import 'package:flutter/material.dart';
import 'package:geniuspay/app/auth/pages/passcode/pin_code_page.dart';
import 'package:geniuspay/app/payout/international_transfer/widgets/confirm_transaction.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/app/shared_widgets/transfer_result_screen.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/models/bank_beneficiary.dart';
import 'package:geniuspay/models/email_recipient.dart';
import 'package:geniuspay/models/international_transfer_model.dart';
import 'package:geniuspay/models/international_transfer_quotation.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/services/payout_services.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

@lazySingleton
class InternationalTransferVM extends BaseModel {
  final AuthenticationService _authenticationService = sl<AuthenticationService>();
  final PayoutService _payoutService = sl<PayoutService>();
  BaseModelState baseModelState = BaseModelState.loading;
  void changeState(BaseModelState state) {
    baseModelState = state;
    notifyListeners();
  }

  List<EmailRecipient> emailRecipients = [];

  Future<void> validateTransfer(
      {required BuildContext context,
      required InternationalTransferModel internationalTransferModel,
      required BankBeneficiary selectedBeneficiary,
      required Wallet selectedWallet}) async {
    final result = await _payoutService.validateInternationalTransfer(internationalTransferModel);
    result.fold((l) {
      PopupDialogs(context).errorMessage('Unable to validate payment. ${l.props[0]}');
    }, (r) {
      showModalBottomSheet(
          isScrollControlled: true,
          isDismissible: false,
          backgroundColor: Colors.white,
          context: context,
          builder: (context) {
            return ConfirmInternationalTransaction(
              internationalTransferModel: r,
              selectedBeneficiary: selectedBeneficiary,
              selectedWallet: selectedWallet,
              sameCurrency: true,
            );
          });
    });
  }

  Future<void> getQuotation({
    required BuildContext context,
    required InternationalTransferModel internationalTransferModel,
    required BankBeneficiary selectedBeneficiary,
    required Wallet selectedWallet,
    required String sellingCurrency,
  }) async {
    final result =
        await _payoutService.getQuotation(internationalTransferModel.amount, sellingCurrency, _authenticationService.user!.id);
    if (result.isLeft()) {
      PopupDialogs(context).errorMessage('Unable to get quotation. Please try again later');
    } else {
      String rate = '';
      final model = result.foldRight(InternationalTransferQuotation, (r, previous) {
        internationalTransferModel.quotation = r.id!;
        rate = r.rate;
      });
      final result2 = await _payoutService.validateInternationalTransfer(internationalTransferModel);
      result2.fold((l) {
        PopupDialogs(context).errorMessage('Unable to validate payment. Try again');
      }, (r) {
        showModalBottomSheet(
            isScrollControlled: true,
            isDismissible: false,
            backgroundColor: Colors.white,
            context: context,
            builder: (context) {
              return ConfirmInternationalTransaction(
                internationalTransferModel: r,
                selectedBeneficiary: selectedBeneficiary,
                selectedWallet: selectedWallet,
                sameCurrency: false,
                exchangeRate: rate,
              );
            });
      });
    }
  }

  Future<void> createInternationalTransfer(
      BuildContext context, InternationalTransferModel internationalTransferModel, String from, String to) async {
    PINCodeSettingPage.show(
        context: context,
        isLogin: true,
        passcodeTitle: 'Enter your Passcode\nto approve transaction',
        onVerified: (context) async {
          final result = await _payoutService.createInternationalTransfer(internationalTransferModel);
          result.fold((l) {
            TransferResultScreen.show(
                context: context,
                status: 2,
                title: 'Transfer Failed',
                from: from,
                to: to,
                points: '',
                description: "Please try again later or use different transfer method",
                date: DateFormat('dd MMM yyyy').format(DateTime.now()),
                amount: internationalTransferModel.amount.valueWithCurrency ?? '',
                replacescreen: true);
          }, (r) {
            TransferResultScreen.show(
              context: context,
              status: 1,
              title: 'Transfer Success',
              points: '',
              referenceNumber: r,
              from: from,
              to: to,
              description: "You have sent",
              date: DateFormat('dd MMM yyyy').format(DateTime.now()),
              amount: internationalTransferModel.amount.valueWithCurrency ?? '',
            );
          });
        });
  }
}
