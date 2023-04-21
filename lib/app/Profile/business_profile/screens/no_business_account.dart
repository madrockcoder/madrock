import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/Profile/business_profile/screens/open_business_account_home_page.dart';
import 'package:geniuspay/app/shared_widgets/circle_border_icon.dart';
import 'package:geniuspay/app/shared_widgets/custom_yellow_elevated_button.dart';
import 'package:geniuspay/util/color_scheme.dart';

class NoBusinessAccount extends StatefulWidget {
  static Future<void> show(
    BuildContext context,
  ) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const NoBusinessAccount(),
      ),
    );
  }

  const NoBusinessAccount({Key? key}) : super(key: key);

  @override
  State<NoBusinessAccount> createState() => _NoBusinessAccountState();
}

class _NoBusinessAccountState extends State<NoBusinessAccount> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: true,
          title: const Text('')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleBorderIcon(
              gradientStart: const Color(0xff7ed8fc).withOpacity(.2),
              gradientEnd: AppColor.kWhiteColor,
              gapColor: Colors.white,
              size: 200,
              bgColor: AppColor.kAccentColor2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/icons/briefcase.png',
                ),
              ),
            ),
            const Gap(40),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text('No Business account',
                    style: textTheme.headlineMedium
                        ?.copyWith(color: AppColor.kSecondaryColor),
                    textAlign: TextAlign.center)),
            const Gap(16),
            Text(
              'You do not have any business account yet...',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColor.kOnPrimaryTextColor2),
              textAlign: TextAlign.center,
            ),
            const Gap(32),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: CustomYellowElevatedButton(
                onTap: () {
                  OpenBusinessAccountHomePage.show(context);
                },
                text: "OPEN BUSINESS ACCOUNT",
              ),
            ),
            const Gap(32),
          ],
        ),
      ),
    );
  }
}
