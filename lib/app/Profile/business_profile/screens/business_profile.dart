import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/Profile/business_profile/screens/business_details.dart';
import 'package:geniuspay/app/Profile/business_profile/screens/business_structure.dart';
import 'package:geniuspay/app/Profile/business_profile/screens/type_of_business.dart';
import 'package:geniuspay/app/Profile/business_profile/screens/verify_documents.dart';
import 'package:geniuspay/app/shared_widgets/custom_circular_icon.dart';
import 'package:geniuspay/app/shared_widgets/custom_section_heading.dart';
import 'package:geniuspay/app/shared_widgets/custom_shadow_container.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/models/business_profile_model.dart';
import 'package:geniuspay/util/color_scheme.dart';

class BusinessProfile extends StatefulWidget {
  static Future<void> show(BuildContext context,
      BusinessProfileModel businessProfileModel, String customerNumber) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BusinessProfile(
            businessProfileModel: businessProfileModel,
            customerNumber: customerNumber),
      ),
    );
  }

  final BusinessProfileModel businessProfileModel;
  final String customerNumber;

  const BusinessProfile(
      {Key? key,
      required this.businessProfileModel,
      required this.customerNumber})
      : super(key: key);

  @override
  State<BusinessProfile> createState() => _BusinessProfileState();
}

class _BusinessProfileState extends State<BusinessProfile> {
  BusinessProfileModel get businessProfile => widget.businessProfileModel;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: true,
            leading: const BackButton(),
            actions: const [HelpIconButton()],
            title: const Text('Business Profile')),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSectionHeading(
                heading: businessProfile.businessName!,
                headingAndChildGap: 8,
                topSpacing: 12,
                headingTextStyle: textTheme.titleSmall
                    ?.copyWith(fontSize: 14, color: AppColor.kSecondaryColor),
                child: CustomShadowContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Key information',
                        style: textTheme.titleSmall?.copyWith(
                            fontSize: 14, color: Colors.black.withOpacity(0.5)),
                      ),
                      const Gap(16),
                      customListTile(
                          'assets/icons/details-line.svg',
                          'Business details',
                          getStatus(businessProfile.verificationStatus!),
                          () =>
                              getStatus(businessProfile.verificationStatus!) ==
                                      'VERIFIED'
                                  ? BusinessDetails.show(
                                      context, widget.businessProfileModel)
                                  : VerifyDocuments.show(
                                      context, widget.customerNumber)),
                      const Gap(16),
                      customListTile(
                          'assets/icons/business-outline.svg',
                          'Type of business',
                          getStatus(businessProfile.verificationStatus!),
                          () =>
                              getStatus(businessProfile.verificationStatus!) ==
                                      'VERIFIED'
                                  ? TypeOfBusiness.show(
                                      context, widget.businessProfileModel)
                                  : VerifyDocuments.show(
                                      context, widget.customerNumber)),
                      const Gap(16),
                      customListTile(
                        'assets/icons/tree-structure-light.svg',
                        'Business structure',
                        getStatus(businessProfile.structureVerification!),
                        () =>
                            getStatus(businessProfile.structureVerification!) ==
                                    'VERIFIED'
                                ? BusinessStructure.show(
                                    context, widget.businessProfileModel)
                                : VerifyDocuments.show(
                                    context, widget.customerNumber),
                      )
                    ],
                  ),
                ),
              ),
              const Gap(8),
              CustomShadowContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Additional information',
                      style: textTheme.titleSmall?.copyWith(
                          fontSize: 14, color: Colors.black.withOpacity(0.5)),
                    ),
                    const Gap(16),
                    customListTile(
                        'assets/icons/ep_document.svg',
                        businessProfile.taxNumber!.isNotEmpty
                            ? 'VAT number'
                            : 'Not VAT provided',
                        SubtitleEnum.pending,
                        () {},
                        showTrailing: false),
                    const Gap(16),
                    customListTile(
                        'assets/icons/profile-dcument.svg',
                        'Profile assessment',
                        getStatus(businessProfile
                            .businessAssessment!.verificationStatus!),
                        () {},
                        showTrailing: false),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget customListTile(String asset, String title, SubtitleEnum subtitleEnum,
      GestureTapCallback onTap,
      {bool showTrailing = true}) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          CustomCircularIcon(SvgPicture.asset(asset)),
          const Gap(12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textTheme.titleSmall
                    ?.copyWith(color: AppColor.kSecondaryColor, fontSize: 12),
              ),
              Text(
                subtitleEnum == SubtitleEnum.success
                    ? 'Verified'
                    : subtitleEnum == SubtitleEnum.pending
                        ? 'Pending'
                        : 'Additional information required',
                style: textTheme.bodyMedium?.copyWith(
                    color: subtitleEnum == SubtitleEnum.success
                        ? AppColor.kDepositColor
                        : subtitleEnum == SubtitleEnum.pending
                            ? AppColor.kGoldColor2
                            : const Color(0xFFDB1F35),
                    fontSize: 11),
              ),
            ],
          ),
          if (showTrailing) ...[
            const Spacer(),
            SvgPicture.asset('assets/icons/arrow.svg')
          ]
        ],
      ),
    );
  }

  SubtitleEnum getStatus(String val) {
    return val == 'VERIFIED' ? SubtitleEnum.success : SubtitleEnum.error;
  }
}

/// Subtitle Enum
enum SubtitleEnum { success, pending, error }
