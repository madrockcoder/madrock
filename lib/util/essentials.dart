import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/shared_widgets/circle_border_icon.dart';
import 'package:geniuspay/app/shared_widgets/size_config.dart';
import 'package:url_launcher/url_launcher.dart';

import 'color_scheme.dart';

bool shouldTemporaryHideForEarlyLaunch = true;

void debugPrint(dynamic message) {
  if (kDebugMode) {
    print(message);
  }
}

class Essentials {
  static String capitalize(String s) {
    return s[0].toUpperCase() + s.substring(1);
  }

  static Future<dynamic> launchCustomUrl(Uri uri, BuildContext context,
      {LaunchMode launchMode = LaunchMode.platformDefault}) {
    final textTheme = Theme.of(context).textTheme;
    if (Platform.isAndroid) {
      return showDialog(
          context: context,
          builder: (context) => AlertDialog(
                  content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Warning",
                      style: textTheme.titleSmall?.copyWith(
                          fontSize: 18, color: AppColor.kSecondaryColor)),
                  const Gap(12),
                  Text(
                    "You are leaving geniuspay application. Do you want to be redirected to the system browser.",
                    style: textTheme.bodyMedium?.copyWith(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                  const Gap(14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Cancel",
                            style: TextStyle(color: Colors.grey),
                          )),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            launchUrl(uri, mode: launchMode);
                          },
                          child: const Text(
                            "Continue",
                            style: TextStyle(color: AppColor.kSecondaryColor),
                          )),
                    ],
                  )
                ],
              )));
    } else {
      return showDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
              title: const Text("Warning"),
              actions: [
                CupertinoDialogAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel")),
                CupertinoDialogAction(
                    onPressed: () {
                      Navigator.pop(context);
                      launchUrl(uri, mode: launchMode);
                    },
                    child: const Text("OK")),
              ],
              content: const Text(
                  "You are leaving geniuspay application. Do you want to be redirected to the system browser.")));
    }
  }

  static Future<dynamic> showBottomSheet(
    Widget child,
    BuildContext context, {
    bool showHeaderIcon = false,
    bool showFullScreen = false,
    Widget? icon,
    List<Color>? gradient,
    Color color = AppColor.kAccentColor2,
    Color bgColor = Colors.white,
  }) async {
    SizeConfig().init(context);
    final height = MediaQuery.of(context).size.height;
    return showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                color: bgColor,
              ),
              height: showFullScreen ? height * .8 : null,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  child,
                  if (showHeaderIcon)
                    Positioned(
                      top: -40,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleBorderIcon(
                              gradientStart: gradient?.first ??
                                  const Color(0xff008AA7).withOpacity(.3),
                              gradientEnd:
                                  gradient?.elementAt(1) ?? Colors.white,
                              gapColor: Colors.white,
                              bgColor: Colors.white,
                              spaceBetweenRingAndWidget: 12,
                              size: 100,
                              borderWidth: 3,
                              child: Container(
                                width: 80,
                                height: 80,
                                child: Center(child: icon),
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    blurRadius: 20,
                                    color:
                                        Colors.grey.shade400.withOpacity(0.5),
                                    spreadRadius: 0.3,
                                  ),
                                ], shape: BoxShape.circle, color: color),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

Map<K, V> removeNull<K, V>(Map map, [bool newMap = false]) =>
    (newMap ? Map<K, V>.from(map) : map).cast<K, V>()
      ..removeWhere((_, value) {
        if (value is Map) {
          removeNull(value, newMap);
        } else if (value is List<Map>) {
          value.forEach((mapInList) {
            removeNull(mapInList, newMap);
          });
        }
        return value == null;
      });
