import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/shared_widgets/custom_divider.dart';
import 'package:geniuspay/util/color_scheme.dart';

class EditDetailsV2Widget extends StatelessWidget {
  final String heading;
  final String subHeading;
  final Map<String, Map<String, String>> sections;
  final GestureTapCallback onEditClicked;
  final bool hidSvg;

  const EditDetailsV2Widget(
      {Key? key,
      required this.heading,
      required this.sections,
      required this.subHeading,
      required this.onEditClicked, this.hidSvg = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColor.kSecondaryColor),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    heading,
                    style: textTheme.titleMedium
                        ?.copyWith(color: AppColor.kSecondaryColor, fontSize: 14),
                  ),
                  const Gap(4),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.65,
                    child: Text(
                      subHeading,
                      style: textTheme.bodyMedium
                          ?.copyWith(color: AppColor.kOnPrimaryTextColor2, fontSize: 12),
                    ),
                  ),
                ],
              ),
              if(!hidSvg)...[
                const Spacer(),
                InkWell(
                  onTap: onEditClicked,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SvgPicture.asset(
                      'assets/icons/edit-2.svg',
                      width: 16,
                    ),
                  ),
                )
              ]
            ],
          ),
          const CustomDivider(
              thickness: 0.3,
              color: AppColor.kSecondaryColor,
              sizedBoxHeight: 8),
          Column(
            children: List.generate(
                sections.length,
                (index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sections.keys.elementAt(index),
                      style: textTheme.titleMedium?.copyWith(fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    for (int i = 0;
                        i < sections.values.elementAt(index).length;
                        i++) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            sections.values
                                .elementAt(index)
                                .keys
                                .elementAt(i),
                            style: textTheme.titleMedium?.copyWith(
                                color: AppColor.kSecondaryColor,
                                fontSize: 12),
                          ),
                          Text(
                              sections.values
                                  .elementAt(index)
                                  .values
                                  .elementAt(i),
                              style: textTheme.bodyMedium?.copyWith(
                                  color: AppColor.kPinDesColor,
                                  fontSize: 12),
                              textAlign: TextAlign.right),
                        ],
                      ),
                      i == sections.values.elementAt(index).length - 1
                          ? const SizedBox()
                          : const SizedBox(height: 8),
                    ],
                    if (index != sections.length - 1)
                      const CustomDivider(
                          thickness: 0.3,
                          color: AppColor.kSecondaryColor,
                          sizedBoxHeight: 8),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
