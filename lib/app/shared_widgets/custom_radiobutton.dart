import 'package:flutter/material.dart';
import 'package:geniuspay/util/color_scheme.dart';

enum CustomRadioButtonShape {circle, rectangle}

class CustomRadioButton extends StatelessWidget {
  final int? groupValue;
  final int tileValue;
  final ValueChanged<int> onChanged;
  final CustomRadioButtonShape checkboxShape;
  const CustomRadioButton({Key? key, this.groupValue, required this.tileValue, required this.onChanged, this.checkboxShape = CustomRadioButtonShape.circle}) : super(key: key);
  bool get isCircle => checkboxShape == CustomRadioButtonShape.circle;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(tileValue),
      child: Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(
            color: groupValue == tileValue
                ? AppColor.kSecondaryColor
                : AppColor.kWhiteColor,
            border: Border.all(width: 1, color: AppColor.kSecondaryColor),
            borderRadius: isCircle?null:BorderRadius.circular(2),
            shape: isCircle?BoxShape.circle:BoxShape.rectangle),
        child: groupValue == tileValue
            ? const Icon(
          Icons.check,
          size: 12,
          color: Colors.white,
        )
            : null,
      ),
    );
  }
}