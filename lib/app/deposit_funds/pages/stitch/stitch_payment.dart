import 'package:flutter/material.dart';
import 'package:geniuspay/app/deposit_funds/view_models/stitch_view_model.dart';
import 'package:geniuspay/app/deposit_funds/widgets/choose_amount_template.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/util/converter.dart';

class PayWithStitchPage extends StatelessWidget {
  final Wallet wallet;
  const PayWithStitchPage({Key? key, required this.wallet}) : super(key: key);
  static Future<void> show(BuildContext context, Wallet wallet) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PayWithStitchPage(
          wallet: wallet,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChooseAmountTemplate(
        wallet: wallet,
        imageAssetPath: 'assets/icons/deposit/stitch_logo.png',
        currency: wallet.currency,
        currencySymbol: Converter().getCurrency(wallet.currency),
        onPressed: (context, amount, wallet) async {
          await StitchViewModel().createStitchPayment(context, amount, wallet);
        });
  }
}
