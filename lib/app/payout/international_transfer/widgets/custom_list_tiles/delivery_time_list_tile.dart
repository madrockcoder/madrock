import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/payout/international_transfer/widgets/choose_delivery_option_bottomsheet.dart';
import 'package:geniuspay/app/shared_widgets/custom_circular_icon.dart';
import 'package:geniuspay/app/shared_widgets/custom_divider.dart';
import 'package:geniuspay/util/color_scheme.dart';

class DeliveryTimeListTile extends StatelessWidget {
  final DeliveryOption selectedDeliveryOption;

  const DeliveryTimeListTile({Key? key, required this.selectedDeliveryOption})
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
              CustomCircularIcon(SvgPicture.asset('assets/icons/send2.svg',
                  width: 24, height: 24)),
              const Gap(16),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Delivery time',
                    style: textTheme.bodyMedium?.copyWith(
                      fontSize: 10,
                    ),
                  ),
                  const Gap(4),
                  Row(
                    children: [
                      Text(
                        selectedDeliveryOption.title,
                        style: textTheme.titleSmall
                            ?.copyWith(color: AppColor.kSecondaryColor),
                      ),
                      Text(
                        ' (${selectedDeliveryOption.subtitle})',
                        style: textTheme.bodyMedium?.copyWith(
                            fontSize: 12, color: AppColor.kOnPrimaryTextColor3),
                      ),
                    ],
                  )
                ],
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                    color: AppColor.kSecondaryColor,
                    borderRadius: BorderRadius.circular(16)),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                child: Text(
                  selectedDeliveryOption.actualPrice == 0
                      ? 'Free'
                      : '\$ ${selectedDeliveryOption.actualPrice}',
                  style: textTheme.bodyMedium
                      ?.copyWith(color: Colors.white, fontSize: 10),
                ),
              ),
              const Gap(8),
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
