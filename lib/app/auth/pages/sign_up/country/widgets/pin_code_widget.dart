import 'package:flutter/material.dart';
import 'package:geniuspay/util/color_scheme.dart';

class PinCodeWidget extends StatelessWidget {
  const PinCodeWidget({
    Key? key,
    this.filled = false,
  }) : super(key: key);
  final bool filled;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 15,
      height: 15,
      decoration: BoxDecoration(
        color: filled ? AppColor.kSecondaryColor : Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColor.kSecondaryColor,
          width: 1,
        ),
      ),
    );
  }
}
