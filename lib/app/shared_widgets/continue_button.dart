import 'package:flutter/material.dart';
import 'package:geniuspay/util/color_scheme.dart';

import 'custom_elevated_button.dart';

class ContinueButton extends CustomElevatedButton {
  ContinueButton(
      {Key? key,
      required BuildContext context,
      VoidCallback? onPressed,
      bool? isLoading = false,
      Widget? icon,
      Color? color,
      Color? disabledColor,
      String? text,
      EdgeInsetsGeometry? padding,
      Color? textColor,
      bool disable = false,
      TextStyle? textStyle,
      Color? borderColor})
      : super(
            key: key,
            color: color,
            disabledColor: disabledColor,
            height: 56.0,
            radius: 16.0,
            onPressed: onPressed == null || disable
                ? null
                : () => isLoading! ? null : onPressed(),
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 24.25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[icon, const SizedBox(width: 13.0)],
                if (isLoading!)
                  const Center(
                      child: CircularProgressIndicator.adaptive(
                          backgroundColor: Colors.white)),
                if (!isLoading)
                  Text(
                    text ?? 'Continue'.toUpperCase(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: disable ? 13 : 16,
                          color: disable
                              ? AppColor.kOnPrimaryTextColor3
                              : textColor ?? Colors.black,
                          fontWeight:
                              disable ? FontWeight.bold : FontWeight.bold,
                        ),

                    // overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
            borderColor: borderColor);
}
