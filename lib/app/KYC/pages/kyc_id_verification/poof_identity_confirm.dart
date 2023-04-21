import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/KYC/pages/kyc_id_verification/processing_application_page.dart';
import 'package:geniuspay/app/KYC/pages/kyc_id_verification/select_document.dart';
import 'package:geniuspay/app/KYC/view_models.dart/kyc_view_model.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button_async.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/models/kyc.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/enums.dart';
import 'package:geniuspay/util/widgets_util.dart';

class ProofIdentityConfirm extends StatelessWidget {
  const ProofIdentityConfirm({Key? key}) : super(key: key);
  static Future<void> show(
    BuildContext context,
  ) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const ProofIdentityConfirm(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BaseView<KycViewModel>(builder: (context, model, snapshot) {
      String icon;
      String name;
      switch (model.option) {
        case DocumentType.idCard:
          icon = 'assets/icons/nationID.png';
          name = 'National Identity Card';
          break;
        case DocumentType.passport:
          icon = 'assets/icons/passport.png';
          name = 'Passport';
          break;
        case DocumentType.residentPermit:
          icon = 'assets/icons/recisdence_permit.png';
          name = 'Resident permit card';
          break;
        default:
          icon = 'assets/icons/nationID.png';
          name = 'National Identity Card';
      }
      return Scaffold(
        appBar: WidgetsUtil.onBoardingAppBar(context),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Get ready to take a photo of your ID document',
                  style: textTheme.displayLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: AppColor.kSecondaryColor,
                  ),
                ),
                const Gap(24),
                SelectDocumentWidget(
                  textTheme: textTheme,
                  text: name,
                  icon: icon,
                  isActive: false,
                  subText: model.country?.name,
                  iconWidget: const Icon(
                    Icons.edit,
                    color: AppColor.kSecondaryColor,
                  ),
                  onTap: () {
                    SelectDocumentPage.show(context);
                  },
                ),
                const Gap(40),
                Text(
                  'Please make sure:',
                  style: textTheme.displayLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: AppColor.kSecondaryColor,
                  ),
                ),
                const Gap(24),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/bxs_user-account.svg',
                      width: 20,
                    ),
                    const Gap(14),
                    Text(
                      'You don\'t have a geniuspay account yet',
                      style: textTheme.bodyMedium?.copyWith(
                        fontSize: 16,
                        color: AppColor.kOnPrimaryTextColor2,
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Divider(
                    color: AppColor.kAccentColor2,
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/sun.svg',
                      width: 20,
                    ),
                    const Gap(14),
                    Text(
                      'The ID photo is clear and bright',
                      style: textTheme.bodyMedium?.copyWith(
                        fontSize: 16,
                        color: AppColor.kOnPrimaryTextColor2,
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Divider(
                    color: AppColor.kAccentColor2,
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/visible.svg',
                      width: 20,
                    ),
                    const Gap(14),
                    Text(
                      'All the information is visible',
                      style: textTheme.bodyMedium?.copyWith(
                        fontSize: 16,
                        color: AppColor.kOnPrimaryTextColor2,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                CustomElevatedButtonAsync(
                  color: AppColor.kGoldColor2,
                  disabledColor: AppColor.kAccentColor3,
                  child: Text(
                    'CONTINUE',
                    style: textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () async {
                    await model.getVerificationStatus();
                    if (model.verificationStatusResponse == null ||
                        model.verificationStatusResponse?.verificationStatus ==
                            KYCVerificationStatus.pending) {
                      await model.initiateKyc(context, false);
                    } else {
                      ProcessingApplicationPage.show(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
