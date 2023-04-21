import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/KYC/pages/residential_address/enter_address_page.dart';
import 'package:geniuspay/app/auth/pages/sign_up/widgets/auth_provider.dart';
import 'package:geniuspay/app/shared_widgets/continue_button.dart';
import 'package:geniuspay/app/shared_widgets/custom_text_field.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/widgets_util.dart';
import 'package:provider/provider.dart';

class SearchAddressPage extends StatefulWidget {
  const SearchAddressPage({
    Key? key,
    required this.value,
  }) : super(key: key);
  final AuthProvider value;

  static Future<void> show(
    BuildContext context,
  ) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => Consumer<AuthProvider>(
          builder: (_, value, __) => SearchAddressPage(value: value),
        ),
      ),
    );
  }

  @override
  State<SearchAddressPage> createState() => _SearchAddressPageState();
}

class _SearchAddressPageState extends State<SearchAddressPage> {
  final _countryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: WidgetsUtil.onBoardingAppBar(
        context,
        title: 'Residential address',
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    CustomTextField(
                      radius: 9,
                      height: 40,
                      controller: _countryController,
                      fillColor: AppColor.kAccentColor2,
                      keyboardType: TextInputType.name,
                      icon: WidgetsUtil.searchIcon(),
                      hasBorder: false,
                      // onChanged: (_) => _onSearchChanged(() {
                      //   if (_countryController.text.isNotEmpty) {
                      //     getCountries(_countryController.text);
                      //   } else {
                      //     setState(() {});
                      //   }
                      // }),
                      hint: 'Select Country',
                    ),
                    const Gap(5),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColor.kGreyColor,
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.error,
                            color: AppColor.kOnPrimaryTextColor3,
                            size: 16,
                          ),
                          const Gap(5),
                          Expanded(
                            child: Text(
                              'My address is not on the list',
                              style: textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: AppColor.kOnPrimaryTextColor3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(30),
                    ListTile(
                      title: Text(
                        'Aaaaaaaa',
                        style: textTheme.bodyLarge?.copyWith(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        'Wrocław, Poland',
                        style: textTheme.bodyLarge?.copyWith(
                          fontSize: 12,
                          color: AppColor.kOnPrimaryTextColor3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ContinueButton(
                context: context,
                color: AppColor.kGoldColor2,
                textColor: Colors.black,
                onPressed: () async {
                  EnterAddressPage.show(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
