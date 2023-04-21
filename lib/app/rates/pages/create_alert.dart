// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geniuspay/app/auth/pages/sign_up/country/widgets/currency_list.dart';
import 'package:geniuspay/app/auth/view_models/select_country_view_model.dart';
import 'package:geniuspay/app/rates/pages/deliver_money.dart';
import 'package:geniuspay/app/shared_widgets/custom_checkbox.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/app/shared_widgets/picker_container.dart';
import 'package:geniuspay/app/shared_widgets/textfield_decoration.dart';
import 'package:geniuspay/models/country.dart';
import 'package:geniuspay/util/color_scheme.dart';

final TextEditingController _countryController = TextEditingController();
final FocusNode _countryFocusNode = FocusNode();

class CreateAlert extends StatefulWidget {
  const CreateAlert({Key? key}) : super(key: key);

  @override
  State<CreateAlert> createState() => _CreateAlertState();
}

int _selectedTab = 0;
Country selectedCurrency = Country(
    iso2: "GH", name: "Ghana", currencyISO: "GHS", phoneCode: "233", iso3: '');
Country selectedCurrency2 = Country(
    iso2: "US",
    name: "United States",
    currencyISO: "USD",
    phoneCode: "1",
    iso3: '');
int notifyOnPhone = 0;
int notifyOnEmail = 0;

class _CreateAlertState extends State<CreateAlert>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: SvgPicture.asset(
            'assets/share_with_contact/arrowback.svg',
            fit: BoxFit.scaleDown,
            height: 15,
            width: 15,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Create alert',
          style: textTheme.titleLarge?.copyWith(
              color: AppColor.kOnPrimaryTextColor, fontWeight: FontWeight.w700),
        ),
        actions: [
          HelpIconButton(
            onTap: () {},
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(2),
              width: width,
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColor.kSecondaryColor, width: 2),
                  borderRadius: BorderRadius.circular(30)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedTab = 0;
                      });
                    },
                    child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: _selectedTab == 0
                                ? AppColor.kSecondaryColor
                                : AppColor.kWhiteColor),
                        child: Text(
                          'Target rate',
                          style: textTheme.bodyLarge?.copyWith(
                              color: _selectedTab == 0
                                  ? AppColor.kWhiteColor
                                  : AppColor.kSecondaryColor),
                        ),
                        width: (width - 56) / 2,
                        height: double.maxFinite),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedTab = 1;
                      });
                    },
                    child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: _selectedTab == 1
                              ? AppColor.kSecondaryColor
                              : AppColor.kWhiteColor,
                        ),
                        child: Text(
                          'Daily rate',
                          style: textTheme.bodyLarge?.copyWith(
                              color: _selectedTab == 1
                                  ? AppColor.kWhiteColor
                                  : AppColor.kSecondaryColor),
                        ),
                        width: (width - 56) / 2,
                        height: double.maxFinite),
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 25, left: 10),
              child: Text(
                'Receive alert for:',
                style: textTheme.bodyMedium
                    ?.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 15),
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    PickerContainer3(
                      addSuffix: true,
                      hint: 'Currency',
                      country: selectedCurrency,
                      onPressed: () async {
                        _showCountryPicker(
                            context: context,
                            selectedCountry: SelectCountryViewModel().country,
                            onTap: (country) {
                              setState(() {
                                selectedCurrency = country;
                              });
                            });
                      },
                    ),
                    Container(
                      child: Image.asset(
                        "assets/icons/arrow_right.png",
                        scale: 1.3,
                      ),
                    ),
                    PickerContainer3(
                      addSuffix: true,
                      hint: 'Currency',
                      country: selectedCurrency2,
                      onPressed: () async {
                        _showCountryPicker(
                            context: context,
                            selectedCountry: SelectCountryViewModel().country,
                            onTap: (country) {
                              setState(() {
                                selectedCurrency2 = country;
                              });
                            });
                      },
                    ),
                  ],
                )),
            _selectedTab == 0
                ? Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: 25, left: 10),
                    child: Text(
                      'When exchange rate reaches:',
                      style: textTheme.bodyMedium
                          ?.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  )
                : Container(),
            _selectedTab == 0
                ? Container(
                    margin: EdgeInsets.only(left: 10, top: 15),
                    child: TextFormField(
                      controller: _countryController,
                      decoration: TextFieldDecoration(
                        context: context,
                        focusNode: _countryFocusNode,
                        hintText: 'Rate',
                        onClearTap: () {
                          setState(() {
                            _countryController.clear();
                          });
                        },
                        controller: _countryController,
                      ).inputDecoration(),
                      keyboardType: TextInputType.number,
                      // onChanged: (val) {
                      //   _countryController.text = val;
                      // },
                    ),
                  )
                : Container(),
            _selectedTab == 0
                ? Container(
                    margin: EdgeInsets.only(left: 10, top: 5),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '1 GHS = 0.94 USD',
                      style: textTheme.titleSmall?.copyWith(
                          color: Colors.grey, fontWeight: FontWeight.w300),
                    ))
                : Container(),
            Container(
                margin: EdgeInsets.only(top: 40, left: 10),
                height: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      CustomCheckbox(
                        values: [],
                        onChanged: () {
                          setState(() {
                            // notifyOnPhone = notifyOnPhone == val ? 0 : val;
                          });
                        },
                        tileValue: 1,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Notify me on my phone',
                        style:
                            textTheme.titleSmall?.copyWith(color: Colors.grey),
                      ),
                    ]),
                    Row(children: [
                      CustomCheckbox(
                        values: [],
                        onChanged: () {
                          setState(() {
                            // notifyOnEmail = notifyOnEmail == val ? 0 : val;
                          });
                        },
                        tileValue: 1,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Notify me on my email',
                        style:
                            textTheme.titleSmall?.copyWith(color: Colors.grey),
                      ),
                    ]),
                  ],
                )),
            _selectedTab == 1
                ? Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 10, top: 15),
                    child: Text(
                      'Daily rate alerts are sent at 9:00 in the morning.',
                      style: textTheme.titleSmall?.copyWith(
                          color: Color(0xff008AA7),
                          fontWeight: FontWeight.w300),
                    ),
                  )
                : Container()
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(25),
        child: CustomElevatedButton(
            child: Text(
              'CREATE ALERT',
              style: textTheme.bodyLarge
                  ?.copyWith(color: AppColor.kOnPrimaryTextColor),
            ),
            color: const Color(0xffEBD75C),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DeliverMoneyToRecipient()));
            },
            radius: 8),
      ),
    );
  }
}

Future<void> _showCountryPicker(
    {required BuildContext context,
    required Country? selectedCountry,
    required Function(Country country) onTap}) async {
  await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0), topRight: Radius.circular(0))),
      builder: (context) {
        return CurrencyListWidget(
          selectedCountry: selectedCountry,
          onTap: onTap,
        );
      });
}
