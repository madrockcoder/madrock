import 'package:flutter/material.dart';
import 'package:geniuspay/util/color_scheme.dart';

class CustomElevatedButtonIcon extends StatelessWidget {
  final Widget label;
  final Widget icon;
  final VoidCallback? onPressed;
  const CustomElevatedButtonIcon({
    Key? key,
    required this.icon,
    required this.label,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.kSecondaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
          )),
      onPressed: onPressed,
      label: label,
      icon: icon,
    );
  }
}
