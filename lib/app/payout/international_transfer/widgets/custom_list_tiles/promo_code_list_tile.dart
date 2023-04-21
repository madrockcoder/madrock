import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/shared_widgets/custom_circular_icon.dart';
import 'package:geniuspay/app/shared_widgets/custom_divider.dart';
import 'package:geniuspay/util/color_scheme.dart';

class PromoCodeListTile extends StatelessWidget {
  const PromoCodeListTile({Key? key}) : super(key: key);

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
              CustomCircularIcon(
                SvgPicture.asset(
                  'assets/icons/promo.svg',
                  width: 24,
                  height: 24,
                  color: Colors.white,
                ),
                color: AppColor.kSecondaryColor,
              ),
              const Gap(16),
              // if (selectedBeneficiary != null)
              //   Column(
              //     mainAxisSize: MainAxisSize.min,
              //     children: [
              //       Text('Receiver', style: textTheme.bodyText2?.copyWith(
              //         fontSize: 10,
              //       ),),
              //       const Gap(4),
              //       Text(
              //         selectedBeneficiary?.friendlyName ?? '',
              //         style: textTheme.subtitle2
              //             ?.copyWith(color: AppColor.kSecondaryColor),
              //       ),
              //       Text(selectedBeneficiary?.hashedIban ?? '', style: textTheme.bodyText2?.copyWith(
              //           fontSize: 12,
              //           color: AppColor.kOnPrimaryTextColor3
              //       ),),
              //     ],
              //   ),
              // if (selectedBeneficiary == null)
              Text(
                'Have a promo or invite code?',
                style: textTheme.titleSmall
                    ?.copyWith(color: AppColor.kSecondaryColor),
              ),
              // const Spacer(),
              // if (selectedBeneficiary != null)
              //   SvgPicture.asset(
              //     'assets/icons/arrow.svg',
              //     width: 21.77,
              //   )
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
