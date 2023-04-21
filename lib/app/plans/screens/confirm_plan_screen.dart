import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/home/pages/home_containter.dart';
import 'package:geniuspay/app/shared_widgets/circle_border_icon.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button_async.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/services/kyc_service.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/enum_converter.dart';

class ConfirmPlanScreen extends StatelessWidget with EnumConverter {
  final String planName;
  final String planString;
  ConfirmPlanScreen(
      {Key? key, required this.planName, required this.planString})
      : super(key: key);
  static Future<void> show(
      {required BuildContext context,
      required String planName,
      required String planString}) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ConfirmPlanScreen(
          planName: planName,
          planString: planString,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColor.kAccentColor2,
      appBar: AppBar(
        backgroundColor: AppColor.kAccentColor2,
      ),
      body: Column(children: [
        const Spacer(),
        CircleBorderIcon(
            gradientStart: AppColor.kSecondaryColor,
            gradientEnd: AppColor.kAccentColor2,
            bgColor: AppColor.kSecondaryColor,
            gapColor: AppColor.kAccentColor2,
            child: SvgPicture.asset(
              'assets/plans/price_tag.svg',
              width: 35,
            )),
        const Gap(16),
        Text(
          'You\'re choosing our $planName plan',
          textAlign: TextAlign.center,
          style: textTheme.headlineMedium?.copyWith(color: AppColor.kSecondaryColor),
        ),
        const Gap(16),
        Text(
          'Tap the button below to confirm your plan',
          textAlign: TextAlign.center,
          style: textTheme.bodyMedium?.copyWith(color: AppColor.kSecondaryColor),
        ),
        const Spacer(),
        Padding(
            padding: const EdgeInsets.all(24),
            child: CustomElevatedButtonAsync(
                borderColor: AppColor.kGoldColor2,
                color: AppColor.kGoldColor2,
                child: const Text('CONTINUE'),
                onPressed: () async {
                  final Kycservice _kycservice = sl<Kycservice>();
                  final AuthenticationService _authenticationService =
                      sl<AuthenticationService>();
                  final result = await _kycservice.choosePlan(
                    uid: _authenticationService.user!.id,
                    planString: planString,
                  );
                  result.fold((l) {
                    PopupDialogs(context).errorMessage(
                        'Unable to select plan. Please try again later');
                  }, (r) {
                    HomeWidget.show(context,
                        resetUser: true,
                        showSuccessDialog: 'Upgraded plan to $planName');
                  });
                })),
        const Gap(32),
      ]),
    );
  }
}
