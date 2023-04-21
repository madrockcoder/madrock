import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/currency_exchange/widgets/transaction_form_item.dart';
import 'package:geniuspay/util/color_scheme.dart';

class ConfirmDepositTransitionWidget extends StatelessWidget {
  final String internalAccountId;
  final String amount;
  final String currency;
  final String feePercent;
  final String fee;
  final String totalAmount;
  final String currencySymbol;
  const ConfirmDepositTransitionWidget(
      {Key? key,
      required this.internalAccountId,
      required this.amount,
      required this.currency,
      required this.feePercent,
      required this.fee,
      required this.totalAmount,
      required this.currencySymbol})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 49),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Column(
        children: [
          const TransactionFormItem(title: 'Type', content: 'Deposit'),
          const Gap(7),
          TransactionFormItem(title: 'Wallet', content: internalAccountId),
          const Gap(7),
          TransactionFormItem(
              title: "You'll receive", content: "$currencySymbol $amount"),
          const Gap(7),
          TransactionFormItem(title: 'Fee ($feePercent)', content: fee),
          const Gap(15),
          Container(
              height: 0.5, color: AppColor.kPrimaryColor.withOpacity(0.5)),
          const Gap(32),
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 12.5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColor.kSecondaryColor.withOpacity(0.3),
            ),
            child: TransactionFormItem(
                title: "You're paying", content: totalAmount),
          ),
          const Gap(16),
          Row(
            children: [
              const Icon(
                Icons.error,
                color: AppColor.kSecondaryColor,
                size: 22,
              ),
              const Gap(8),
              Expanded(
                  child: Text(
                'You will be redirected to continue your payment.',
                style: textTheme.bodyMedium
                    ?.copyWith(color: AppColor.kSecondaryColor, fontSize: 12),
              ))
            ],
          ),
          const Gap(16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 1, color: AppColor.kSecondaryColor),
              color: AppColor.kAccentColor2,
            ),
            child: Row(children: [
              SvgPicture.asset(
                'assets/icons/yellow_star.svg',
                width: 32,
              ),
              const Gap(8),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'You will get loyalty points with this deposit',
                    style: textTheme.bodyMedium?.copyWith(fontSize: 10),
                  ),
                  const Gap(4),
                  Text(
                    'Points will be rewarded upon deposit completion',
                    style: textTheme.bodyMedium?.copyWith(
                        fontSize: 10, color: AppColor.kSecondaryColor),
                  )
                ],
              ))
            ]),
          )
        ],
      ),
    );
  }
}
