import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/currency_exchange/widgets/label_button.dart';
import 'package:geniuspay/app/currency_exchange/widgets/transaction_form_item.dart';
import 'package:geniuspay/app/payout/view_models/payout_vm.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button_async.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/util/converter.dart';
import 'package:intl/intl.dart';

import '../../../util/color_scheme.dart';

class Confirmp2pTransationPage extends StatefulWidget {
  final Wallet wallet;
  final dynamic recipient;
  final String amount;
  final String description;
  const Confirmp2pTransationPage(
      {Key? key,
      required this.wallet,
      required this.recipient,
      required this.amount,
      required this.description})
      : super(key: key);

  static Future<void> show(BuildContext context, Wallet wallet,
      dynamic recipient, String amount, String description) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => Confirmp2pTransationPage(
          wallet: wallet,
          recipient: recipient,
          amount: amount,
          description: description,
        ),
      ),
    );
  }

  @override
  State<Confirmp2pTransationPage> createState() =>
      _Confirmp2pTransationPageState();
}

class _Confirmp2pTransationPageState extends State<Confirmp2pTransationPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColor.kAccentColor2,
      appBar: AppBar(
        backgroundColor: AppColor.kAccentColor2,
        centerTitle: true,
        title: Text('Confirm Transaction',
            style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
        actions: const [HelpIconButton()],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            mainTransitionWidget(),
            const Gap(50),
            confirmButton(textTheme),
            const Gap(15),
            backButton(),
            const Gap(15)
          ],
        ),
      ),
    );
  }

  final _converter = Converter();

  Widget mainTransitionWidget() {
    final recipient = widget.recipient;
    final wallet = widget.wallet;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 49),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Column(
        children: [
          TransactionFormItem(
              title: 'From wallet', content: wallet.friendlyName),
          const Gap(7),
          TransactionFormItem(title: 'Currency', content: wallet.currency),
          const Gap(7),
          TransactionFormItem(
              title: 'Amount',
              content: "${_converter.getCurrency(wallet.currency)} "
                  "${widget.amount}"),
          const Gap(7),
          TransactionFormItem(
              title: 'Fee',
              content: "${_converter.getCurrency(wallet.currency)} "
                  "0.00"),
          const Gap(15),
          Container(
              height: 0.5, color: AppColor.kPrimaryColor.withOpacity(0.5)),
          const Gap(40),
          TransactionFormItem(
              title: 'Transaction Date',
              content: DateFormat('dd MMM yyyy').format(DateTime.now())),
          const Gap(7),
          if (widget.description.isNotEmpty)
            TransactionFormItem(
                title: 'Description', content: widget.description),
          const Gap(32),
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 12.5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColor.kSecondaryColor.withOpacity(0.3),
            ),
            child: TransactionFormItem(
                title: 'Total Amount',
                content: "${_converter.getCurrency(wallet.currency)} "
                    "${widget.amount}"),
          )
        ],
      ),
    );
  }

  Widget confirmButton(TextTheme textTheme) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: CustomElevatedButtonAsync(
          onPressed: () async {
            await PayoutVM().createp2pTransfer(context, widget.recipient,
                widget.amount, widget.wallet, widget.description);
          },
          color: AppColor.kGoldColor2,
          child: Text(
            'CONFIRM',
            style: textTheme.bodyLarge,
          ),
        ));
  }

  Widget backButton() {
    return LabelButton(
        voidCallback: () {
          Navigator.pop(context);
        },
        label: 'BACK',
        labelColor: Colors.black);
  }
}
