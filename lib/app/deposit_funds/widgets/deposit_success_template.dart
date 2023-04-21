import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/currency_exchange/widgets/label_button.dart';
import 'package:geniuspay/app/currency_exchange/widgets/round_button.dart';
import 'package:geniuspay/app/deposit_funds/pages/choose_payment_page.dart';
import 'package:geniuspay/app/home/pages/home_containter.dart';
import 'package:geniuspay/app/shared_widgets/circle_border_icon.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/converter.dart';
import 'package:ionicons/ionicons.dart';

class DepositSuccessTemplate extends StatefulWidget {
  final String amount;
  final Wallet wallet;
  final String currency;
  final String currencySymbol;
  const DepositSuccessTemplate({
    Key? key,
    required this.amount,
    required this.wallet,
    required this.currency,
    required this.currencySymbol,
  }) : super(key: key);

  static Future<void> show(BuildContext context, String amount, Wallet wallet,
      String currency, String currencySymbol) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => DepositSuccessTemplate(
          amount: amount,
          wallet: wallet,
          currency: currency,
          currencySymbol: currencySymbol,
        ),
      ),
    );
  }

  @override
  State<DepositSuccessTemplate> createState() => _DepositSuccessTemplateState();
}

class _DepositSuccessTemplateState extends State<DepositSuccessTemplate> {
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
                          'Deposit Successful!',
                          style: textTheme.displaySmall
                              ?.copyWith(color: AppColor.kSuccessColor3),
                        ),
                        const Gap(22),
                        subContentWidget(),
                        const Gap(50),
                        controlButtonsWidget(),
                        const Gap(32),
                        anotherTransferButton(),
                        backHomeButton(),
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
              'You have deposited ',
              style:
                  Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 18),
            ),
            Text(
              "${Converter().getCurrency(widget.currency)}" "${widget.amount}",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: AppColor.kSuccessColor3, fontSize: 18),
            )
          ],
        ),
        Text(
          'to your ${widget.currency} Wallet',
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
        HomeWidget.show(context, defaultPage: 0);
        ChoosePaymentPage.show(context, widget.wallet);
      },
      backgroundColor: AppColor.kSuccessColor3,
      label: 'ANOTHER DEPOSIT',
    );
  }

  Widget backHomeButton() {
    return LabelButton(
      voidCallback: () {
        HomeWidget.show(context,
            defaultPage: 0, showWalletId: widget.wallet.walletID);
      },
      label: 'BACK HOME',
      labelColor: Colors.black,
    );
  }
}
