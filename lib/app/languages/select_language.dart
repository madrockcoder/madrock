import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geniuspay/app/shared_widgets/country_flag_container.dart';
import 'package:geniuspay/app/shared_widgets/custom_text_field.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/models/country.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/widgets_util.dart';


class SelectLanguage extends StatefulWidget {
  const SelectLanguage({Key? key}) : super(key: key);

  @override
  State<SelectLanguage> createState() => _SelectLanguageState();
}

List<Country> _foundCountries = [];
List<Country> _countries = [];

class _SelectLanguageState extends State<SelectLanguage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCountries(context, setState);
  }

  final _countryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
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
            'Languages',
            style: textTheme.titleLarge?.copyWith(color: AppColor.kOnPrimaryTextColor),
          ),
          actions: [
            HelpIconButton(
              onTap: () {},
            )
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(24),
          child: Column(children: [
            CustomTextField(
              radius: 9,
              validationColor: AppColor.kSecondaryColor,
              controller: _countryController,
              fillColor: Colors.transparent,
              keyboardType: TextInputType.name,
              prefixIcon: WidgetsUtil.searchIcon(),
              hasBorder: false,
              onChanged: (val) {
                setState(() {
                  if (val.isNotEmpty) {
                    searchCountry(keyword: val, context: context);
                  } else if (val.isEmpty) {
                    getCountries(context, setState);
                  }
                });
              },
              hint: 'Search',
            ),
            Flexible(
              child: ListView.builder(
                  itemCount: _foundCountries.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CountryFlagContainer(flag: _foundCountries[index].iso2),
                      title: Text(_foundCountries[index].name),
                    );
                  }),
            )
          ]),
        ));
  }
}

Future<void> searchCountry({
  required String keyword,
  required BuildContext context,
}) async {
  final result = _countries.where((element) => element.name.toLowerCase().startsWith(keyword.toLowerCase()));
  _foundCountries = result.toList();
}

Future<void> getCountries(BuildContext context, setState) async {
  String data = await DefaultAssetBundle.of(context).loadString("assets/languages.json");
  final jsonResult = jsonDecode(data);
  _countries = CountrylList.fromJson(jsonResult).list;
  _foundCountries = _countries;
  setState(() {});
}
