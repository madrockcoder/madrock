import 'package:flutter/material.dart';
import 'package:geniuspay/app/deposit_funds/view_models/card_transfer_view_model.dart';
import 'package:geniuspay/app/deposit_funds/widgets/choose_amount_template.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/util/converter.dart';
import 'package:geniuspay/util/iconPath.dart';

class CardTransferPage extends StatelessWidget {
  final Wallet wallet;

  const CardTransferPage({Key? key, required this.wallet}) : super(key: key);

  static Future<void> show(BuildContext context, Wallet wallet) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CardTransferPage(
          wallet: wallet,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChooseAmountTemplate(
        wallet: wallet,
        imageAssetPath: IconPath.stripeLogoPNG,
        currency: wallet.currency,
        currencySymbol: Converter().getCurrency(wallet.currency),
        onPressed: (context, amount, wallet) async {
          CardTransferViewModel cardTransferViewModel = CardTransferViewModel();
          cardTransferViewModel.resetTransaction();
          cardTransferViewModel.setTransaction(amount, wallet.currency, wallet);
          await cardTransferViewModel.initiateTransfer(context);
          if (cardTransferViewModel.payInRequestId != null) {
            await cardTransferViewModel.createCardTransferPayment(context);
            if (cardTransferViewModel
                .isMoneySuccessfullyDeductedFromUserAccount) {
              await cardTransferViewModel.confirmTransfer(context);
            }
          }
        });
  }
}
