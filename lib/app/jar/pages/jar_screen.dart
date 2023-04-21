import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/changes/pages/changes_screen.dart';
import 'package:geniuspay/app/jar/widgets/jar_app_bar.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/util/color_scheme.dart';

import 'package:geniuspay/app/jar/widgets/assets.gen.dart';

class CreateJarPage extends StatelessWidget {
  const CreateJarPage({Key? key}) : super(key: key);
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const CreateJarPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColor.kAccentColor2,
      appBar: const JarAppBar(text: 'Jar'),
      body: Padding(
        padding: const EdgeInsets.only(left: 22.5, right: 22.5),
        child: ListView(
          children: [
            const Gap(104),
            Assets.backgrounds.createJar
                .image(width: 273.5, height: 385, fit: BoxFit.contain),
            const Gap(16),
            SizedBox(
              width: 327,
              child: Text(
                  'Instantly add coins to your portfolio on geniuspay.\nStart with the smallest amount you comfortable with - even \$1.00.',
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium),
            ),
            const Gap(76),
            CustomElevatedButton(
              onPressed: () {
                ChangesComingSoon.show(context);
                // PopupDialogs(context).comingSoonSnack();
                // final AuthenticationService _authenticationService =
                //     sl<AuthenticationService>();
                // if (_authenticationService.user!.userProfile.onboardingStatus ==
                //     OnboardingStatus.onboardingCompleted) {
                //   showModalBottomSheet(
                //       shape: const RoundedRectangleBorder(
                //           borderRadius: BorderRadius.only(
                //               topLeft: Radius.circular(40),
                //               topRight: Radius.circular(40))),
                //       context: context,
                //       builder: (context) {
                //         return const JarTypeSheet();
                //       });
                // } else {
                //   OnboardingStatusPage.show(
                //       context,
                //       _authenticationService
                //           .user!.userProfile.onboardingStatus);
                // }
              },
              radius: 8,
              color: AppColor.kGoldColor2,
              child: Text(
                'CREATE A JAR',
                style: textTheme.bodyLarge,
              ),
            )
          ],
        ),
      ),
    );
  }
}
