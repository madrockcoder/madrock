import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/KYC/pages/national_id_page.dart';
import 'package:geniuspay/app/KYC/pages/kyc_risk_assesment/pep_status_question_page.dart';
import 'package:geniuspay/app/KYC/view_models.dart/kyc_view_model.dart';
import 'package:geniuspay/app/auth/pages/sign_up/country/widgets/country_list.dart';
import 'package:geniuspay/app/shared_widgets/continue_button.dart';
import 'package:geniuspay/app/shared_widgets/country_flag_container.dart';
import 'package:geniuspay/app/shared_widgets/show_draggable_scrollable_sheet.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/models/country.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/widgets_util.dart';

class TaxesPage extends StatefulWidget {
  const TaxesPage({Key? key}) : super(key: key);

  static Future<void> show(
    BuildContext context,
  ) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const TaxesPage(),
      ),
    );
  }

  @override
  State<TaxesPage> createState() => _TaxesPageState();
}

class _TaxesPageState extends State<TaxesPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BaseView<KycViewModel>(builder: (context, model, snapshot) {
      return Scaffold(
        appBar: WidgetsUtil.onBoardingAppBar(
          context,
          title: 'Taxes',
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Do you pay taxes in other countries?',
                  style: textTheme.bodyLarge?.copyWith(
                    fontSize: 16,
                    color: AppColor.kSecondaryColor,
                  ),
                ),
                const Gap(20),
                Text(
                  'Please, indicate all the countries in which you are a\nresident for tax purposes',
                  style: textTheme.bodyMedium,
                ),
                const Gap(20),
                Column(
                  children: [
                    if (model.taxCountry != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 24,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColor.kSecondaryColor),
                          color: AppColor.kAccentColor2,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(children: [
                          CountryFlagContainer(flag: model.taxCountry!.iso2),
                          const Gap(14),
                          Text(
                            model.taxCountry!.name,
                          )
                        ]),
                      ),
                    const Gap(16),
                    InkWell(
                      onTap: () {
                        _showCountryPicker(
                            selectedCountry: model.taxCountry,
                            onTap: (country) {
                              model.setTaxCountry = country;
                            });
                      },
                      child: Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: AppColor.kAccentColor2,
                            radius: 16,
                            child: Center(
                              child: Icon(
                                Icons.add,
                                size: 16,
                              ),
                            ),
                          ),
                          const Gap(16),
                          Text(
                            'Add Country',
                            style: textTheme.bodyMedium?.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColor.kSecondaryColor,
                            ),
                          )
                        ],
                      ),
                    ),
                    const Gap(30),
                  ],
                ),
                const Spacer(),
                ContinueButton(
                  context: context,
                  color: AppColor.kGoldColor2,
                  disabledColor: AppColor.kAccentColor3,
                  disable: model.taxCountry == null,
                  onPressed: model.taxCountry == null
                      ? null
                      : () async {
                          NationalIdPage.show(context);
                        },
                ),
                const Gap(20),
                Center(
                  child: TextButton(
                    onPressed: () {
                      PepStatusQuestionPage.show(context);
                    },
                    child: Text(
                      'I DON\'T PAY TAXES IN OTHER COUNTRIES',
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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
}
