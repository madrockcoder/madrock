import 'package:flutter/material.dart';
import 'package:geniuspay/app/deposit_funds/view_models/payu_view_model.dart';
import 'package:geniuspay/app/deposit_funds/widgets/choose_amount_template.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/util/converter.dart';
import 'package:geniuspay/util/iconPath.dart';

class PayWithPayUPage extends StatelessWidget {
  final Wallet wallet;
  const PayWithPayUPage({Key? key, required this.wallet}) : super(key: key);
  static Future<void> show(BuildContext context, Wallet wallet) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PayWithPayUPage(
          wallet: wallet,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChooseAmountTemplate(
        wallet: wallet,
        imageAssetPath: IconPath.payUlogo,
        currency: wallet.currency,
        currencySymbol: Converter().getCurrency(wallet.currency),
        onPressed: (context, amount, wallet) async {
          await PayUViewModel().createPayUPayment(context, amount, wallet);
        });
  }
}
