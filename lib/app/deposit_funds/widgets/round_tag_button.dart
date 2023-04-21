import 'package:flutter/material.dart';

import '../../../util/color_scheme.dart';

class RoundTag extends StatelessWidget {
  const RoundTag(
      {Key? key,
      required this.label,
      this.textStyle,
      this.bgColor = AppColor.kAccentColor2})
      : super(key: key);

  final String label;
  final TextStyle? textStyle;
  final Color bgColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: bgColor, borderRadius: BorderRadius.circular(10)),
      child: Text(
        label,
        style: textStyle ??
            Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 9),
      ),
    );
  }
}
