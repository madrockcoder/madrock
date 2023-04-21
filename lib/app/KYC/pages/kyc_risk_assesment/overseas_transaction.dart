import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/KYC/pages/kyc_risk_assesment/terms_and_condition_page.dart';
import 'package:geniuspay/app/KYC/view_models.dart/kyc_view_model.dart';
import 'package:geniuspay/app/auth/pages/sign_up/country/widgets/country_list.dart';
import 'package:geniuspay/app/shared_widgets/continue_button.dart';
import 'package:geniuspay/app/shared_widgets/country_flag_container.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/app/shared_widgets/show_draggable_scrollable_sheet.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/models/country.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/widgets_util.dart';

class OverseaTransactionPage extends StatefulWidget {
  const OverseaTransactionPage({Key? key}) : super(key: key);

  static Future<void> show(
    BuildContext context,
  ) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const OverseaTransactionPage(),
      ),
    );
  }

  @override
  State<OverseaTransactionPage> createState() => _OverseaTransactionPageState();
}

class _OverseaTransactionPageState extends State<OverseaTransactionPage> {
  final countries = <Country>[];
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BaseView<KycViewModel>(builder: (context, model, snapshot) {
      return Scaffold(
        appBar: WidgetsUtil.onBoardingAppBar(
          context,
          title: 'Overseas Transactions',
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(24),
          child: ContinueButton(
            context: context,
            color: AppColor.kGoldColor2,
            textColor: Colors.black,
            disabledColor: AppColor.kAccentColor3,
            disable: countries.isEmpty,
            onPressed: () async {
              model.overseaCountries = countries;
              TermsAndConditionPage.show(context);
            },
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Text(
              'Which countries will you be sending funds to or receiving funds from?',
              style: textTheme.bodyMedium,
            ),
            const Gap(20),
            InkWell(
              onTap: () {
                _showCountryPicker(
                    selectedCountry: model.country,
                    onTap: (country) {
                      if (countries.contains(country)) {
                        PopupDialogs(context).errorMessage(
                          'You already selected this Country',
                        );
                      } else {
                        setState(() {
                          countries.add(country);
                        });
                      }
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
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Gap(16),
                  Text(
                    'Add country',
                    style: textTheme.bodyLarge?.copyWith(
                      fontSize: 16,
                      color: AppColor.kSecondaryColor,
                    ),
                  )
                ],
              ),
            ),
            const Gap(20),
            for (var item in countries)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
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
                    CountryFlagContainer(flag: item.iso2),
                    const Gap(14),
                    Text(
                      item.name,
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          countries.remove(item);
                        });
                      },
                      icon: const Icon(
                        Icons.cancel_outlined,
                        color: AppColor.kSecondaryColor,
                      ),
                    )
                  ]),
                ),
              ),
            const Gap(200),
          ],
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
