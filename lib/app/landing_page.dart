import 'package:flutter/material.dart';
import 'package:geniuspay/app/auth/pages/flash_screens/start_page.dart';
import 'package:geniuspay/app/auth/pages/passcode/pin_code_page.dart';
import 'package:geniuspay/app/auth/pages/sign_up/mobile_number/mobile_number_page.dart';
import 'package:geniuspay/app/home/pages/home_containter.dart';
import 'package:geniuspay/app/landing_page_vm.dart';
import 'package:geniuspay/app/onboarding/onboarding_page.dart';
import 'package:geniuspay/app/shared_widgets/error_screens/account_banned.dart';
import 'package:geniuspay/app/shared_widgets/error_screens/account_locked.dart';
import 'package:geniuspay/app/shared_widgets/error_screens/error_screen_selector.dart';
import 'package:geniuspay/app/shared_widgets/error_screens/jailbreak_screen.dart';
import 'package:geniuspay/app/splash_screen.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/util/enums.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => const LandingPage(),
      ),
      ((route) => false),
    );
  }

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return BaseView<LandingPageVM>(
        onModelReady: (p0) => p0.initialize(context),
        builder: (context, model, snapshot) {
          // loading
          if (model.baseModelState == BaseModelState.loading || model.splashdone == false) {
            return SplashScreen(
              model: model,
            );
          }

          // if (model.baseModelState == BaseModelState.error) {
          //   return ErrorScreen(
          //       showHelp: true,
          //       onRefresh: () {
          //         setState(() {
          //           model.initialize(context);
          //         });
          //       },
          //       exception: model.errorType);
          // }
          // else
          if (model.baseModelState == BaseModelState.error && model.jailBreak) {
            return const JailBreakScreen();
          }
          // error
          else if (model.baseModelState == BaseModelState.error) {
            print(model.user?.userProfile.status);
            switch (model.user?.userProfile.status) {
              case ProfileStatus.active:
              case ProfileStatus.limited:
              case ProfileStatus.banned:
              case ProfileStatus.suspended:
                return AccountBanned(profileStatus: model.userStatus);
              case ProfileStatus.blocked:
              case ProfileStatus.closing:
              case ProfileStatus.closed:
                return AccountLocked(profileStatus: model.userStatus);
              default:
                return ErrorScreen(
                    showHelp: true,
                    onRefresh: () {
                      setState(() {
                        model.initialize(context);
                      });
                    },
                    exception: model.errorType);
            }
          }

          // success
          else {
            if (model.signedIn) {
              final status = model.user?.userProfile.onboardingStatus;
              if (status == OnboardingStatus.onboardingRequired) {
                return MobileNumberVerification(
                  selectedCountry: model.selectedCountry!,
                );
              } else if (status == OnboardingStatus.passCodeRequired) {
                return PINCodeSettingPage(
                  isLogin: false,
                  onVerified: (context) {},
                );
              } else if (model.biometricVerified) {
                return const HomeWidget();
              } else {
                return PINCodeSettingPage(
                  isLogin: model.user?.userProfile.passCode != null,
                  onVerified: (pinContext) {
                    HomeWidget.show(context);
                  },
                );
              }
            } else {
              // return const OnboardingPage();
              if (model.privacyAndTermsAccepted) {
                return const OnboardingPage();
              } else {
                return const Startpage();
              }
            }
          }
        });
  }
}
