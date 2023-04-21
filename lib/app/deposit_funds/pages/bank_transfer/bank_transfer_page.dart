import 'package:flutter/material.dart';
import 'package:geniuspay/app/deposit_funds/pages/bank_transfer/bank_transfer_widget.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/models/wallet.dart';

class BankTransferPage extends StatefulWidget {
  final Wallet wallet;
  const BankTransferPage({Key? key, required this.wallet}) : super(key: key);
  static Future<void> show(BuildContext context, Wallet wallet) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BankTransferPage(
          wallet: wallet,
        ),
      ),
    );
  }

  @override
  State<BankTransferPage> createState() => _BankTransferPageState();
}

class _BankTransferPageState extends State<BankTransferPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Confirm Deposit'),
          centerTitle: true,
          actions: const [HelpIconButton()],
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: widget.wallet.walletAccountDetails == null
                ? const Center(child: Text('Unable to load Wallet details'))
                : BankTransferWidget(
                    wallet: widget.wallet,
                    walletDetailsList: [widget.wallet.walletAccountDetails!])));
  }
}
