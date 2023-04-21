import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/shared_widgets/custom_divider.dart';
import 'package:geniuspay/util/color_scheme.dart';

class EditDetailsV1Widget extends StatelessWidget {
  final String heading;
  final Map<String, String> fields;
  final GestureTapCallback onEditClicked;
  final String? lowerText;
  final bool hideEdit;

  const EditDetailsV1Widget(
      {Key? key,
      required this.heading,
      required this.fields,
      required this.onEditClicked,
      this.lowerText, this.hideEdit = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColor.kSecondaryColor),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                heading,
                style: textTheme.titleMedium
                    ?.copyWith(color: AppColor.kSecondaryColor, fontSize: 14),
              ),
              const Spacer(),
              if(!hideEdit)
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
            ],
          ),
          const CustomDivider(
              thickness: 0.3,
              color: AppColor.kSecondaryColor,
              sizedBoxHeight: 8),
          Column(
            children: List.generate(
                fields.length,
                (index) => Padding(
                      padding: EdgeInsets.only(
                          bottom: index == fields.length - 1 ? 0.0 : 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            fields.keys.elementAt(index),
                            style: textTheme.titleMedium?.copyWith(
                                color: AppColor.kSecondaryColor, fontSize: 12),
                          ),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 150),
                            child: Text(fields.values.elementAt(index),
                                maxLines: 10,
                                style: textTheme.bodyMedium?.copyWith(
                                    color: AppColor.kPinDesColor, fontSize: 12),
                                textAlign: TextAlign.right),
                          ),
                        ],
                      ),
                    )),
          ),
          if (lowerText != null) ...[
            const Gap(8),
            Text(
              lowerText!,
              style: const TextStyle(
                  color: Color(0xff5D5D5D),
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            )
          ]
        ],
      ),
    );
  }
}
