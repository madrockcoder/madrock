import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/currency_exchange/view_models/create_conversion.dart';
import 'package:geniuspay/app/currency_exchange/widgets/label_button.dart';
import 'package:geniuspay/app/currency_exchange/widgets/transaction_form_item.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button_async.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/models/exchange_rate.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/util/converter.dart';
import 'package:intl/intl.dart';

import '../../../util/color_scheme.dart';

class ConfirmTransationPage extends StatefulWidget {
  final ExchangeRate exchangeRate;
  final Wallet buyingWallet;
  final Wallet sellingWallet;
  const ConfirmTransationPage(
      {Key? key,
      required this.exchangeRate,
      required this.buyingWallet,
      required this.sellingWallet})
      : super(key: key);

  static Future<void> show(
    BuildContext context,
    ExchangeRate exchangeRate,
    Wallet buyingWallet,
    Wallet sellingWallet,
  ) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ConfirmTransationPage(
          exchangeRate: exchangeRate,
          buyingWallet: buyingWallet,
          sellingWallet: sellingWallet,
        ),
      ),
    );
  }

  @override
  State<ConfirmTransationPage> createState() => _ConfirmTransationPageState();
}

class _ConfirmTransationPageState extends State<ConfirmTransationPage> {
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
  String getRate(ExchangeRate exchangeRate) {
    String currencyPair = exchangeRate.currencyPair;
    String buyCurrency = exchangeRate.buyCurrency;
    String rate = exchangeRate.rate;
    if ("${currencyPair[0]}${currencyPair[1]}${currencyPair[2]}" ==
        buyCurrency) {
      return rate;
    } else {
      final newRate = 1 / double.parse(rate);
      return _converter.reduceDecimals(newRate, precision: 3).toString();
    }
  }

  String _getTotalAmount(String buyAmount) {
    final amount = double.parse(buyAmount);
    final fee = double.parse(widget.exchangeRate.fees);
    return (amount + fee).toStringAsFixed(2);
  }

  Widget mainTransitionWidget() {
    final exchangeRate = widget.exchangeRate;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 49),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Column(
        children: [
          const TransactionFormItem(
              title: 'Type', content: 'Currency Exchange'),
          const Gap(7),
          TransactionFormItem(
              title: 'Buy currency', content: exchangeRate.buyCurrency),
          const Gap(7),
          TransactionFormItem(
              title: 'Amount',
              content: "${_converter.getCurrency(exchangeRate.buyCurrency)}"
                  "${exchangeRate.buyAmount}"),
          const Gap(7),
          TransactionFormItem(
              title: 'Exchange fee',
              content:
                  "${_converter.getCurrency(exchangeRate.buyCurrency)}${exchangeRate.fees}"),
          const Gap(15),
          Container(
              height: 0.5, color: AppColor.kPrimaryColor.withOpacity(0.5)),
          const Gap(40),
          TransactionFormItem(
              title: 'Sell currency', content: exchangeRate.sellCurrency),
          const Gap(7),
          TransactionFormItem(
              title: 'You\'ll receive',
              content: "${_converter.getCurrency(exchangeRate.sellCurrency)}"
                  "${exchangeRate.sellAmount}"),
          const Gap(15),
          Container(
              height: 0.5, color: AppColor.kPrimaryColor.withOpacity(0.5)),
          const Gap(40),
          TransactionFormItem(
              title: 'Conversion Date',
              content: DateFormat('dd MMM yyyy').format(DateTime.now())),
          const Gap(7),
          TransactionFormItem(
              title: 'Exchange Rate',
              content:
                  '1${exchangeRate.buyCurrency} = ${getRate(exchangeRate)} ${exchangeRate.sellCurrency}'),
          const Gap(32),
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 12.5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColor.kSecondaryColor.withOpacity(0.3),
            ),
            child: TransactionFormItem(
                title: 'You\'ll pay',
                content: "${Converter().getCurrency(exchangeRate.buyCurrency)}"
                    "${_getTotalAmount(exchangeRate.buyAmount)}"),
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
            await CurrencyExchangeViewModel().createConversion(
                context,
                widget.exchangeRate,
                widget.buyingWallet.walletID!,
                widget.sellingWallet.walletID!);
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
