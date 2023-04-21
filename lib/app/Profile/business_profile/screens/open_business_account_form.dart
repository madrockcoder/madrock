import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/Profile/business_profile/screens/tell_us_about_business.dart';
import 'package:geniuspay/app/shared_widgets/custom_circular_image.dart';
import 'package:geniuspay/app/shared_widgets/custom_icon_button.dart';
import 'package:geniuspay/app/shared_widgets/custom_section_heading.dart';
import 'package:geniuspay/app/shared_widgets/custom_yellow_elevated_button.dart';
import 'package:geniuspay/models/business_profile_model.dart';
import 'package:geniuspay/models/country.dart';
import 'package:geniuspay/util/color_scheme.dart';
import '../widgets/custom_text_field.dart';

class OpenBusinessAccountForm extends StatefulWidget {
  static Future<void> show(BuildContext context,
      BusinessProfileModel businessProfileModel, Country country,
      {bool isUpdate = false}) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => OpenBusinessAccountForm(
          businessProfileModel: businessProfileModel,
          isUpdate: isUpdate,
          country: country,
        ),
      ),
    );
  }

  final BusinessProfileModel businessProfileModel;
  final bool isUpdate;
  final Country country;

  const OpenBusinessAccountForm(
      {Key? key,
      required this.businessProfileModel,
      required this.isUpdate,
      required this.country})
      : super(key: key);

  @override
  State<OpenBusinessAccountForm> createState() =>
      _OpenBusinessAccountFormState();
}

class _OpenBusinessAccountFormState extends State<OpenBusinessAccountForm> {
  late TextEditingController companyLegalNameController;
  FocusNode companyLegalNameFocusNode = FocusNode();
  late TextEditingController postalCodeController;
  FocusNode postalCodeFocusNode = FocusNode();
  late TextEditingController cityController;
  FocusNode cityFocusNode = FocusNode();
  late TextEditingController stateController;
  FocusNode stateFocusNode = FocusNode();
  Country? selectedCountry;
  late TextEditingController countryController;
  FocusNode countryFocusNode = FocusNode();
  late TextEditingController streetController;
  FocusNode streetFocusNode = FocusNode();
  late TextEditingController houseNumberController;
  FocusNode houseNumberFocusNode = FocusNode();
  late TextEditingController postalCodeServiceController;
  FocusNode postalCodeServiceFocusNode = FocusNode();
  late TextEditingController cityServiceController;
  FocusNode cityServiceFocusNode = FocusNode();
  late TextEditingController stateServiceController;
  FocusNode stateServiceFocusNode = FocusNode();
  Country? selectedCountryService;
  late TextEditingController countryServiceController;
  FocusNode countryServiceFocusNode = FocusNode();
  late TextEditingController streetServiceController;
  FocusNode streetServiceFocusNode = FocusNode();
  late TextEditingController houseNumberServiceController;
  FocusNode houseNumberServiceFocusNode = FocusNode();

  bool isServiceAccount = true;

  bool get areAllImportantFieldsFilled =>
      postalCodeController.text.trim().isNotEmpty &&
      cityController.text.trim().isNotEmpty &&
      // countryStateController.text.trim().isNotEmpty &&
      streetController.text.trim().isNotEmpty &&
      stateController.text.trim().isNotEmpty &&
      countryController.text.trim().isNotEmpty &&
      (postalCodeServiceController.text.trim().isNotEmpty ||
          isServiceAccount) &&
      (stateServiceController.text.trim().isNotEmpty || isServiceAccount) &&
      (countryServiceController.text.trim().isNotEmpty || isServiceAccount) &&
      (cityServiceController.text.trim().isNotEmpty || isServiceAccount) &&
      (streetServiceController.text.trim().isNotEmpty || isServiceAccount);

  @override
  void initState() {
    var businessProfileModel = widget.businessProfileModel;
    companyLegalNameController = TextEditingController(
        text: businessProfileModel.businessName);
    postalCodeController = TextEditingController(
        text: businessProfileModel.registeredAddress?.zipCode);
    cityController = TextEditingController(
        text: businessProfileModel.registeredAddress?.city);
    stateController = TextEditingController(
        text: businessProfileModel.registeredAddress?.stateOrProvince);
    countryController = TextEditingController(
        text: businessProfileModel.registeredAddress?.country);
    streetController = TextEditingController(
        text: businessProfileModel.registeredAddress?.addressLine1);
    houseNumberController = TextEditingController(
        text: businessProfileModel.registeredAddress?.addressLine2);
    if (businessProfileModel.serviceAddress?.zipCode?.isNotEmpty ?? false) {
      isServiceAccount = true;
    }
    postalCodeServiceController = TextEditingController(
        text: businessProfileModel.serviceAddress?.zipCode);
    cityServiceController =
        TextEditingController(text: businessProfileModel.serviceAddress?.city);
    stateServiceController = TextEditingController(
        text: businessProfileModel.serviceAddress?.stateOrProvince);
    countryServiceController = TextEditingController(
        text: businessProfileModel.serviceAddress?.country);
    streetServiceController = TextEditingController(
        text: businessProfileModel.serviceAddress?.addressLine1);
    houseNumberServiceController = TextEditingController(
        text: businessProfileModel.serviceAddress?.addressLine2);
    selectedCountry = widget.country;
    countryController.text = selectedCountry!.name;
    selectedCountryService = widget.country;
    countryServiceController.text = selectedCountryService!.name;
    super.initState();
  }

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
          shape: const Border(
              bottom: BorderSide(color: AppColor.kSecondaryColor, width: 1)),
          actions: [
            CustomIconButton(
              iconData: Icons.close,
              onTap: () => Navigator.pop(context),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSectionHeading(
                  heading: "Registered address",
                  headingAndChildGap: 16,
                  topSpacing: 16,
                  headingTextStyle: textTheme.bodyLarge
                      ?.copyWith(color: AppColor.kSecondaryColor),
                  child: Column(
                    children: [
                      CustomTextField(
                          controller: companyLegalNameController,
                          setState: setState,
                          focusNode: companyLegalNameFocusNode,
                          maxLines: 1,
                          hintText: 'Company legal name',
                          helperText:
                              'Full legal name of the company as it appears on the incorporation document.'),
                      CustomTextField(
                          controller: countryController,
                          setState: setState,
                          maxLines: 1,
                          readOnly: true,
                          suffix: const Icon(Icons.keyboard_arrow_down,
                              color: AppColor.kSecondaryColor, size: 20),
                          isDisabled: true,
                          prefix: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: CustomCircularImage(
                              'icons/flags/png/${selectedCountry!.iso2.toLowerCase()}.png',
                              package: 'country_icons',
                              radius: 12,
                              fit: BoxFit.fill,
                            ),
                          ),
                          onTap: () {
                            // _showCountryPicker(
                            //     selectedCountry: selectedCountry,
                            //     onTap: (c) {
                            //       setState(() {
                            //         selectedCountry = c;
                            //         countryController.text = c.name;
                            //       });
                            //     });
                          },
                          focusNode: countryFocusNode,
                          hintText: 'Country'),
                      CustomTextField(
                          controller: streetController,
                          setState: setState,
                          maxLines: 1,
                          focusNode: streetFocusNode,
                          hintText: 'Street'),
                      CustomTextField(
                          controller: houseNumberController,
                          setState: setState,
                          maxLines: 1,
                          focusNode: houseNumberFocusNode,
                          hintText: 'House Number (Optional)'),
                      CustomTextField(
                          controller: stateController,
                          setState: setState,
                          focusNode: stateFocusNode,
                          hintText: 'state'),
                      CustomTextField(
                          controller: cityController,
                          setState: setState,
                          maxLines: 1,
                          focusNode: cityFocusNode,
                          hintText: 'City'),
                      CustomTextField(
                          controller: postalCodeController,
                          setState: setState,
                          focusNode: postalCodeFocusNode,
                          maxLines: 1,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          hintText: 'Postal Code'),
                    ],
                  ),
                ),
                CustomSectionHeading(
                  heading: "Service address",
                  headingAndChildGap: 8,
                  topSpacing: 18,
                  headingTextStyle: textTheme.bodyLarge
                      ?.copyWith(color: AppColor.kSecondaryColor),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .68,
                            child: Text(
                              'Service address and Registered address are the same',
                              style:
                                  textTheme.bodyMedium?.copyWith(fontSize: 10),
                            ),
                          ),
                          const Spacer(),
                          CupertinoSwitch(
                            activeColor: AppColor.kSecondaryColor,
                            value: isServiceAccount,
                            onChanged: (val) {
                              setState(() {
                                isServiceAccount = val;
                              });
                            },
                          )
                        ],
                      ),
                      if (!isServiceAccount) ...[
                        const Gap(8),
                        Column(
                          children: [
                            CustomTextField(
                                controller: countryServiceController,
                                setState: setState,
                                readOnly: true,
                                isDisabled: true,
                                prefix: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: CustomCircularImage(
                                    'icons/flags/png/${selectedCountry!.iso2.toLowerCase()}.png',
                                    package: 'country_icons',
                                    radius: 12,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                onTap: () {
                                  // _showCountryPicker(
                                  //     selectedCountry: selectedCountryService,
                                  //     onTap: (c) {
                                  //       setState(() {
                                  //         selectedCountryService = c;
                                  //         countryServiceController.text =
                                  //             c.name;
                                  //       });
                                  //     });
                                },
                                focusNode: countryServiceFocusNode,
                                hintText: 'Country'),
                            CustomTextField(
                                controller: streetServiceController,
                                setState: setState,
                                focusNode: streetServiceFocusNode,
                                hintText: 'Street'),
                            CustomTextField(
                                controller: houseNumberServiceController,
                                setState: setState,
                                focusNode: houseNumberServiceFocusNode,
                                hintText: 'House Number (Optional)'),
                            CustomTextField(
                                controller: stateServiceController,
                                setState: setState,
                                focusNode: stateServiceFocusNode,
                                hintText: 'state'),
                            CustomTextField(
                                controller: cityServiceController,
                                setState: setState,
                                focusNode: cityServiceFocusNode,
                                hintText: 'City'),
                            CustomTextField(
                                controller: postalCodeServiceController,
                                setState: setState,
                                focusNode: postalCodeServiceFocusNode,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                hintText: 'Postal Code'),
                          ],
                        )
                      ]
                    ],
                  ),
                ),
                const Gap(24),
                CustomYellowElevatedButton(
                  onTap: () {
                    widget.businessProfileModel.businessName =
                        companyLegalNameController.text;
                    widget.businessProfileModel.tradingName =
                        companyLegalNameController.text;
                    widget.businessProfileModel.registeredAddress =
                        RegisteredAddress(
                            zipCode: postalCodeController.text,
                            city: cityController.text,
                            country: selectedCountry!.iso2,
                            stateOrProvince: stateController.text,
                            addressLine2: houseNumberController.text,
                            addressLine1: streetController.text);
                    if (!isServiceAccount) {
                      widget.businessProfileModel.serviceAddress =
                          RegisteredAddress(
                              zipCode: postalCodeServiceController.text,
                              city: cityServiceController.text,
                              stateOrProvince: stateServiceController.text,
                              country: selectedCountryService!.iso2,
                              addressLine2: houseNumberServiceController.text,
                              addressLine1: streetServiceController.text);
                    }
                    if (!widget.isUpdate) {
                      TellUsAboutBusinessMain.show(
                          context, widget.businessProfileModel);
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  disable: !areAllImportantFieldsFilled,
                  text: "CONTINUE",
                ),
                const Gap(24)
              ],
            ),
          ),
        ),
      ),
    );
  }

// Future<void> _showCountryPicker(
//     {required Country? selectedCountry,
//     required Function(Country country) onTap}) async {
//   await showCustomScrollableSheet(
//       context: context,
//       child: CountryListWidget(
//         selectedCountry: selectedCountry,
//         onTap: onTap,
//       ));
// }
}
