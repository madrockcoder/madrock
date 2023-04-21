import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geniuspay/app/auth/pages/sign_up/help/help_screen.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'app_bar_back_button.dart';
import 'color_scheme.dart';

class WidgetsUtil {
  static AppBar appBar(BuildContext context,
      {required String title,
      bool? backButton = true,
      List<Widget>? actions,
      IconData? prefixIcon}) {
    return AppBar(
      title: Text(
        title,
        style: GoogleFonts.lato(
          textStyle: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontSize: 21.0,
              fontWeight: FontWeight.w700,
              color: AppColor.kOnPrimaryTextColor2),
        ),
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: !backButton!
          ? null
          : Row(
              children: [
                const SizedBox(width: 18.0),
                InkWell(
                  child: AppBarBackButton(
                    context: context,
                    icon: prefixIcon,
                  ),
                  onTap: () => Navigator.of(context).pop(),
                ),
              ],
            ),
      actions: actions,
    );
  }

  static AppBar onBoardingAppBar(
    BuildContext context, {
    String? title,
    List<Widget>? actions,
    bool automaticallyImplyLeading = true,
    Widget? backButton,
  }) {
    final textTheme = Theme.of(context).textTheme;
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      centerTitle: true,
      leading: backButton,
      leadingWidth: 40,
      backgroundColor: Colors.transparent,
      title: Text(
        title ?? '',
        style: textTheme.displayLarge?.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
      actions: actions ??
          [
            HelpIconButton(
              onTap: () {
                HelpScreen.show(context);
              },
            ),
          ],
    );
  }

  static Widget onboardingBackground({required Widget child}) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 1],
          colors: [
            Color(0xffD3F4FE),
            Colors.white,
          ],
        ),
      ),
      child: child,
    );
  }

  static Widget pageTitle(BuildContext context,
      {required String title, required String description}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.lato(
            textStyle: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        const SizedBox(height: 12.0),
        Row(
          children: [
            Flexible(
              child: Text(
                description,
                style: GoogleFonts.lato(
                  textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColor.kPinDesColor,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 32.0),
      ],
    );
  }

  static Widget searchIcon() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SvgPicture.asset(
        'assets/icons/search-normal.svg',
        height: 18.0,
        width: 18.0,
        fit: BoxFit.contain,
      ),
    );
  }

  static Widget cancelIcon({
    VoidCallback? onTap,
    double? size,
    Color? color,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          height: size ?? 18.0,
          width: size ?? 18.0,
          child: SvgPicture.asset(
            size != null
                ? 'assets/icons/cancel2.svg'
                : 'assets/icons/cancel.svg',
            color: color ?? AppColor.kDisabledTextFieldTextColor,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  static String? getCurrency(String currency) {
    final format = NumberFormat.simpleCurrency(
      locale: Platform.localeName,
      name: currency,
    );
    return format.currencySymbol;
  }

  //text span
  static TextSpan textSpan({required String value, required TextStyle textStyle, TapGestureRecognizer? recognizer}) {
    return TextSpan(
      recognizer: recognizer,
      text: value,
      style: textStyle,
    );
  }
}
