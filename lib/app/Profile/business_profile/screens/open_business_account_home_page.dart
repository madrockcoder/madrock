import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/Profile/business_profile/screens/open_business_account_form.dart';
import 'package:geniuspay/app/Profile/business_profile/screens/tell_us_about_business.dart';
import 'package:geniuspay/app/Profile/business_profile/view_models/business_profile_vm.dart';
import 'package:geniuspay/app/Profile/business_profile/widgets/edit_details_v1.dart';
import 'package:geniuspay/app/auth/pages/sign_up/country/widgets/country_list.dart';
import 'package:geniuspay/app/auth/view_models/select_country_view_model.dart';
import 'package:geniuspay/app/shared_widgets/custom_circular_image.dart';
import 'package:geniuspay/app/shared_widgets/custom_section_heading.dart';
import 'package:geniuspay/app/shared_widgets/custom_shadow_container.dart';
import 'package:geniuspay/app/shared_widgets/custom_yellow_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/app/shared_widgets/show_draggable_scrollable_sheet.dart';
import 'package:geniuspay/core/injections/injections.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/models/business_profile_model.dart';
import 'package:geniuspay/models/country.dart';
import 'package:geniuspay/services/remote_config_service.dart';
import 'package:geniuspay/util/color_scheme.dart';

class OpenBusinessAccountHomePage extends StatefulWidget {
  static Future<void> show(
    BuildContext context,
  ) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const OpenBusinessAccountHomePage(),
      ),
    );
  }

  const OpenBusinessAccountHomePage({Key? key}) : super(key: key);

  @override
  State<OpenBusinessAccountHomePage> createState() =>
      _OpenBusinessAccountHomePageState();
}

class _OpenBusinessAccountHomePageState
    extends State<OpenBusinessAccountHomePage> {
  Country? country;
  bool isCompanyRecognized = false;
  FocusNode focusNode2 = FocusNode();

  TextEditingController companyCodeController = TextEditingController();
  TextEditingController companyCodeTextController =
      TextEditingController(text: 'Company Code');
  TextEditingController companyCodeTextOtherController =
      TextEditingController(text: 'Legal Entity Identifier');

  bool nowICanShowRedError = false;

  bool get isLEISelected => selectedDropDownValue == 1;

  bool get isCompanyCodeSelected => selectedDropDownValue == 0;

  Map<String, String> countries = const {
    'PL': 'KRS',
    'GB': 'Company number',
    'CA': 'Incorporation number',
  };

  BusinessProfileVM businessProfileVM = sl<BusinessProfileVM>();
  int selectedDropDownValue = 0;
  bool openDropDown = false;
  final SelectCountryViewModel _selectCountryViewModel =
      sl<SelectCountryViewModel>();

  @override
  void initState() {
    isAutomaticLEIAccount = false;
    isAutomaticCompanyCodeAccount = false;
    getData();
    super.initState();
  }

  getData() async {
    country = await _selectCountryViewModel.getCountryFromIso(context, 'CA');
    if (countries.containsKey(country!.iso2)) {
      if (isCompanyCodeSelected) {
        companyCodeTextController.text = countries[country!.iso2]!;
      } else {
        companyCodeTextOtherController.text = countries[country!.iso2]!;
      }
    } else {
      if (isCompanyCodeSelected) {
        companyCodeTextController.text = 'Company code';
      } else {
        companyCodeTextOtherController.text = 'Company code';
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        if (openDropDown) {
          openDropDown = false;
          setState(() {});
        }
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
            child: SizedBox(
              height: isCompanyRecognized
                  ? null
                  : MediaQuery.of(context).size.height * 0.88,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSectionHeading(
                    heading: "Business account",
                    headingAndChildGap: 8,
                    topSpacing: 8,
                    headingTextStyle: textTheme.displayMedium?.copyWith(
                        fontSize: 20, color: AppColor.kSecondaryColor),
                    child: Text(
                      "Choose your company registration country and input its registration code.",
                      style: textTheme.bodyMedium
                          ?.copyWith(color: AppColor.kPinDesColor),
                    ),
                  ),
                  const Gap(32),
                  CustomShadowContainer(
                    onTap: () async {
                      await showCustomScrollableSheet(
                          context: context,
                          child: CountryListWidget(
                            selectedCountry: country,
                            allowedCountries: RemoteConfigService
                                .getRemoteData.supportedCountries,
                            onTap: (_country) {
                              setState(() {
                                country = _country;
                                if (countries.containsKey(country!.iso2)) {
                                  if (isCompanyCodeSelected) {
                                    companyCodeTextController.text =
                                        countries[country!.iso2]!;
                                  } else {
                                    companyCodeTextOtherController.text =
                                        countries[country!.iso2]!;
                                  }
                                } else {
                                  if (isCompanyCodeSelected) {
                                    companyCodeTextController.text =
                                        'Company code';
                                  } else {
                                    companyCodeTextOtherController.text =
                                        'Company code';
                                  }
                                }
                              });
                            },
                          ));
                    },
                    child: country != null
                        ? Row(
                            children: [
                              CustomCircularImage(
                                'icons/flags/png/${country!.iso2.toLowerCase()}.png',
                                package: 'country_icons',
                                radius: 26,
                                fit: BoxFit.fill,
                              ),
                              const Gap(12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Choose the company’s registration country',
                                    style: textTheme.bodyMedium?.copyWith(
                                        color: AppColor.kPinDesColor,
                                        fontSize: 10),
                                  ),
                                  Text(
                                    country!.name,
                                    style: textTheme.titleMedium?.copyWith(
                                        color: AppColor.kOnPrimaryTextColor2,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              SvgPicture.asset('assets/icons/arrow.svg')
                            ],
                          )
                        : const SizedBox(),
                  ),
                  const Gap(16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: companyCodeTextController,
                              readOnly: true,
                              showCursor: false,
                              onTap: () {
                                openDropDown = !openDropDown;
                                setState(() {});
                              },
                              style:
                                  textTheme.bodyMedium?.copyWith(fontSize: 12),
                              decoration: InputDecoration(
                                labelText: "Category",
                                fillColor: AppColor.kAccentColor2,
                                filled: true,
                                contentPadding:
                                    const EdgeInsets.fromLTRB(12, 12, 0, 12),
                                suffixIcon: Icon(
                                    openDropDown
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                    color: AppColor.kSecondaryColor,
                                    size: 20),
                                enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColor.kSecondaryColor)),
                                errorBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColor.kred)),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColor.kSecondaryColor)),
                                labelStyle: textTheme.bodyMedium?.copyWith(
                                    color: AppColor.kPinDesColor, fontSize: 12),
                              ),
                            ),
                            if (openDropDown)
                              TextFormField(
                                controller: companyCodeTextOtherController,
                                onTap: () {
                                  companyCodeController.clear();
                                  isCompanyRecognized = false;
                                  selectedDropDownValue = isLEISelected ? 0 : 1;
                                  var t = companyCodeTextOtherController.text;
                                  companyCodeTextOtherController.text =
                                      companyCodeTextController.text;
                                  companyCodeTextController.text = t;
                                  openDropDown = false;
                                  setState(() {});
                                },
                                readOnly: true,
                                showCursor: false,
                                style:
                                    textTheme.bodyMedium?.copyWith(fontSize: 12),
                                decoration: const InputDecoration(
                                  fillColor: AppColor.kAccentColor2,
                                  filled: true,
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide.none),
                                  errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide.none),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide.none),
                                ),
                              )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: TextFormField(
                          focusNode: focusNode2,
                          keyboardType: isCompanyCodeSelected
                              ? const TextInputType.numberWithOptions(
                                  decimal: true)
                              : TextInputType.text,
                          onChanged: (value) async {
                            if (isCompanyRecognized) {
                              isCompanyRecognized = false;
                            }
                            nowICanShowRedError = false;
                            setState(() {});
                            if (isLEISelected) {
                              if (value.length == 20) {
                                await businessProfileVM.validateLEI(
                                    value, context, country!);
                                if (businessProfileVM.baseModelState ==
                                    BaseModelState.success) {
                                  FocusScopeNode currentFocus = FocusScope.of(context);
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                  isCompanyRecognized = true;
                                  setState(() {});
                                } else {
                                  isCompanyRecognized = false;
                                  nowICanShowRedError = true;
                                  setState(() {});
                                }
                              }
                            } else {
                              if (value.length >= 8) {
                                await businessProfileVM.validateCompanyCode(
                                    value, country!.iso2, context);
                                if (businessProfileVM.baseModelState ==
                                    BaseModelState.success) {
                                  FocusScopeNode currentFocus = FocusScope.of(context);
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                  isCompanyRecognized = true;
                                  setState(() {});
                                } else {
                                  isCompanyRecognized = false;
                                  nowICanShowRedError = true;
                                  setState(() {});
                                }
                              }
                            }
                            setState(() {});
                          },
                          controller: companyCodeController,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(
                                isLEISelected ? 20 : 10)
                          ],
                          style: textTheme.bodyMedium?.copyWith(fontSize: 12),
                          decoration: InputDecoration(
                            labelText: isCompanyCodeSelected
                                ? companyCodeTextController.text
                                : "Legal Entity Identifier",
                            fillColor: isDisabled && nowICanShowRedError
                                ? const Color(0xFFDB1F35).withOpacity(0.5)
                                : AppColor.kAccentColor2,
                            filled: true,
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: isDisabled && nowICanShowRedError
                                        ? const Color(0xFFDB1F35)
                                        : AppColor.kSecondaryColor)),
                            errorBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: AppColor.kred)),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColor.kSecondaryColor)),
                            labelStyle: textTheme.bodyMedium?.copyWith(
                                color: AppColor.kPinDesColor, fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (!openDropDown) ...[
                    const Gap(8),
                    Text(
                      isLEISelected
                          ? 'The Legal Entity Identifier (LEI) is a 20-character, alpha-numeric code based on the ISO 17442 standard developed by the International Organization for Standardization (ISO). It connects to key reference information that enables clear and unique identification of legal entities participating in financial transactions.'
                          : 'The Registration or Incorporation number of business.',
                      style: textTheme.bodyMedium?.copyWith(
                          color: AppColor.kOnPrimaryTextColor2, fontSize: 10),
                    ),
                  ],
                  if (isCompanyRecognized)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 42),
                      child: Column(
                        children: [
                          const Gap(24),
                          Text(
                            'Double check your business details and edit if necessary',
                            style: textTheme.bodyMedium
                                ?.copyWith(color: AppColor.kSecondaryColor),
                          ),
                          const Gap(16),
                          EditDetailsV1Widget(
                            heading: "Business Details",
                            hideEdit: true,
                            onEditClicked: () {},
                            fields: {
                              "Legal Name": businessProfileVM
                                      .businessProfile?.businessName ??
                                  '-',
                              "Trading name": businessProfileVM
                                      .businessProfile?.tradingName ??
                                  '-',
                              "Company number": businessProfileVM
                                      .businessProfile?.registrationNumber ??
                                  '-',
                              "Registered address": businessProfileVM
                                      .businessProfile
                                      ?.getRegisteredAddress() ??
                                  '-',
                              "Where do you pay VAT?": _selectCountryViewModel
                                  .countries
                                  .where((element) =>
                                      businessProfileVM
                                          .businessProfile?.registeredCountry ==
                                      element.iso2)
                                  .first
                                  .name,
                            },
                          )
                        ],
                      ),
                    ),
                  if (!isCompanyRecognized) const Spacer(),
                  CustomYellowElevatedButton(
                    onTap: () {
                      BusinessProfileModel businessProfileModel =
                          BusinessProfileModel();
                      businessProfileModel = businessProfileVM.businessProfile!;
                      businessProfileModel.registeredCountry = country!.iso2;
                      if (isCompanyCodeSelected) {
                        isAutomaticCompanyCodeAccount = true;
                        businessProfileModel.legalEntityIdentifier =
                            companyCodeController.text;
                      } else {
                        isAutomaticLEIAccount = true;
                        businessProfileModel.registrationNumber =
                            companyCodeController.text;
                      }
                      if (isAutomaticLEIAccount ||
                          isAutomaticCompanyCodeAccount) {
                        TellUsAboutBusinessMain.show(
                            context, businessProfileModel);
                      }
                    },
                    disable: isDisabled,
                    text: "OPEN BUSINESS ACCOUNT",
                  ),
                  const Gap(8),
                  CustomYellowElevatedButton(
                    onTap: () {
                      if (isDisabled) {
                        PopupDialogs(context)
                            .errorMessage('Invalid company code');
                        nowICanShowRedError = true;
                        setState(() {});
                      } else {
                        BusinessProfileModel businessProfileModel =
                            BusinessProfileModel();
                        businessProfileModel.registeredCountry = country!.iso2;
                        businessProfileModel.registrationNumber =
                            companyCodeController.text;
                        OpenBusinessAccountForm.show(
                            context, businessProfileModel, country!);
                      }
                    },
                    transparentBackground: true,
                    text: "ENTER MANUALLY",
                  ),
                  const Gap(24)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool get isDisabled => isCompanyCodeSelected
      ? (companyCodeController.text.length < 8 || !isCompanyRecognized)
      : (companyCodeController.text.length != 20 || !isCompanyRecognized);
}

bool isAutomaticLEIAccount = false;
bool isAutomaticCompanyCodeAccount = false;
