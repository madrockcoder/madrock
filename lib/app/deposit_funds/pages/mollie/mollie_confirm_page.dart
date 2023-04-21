import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/currency_exchange/widgets/label_button.dart';
import 'package:geniuspay/app/deposit_funds/view_models/mollie_view_model.dart';
import 'package:geniuspay/app/deposit_funds/widgets/confirm_deposit_transition.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button_async.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/models/mollie_response.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/converter.dart';
import 'package:geniuspay/util/iconPath.dart';

class MollieConfirmDepositPage extends StatelessWidget {
  final MolliePaymentResponse paymentResponse;
  final Wallet wallet;
  const MollieConfirmDepositPage(
      {Key? key, required this.paymentResponse, required this.wallet})
      : super(key: key);

  static Future<void> show(BuildContext context, Wallet wallet,
      MolliePaymentResponse paymentResponse) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MollieConfirmDepositPage(
          paymentResponse: paymentResponse,
          wallet: wallet,
        ),
      ),
    );
  }

  String getFeePercent() {
    final fee = paymentResponse.fees.value;
    final amount = paymentResponse.instructedAmount.value;
    final percent = (fee / amount) * 100;
    return "${percent.toStringAsFixed(1)}%";
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColor.kAccentColor2,
      appBar: AppBar(
        backgroundColor: AppColor.kAccentColor2,
        centerTitle: true,
        title: Text('Confirm Deposit',
            style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
        actions: const [HelpIconButton()],
      ),
      body: Column(
        children: [
          ConfirmDepositTransitionWidget(
              internalAccountId: wallet.internalAccountId!,
              amount: paymentResponse.instructedAmount.value.toString(),
              currency: paymentResponse.currency,
              feePercent: getFeePercent(),
              currencySymbol: Converter().getCurrency(paymentResponse.currency),
              fee: paymentResponse.fees.valueWithCurrency!,
              totalAmount: paymentResponse.totalAmount.valueWithCurrency!),
          const Gap(24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Secure payment by',
                style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w300,
                    color: const Color(0xff5D5D5D),
                    letterSpacing: 1.5),
              ),
              const Gap(16),
              Image.asset(
                IconPath.mollieLogo,
                width: 100,
              )
            ],
          ),
          const Spacer(),
          confirmButton(context, textTheme),
          const Gap(15),
          backButton(context),
          const Gap(15)
        ],
      ),
    );
  }

  Widget confirmButton(BuildContext context, TextTheme textTheme) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: CustomElevatedButtonAsync(
          onPressed: () async {
            await MollieViewModel().initiatePayment(
                context,
                paymentResponse.paymentUrl,
                paymentResponse.instructedAmount.value.toString(),
                wallet,
                paymentResponse.id);
          },
          color: AppColor.kGoldColor2,
          child: Text(
            'CONFIRM',
            style: textTheme.bodyLarge,
          ),
        ));
  }

  Widget backButton(BuildContext context) {
    return LabelButton(
        voidCallback: () {
          Navigator.pop(context);
        },
        label: 'BACK',
        labelColor: Colors.black);
  }
}
