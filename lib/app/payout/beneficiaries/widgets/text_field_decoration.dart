import 'package:flutter/material.dart';
import 'package:geniuspay/util/color_scheme.dart';

class TextFieldDecoration {
  final FocusNode focusNode;
  final TextEditingController controller;
  final Function() onClearTap;
  final String hintText;
  TextFieldDecoration({
    required this.focusNode,
    required this.controller,
    required this.onClearTap,
    required this.hintText,
  });
  InputDecoration inputDecoration() {
    return InputDecoration(
        errorStyle: const TextStyle(color: AppColor.kRedColor),
        filled: true,
        border: OutlineInputBorder(
          borderSide:
              const BorderSide(color: AppColor.kSecondaryColor, width: 1),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: AppColor.kSecondaryColor, width: 1),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: AppColor.kSecondaryColor, width: 1),
          borderRadius: BorderRadius.circular(8.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.kRedColor, width: 1),
          borderRadius: BorderRadius.circular(8.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: AppColor.kSecondaryColor, width: 1),
          borderRadius: BorderRadius.circular(8.0),
        ),
        fillColor: focusNode.hasFocus || controller.text.isNotEmpty
            ? AppColor.kAccentColor2
            : Colors.white,
        suffix: InkWell(
            onTap: onClearTap,
            borderRadius: BorderRadius.circular(24),
            child: const CircleAvatar(
              radius: 10,
              backgroundColor: AppColor.kSecondaryColor,
              child: Icon(
                Icons.close,
                size: 12,
                color: Colors.white,
              ),
            )),
        labelText: hintText,
        hintText: hintText);
  }
}
