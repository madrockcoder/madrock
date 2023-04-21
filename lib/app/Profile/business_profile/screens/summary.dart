import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/Profile/business_profile/screens/business_directors.dart';
import 'package:geniuspay/app/Profile/business_profile/screens/business_owners.dart';
import 'package:geniuspay/app/Profile/business_profile/screens/open_business_account_form.dart';
import 'package:geniuspay/app/Profile/business_profile/screens/open_business_account_home_page.dart';
import 'package:geniuspay/app/Profile/business_profile/screens/tell_us_about_business.dart';
import 'package:geniuspay/app/Profile/business_profile/view_models/business_profile_vm.dart';
import 'package:geniuspay/app/Profile/business_profile/widgets/edit_details_v1.dart';
import 'package:geniuspay/app/Profile/business_profile/widgets/edit_details_v2.dart';
import 'package:geniuspay/app/auth/view_models/select_country_view_model.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button_async.dart';
import 'package:geniuspay/app/shared_widgets/custom_section_heading.dart';
import 'package:geniuspay/core/injections/injections.dart';
import 'package:geniuspay/models/business_profile_model.dart';
import 'package:geniuspay/models/country.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/util/color_scheme.dart';

class Summary extends StatefulWidget {
  static Future<void> show(
      BuildContext context, BusinessProfileModel businessProfileModel) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => Summary(businessProfileModel: businessProfileModel),
      ),
    );
  }

  final BusinessProfileModel businessProfileModel;

  const Summary({Key? key, required this.businessProfileModel})
      : super(key: key);

  @override
  State<Summary> createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
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
            title: const Text('')),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSectionHeading(
                  heading: "Summary",
                  headingAndChildGap: 8,
                  topSpacing: 8,
                  headingTextStyle: textTheme.displayMedium
                      ?.copyWith(fontSize: 20, color: AppColor.kSecondaryColor),
                  child: Text(
                    "Before submitting, check if all the details are correct and edit if necessary.",
                    style: textTheme.bodyMedium
                        ?.copyWith(color: AppColor.kPinDesColor),
                  ),
                ),
                const Gap(32),
                if(!isAutomaticLEIAccount)...[
                  EditDetailsV1Widget(
                    heading: "Business Details",
                    onEditClicked: () async {
                      Country country;
                      final SelectCountryViewModel _selectCountryViewModel =
                      sl<SelectCountryViewModel>();
                      country = await _selectCountryViewModel.getCountryFromIso(
                          context,
                          widget.businessProfileModel.registeredCountry!);
                      await OpenBusinessAccountForm.show(
                          context, widget.businessProfileModel, country,
                          isUpdate: true);
                      setState(() {});
                    },
                    fields: {
                      "Legal Name": businessProfile.businessName ?? '-',
                      "Trading name": businessProfile.tradingName ?? '-',
                      "Company number": businessProfile.registrationNumber ?? '-',
                      "Registered address":
                      businessProfile.registeredAddress?.addressLine1 ?? '-',
                      "Where do you pay VAT?":
                      businessProfile.registeredAddress?.country ?? '-',
                    },
                  ),
                  const Gap(16),
                ],
                EditDetailsV1Widget(
                  heading: "Business Information",
                  onEditClicked: () async {
                    await TellUsAboutBusinessMain.show(
                        context, widget.businessProfileModel,
                        isUpdate: true);
                    setState(() {});
                  },
                  fields: {
                    "Company type":
                        businessProfile.legalEntityType?.name ?? '-',
                    "Business category": businessProfile.category?.name ?? '-',
                    "Business subcategory":
                        businessProfile.subCategory?.name ?? '-',
                    "VAT registration number": businessProfile.taxNumber ?? '-',
                    "Website": businessProfile.website ?? '-',
                    "Number of employees":
                        businessProfile.businessAssessment?.totalEmployees ??
                            '-',
                    "Business nature":
                        businessProfile.natureOfBusiness!.length > 10
                            ? (businessProfile.natureOfBusiness!
                                .substring(0, 10)) + '...'
                            : (businessProfile.natureOfBusiness!)
                  },
                  lowerText:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis.',
                ),
                if (widget.businessProfileModel.directors?.isNotEmpty ??
                    false) ...[
                  const Gap(16),
                  EditDetailsV2Widget(
                    heading: "Business Directors",
                    subHeading:
                        "People who own or control at least 25% of the business",
                    onEditClicked: () async {
                      await BusinessDirectors.show(
                          context, widget.businessProfileModel,
                          isUpdate: true);
                      setState(() {});
                    },
                    sections: getDirectors(),
                  ),
                ],
                if (widget.businessProfileModel.beneficialOwners?.isNotEmpty ??
                    false) ...[
                  const Gap(16),
                  EditDetailsV2Widget(
                    heading: "Business Owners",
                    subHeading:
                        "People who own or control at least 25% of the business",
                    onEditClicked: () async {
                      await BusinessOwners.show(
                          context, widget.businessProfileModel,
                          isUpdate: true);
                      setState(() {});
                    },
                    sections: getOwners(),
                  ),
                ],
                const Gap(24),
                Text(
                  'By clicking submit, you confirm you are an authorised representative of geniuspay LTD. and have authorisation to make payments on behalf of geniuspay LTD.',
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium
                      ?.copyWith(color: AppColor.kPinDesColor, fontSize: 10),
                ),
                const Gap(24),
                CustomElevatedButtonAsync(
                  onPressed: () async {
                    BusinessProfileVM businessProfileVM =
                        sl<BusinessProfileVM>();
                    AuthenticationService _auth = sl<AuthenticationService>();
                    widget.businessProfileModel.registeredDate =
                        _auth.user!.dateJoined.substring(0, 10);
                    await businessProfileVM.openBusinessAccount(
                        widget.businessProfileModel, _auth.user!.id, context, isAutomaticLEI: isAutomaticLEIAccount, isAutomaticCompanyCode: isAutomaticCompanyCodeAccount);
                  },
                  color: AppColor.kGoldColor2,
                  height: 40,
                  child: Text('SUBMIT', style: textTheme.bodyMedium,),
                ),
                const Gap(24)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Map<String, Map<String, String>> getOwners() {
    Map<String, Map<String, String>> result = {};
    int counter = 1;
    businessProfile.beneficialOwners?.forEach((element) {
      result["Business owner $counter"] = {
        "Name": '${element.firstName} ${element.lastName}',
        "% shares": '${element.percentage}%',
        "Date of birth": element.dob.isNotEmpty ? element.dob : '-'
      };
      counter++;
    });
    return result;
  }

  Map<String, Map<String, String>> getDirectors() {
    Map<String, Map<String, String>> result = {};
    int counter = 1;
    businessProfile.directors?.forEach((element) {
      result["Business director $counter"] = {
        "Name": '${element.firstName} ${element.lastName}',
        "Date of birth": (element.dob?.isNotEmpty??false) ? element.dob! : '-'
      };
      counter++;
    });
    return result;
  }
}
