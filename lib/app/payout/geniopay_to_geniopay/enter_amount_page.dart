import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/auth/view_models/select_country_view_model.dart';
import 'package:geniuspay/app/currency_exchange/view_models/main_currency_exchange_vm.dart';
import 'package:geniuspay/app/payout/geniuspay_to_geniuspay/confirm_transaction.dart';
import 'package:geniuspay/app/shared_widgets/curved_background.dart';
import 'package:geniuspay/app/shared_widgets/custom_circular_image.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/core/injections/injections.dart';
import 'package:geniuspay/models/country.dart';
import 'package:geniuspay/models/mobile_recipient.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/converter.dart';

class EnterTransferAmountPage extends StatefulWidget {
  final Wallet wallet;
  final dynamic recipient;

  const EnterTransferAmountPage(
      {Key? key, required this.wallet, required this.recipient})
      : super(key: key);

  static Future<void> show(
      BuildContext context, Wallet wallet, dynamic recipient) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
          builder: (_) =>
              EnterTransferAmountPage(wallet: wallet, recipient: recipient)),
    );
  }

  @override
  State<EnterTransferAmountPage> createState() =>
      _EnterTransferAmountPageState();
}

class _EnterTransferAmountPageState extends State<EnterTransferAmountPage> {
  String amount = '';
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _converter = Converter();
  final _formKey = GlobalKey<FormState>();
  CurrencyExchangeViewModel currencyExchangeViewModel =
      sl<CurrencyExchangeViewModel>();
  final SelectCountryViewModel _selectCountryViewModel =
      sl<SelectCountryViewModel>();

  bool get isMobileRecipient => widget.recipient.runtimeType == MobileRecipient;

  @override
  void initState() {
    if (isMobileRecipient) {
      currencyExchangeViewModel.setBuyingWallet(context, widget.wallet);
      Country countryModel = _selectCountryViewModel.countries
          .where((element) =>
              element.iso2 == (widget.recipient as MobileRecipient).country)
          .first;
      currencyExchangeViewModel.setSellingWallet(
          context,
          Wallet(
              user: (widget.recipient as MobileRecipient).payerId,
              friendlyName: (widget.recipient as MobileRecipient).firstName!,
              currency: countryModel.currencyISO,
              isDefault: true));
      setState(() {});
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final amountStyle = textTheme.displayLarge
        ?.copyWith(color: AppColor.kSecondaryColor, fontSize: 44);
    final descriptionStyle =
        textTheme.titleSmall?.copyWith(color: AppColor.kGreyColor);
    return Form(
        key: _formKey,
        child: Scaffold(
          backgroundColor: AppColor.kAccentColor2,
          appBar: AppBar(
            backgroundColor: AppColor.kAccentColor2,
            centerTitle: true,
            title: const Text('Enter amount'),
          ),
          body: Column(children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: CurvedBackground(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Enter Amount',
                        style: textTheme.bodyMedium
                            ?.copyWith(color: AppColor.kSecondaryColor)),
                    IntrinsicWidth(
                        child: TextFormField(
                            style: amountStyle,
                            autofocus: true,
                            controller: _amountController,
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            onChanged: (val) {
                              currencyExchangeViewModel
                                  .getExchangeRate(context: context)
                                  .then((value) {
                                if (mounted) setState(() {});
                              });
                              setState(() {
                                _formKey.currentState?.validate();
                              });
                            },
                            maxLength: 10,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d*')),
                            ],
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Amount can't be empty";
                              }
                              final value = double.tryParse(val);
                              if (value != null && value < 1) {
                                return 'Minimum amount is ${_converter.getCurrency(widget.wallet.currency)}1';
                              }
                              final balance =
                                  widget.wallet.availableBalance!.value;
                              if (value != null && value > balance) {
                                return 'Exceeded balance ${_converter.getCurrency(widget.wallet.currency)}$balance';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: '0.00',
                              contentPadding: EdgeInsets.zero,
                              prefixIcon: Text(
                                _converter.getCurrency(widget.wallet.currency),
                                style: amountStyle,
                              ),
                              counterText: '',
                              hintStyle: amountStyle,
                              border: InputBorder.none,
                              prefixStyle: amountStyle,
                            ))),
                    if (!isMobileRecipient) ...[
                      const Gap(12),
                      IntrinsicWidth(
                          child: TextField(
                              style: descriptionStyle,
                              textAlign: TextAlign.center,
                              autofocus: true,
                              controller: _descriptionController,
                              keyboardType: TextInputType.text,
                              maxLines: 3,
                              maxLength: 50,
                              decoration: InputDecoration(
                                hintText: 'Add Message',
                                counterText: "",
                                hintStyle: descriptionStyle,
                                border: InputBorder.none,
                              ))),
                    ],
                    if (isMobileRecipient &&
                        currencyExchangeViewModel.exchangeRate != null) ...[
                      const Gap(24),
                      Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColor.kSecondaryColor),
                            borderRadius: BorderRadius.circular(15)),
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            CustomCircularImage(
                                'icons/flags/png/${(widget.recipient as MobileRecipient).country?.toLowerCase()}.png',
                                radius: 40,
                                package: 'country_icons',
                                fit: BoxFit.cover),
                            const Gap(16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'They Receive',
                                  style: textTheme.bodyMedium?.copyWith(
                                      color: AppColor.kSecondaryColor),
                                ),
                                Text(
                                  (currencyExchangeViewModel.exactRate! *
                                              (double.tryParse(
                                                      _amountController.text) ??
                                                  0))
                                          .toStringAsFixed(2) +
                                      ' ' +
                                      currencyExchangeViewModel
                                          .exchangeRate!.sellCurrency,
                                  style: textTheme.titleMedium?.copyWith(
                                      color: AppColor.kSecondaryColor,
                                      fontSize: 25),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                    // Align(
                    //     alignment: Alignment.centerLeft,
                    //     child: Text(
                    //       'From Wallet',
                    //       style: textTheme.bodyText1
                    //           ?.copyWith(color: AppColor.kSecondaryColor),
                    //     )),
                    // const Gap(8),
                    // Container(
                    //   decoration: BoxDecoration(
                    //       color: AppColor.kAccentColor2,
                    //       borderRadius: BorderRadius.circular(15),
                    //       border: Border.all(color: AppColor.kSecondaryColor)),
                    //   child: ListTile(
                    //     contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    //     minVerticalPadding: 0,
                    //     leading: CircleAvatar(
                    //       radius: 20,
                    //       backgroundImage: AssetImage(
                    //           'icons/flags/png/${_converter.getLocale(widget.wallet.currency)}.png',
                    //           package: 'country_icons'),
                    //     ),
                    //     title: Text(widget.wallet.friendlyName,
                    //         style: textTheme.bodyText1),
                    //     subtitle: Text(
                    //       widget.wallet.availableBalance?.valueWithCurrency ?? '',
                    //       style: textTheme.subtitle2
                    //           ?.copyWith(color: AppColor.kSecondaryColor),
                    //     ),
                    //   ),
                    // )
                  ],
                ))),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                const Text('From'),
                const Gap(8),
                CircleAvatar(
                  radius: 8,
                  backgroundImage: AssetImage(
                      'icons/flags/png/${_converter.getLocale(widget.wallet.currency)}.png',
                      package: 'country_icons'),
                ),
                const Gap(8),
                Text(widget.wallet.friendlyName, style: textTheme.bodyLarge),
                const Gap(8),
                Expanded(
                    flex: 2,
                    child: Text(
                      widget.wallet.availableBalance?.valueWithCurrency ?? '',
                      style: textTheme.titleSmall
                          ?.copyWith(color: AppColor.kSecondaryColor),
                    )),
              ],
            ),
            Padding(
                padding: const EdgeInsets.all(24),
                child: CustomElevatedButton(
                    color: AppColor.kGoldColor2,
                    borderColor: (_formKey.currentState?.validate() ?? false)
                        ? AppColor.kGoldColor2
                        : AppColor.kDisabledContinueButtonColor,
                    onPressed: (_formKey.currentState?.validate() ?? false)
                        ? () {
                            Confirmp2pTransationPage.show(
                                context,
                                widget.wallet,
                                widget.recipient,
                                _amountController.text,
                                _descriptionController.text);
                          }
                        : null,
                    child: Text(
                      'NEXT',
                      style: textTheme.bodyLarge,
                    )))
          ]),
        ));
  }
}
