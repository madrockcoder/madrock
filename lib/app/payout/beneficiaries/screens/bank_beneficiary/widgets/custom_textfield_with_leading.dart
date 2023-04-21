import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/util/color_scheme.dart';

class CustomTextFieldWithLeading extends StatelessWidget {
  final Widget leading;
  final String hintText;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final bool isFilled;

  const CustomTextFieldWithLeading(
      {Key? key,
      required this.leading,
      required this.hintText,
      required this.controller,
      this.onChanged,
      this.isFilled = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.maxFinite,
        height: 40,
        decoration: BoxDecoration(
            border: Border.all(color: AppColor.kSecondaryColor),
            color: isFilled ? AppColor.kAccentColor2 : null,
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Row(
          children: [
            const Gap(17.33),
            leading,
            const Gap(8),
            Flexible(
              child: TextField(
                controller: controller,
                onChanged: onChanged,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    filled: isFilled,
                    fillColor: AppColor.kAccentColor2,
                    hintText: hintText,
                    hintStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: AppColor.kOnPrimaryTextColor3)),
              ),
            )
          ],
        ));
  }
}
