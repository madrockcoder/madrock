import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/auth/pages/sign_up/country/widgets/country_list.dart';
import 'package:geniuspay/app/auth/view_models/select_country_view_model.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button_async.dart';
import 'package:geniuspay/app/shared_widgets/error_screens/error_screen_selector.dart';
import 'package:geniuspay/app/shared_widgets/picker_container.dart';
import 'package:geniuspay/app/shared_widgets/show_draggable_scrollable_sheet.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/models/country.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/widgets_util.dart';
import 'package:shimmer/shimmer.dart';

class SelectCountryResidence extends StatefulWidget {
  const SelectCountryResidence({
    Key? key,
  }) : super(key: key);

  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const SelectCountryResidence()),
    );
  }

  @override
  State<SelectCountryResidence> createState() => _SelectCountryResidenceState();
}

class _SelectCountryResidenceState extends State<SelectCountryResidence> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BaseView<SelectCountryViewModel>(
        onModelReady: (p0) => p0.init(context),
        builder: (context, model, snapshot) {
          return Scaffold(
            appBar: WidgetsUtil.onBoardingAppBar(context,
                title: 'Nationality & Residency'),
            body: SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: model.baseModelState == BaseModelState.loading
                  ? ListView.builder(
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(9)),
                          ),
                        );
                      },
                      itemCount: 4,
                    )
                  : model.baseModelState == BaseModelState.error
                      ? ErrorScreen(
                          showHelp: false,
                          onRefresh: () {
                            setState(() {
                              model.init(context);
                            });
                          },
                          exception: model.errorType)
                      : Column(
                          children: [
                            const SizedBox(height: 8.0),
                            PickerContainer(
                              hint: 'Country of primary nationality',
                              country: model.country,
                              onPressed: () async {
                                await _showCountryPicker(
                                  selectedCountry: model.country,
                                  onTap: (country) {
                                    model.country = country;
                                  },
                                );
                              },
                            ),
                            const Gap(20),
                            PickerContainer(
                              hint: 'Country of Residence',
                              country: model.residenceCountry,
                              onPressed: () async {
                                await _showCountryPicker(
                                  selectedCountry: model.residenceCountry,
                                  onTap: (country) {
                                    model.residenceCountry = country;
                                  },
                                );
                              },
                            ),
                            const Gap(20),
                            PickerContainer(
                              hint: 'Country of birth',
                              country: model.countryOfBirth,
                              onPressed: () async {
                                await _showCountryPicker(
                                    selectedCountry: model.countryOfBirth,
                                    onTap: (country) {
                                      model.countryOfBirth = country;
                                    });
                              },
                            ),
                            const Gap(20),
                            PickerContainer(
                              hint: 'Other citizenship (optional)',
                              country: model.otherCountry,
                              onPressed: () async {
                                await _showCountryPicker(
                                    selectedCountry: model.otherCountry,
                                    onTap: (country) {
                                      model.otherCountry = country;
                                    });
                              },
                            ),
                            const Gap(20),
                            if (model.residenceCountry != model.deviceCountry)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 10),
                                decoration: BoxDecoration(
                                  color: AppColor.kAlertBackgroundColor,
                                  borderRadius: BorderRadius.circular(9),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.error,
                                      color: AppColor.kAlertColor2,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Your IP address suggests you're in a "
                                        'different country. Once you sign up, '
                                        'you cannot change your country.',
                                        style: textTheme.bodyMedium?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: AppColor.kAlertColor2,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            const Spacer(),
                            CustomElevatedButtonAsync(
                              onPressed: buttonDisabled(model)
                                  ? null
                                  : () async {
                                      await model.continueButton(context);
                                    },
                              color: AppColor.kGoldColor2,
                              disabledColor: AppColor.kAccentColor3,
                              child: Text(
                                'CONTINUE',
                                style: textTheme.bodyMedium?.copyWith(
                                  fontSize: 14,
                                  color: buttonDisabled(model)
                                      ? AppColor.kOnPrimaryTextColor3
                                      : Colors.black,
                                  fontWeight: buttonDisabled(model)
                                      ? FontWeight.w400
                                      : FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
            )),
          );
        });
  }

  Future<void> _showCountryPicker(
      {required Country? selectedCountry,
      required Function(Country country) onTap}) async {
    await showCustomScrollableSheet(
        context: context,
        child: CountryListWidget(
          selectedCountry: selectedCountry,
          onTap: onTap,
        ));
  }

  bool buttonDisabled(SelectCountryViewModel model) {
    if (model.country != null &&
        model.residenceCountry != null &&
        model.countryOfBirth != null) {
      return false;
    }
    return true;
  }
}
