import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/KYC/pages/kyc_risk_assesment/kyc_risk_starting_page.dart';
import 'package:geniuspay/app/KYC/view_models.dart/kyc_view_model.dart';
import 'package:geniuspay/app/home/pages/home_containter.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/models/verification_status_response.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/converter.dart';
import 'package:geniuspay/util/enums.dart';
import 'package:geniuspay/util/widgets_util.dart';

class ProcessingApplicationPage extends StatefulWidget {
  const ProcessingApplicationPage({
    Key? key,
  }) : super(key: key);

  static Future<void> show(
    BuildContext context,
  ) async {
    await Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => const ProcessingApplicationPage(),
      ),
      ((route) => true),
    );
  }

  @override
  State<ProcessingApplicationPage> createState() =>
      _ProcessingApplicationPageState();
}

class _ProcessingApplicationPageState extends State<ProcessingApplicationPage> {
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  late Timer _timer;
  final _converter = Converter();
  startStatusTimer(KycViewModel model) {
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      model.getVerificationStatus();
      if (model.verificationStatusResponse != null &&
          model.verificationStatusResponse!.verificationStatus ==
              KYCVerificationStatus.verified) {
        KYCRiskStartingPage.show(context);
      }
    });
  }

  Widget _getStatusWidget(VerificationStatusResponse statusResponse) {
    if (statusResponse.verificationStatus == KYCVerificationStatus.rejected) {
      return const SorryWidget();
    } else if (statusResponse.submittedTime.isNotEmpty &&
        DateTime.now()
                .toUtc()
                .difference(_converter
                    .getDateFormatFromString(statusResponse.submittedTime)
                    .subtract(const Duration(hours: 1)))
                .inMinutes >=
            5) {
      return const TakingLongerWidget();
    } else {
      return const ProcessingWidget();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.kAccentColor2,
        appBar: WidgetsUtil.onBoardingAppBar(context,
            automaticallyImplyLeading: true,
            backButton: IconButton(
                onPressed: () {
                  HomeWidget.show(context);
                },
                icon: const Icon(Icons.close))),
        body: BaseView<KycViewModel>(onModelReady: (p0) async {
          startStatusTimer(p0);
          await p0.getVerificationStatus();

          if (p0.verificationStatusResponse != null &&
              p0.verificationStatusResponse!.verificationStatus ==
                  KYCVerificationStatus.verified) {
            KYCRiskStartingPage.show(context);
          }
        }, builder: (context, model, snapshot) {
          if (model.verificationStatusResponse == null) {
            return const ProcessingWidget();
          } else {
            return _getStatusWidget(model.verificationStatusResponse!);
          }
        }));
  }
}

class ProcessingWidget extends StatelessWidget {
  const ProcessingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21),
          child: Text(
            'We\'re processing your\napplication... ',
            style: textTheme.bodyMedium?.copyWith(
                fontSize: 30, fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ),
        const Gap(40),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(40),
              topLeft: Radius.circular(40),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColor.kAccentColor2,
                    radius: 18,
                    child: SvgPicture.asset('assets/images/bx_time-five.svg'),
                  ),
                  const Gap(12),
                  Expanded(
                    child: Text(
                      'It will take 5-30 seconds',
                      style: textTheme.bodyMedium?.copyWith(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
              const Gap(35),
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColor.kAccentColor2,
                    radius: 18,
                    child: SvgPicture.asset(
                        'assets/images/clarity_notification-outline-badged.svg'),
                  ),
                  const Gap(12),
                  Expanded(
                    child: Text(
                      'After finishing, we will send you a push\nnotification',
                      style: textTheme.bodyMedium?.copyWith(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 100.0),
            ],
          ),
        ),
      ],
    );
  }
}

class SorryWidget extends StatelessWidget {
  const SorryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: Image.asset(
          'assets/kyc/sorry_image.png',
          width: 230,
        )),
        const Gap(26),
        Text(
          'Sorry, we are unable to\n proceed with your account',
          textAlign: TextAlign.center,
          style: textTheme.displaySmall?.copyWith(color: AppColor.kSecondaryColor),
        ),
        const Gap(16),
        Text(
          "Due to legal obligations, we are not able to offer you "
          " an account. Please check the email you received for"
          " further information. Thank you for your understanding.",
          textAlign: TextAlign.center,
          style: textTheme.bodyMedium,
        )
      ],
    );
  }
}

class TakingLongerWidget extends StatelessWidget {
  const TakingLongerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21),
          child: Text(
            'This is taking longer than expected. Your application is still being processed.',
            style: textTheme.bodyMedium?.copyWith(
                fontSize: 30, fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ),
        const Gap(40),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(40),
              topLeft: Radius.circular(40),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColor.kAccentColor2,
                    radius: 18,
                    child: SvgPicture.asset('assets/images/bx_time-five.svg'),
                  ),
                  const Gap(12),
                  Expanded(
                    child: Text(
                      'Sometimes it can take 5-60 minutes',
                      style: textTheme.bodyMedium?.copyWith(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
              const Gap(35),
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColor.kAccentColor2,
                    radius: 18,
                    child: SvgPicture.asset(
                        'assets/images/clarity_notification-outline-badged.svg'),
                  ),
                  const Gap(12),
                  Expanded(
                    child: Text(
                      'You can close the app and check back later. We will notify you as soon as we have an update',
                      style: textTheme.bodyMedium?.copyWith(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 100.0),
            ],
          ),
        ),
      ],
    );
  }
}
