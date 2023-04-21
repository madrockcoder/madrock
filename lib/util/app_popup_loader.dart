import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geniuspay/util/color_scheme.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppLoadingPopup {
  AppLoadingPopup({
    required this.context,
  });

  final BuildContext context;

  Future<dynamic> show() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Center(
            child: Container(
              // width: 80,
              // height: 80,
              decoration: const BoxDecoration(
                // color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(100),
                ),
              ),
              child: const Center(
                  child: SpinKitFadingCircle(
                color: AppColor.kSecondaryColor,
                size: 100,
              )),
            ),
          ),
        );
      },
    );
  }
}
