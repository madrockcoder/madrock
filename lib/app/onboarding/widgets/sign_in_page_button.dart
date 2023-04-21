import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared_widgets/custom_elevated_button.dart';

class SignInPageButton extends CustomElevatedButton {
  SignInPageButton(
      {Key? key,
      double? width,
      String? text,
      required BuildContext context,
      bool? isLoading = false,
      Color? color,
      Color? textColor,
      VoidCallback? onPressed})
      : super(
          key: key,
          width: width,
          child: Text(
            text ?? 'Signup',
            style: GoogleFonts.lato(
              textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: textColor ?? Colors.white),
            ),
          ),
          onPressed: isLoading! ? null : onPressed,
          color: color ?? Theme.of(context).colorScheme.secondary,
          onPrimary: Colors.white,
          height: 56.0,
          radius: 16.0,
        );
}
