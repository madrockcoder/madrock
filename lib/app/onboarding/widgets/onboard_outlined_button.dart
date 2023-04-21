import 'package:flutter/material.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared_widgets/custom_outlined_button.dart';

class OnboardOutlinedButton extends CustomOutlinedButton {
  OnboardOutlinedButton({
    Key? key,
    required BuildContext context,
    required String text,
    EdgeInsetsGeometry? padding,
    Color? color,
    Color? textColor,
    VoidCallback? onTap,
    bool? isLoading = false,
  }) : super(
          key: key,
          onPressed: isLoading! ? null : onTap,
          padding: padding,
          child: Text(
            text,
            style: GoogleFonts.lato(
              textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: textColor ?? AppColor.kOnPrimaryTextColor),
            ),
          ),
          height: 56.0,
          radius: 16.0,
          color: color ?? AppColor.kOnPrimaryTextColor,
        );
}
