import 'package:geniuspay/app/deposit_funds/pages/card_transfer/card_transfer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/deposit_funds/pages/bank_transfer/bank_transfer_page.dart';
import 'package:geniuspay/app/deposit_funds/pages/pay_with.dart';
import 'package:geniuspay/app/deposit_funds/widgets/choose_payment_card.dart';
import 'package:geniuspay/app/payout/international_transfer/international_transfer_main.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/util/iconPath.dart';

import '../../../util/color_scheme.dart';

class ChoosePaymentPage extends StatefulWidget {
  final Wallet wallet;
  final bool justPickPaymentMethodAndPop;
  const ChoosePaymentPage(
      {Key? key,
      required this.wallet,
      this.justPickPaymentMethodAndPop = false})
      : super(key: key);

  static Future show(BuildContext context, Wallet wallet,
      {bool justPickPaymentMethodAndPop = false}) async {
    return await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ChoosePaymentPage(
          wallet: wallet,
          justPickPaymentMethodAndPop: justPickPaymentMethodAndPop,
        ),
      ),
    );
  }

  @override
  State<ChoosePaymentPage> createState() => _ChoosePaymentPageState();
}

class _ChoosePaymentPageState extends State<ChoosePaymentPage> {
  bool get justPickPaymentMethodAndPop => widget.justPickPaymentMethodAndPop;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColor.kWhiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.kWhiteColor,
        centerTitle: true,
        title: Text('Choose how to pay',
            style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
        actions: const [HelpIconButton()],
      ),
      body: Container(
        color: AppColor.kWhiteColor,
        child: SingleChildScrollView(
          child: Column(
            children: [mostPopularWidget(), otherWidget()],
          ),
        ),
      ),
    );
  }

  Widget mostPopularWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(15),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text('Most popular',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: AppColor.kSecondaryColor))),
        const Gap(10),
        if (justPickPaymentMethodAndPop) ...[
          ChoosePaymentCard(
              leadingIcon: SvgPicture.asset('assets/icons/wallet-money.svg'),
              cardTitle: 'Pay with your GenioWallet',
              paymentMethod: PaymentMethod.wallet,
              onTapCard: () {
                PayWithPage.show(context, widget.wallet);
              },
              onTapInfo: () =>
                  _showModalBottomSheet('Send money directly from your wallet'),
              limitValue: 'Unlimited',
              feeValue: 'Fee 0%',
              feeDuration: 'Instant'),
          const Gap(10)
        ],
        const Gap(10),
        Opacity(
            opacity: 1,
            child: ChoosePaymentCard(
                leadingIcon: SvgPicture.asset(SvgPath.cardIconSvg),
                cardTitle: 'Pay with your Credit or Debit Card',
                paymentMethod: PaymentMethod.card,
                onTapCard: () {
                  CardTransferPage.show(context, widget.wallet);
                },
                onTapInfo: () => _showModalBottomSheet(
                    'Save your card to easily add money to your geniuspay wallet. We accept all major cards.'),
                logoList: const [
                  IconPath.masterCardPNG,
                  IconPath.visaPNG,
                  IconPath.jcbLogoPNG,
                  IconPath.americanExpressLogoPNG
                ],
                limitValue: 'Unlimited',
                feeValue: 'Fee 2.5%',
                feeDuration: 'Instant')),
        const Gap(10),
        Opacity(
            opacity: justPickPaymentMethodAndPop || kReleaseMode  ? 0.3 : 1,
            child: ChoosePaymentCard(
                leadingIcon: SvgPicture.asset(SvgPath.banklinkIconSvg),
                cardTitle: 'Pay directly from your bank account',
                paymentMethod: PaymentMethod.bank,
                onTapCard: () {
                  if(kDebugMode){
                    PayWithPage.show(context, widget.wallet);
                  }
                },
                onTapInfo: () => _showModalBottomSheet(
                    'Deposit funds directly from your bank using any of our payment gateways (stitch, trustly, etc)'),
                logoList: const [
                  IconPath.trustlyLogoPNG,
                  IconPath.rapidLogoPNG,
                  IconPath.przelewPNG,
                ],
                limitValue: 'Unlimited',
                feeValue: 'Fee 0%',
                feeDuration: 'Instant')),
      ],
    );
  }

  Widget otherWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(15),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text('Other', style: Theme.of(context).textTheme.headlineSmall)),
        const Gap(10),
        if (widget.wallet.hasAccountDetails) ...[
          ChoosePaymentCard(
              leadingIcon: SvgPicture.asset(
                SvgPath.bankIconSvg,
              ),
              cardTitle: 'Make a transfer from your bank account',
              paymentMethod: PaymentMethod.manualBank,
              limitValue: "Limit \$500,000.00",
              feeValue: 'Fee 0%',
              onTapCard: () {
                if (widget.wallet.hasAccountDetails) {
                  BankTransferPage.show(context, widget.wallet);
                }
              },
              onTapInfo: () => _showModalBottomSheet(
                  "We'll give you the bank account details. All you have to do is transfer the amount from your bank"),
              feeDuration: '2-5 days'),
          const Gap(10)
        ],
        Opacity(
            opacity: 0.3,
            child: ChoosePaymentCard(
                leadingIcon: SvgPicture.asset(
                  SvgPath.biCashCoinSvg,
                ),
                cardTitle: 'Pay with cash at your nearest location',
                paymentMethod: PaymentMethod.cash,
                limitValue: "Limit \$900.00",
                feeValue: 'Fee 2.5%',
                onTapCard: () {
                  PopupDialogs(context).comingSoonSnack();
                },
                onTapInfo: () => _showModalBottomSheet(
                    'Visit our nearest location and deposit funds via cash'),
                feeDuration: 'Instant')),
        const Gap(10),
        Opacity(
            opacity: 0.3,
            child: ChoosePaymentCard(
                leadingIcon: SvgPicture.asset(
                  SvgPath.carbonMobileDownloadSvg,
                ),
                cardTitle: 'Mobile money payment',
                paymentMethod: PaymentMethod.mobile,
                limitValue: "Limit \$320.00",
                feeValue: 'Fee 0%',
                onTapCard: () {
                  PopupDialogs(context).comingSoonSnack();
                },
                onTapInfo: () => _showModalBottomSheet(
                    'Use mobile money to receive funds in your wallet'),
                feeDuration: 'Instant')),
        const Gap(10),
        Opacity(
            opacity: 0.3,
            child: ChoosePaymentCard(
                leadingIcon: Image.asset(IconPath.paysafeCardPNG),
                cardTitle: 'Buy a Paysafecard and use its code',
                paymentMethod: PaymentMethod.paySafeCard,
                limitValue: "Limit \$650.00",
                feeValue: 'Fee 5%',
                onTapCard: () {
                  PopupDialogs(context).comingSoonSnack();
                },
                onTapInfo: () =>
                    _showModalBottomSheet('Buy a Paysafecard and use its code'),
                feeDuration: 'Instant')),
        const Gap(32),
      ],
    );
  }

  void _showModalBottomSheet(String content) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) {
        return Container(
          height: 200,
          padding: const EdgeInsets.symmetric(horizontal: 41, vertical: 48),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'How it works',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 16),
              ),
              const Gap(20),
              Text(
                content,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: 16),
              )
            ],
          ),
        );
      },
    );
  }
}
