import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/auth/pages/sign_up/country/widgets/country_list.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button_async.dart';
import 'package:geniuspay/app/shared_widgets/picker_container.dart';
import 'package:geniuspay/app/shared_widgets/show_draggable_scrollable_sheet.dart';
import 'package:geniuspay/app/wallet/connect_bank_account/select_bank_vm.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/models/country.dart';
import 'package:geniuspay/models/nordigen_bank.dart';
import 'package:geniuspay/util/color_scheme.dart';

class SelectBankPage extends StatefulWidget {
  const SelectBankPage({Key? key}) : super(key: key);
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const SelectBankPage(),
      ),
    );
  }

  @override
  State<SelectBankPage> createState() => _SelectBankPageState();
}

class _SelectBankPageState extends State<SelectBankPage> {
  Future<void> _showCountryPicker(
      {required Country? selectedCountry,
      required Function(Country country) onTap}) async {
    await showCustomScrollableSheet(
        context: context,
        child: CountryListWidget(
            selectedCountry: selectedCountry,
            onTap: onTap,
            allowedCountries: const [
              'AT',
              'BE',
              'BG',
              'HR',
              'CY',
              'CZ',
              'DK',
              'EE',
              'FI',
              'FR',
              'DE',
              'GR',
              'HU',
              'IS',
              'IE',
              'IT',
              'LV',
              'LI',
              'LT',
              'LU',
              'MT',
              'NL',
              'NO',
              'PL',
              'PT',
              'RO',
              'SK',
              'SI',
              'ES',
              'SE',
              'GB'
            ]));
  }

  NordigenBank? _selectedBank;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BaseView<SelectBankVM>(
        onModelReady: (p0) => p0.getCountry(context),
        builder: (context, model, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Link a bank'),
              centerTitle: true,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Padding(
                padding: const EdgeInsets.all(24),
                child: CustomElevatedButtonAsync(
                  onPressed: _selectedBank == null
                      ? null
                      : () async {
                          // ResultsPage.show(
                          //     context,
                          //     'Your account was successfully linked to geniuspay',
                          //     _selectedBank!);
                          await model.initiateRequisition(
                              context, _selectedBank!);
                        },
                  child: Text(
                    'CONTINUE',
                    style: textTheme.bodyLarge,
                  ),
                  color: AppColor.kGoldColor2,
                )),
            body: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                Text(
                  'Select the country',
                  style: textTheme.bodyLarge,
                ),
                const Gap(8),
                PickerContainer2(
                  hint: 'Select Country',
                  height: 40,
                  country: model.country,
                  onPressed: () async {
                    _showCountryPicker(
                        selectedCountry: model.country,
                        onTap: (country) {
                          model.changeCountry(country);
                        });
                  },
                ),
                const Gap(24),
                Text(
                  'Select your bank',
                  style: textTheme.bodyLarge,
                ),
                const Gap(16),
                Theme(
                    data: ThemeData(
                        splashColor: AppColor.kAccentColor2,
                        highlightColor: AppColor.kAccentColor2),
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: model.bankList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            selected: _selectedBank == null
                                ? false
                                : _selectedBank!.id == model.bankList[index].id,
                            selectedTileColor: AppColor.kAccentColor2,
                            onTap: () {
                              setState(() {
                                _selectedBank = model.bankList[index];
                              });
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundColor: AppColor.kAccentColor2,
                              child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Image.network(
                                    model.bankList[index].logo,
                                    errorBuilder:
                                        (context, exception, stackTrace) {
                                      return const Icon(Icons.add);
                                    },
                                  )),
                            ),
                            title: Text(
                              model.bankList[index].name,
                              style:
                                  textTheme.bodyMedium?.copyWith(fontSize: 12),
                            ),
                          );
                        }))
              ],
            ),
          );
        });
  }
}
