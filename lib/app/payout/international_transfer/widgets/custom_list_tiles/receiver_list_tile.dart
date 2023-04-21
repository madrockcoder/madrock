import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/shared_widgets/custom_circular_icon.dart';
import 'package:geniuspay/app/shared_widgets/custom_divider.dart';
import 'package:geniuspay/models/bank_beneficiary.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/conditional.dart';

class ReceiverListTile extends StatelessWidget {
  final BankBeneficiary? selectedBeneficiary;

  const ReceiverListTile({Key? key, this.selectedBeneficiary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Conditional.single(
                context: context,
                conditionBuilder: (context) => selectedBeneficiary != null,
                widgetBuilder: (context) => CustomCircularIcon(SvgPicture.asset(
                    'assets/icons/user-add.svg',
                    width: 24,
                    height: 24)),
                fallbackBuilder: (context) => CustomCircularIcon(
                    SvgPicture.asset('assets/icons/user-add.svg',
                        width: 17.6, color: Colors.white, height: 19.27),
                    color: AppColor.kSecondaryColor),
              ),
              const Gap(16),
              if (selectedBeneficiary != null)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Receiver',
                      style: textTheme.bodyMedium?.copyWith(
                        fontSize: 10,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      selectedBeneficiary?.friendlyName ?? '',
                      style: textTheme.titleSmall
                          ?.copyWith(color: AppColor.kSecondaryColor),
                    ),
                    Text(
                      selectedBeneficiary?.hashedIban ?? '',
                      style: textTheme.bodyMedium?.copyWith(
                          fontSize: 12, color: AppColor.kOnPrimaryTextColor3),
                    ),
                  ],
                ),
              if (selectedBeneficiary == null)
                Text(
                  'Select receiver',
                  style: textTheme.titleSmall
                      ?.copyWith(color: AppColor.kSecondaryColor),
                ),
              const Spacer(),
              if (selectedBeneficiary != null)
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
