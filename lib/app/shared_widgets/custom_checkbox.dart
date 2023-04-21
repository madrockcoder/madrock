import 'package:flutter/material.dart';
import 'package:geniuspay/util/color_scheme.dart';

enum CustomCheckboxShape { circle, rectangle }

class CustomCheckbox extends StatefulWidget {
  final List<int> values;
  final int tileValue;
  final CustomCheckboxShape checkboxShape;
  final GestureTapCallback onChanged;
  const CustomCheckbox({
    Key? key,
    required this.values,
    required this.tileValue,
    this.checkboxShape = CustomCheckboxShape.circle,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool get isCircle => widget.checkboxShape == CustomCheckboxShape.circle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onChanged();
      },
      child: Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(
            color: widget.values.contains(widget.tileValue) ? AppColor.kSecondaryColor : AppColor.kWhiteColor,
            border: Border.all(width: 1, color: AppColor.kSecondaryColor),
            borderRadius: isCircle ? null : BorderRadius.circular(2),
            shape: isCircle ? BoxShape.circle : BoxShape.rectangle),
        child: widget.values.contains(widget.tileValue)
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
