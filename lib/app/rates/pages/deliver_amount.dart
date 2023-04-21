// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geniuspay/app/auth/pages/sign_up/country/widgets/currency_list.dart';
import 'package:geniuspay/app/auth/view_models/select_country_view_model.dart';
import 'package:geniuspay/app/shared_widgets/country_flag_container.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/custom_keyboard.dart';
import 'package:geniuspay/models/country.dart';
import 'package:geniuspay/util/color_scheme.dart';

class DeliverAmount extends StatefulWidget {
  const DeliverAmount({Key? key}) : super(key: key);

  @override
  State<DeliverAmount> createState() => _DeliverAmountState();
}

Country selectedCurrency1 = Country(iso2: "US", name: "United States", currencyISO: "USD", phoneCode: "1", iso3: '');
Country selectedCurrency2 = Country(iso2: "US", name: "United States", currencyISO: "USD", phoneCode: "1", iso3: '');

class _DeliverAmountState extends State<DeliverAmount> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [AppColor.kAccentColor2, AppColor.kWhiteColor])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.close)),
        ),
        body: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                height: height / 3.5,
                width: width,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColor.kWhiteColor, boxShadow: [
                  BoxShadow(
                    color: AppColor.kAccentColor2,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  )
                ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'You pay',
                      style: textTheme.titleSmall?.copyWith(color: Colors.grey),
                    ),
                    ListTile(
                        contentPadding: EdgeInsets.all(0),
                        leading: CountryFlagContainer(
                          flag: selectedCurrency1.iso2,
                        ),
                        minLeadingWidth: 5,
                        title: Transform.translate(
                          offset: Offset(-8, 0),
                          child: GestureDetector(
                            onTap: () async {
                              _showCountryPicker(
                                  context: context,
                                  selectedCountry: SelectCountryViewModel().country,
                                  onTap: (country) {
                                    setState(() {
                                      selectedCurrency1 = country;
                                    });
                                  });
                            },
                            child: SizedBox(
                                width: 100,
                                child: Row(
                                  children: [
                                    Text(selectedCurrency1.currencyISO + ' '),
                                    SvgPicture.asset(
                                      'assets/icons/chevron-down.svg',
                                      color: Colors.black,
                                    )
                                  ],
                                )),
                          ),
                        ),
                        trailing: RichText(
                          text: TextSpan(
                            style: textTheme.headlineMedium,
                            text: '\$',
                            children: [TextSpan(text: '500.00', style: textTheme.displayMedium)],
                          ),
                        )),
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/rates/deliver_amount.png',
                            scale: 1.2,
                          ),
                          Expanded(
                            child: Divider(
                              color: AppColor.kAccentColor2,
                            ),
                          )
                        ],
                      ),
                    ),
                    Text(
                      'They receive',
                      style: textTheme.titleSmall?.copyWith(color: Colors.grey),
                    ),
                    ListTile(
                        contentPadding: EdgeInsets.all(0),
                        leading: CountryFlagContainer(
                          flag: selectedCurrency2.iso2,
                        ),
                        minLeadingWidth: 5,
                        title: Transform.translate(
                          offset: Offset(-8, 0),
                          child: GestureDetector(
                            onTap: () async {
                              _showCountryPicker(
                                  context: context,
                                  selectedCountry: SelectCountryViewModel().country,
                                  onTap: (country) {
                                    setState(() {
                                      selectedCurrency2 = country;
                                    });
                                  });
                            },
                            child: SizedBox(
                                width: 100,
                                child: Row(
                                  children: [
                                    Text(selectedCurrency2.currencyISO + ' '),
                                    SvgPicture.asset(
                                      'assets/icons/chevron-down.svg',
                                      color: Colors.black,
                                    )
                                  ],
                                )),
                          ),
                        ),
                        trailing: RichText(
                          text: TextSpan(
                            style: textTheme.headlineMedium?.copyWith(color: AppColor.kSecondaryColor),
                            text: '\$',
                            children: [
                              TextSpan(text: '500.00', style: textTheme.displayMedium?.copyWith(color: AppColor.kSecondaryColor))
                            ],
                          ),
                        )),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                height: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 16),
                        text: 'x 1.578',
                        children: [
                          TextSpan(
                              text: ' live rate', style: textTheme.bodyMedium?.copyWith(fontSize: 16, fontWeight: FontWeight.w100))
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 16),
                        text: 'Fee:',
                        children: [
                          TextSpan(
                              text: ' 1.50 USD', style: textTheme.bodyMedium?.copyWith(fontSize: 16, fontWeight: FontWeight.w100))
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 16),
                        text: 'Should arrive',
                        children: [
                          TextSpan(
                              text: ' in a few minutes',
                              style: textTheme.bodyMedium?.copyWith(fontSize: 16, fontWeight: FontWeight.w100))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: CustomKeyboard(
                  onKeypressed: (val) {},
                  customButton: Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: Center(
                      child: Text(
                        '.',
                        style: textTheme.displayLarge,
                      ),
                    ),
                  ),
                ),
              ),
              CustomElevatedButton(
                  child: Text(
                    'GET STARTED',
                    style: textTheme.bodyLarge?.copyWith(color: AppColor.kOnPrimaryTextColor),
                  ),
                  color: const Color(0xffEBD75C),
                  onPressed: () {},
                  radius: 8),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _showCountryPicker(
    {required BuildContext context, required Country? selectedCountry, required Function(Country country) onTap}) async {
  await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(0), topRight: Radius.circular(0))),
      builder: (context) {
        return CurrencyListWidget(
          selectedCountry: selectedCountry,
          onTap: onTap,
        );
      });
}
