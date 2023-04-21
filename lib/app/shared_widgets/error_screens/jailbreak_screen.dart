import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/auth/pages/sign_up/help/help_screen.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/util/color_scheme.dart';

class JailBreakScreen extends StatelessWidget {
  const JailBreakScreen({Key? key}) : super(key: key);
  static Future<void> show({
    required BuildContext context,
  }) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const JailBreakScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
          padding: const EdgeInsets.all(24),
          child: CustomElevatedButton(
            child: Text(
              'CONTACT SUPPORT',
              style: textTheme.bodyLarge?.copyWith(color: Colors.white),
            ),
            onPressed: () {
              HelpScreen.show(context);
            },
          )),
      backgroundColor: Colors.white,
      body: Center(
          child: ListView(shrinkWrap: true, children: [
        SvgPicture.asset('assets/splash/error_broken_robot.svg'),
        const Gap(40),
        Text(
          'This device has been ${Platform.isIOS ? 'JailBroken' : 'Rooted'}',
          style: textTheme.headlineMedium?.copyWith(
            color: AppColor.kSecondaryColor,
          ),
          textAlign: TextAlign.center,
        ),
        const Gap(16),
        Text(
          "Due to security reasons, we can't let you proceeed",
          style: textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        const Gap(100),
      ])),
    );
  }
}
