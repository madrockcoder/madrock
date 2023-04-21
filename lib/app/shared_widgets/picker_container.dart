import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../models/country.dart';
import '../../util/color_scheme.dart';

class PickerContainer extends StatelessWidget {
  final VoidCallback? onPressed;
  final Country? country;
  final Widget? suffix;
  final String? hint;
  final bool addSuffix;
  final double? height;
  final double? radius;
  final bool error;
  final bool isCountryCode;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final Widget? prefix;
  const PickerContainer(
      {Key? key,
      this.onPressed,
      this.country,
      this.suffix,
      this.addSuffix = true,
      this.hint,
      this.height,
      this.radius,
      this.borderColor,
      this.error = false,
      this.padding,
      this.prefix,
      this.isCountryCode = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 25),
          decoration: BoxDecoration(
              color: country == null ? Colors.white : AppColor.kAccentColor2,
              border: Border.all(color: AppColor.kSecondaryColor),
              borderRadius: BorderRadius.circular(8)),
          child: Row(children: [
            if (country != null) ...[
              CircleAvatar(
                radius: 12.5,
                backgroundImage: AssetImage(
                  'icons/flags/png/${country?.iso2.toLowerCase()}.png',
                  package: 'country_icons',
                ),
              )
            ] else
              prefix ?? const SizedBox(width: 12.5),
            const Gap(12),
            const Icon(
              Icons.keyboard_arrow_down,
              color: AppColor.kSecondaryColor,
              size: 24,
            ),
            const Gap(12),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hint ?? 'Select country',
                  style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300, fontSize: country == null ? 14 : 12),
                ),
                if (country != null)
                  Text(
                    isCountryCode ? "${country?.phoneCode}" : "${country?.name}",
                    style: textTheme.bodyMedium,
                  )
              ],
            )
          ]),
        ));
  }
}

class PickerContainer2 extends StatelessWidget {
  final VoidCallback? onPressed;
  final Country? country;
  final Widget? suffix;
  final String? hint;
  final bool addSuffix;
  final double? height;
  final double? radius;
  final bool error;
  final bool isCountryCode;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  const PickerContainer2(
      {Key? key,
      this.onPressed,
      this.country,
      this.suffix,
      this.addSuffix = true,
      this.hint,
      this.height,
      this.radius,
      this.borderColor,
      this.error = false,
      this.padding,
      this.isCountryCode = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: height ?? 60,
          padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 25),
          decoration: BoxDecoration(
              color: country == null ? Colors.white : AppColor.kAccentColor2,
              border: Border.all(color: AppColor.kSecondaryColor),
              borderRadius: BorderRadius.circular(8)),
          child: Row(children: [
            if (country != null) ...[
              CircleAvatar(
                radius: 12.5,
                backgroundImage: AssetImage(
                  'icons/flags/png/${country?.iso2.toLowerCase()}.png',
                  package: 'country_icons',
                ),
              )
            ] else
              const SizedBox(width: 12.5),
            const Gap(10),
            const Icon(
              Icons.keyboard_arrow_down,
              color: AppColor.kSecondaryColor,
              size: 24,
            ),
            const Gap(10),
            Text(
              country == null ? 'Select Country' : "${country?.name}",
              style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300, fontSize: country == null ? 14 : 12),
            ),
          ]),
        ));
  }
}

class PickerContainer3 extends StatelessWidget {
  final VoidCallback? onPressed;
  final Country? country;
  final Widget? suffix;
  final String? hint;
  final bool addSuffix;
  final double? height;
  final double? radius;
  final bool error;
  final bool isCountryCode;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  const PickerContainer3(
      {Key? key,
      this.onPressed,
      this.country,
      this.suffix,
      this.addSuffix = true,
      this.hint,
      this.height,
      this.radius,
      this.borderColor,
      this.error = false,
      this.padding,
      this.isCountryCode = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: height ?? 60,
          padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 15),
          decoration: BoxDecoration(
              color: country == null ? Colors.white : AppColor.kAccentColor2,
              border: Border.all(color: AppColor.kSecondaryColor),
              borderRadius: BorderRadius.circular(8)),
          child: Row(children: [
            if (country != null) ...[
              CircleAvatar(
                radius: 12.5,
                backgroundImage: AssetImage(
                  'icons/flags/png/${country?.iso2.toLowerCase()}.png',
                  package: 'country_icons',
                ),
              )
            ] else
              const SizedBox(width: 0.5),
            const Gap(5),
            const Icon(
              Icons.keyboard_arrow_down,
              color: AppColor.kSecondaryColor,
              size: 24,
            ),
            const Gap(5),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hint ?? 'Select Currency',
                  style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300, fontSize: country == null ? 14 : 12),
                ),
                if (country != null)
                  Text(
                    country == null ? 'Select Currency' : "${country?.currencyISO}",
                    style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300, fontSize: country == null ? 14 : 12),
                  ),
              ],
            )
          ]),
        ));
  }
}
