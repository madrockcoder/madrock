import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/shared_widgets/custom_section_heading.dart';
import 'package:geniuspay/app/shared_widgets/custom_shadow_container.dart';
import 'package:geniuspay/util/color_scheme.dart';

class CustomElevatedContainerSectionWithHeading extends StatelessWidget {
  final String heading;
  final Widget prefixWidget;
  final Widget? suffixWidget;
  final Widget? unAssignedTitle;
  final Widget title;
  final Widget? subtitle;
  final GestureTapCallback? onTap;

  const CustomElevatedContainerSectionWithHeading(
      {Key? key,
      required this.heading,
      required this.prefixWidget,
      this.suffixWidget,
      required this.title,
      this.subtitle,
      this.onTap,
      this.unAssignedTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomSectionHeading(
        heading: heading,
        headingTextStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: AppColor.kSecondaryColor),
        headingAndChildGap: 8,
        child: CustomShadowContainer(
          onTap: onTap,
          child: CustomTransferListTile(
            prefixWidget: prefixWidget,
            title: title,
            suffixWidget: suffixWidget,
            subtitle: subtitle,
          ),
        ));
  }
}

class CustomTransferListTile extends StatelessWidget {
  final Widget prefixWidget;
  final Widget? suffixWidget;
  final Widget title;
  final Widget? subtitle;

  const CustomTransferListTile(
      {Key? key,
      required this.prefixWidget,
      this.suffixWidget,
      required this.title,
      this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        prefixWidget,
        const Gap(12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title,
            subtitle ?? const SizedBox(),
          ],
        ),
        const Spacer(),
        suffixWidget != null
            ? Padding(
                padding: const EdgeInsets.only(right: 22.35),
                child: suffixWidget,
              )
            : const SizedBox(),
        SvgPicture.asset('assets/icons/arrow.svg')
      ],
    );
  }
}
