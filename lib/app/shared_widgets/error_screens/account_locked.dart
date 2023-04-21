import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/shared_widgets/circle_border_icon.dart';
import 'package:geniuspay/app/shared_widgets/custom_yellow_elevated_button.dart';
import 'package:geniuspay/app/supplementary_screens/plan_upgrade.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/enums.dart';
import 'package:geniuspay/util/essentials.dart';

class AccountLocked extends StatefulWidget {
  static Future<void> show(
    BuildContext context,
    ProfileStatus profileStatus,
  ) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AccountLocked(profileStatus: profileStatus),
      ),
    );
  }

  final ProfileStatus profileStatus;

  const AccountLocked({Key? key, required this.profileStatus})
      : super(key: key);

  @override
  State<AccountLocked> createState() => _AccountLockedState();
}

class _AccountLockedState extends State<AccountLocked> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(left: 25, right: 20),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                          'We’re sorry. Your account has been ${widget.profileStatus.name.toLowerCase()}.',
                          style: textTheme.headlineMedium
                              ?.copyWith(color: AppColor.kSecondaryColor),
                          textAlign: TextAlign.center)),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: CircleBorderIcon(
                      gradientStart: const Color(0xff7ed8fc).withOpacity(.2),
                      gradientEnd: AppColor.kWhiteColor,
                      gapColor: Colors.white,
                      bgColor: AppColor.kAccentColor2,
                      size: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/account/account_blocked.png',
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'We’re sorry, we are unable to open an account for you this time. This can be down to a  number of reasons such as our ability to verify  your details or our own policies relating to account opening criteria.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppColor.kOnPrimaryTextColor2),
                    textAlign: TextAlign.center,
                  ),
                  const Gap(15),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text:
                          'For further information, please refer to our website ',
                      style: textTheme.bodyMedium
                          ?.copyWith(color: AppColor.kOnPrimaryTextColor2),
                      children: [
                        TextSpan(
                          text: 'www.geniuspay.com',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Essentials.launchCustomUrl(
                                Uri.parse("https://geniuspay.com/"), context),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: AppColor.kblue),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
            child: CustomYellowElevatedButton(
              onTap: () {
                Essentials.showBottomSheet(const PlanUpgrade(), context,
                    showFullScreen: true);
                // ProfilePageVM().logout(context);
              },
              text: "LOG OUT",
            ),
          ),
        ));
  }
}
