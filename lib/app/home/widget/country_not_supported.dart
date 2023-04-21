import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/util/color_scheme.dart';

class CountryNotSupportedWidget extends StatelessWidget {
  const CountryNotSupportedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: AppColor.kAccentColor2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            const Gap(24),
            const Icon(
              Icons.info_outline,
              color: AppColor.kSecondaryColor,
              size: 16,
            ),
            const Gap(16),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(8),
                Text(
                  'Limited access to geniuspay',
                  style: textTheme.bodyLarge
                      ?.copyWith(color: AppColor.kSecondaryColor),
                ),
                const Gap(4),
                Text(
                  'The features in this app are limited in your country',
                  style: textTheme.bodyMedium
                      ?.copyWith(color: AppColor.kSecondaryColor),
                ),
                const Gap(8),
              ],
            )),
            const Gap(24),
          ],
        ));
  }
}
