import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/payout/international_transfer/international_transfer_main.dart';
import 'package:geniuspay/app/shared_widgets/custom_circular_icon.dart';
import 'package:geniuspay/app/shared_widgets/custom_divider.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/conditional.dart';

class PaymentMethodListTile extends StatelessWidget {
  final PaymentMethod? selectedPaymentMethod;
  final Wallet? selectedWallet;
  const PaymentMethodListTile(
      {Key? key, this.selectedPaymentMethod, this.selectedWallet})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Conditional.single(
                context: context,
                conditionBuilder: (context) => selectedPaymentMethod != null,
                widgetBuilder: (context) => CustomCircularIcon(SvgPicture.asset(
                    'assets/icons/wallet-money.svg',
                    width: 24,
                    height: 24)),
                fallbackBuilder: (context) => CustomCircularIcon(
                    SvgPicture.asset(
                      'assets/icons/deposit/cardIcon.svg',
                      width: 24,
                      height: 18,
                      color: Colors.white,
                    ),
                    color: AppColor.kSecondaryColor),
              ),
              const Gap(16),
              if (selectedPaymentMethod != null)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Payment method',
                      style: textTheme.bodyMedium?.copyWith(
                        fontSize: 10,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      "${getPaymentMethodAsString(selectedPaymentMethod!)} payment",
                      style: textTheme.titleSmall
                          ?.copyWith(color: AppColor.kSecondaryColor),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset('assets/icons/wallet-money.svg',
                            height: 12, width: 20),
                        const Gap(4),
                        Text(
                          selectedWallet?.friendlyName ?? '',
                          style: textTheme.bodyMedium?.copyWith(
                              fontSize: 12,
                              color: AppColor.kOnPrimaryTextColor3),
                        ),
                      ],
                    )
                  ],
                ),
              if (selectedPaymentMethod == null)
                Text(
                  'Select payment method',
                  style: textTheme.titleSmall
                      ?.copyWith(color: AppColor.kSecondaryColor),
                ),
              const Spacer(),
              if (selectedPaymentMethod != null)
                SvgPicture.asset(
                  'assets/icons/arrow.svg',
                  width: 10.77,
                )
            ],
          ),
          const Gap(16),
          SizedBox(
              width: MediaQuery.of(context).size.width - 94,
              child: const CustomDivider(
                sizedBoxHeight: 0,
                color: AppColor.kAccentColor2,
              ))
        ],
      ),
    );
  }
}
