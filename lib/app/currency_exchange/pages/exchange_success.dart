import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/currency_exchange/pages/main_currency_exchange.dart';
import 'package:geniuspay/app/currency_exchange/widgets/label_button.dart';
import 'package:geniuspay/app/currency_exchange/widgets/round_button.dart';
import 'package:geniuspay/app/home/pages/home_containter.dart';
import 'package:geniuspay/app/shared_widgets/circle_border_icon.dart';
import 'package:geniuspay/models/conversion.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/converter.dart';
import 'package:ionicons/ionicons.dart';

class ExchangeSuccessPage extends StatefulWidget {
  final Conversion conversion;
  final String buyingWalletId;
  const ExchangeSuccessPage(
      {Key? key, required this.conversion, required this.buyingWalletId})
      : super(key: key);

  static Future<void> show(BuildContext context, Conversion conversion,
      String buyingWalletId) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ExchangeSuccessPage(
          conversion: conversion,
          buyingWalletId: buyingWalletId,
        ),
      ),
    );
  }

  @override
  State<ExchangeSuccessPage> createState() => _ExchangeSuccessPageState();
}

class _ExchangeSuccessPageState extends State<ExchangeSuccessPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return WillPopScope(
        onWillPop: () async => false,
        child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Color(0xffC5FFE2), AppColor.kWhiteColor],
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SafeArea(
                child: SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Gap(240),
                        const CircleBorderIcon(
                            gradientStart: AppColor.greenbg,
                            gradientEnd: Colors.white,
                            gapColor: Color(0xffC5FFE2),
                            bgColor: AppColor.kSuccessColor3,
                            child: Icon(
                              Icons.check_circle_outline,
                              color: Colors.white,
                              size: 42,
                            )),
                        const Gap(22),
                        Text(
                          'Exchange Successful!',
                          style: textTheme.displaySmall
                              ?.copyWith(color: AppColor.kSuccessColor3),
                        ),
                        const Gap(22),
                        subContentWidget(),
                        const Gap(50),
                        controlButtonsWidget(),
                        const Gap(10),
                        anotherTransferButton(),
                        const Gap(10),
                        backHomeButton()
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }

  Widget subContentWidget() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You have exchanged ',
              style:
                  Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 18),
            ),
            Text(
              "${Converter().getCurrency(widget.conversion.buyCurrency)}"
              "${widget.conversion.buyAmount}",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: AppColor.kSuccessColor3, fontSize: 18),
            )
          ],
        ),
        Text(
          'to your ${widget.conversion.sellCurrency} Wallet',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 18),
        ),
      ],
    );
  }

  Widget controlButtonsWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {},
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(width: 1, color: AppColor.kSuccessColor3)),
            child: const Icon(
              Ionicons.sync_outline,
              color: AppColor.kSuccessColor3,
            ),
          ),
        ),
        const Gap(15),
        InkWell(
          onTap: () {},
          child: Container(
            width: 48,
            height: 48,
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(width: 1, color: AppColor.kSuccessColor3)),
            child: SvgPicture.asset(
              'assets/icons/download.svg',
            ),
          ),
        ),
      ],
    );
  }

  Widget anotherTransferButton() {
    return RoundButton(
      voidCallback: () {
        MainCurrencyExchangePage.show(context: context);
      },
      backgroundColor: AppColor.kSuccessColor3,
      label: 'ANOTHER TRANSFER',
    );
  }

  Widget backHomeButton() {
    return LabelButton(
      voidCallback: () {
        HomeWidget.show(context,
            defaultPage: 0, showWalletId: widget.buyingWalletId);
      },
      label: 'BACK HOME',
      labelColor: AppColor.kSuccessColor3,
    );
  }
}
