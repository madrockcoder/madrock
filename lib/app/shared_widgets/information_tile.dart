import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/util/color_scheme.dart';

import 'custom_circular_icon.dart';

class InformationTile extends StatelessWidget {
  final String leadingTitle;
  final String? subtitle;
  final String? leadingAsset;
  final String? trailingText;
  final Widget? trailingWidget;
  final double padding;
  final GestureTapCallback? onTap;

  const InformationTile(
      {Key? key,
      required this.leadingTitle,
      this.trailingText,
      this.padding = 8,
      this.trailingWidget,
      this.leadingAsset,
      this.subtitle,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: padding),
          child: Row(
            children: [
              if (leadingAsset != null) ...[
                CustomCircularIcon(SvgPicture.asset(leadingAsset!)),
                const Gap(12),
              ],
              if (subtitle != null) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      leadingTitle,
                      style: textTheme.bodyLarge?.copyWith(
                          color: AppColor.kSecondaryColor, fontSize: 12),
                    ),
                    Text(
                      subtitle!,
                      style: textTheme.bodyMedium
                          ?.copyWith(color: AppColor.kDepositColor, fontSize: 12),
                    ),
                  ],
                )
              ],
              if (subtitle == null)
                Text(
                  leadingTitle,
                  style: textTheme.bodyLarge
                      ?.copyWith(color: AppColor.kSecondaryColor, fontSize: 12),
                ),
              const Gap(32),
              Expanded(
                  child: Align(
                alignment: Alignment.centerRight,
                child: trailingWidget ??
                    Text(
                      trailingText!,
                      textAlign: TextAlign.right,
                      style: textTheme.bodyMedium
                          ?.copyWith(fontSize: 12, color: AppColor.kGreyColor),
                    ),
              ))
            ],
          )),
    );
  }
}
