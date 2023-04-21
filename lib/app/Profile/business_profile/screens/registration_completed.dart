import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/Profile/business_profile/screens/business_profile.dart';
import 'package:geniuspay/app/home/pages/home_containter.dart';
import 'package:geniuspay/app/shared_widgets/circle_border_icon.dart';
import 'package:geniuspay/app/shared_widgets/custom_yellow_elevated_button.dart';
import 'package:geniuspay/app/wallet/create_individual_wallet/create_wallet_vm.dart';
import 'package:geniuspay/core/injections/injections.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/util/color_scheme.dart';

class RegistrationCompleted extends StatefulWidget {
  static Future<void> show(
    BuildContext context,
  ) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const RegistrationCompleted(),
      ),
    );
  }

  const RegistrationCompleted({Key? key}) : super(key: key);

  @override
  State<RegistrationCompleted> createState() => _RegistrationCompletedState();
}

class _RegistrationCompletedState extends State<RegistrationCompleted> {
  final AuthenticationService _auth = sl<AuthenticationService>();
  bool get isVerified =>
      _auth.user!.userProfile.businessProfile!.verificationStatus == 'VERIFIED';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
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
                  child: Text('Registration Completed',
                      style: textTheme.headline4
                          ?.copyWith(color: AppColor.kSecondaryColor),
                      textAlign: TextAlign.center)),
              const Gap(16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: Text.rich(
                  TextSpan(
                    text: 'You have successfully onboarded ',
                    children: [
                      TextSpan(
                        text: 'geniuspay INC. ',
                        style: textTheme.subtitle2?.copyWith(
                          fontSize: 14,
                          color: AppColor.kSecondaryColor,
                        ),
                      ),
                      const TextSpan(
                        text:
                            'You are not required to do anything at this point. We will notify you if we need additional information to verify your company',
                      )
                    ],
                    style: textTheme.bodyText2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Gap(32),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: CustomYellowElevatedButton(
                  onTap: () {
                    if (isVerified) {
                      Navigator.of(context).pushAndRemoveUntil(
                        NoAnimationPageRoute(
                          builder: (_) => const HomeWidget(
                            defaultPage: 4,
                            showSuccessDialog:
                                'Successfully created your business profile!',
                          ),
                        ),
                        ((route) => false),
                      );
                      BusinessProfile.show(
                          context,
                          _auth.user!.userProfile.businessProfile!,
                          _auth.user!.userProfile.customerNumber!);
                    } else {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (_) => const HomeWidget(
                            defaultPage: 4,
                            showSuccessDialog:
                                'Successfully created your business profile!',
                          ),
                        ),
                        ((route) => false),
                      );
                    }
                  },
                  text: isVerified ? "VIEW PROFILE" : "BACK HOME",
                ),
              ),
              const Gap(32),
            ],
          ),
        ),
      ),
    );
  }
}
