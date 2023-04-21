import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color_scheme.dart';

class AppTheme {
  static final TextTheme lightTextTheme = TextTheme(
    bodyLarge: const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: Colors.black,
      letterSpacing: 0.3,
    ),
    bodyMedium: const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      color: Colors.black,
      letterSpacing: 0.3,
    ),
    titleMedium: const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontSize: 13.0,
      letterSpacing: 0.3,
    ),
    titleSmall: const TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.3,
      color: Colors.black,
    ),
    displayLarge: const TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.3,
        color: AppColor.kOnPrimaryTextColor),
    displayMedium: const TextStyle(
      color: AppColor.kOnPrimaryTextColor,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.3,
      fontSize: 28.0,
    ),
    displaySmall: const TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.3,
        color: AppColor.kOnPrimaryTextColor),
    headlineMedium: GoogleFonts.lato(
      color: Colors.black,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.3,
      fontSize: 18.0,
    ),
    headlineSmall: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16.0,
        letterSpacing: 0.3,
        color: AppColor.kOnPrimaryTextColor),
    titleLarge: const TextStyle(
      color: AppColor.kOnPrimaryTextColor,
      // color:  AppColor.kOnPrimaryTextColor,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.3,
      fontSize: 15.0,
    ),
  );

  static light() {
    return ThemeData(
        iconTheme: const IconThemeData(color: Colors.black),
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSwatch(
          accentColor: AppColor.kAccentColor,
        ).copyWith(
          primary: Colors.black,
          onPrimary: Colors.black,
          secondary: AppColor.kSurfaceColorVariant,
          brightness: Brightness.light,
          background: AppColor.kScaffoldBackgroundColor,
          surface: AppColor.kSurfaceColor,
          secondaryContainer: AppColor.kAccentColorVariant,
          primaryContainer: AppColor.kBorderColor,
          error: AppColor.kErrorColor,
        ),
        primaryColor: AppColor.kSurfaceColorVariant,
        // accentColor: AppColor.kAccentColor,
        snackBarTheme: SnackBarThemeData(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          behavior: SnackBarBehavior.floating,
        ),
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.ibmPlexSansTextTheme((lightTextTheme)),
        appBarTheme: const AppBarTheme().copyWith(
          elevation: 0.0,
          color: Colors.white,
          // systemOverlayStyle: const SystemUiOverlayStyle(
          //   statusBarColor: Colors.white,
          //   statusBarIconBrightness: Brightness.dark,
          //   statusBarBrightness: Brightness.light,
          // ),
          // titleTextStyle: GoogleFonts.lato(
          //   color: AppColor.kOnPrimaryTextColor,
          //   fontWeight: FontWeight.w600,
          //   fontSize: 12.0,
          // ),
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40))),
        ));
  }
}
