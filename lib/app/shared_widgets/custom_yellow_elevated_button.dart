import 'package:flutter/material.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';

import 'package:geniuspay/util/color_scheme.dart';

class CustomYellowElevatedButton extends StatefulWidget {
  final String text;
  final bool transparentBackground;
  final bool disable;
  final GestureTapCallback? onTap;

  const CustomYellowElevatedButton(
      {Key? key,
      required this.text,
      this.transparentBackground = false,
      this.disable = false,
      this.onTap})
      : super(key: key);

  @override
  State<CustomYellowElevatedButton> createState() =>
      _CustomYellowElevatedButtonState();
}

class _CustomYellowElevatedButtonState
    extends State<CustomYellowElevatedButton> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 40,
      child: CustomElevatedButton(
        onPressed: widget.disable ? null : (widget.onTap ?? () {}),
        radius: 8,
        disabledColor: AppColor.kAccentColor2,
        borderColor: Colors.transparent,
        transparentBackground: widget.transparentBackground,
        color: widget.transparentBackground
            ? Colors.transparent
            : AppColor.kGoldColor2,
        child: Text(widget.text,
            style: widget.disable ? textTheme.bodyMedium : textTheme.bodyLarge),
      ),
    );
  }
}
