import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/deposit_funds/pages/bank_transfer/bank_transfer_page.dart';
import 'package:geniuspay/app/deposit_funds/widgets/choose_payment_card.dart';
import 'package:geniuspay/app/home/widget/wallet_selector.dart';
import 'package:geniuspay/app/payout/international_transfer/international_transfer_main.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/iconPath.dart';

class SelectInternationalPaymentMethod extends StatefulWidget {
  const SelectInternationalPaymentMethod({
    Key? key,
  }) : super(key: key);

  static Future<dynamic> show(BuildContext context) async {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const SelectInternationalPaymentMethod(),
      ),
    );
  }

  @override
  State<SelectInternationalPaymentMethod> createState() =>
      _SelectInternationalPaymentMethodState();
}

class _SelectInternationalPaymentMethodState
    extends State<SelectInternationalPaymentMethod> {
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
      body: ColoredBox(
        color: AppColor.kWhiteColor,
        child: SingleChildScrollView(
          child: Column(
            children: [mostPopularWidget()],
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
        ChoosePaymentCard(
            leadingIcon: SvgPicture.asset('assets/icons/wallet-money.svg'),
            cardTitle: 'Pay with your GenioWallet',
            paymentMethod: PaymentMethod.wallet,
            onTapCard: () async {
              final result = await showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return const WalletSelectorList(
                      disable: true,
                    );
                  });
              if (result.runtimeType == Wallet) {
                Navigator.pop(context, [PaymentMethod.wallet, result]);
              }
            },
            onTapInfo: () =>
                _showModalBottomSheet('Send money directly from your wallet'),
            limitValue: 'Unlimited',
            feeValue: 'Fee 0%',
            feeDuration: 'Instant'),
        const Gap(10),
        Opacity(
            opacity: 0.3,
            child: ChoosePaymentCard(
                leadingIcon: SvgPicture.asset(SvgPath.cardIconSvg),
                cardTitle: 'Pay with your Credit or Debit Card',
                paymentMethod: PaymentMethod.card,
                onTapCard: () {
                  PopupDialogs(context).comingSoonSnack();
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
                feeValue: 'Fee 1%',
                feeDuration: 'Instant')),
        const Gap(10),
        Opacity(
            opacity: 0.3,
            child: ChoosePaymentCard(
                leadingIcon: SvgPicture.asset(SvgPath.banklinkIconSvg),
                cardTitle: 'Pay directly from your bank account',
                paymentMethod: PaymentMethod.bank,
                onTapCard: () {
                  PopupDialogs(context).comingSoonSnack();
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
        ChoosePaymentCard(
            leadingIcon: SvgPicture.asset(
              SvgPath.bankIconSvg,
            ),
            cardTitle: 'Make a transfer from your bank account',
            paymentMethod: PaymentMethod.manualBank,
            limitValue: "Limit \$500,000.00",
            feeValue: 'Fee 0%',
            onTapCard: () async {
              final result = await showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return const WalletSelectorList(
                      disable: true,
                    );
                  });
              if (result.runtimeType == Wallet) {
                if (result.hasAccountDetails) {
                  BankTransferPage.show(context, result);
                }
              }
            },
            onTapInfo: () => _showModalBottomSheet(
                "We'll give you the bank account details. All you have to do is transfer the amount from your bank"),
            feeDuration: '2-5 days'),
        const Gap(10),
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
