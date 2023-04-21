import 'package:flutter/material.dart';
import 'package:geniuspay/util/color_scheme.dart';

class TextFieldDecoration {
  final FocusNode focusNode;
  final TextEditingController controller;
  final Function()? onClearTap;
  final String hintText;
  final String? helperText;
  final BuildContext context;
  final bool removeClear;
  final Widget? prefix;
  final double clearSize;
  final int? helperMaxLines;
  final TextStyle? helperTextStyle;
  final Widget? suffix;
  final int hintMaxLines;
  final bool centerHintText;

  TextFieldDecoration(
      {required this.focusNode,
      required this.controller,
      this.onClearTap,
      required this.hintText,
      required this.context,
      this.removeClear = false,
      this.clearSize = 10,
      this.hintMaxLines = 10,
      this.prefix,
      this.helperText,
      this.helperMaxLines,
      this.helperTextStyle,
      this.centerHintText = false,
      this.suffix});

  InputDecoration inputDecoration() {
    return InputDecoration(
      errorStyle: const TextStyle(color: AppColor.kRedColor),
      filled: true,
      prefixIcon: prefix,
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColor.kSecondaryColor, width: 1),
        borderRadius: BorderRadius.circular(8.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColor.kSecondaryColor, width: 1),
        borderRadius: BorderRadius.circular(8.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColor.kSecondaryColor, width: 1),
        borderRadius: BorderRadius.circular(8.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColor.kRedColor, width: 1),
        borderRadius: BorderRadius.circular(8.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColor.kSecondaryColor, width: 1),
        borderRadius: BorderRadius.circular(8.0),
      ),
      fillColor: focusNode.hasFocus || controller.text.isNotEmpty
          ? AppColor.kAccentColor2
          : Colors.white,
      suffixIcon: suffix,
      suffix: removeClear || onClearTap == null
          ? null
          : InkWell(
              onTap: onClearTap,
              borderRadius: BorderRadius.circular(24),
              child: CircleAvatar(
                radius: clearSize,
                backgroundColor: AppColor.kSecondaryColor,
                child: Icon(
                  Icons.close,
                  size: clearSize + 2,
                  color: Colors.white,
                ),
              )),
      hintText: centerHintText?hintText:null,
      hintStyle: Theme.of(context).textTheme.bodyMedium,
      labelText: !centerHintText?hintText:null,
      helperText: helperText,
      helperMaxLines: helperMaxLines,
      hintMaxLines: hintMaxLines,
      helperStyle: helperTextStyle,
      labelStyle: Theme.of(context).textTheme.bodyMedium,
      // labelText: hintText,
    );
  }
}
