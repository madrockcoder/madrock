import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/KYC/pages/kyc_id_verification/processing_application_page.dart';
import 'package:geniuspay/app/KYC/pages/kyc_id_verification/proof_of_identity.dart';
import 'package:geniuspay/app/KYC/pages/kyc_risk_assesment/kyc_risk_starting_page.dart';
import 'package:geniuspay/app/KYC/pages/residential_address/add_address_page.dart';
import 'package:geniuspay/app/home/view_models/home_view_model.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/services/remote_config_service.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/enum_converter.dart';
import 'package:geniuspay/util/enums.dart';

class OnboardingStatusWidget extends StatelessWidget with EnumConverter {
  final OnboardingStatus status;
  OnboardingStatusWidget({Key? key, required this.status}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final text = getOnboardingStatusString(status);
    return Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: AppColor.kAccentColor2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: InkWell(
            onTap: () {
              OnboardingStatusPage.show(context, status);
            },
            child: Row(
              children: [
                const Gap(24),
                const Icon(
                  Icons.info_outline,
                  color: AppColor.kSecondaryColor,
                  size: 16,
                ),
                const Gap(16),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(8),
                    Text(
                      'Account verification required',
                      style: textTheme.bodyText1
                          ?.copyWith(color: AppColor.kSecondaryColor),
                    ),
                    const Gap(4),
                    Text(
                      '$text. Click here for more information.',
                      style: textTheme.bodyText2
                          ?.copyWith(color: AppColor.kSecondaryColor),
                    ),
                    const Gap(8),
                  ],
                )),
                const Gap(16),
                const Icon(
                  Icons.arrow_right_rounded,
                  size: 38,
                  color: AppColor.kSecondaryColor,
                ),
                const Gap(24),
              ],
            )));
  }
}

class OnboardingStatusPage extends StatefulWidget {
  final OnboardingStatus status;
  const OnboardingStatusPage({Key? key, required this.status})
      : super(key: key);
  static Future<void> show(
      BuildContext context, OnboardingStatus status) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => OnboardingStatusPage(
          status: status,
        ),
      ),
    );
  }

  @override
  State<OnboardingStatusPage> createState() => _OnboardingStatusPageState();
}

class _OnboardingStatusPageState extends State<OnboardingStatusPage> {
  Widget _statusTile({
    required bool selected,
    required String title,
    bool last = false,
  }) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (selected) ...[
              const Icon(
                Icons.check_circle,
                color: AppColor.kSecondaryColor,
                size: 24,
              )
            ] else
              const Icon(
                Icons.circle_outlined,
                color: AppColor.kGreyColor,
              ),
            const Gap(10),
            Text(
              title,
              style: selected
                  ? textTheme.bodyText1
                      ?.copyWith(color: AppColor.kSecondaryColor)
                  : textTheme.bodyText2,
            )
          ],
        ),
        if (!last)
          Container(
            margin: const EdgeInsets.only(left: 10, bottom: 2),
            color: selected ? AppColor.kSecondaryColor : AppColor.kGreyColor,
            width: selected ? 4 : 2,
            height: 38,
          )
      ],
    );
  }

  int status = 1;
  setStatus(OnboardingStatus onboardingStatus) {
    switch (onboardingStatus) {
      case OnboardingStatus.onboardingRequired:
        setState(() {
          status = 1;
        });
        break;
      case OnboardingStatus.passCodeRequired:
        setState(() {
          status = 2;
        });
        break;
      case OnboardingStatus.KycidVerifRequired:
        setState(() {
          status = 3;
        });
        break;
      case OnboardingStatus.KycIdVerifSubmitted:
        setState(() {
          status = 4;
        });
        break;
      case OnboardingStatus.KycTaxDeclarationRequired:
        setState(() {
          status = 5;
        });
        break;
      case OnboardingStatus.onboardingFailed:
        setState(() {
          status = 4;
        });
        break;
      case OnboardingStatus.KycAssesmentRequired:
        setState(() {
          status = 6;
        });
        break;
      case OnboardingStatus.KycAddressRequired:
        setState(() {
          status = 7;
        });
        break;
      case OnboardingStatus.PlanSelectionRequired:
        setState(() {
          status = 8;
        });
        break;
      case OnboardingStatus.onboardingCompleted:
        setState(() {
          status = 9;
        });
        break;
      case OnboardingStatus.unknown:
        setState(() {
          status = 1;
        });
        break;
    }
  }

  bool shouldShowOnboardingWidget(
    OnboardingStatus status,
  ) {
    final AuthenticationService _authenticationService =
        sl<AuthenticationService>();
    if (_authenticationService.user?.userProfile.optForBeta == true) {
      return true;
    } else if (!HomeViewModel().isCountrySupported()) {
      return false;
    } else if (status == OnboardingStatus.PlanSelectionRequired) {
      return true;
    } else if (!(RemoteConfigService.getRemoteData.allowKyc ?? true)) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BaseView<HomeViewModel>(onModelReady: (p0) async {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setStatus(widget.status);
      });
      // await p0.getUser();
      // setStatus(p0.user?.userProfile.onboardingStatus ?? widget.status);
    }, builder: (context, model, snapshot) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: const Text('Current Status'),
          actions: [
            IconButton(
              icon: const Icon(CupertinoIcons.refresh),
              onPressed: () async {
                await model.getUser();
              },
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
            padding: const EdgeInsets.all(45),
            child: CustomElevatedButton(
              color: AppColor.kGoldColor2,
              onPressed: shouldShowOnboardingWidget(widget.status)
                  ? () {
                      switch (status) {
                        case 3:
                          ProofIdentity.show(context);
                          break;
                        case 4:
                          ProcessingApplicationPage.show(context);
                          break;
                        case 5:
                          KYCRiskStartingPage.show(context);
                          break;
                        case 6:
                          KYCRiskStartingPage.show(context);
                          break;
                        case 7:
                          AddAddressPage.show(context);
                          break;
                        case 9:
                          Navigator.pop(context);
                          break;
                        default:
                      }
                    }
                  : null,
              child: Text(
                'CONTINUE',
                style: textTheme.bodyText1,
              ),
            )),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'You are few steps away from unlocking the GenioXperience. One account, Many Possibilities.',
              style: textTheme.bodyText2,
            ),
            const Gap(30),
            _statusTile(selected: status > 0, title: 'Sign up with geniuspay'),
            _statusTile(selected: status > 1, title: 'Add your Mobile number'),
            _statusTile(selected: status > 2, title: 'Protect your account'),
            _statusTile(
                selected: status > 3, title: 'Submit ID for verification'),
            _statusTile(selected: status > 4, title: 'Get ID verified'),
            _statusTile(selected: status > 6, title: 'Profile Assessment'),
            _statusTile(
                selected: status > 7, title: 'Provide residential address'),
            _statusTile(
                selected: status > 8,
                title: 'Automagically enjoy! 🎉 ',
                last: true),
            const Gap(160),
          ],
        ),
      );
    });
  }
}
