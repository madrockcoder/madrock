import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geniuspay/util/iconPath.dart';

import '../../../core/injections/locator.dart';
import '../../../models/country.dart';
import '../../../util/color_scheme.dart';
import '../../../util/constants.dart';
import '../../../util/format_date.dart';
import '../../../util/widgets_util.dart';
import '../../auth/view_models/select_country_view_model.dart';
import '../../shared_widgets/animated.column.dart';
import '../../shared_widgets/custom_elevated_button_async.dart';
import '../../shared_widgets/picker_container.dart';
import '../../shared_widgets/size_config.dart';

class TaxRegistrationPage extends StatefulWidget {
  const TaxRegistrationPage({Key? key}) : super(key: key);

  @override
  State<TaxRegistrationPage> createState() => _TaxRegistrationPageState();
}

class _TaxRegistrationPageState extends State<TaxRegistrationPage> {
  final ScrollController _scrollController = ScrollController();
  bool? isTaxResident;
  bool declaration = false;
  FocusNode focusNode = FocusNode();
  TextEditingController tinNumberController = TextEditingController();
  final List<Widget> countryAndTinNumberList = [];
  final SelectCountryViewModel _selectCountryViewModel = sl<SelectCountryViewModel>();
  List<Country> countries = [];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final textTheme = Theme.of(context).textTheme;
    countryAndTinNumberList.add(tinNumberAndCountry(controller: tinNumberController));
    return Scaffold(
      appBar: WidgetsUtil.onBoardingAppBar(context, title: 'Registration'),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: sixDp),
                    child: Scrollbar(
                      thumbVisibility: true,
                      thickness: 0.5,
                      interactive: true,
                      controller: _scrollController,
                      radius: const Radius.circular(twentyDp),
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: sixteenDp),
                          child: AnimatedColumnWidget(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            //1
                            const SizedBox(height: sixDp),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: thirtyDp),
                              child: RichText(
                                textWidthBasis: TextWidthBasis.parent,
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                  text: '',
                                  children: <TextSpan>[
                                    WidgetsUtil.textSpan(
                                        value: "Individual Self-Certification relevant for ", textStyle: textTheme.titleLarge!),
                                  ],
                                ),
                              ),
                            ),
                            Center(
                              child: RichText(
                                textWidthBasis: TextWidthBasis.parent,
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                  text: '',
                                  children: <TextSpan>[
                                    WidgetsUtil.textSpan(
                                        value: ' FATCA',
                                        textStyle: const TextStyle(
                                            color: AppColor.kGenioGreenColor, fontSize: eighteenDp, fontWeight: FontWeight.bold)),
                                    WidgetsUtil.textSpan(
                                        value: ' and', textStyle: const TextStyle(color: Colors.black, fontSize: eighteenDp)),
                                    WidgetsUtil.textSpan(
                                        value: ' CRS',
                                        textStyle: const TextStyle(
                                            fontWeight: FontWeight.bold, color: AppColor.kGenioGreenColor, fontSize: eighteenDp)),
                                    WidgetsUtil.textSpan(
                                        value: ' purposes',
                                        textStyle:
                                            const TextStyle(fontFamily: 'bold', color: Colors.black, fontSize: eighteenDp)),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: thirtyDp),
                            Text(
                              '1. Country of your Tax Residence',
                              style: textTheme.titleLarge!
                                  .copyWith(color: AppColor.kSecondaryColor, fontWeight: FontWeight.w600, fontSize: sixteenDp),
                            ),
                            const SizedBox(height: sixDp),
                            Text(
                                'Please indicate all countries, also domestic, where you are tax resident and your TIN (Taxpayer Identification Number) for each country:',
                                style: textTheme.labelLarge!.copyWith(color: Colors.black)),
                            const SizedBox(height: twentyFourDp),
                            /*    PickerContainer(
                              hint: 'Country',
                              country: _selectCountryViewModel.country,
                              onPressed: () async {
                                _showCountryPicker(
                                    selectedCountry: null,
                                    onTap: (country) {
                                      _selectCountryViewModel.setCountry = country;
                                      countries.add(country);
                                      setState(() {});
                                    });
                              },
                            ),
                            const SizedBox(height: sixteenDp),
                            SizedBox(
                              height: fiftySixDp,
                              child: TextFormField(
                                  cursorWidth: 1,
                                  focusNode: focusNode,
                                  controller: tinNumberController,
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) {
                                    if (value.length < 2) {
                                      setState(() {});
                                    }
                                  },
                                  style: const TextStyle(
                                      color: Color(0xFF000000),
                                      fontSize: fourteenDp,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: ""),
                                  decoration: InputDecoration(
                                    labelText: 'Enter TIN',
                                    labelStyle: const TextStyle(
                                        color: AppColor.kPinDesColor,
                                        fontSize: fourteenDp,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: ""),
                                    filled: true,
                                    suffixIcon: tinNumberController.text.isNotEmpty
                                        ? InkWell(
                                            onTap: () {
                                              tinNumberController.clear();
                                              setState(() {});
                                            },
                                            child: const Icon(
                                              Icons.cancel,
                                              color: AppColor.kSecondaryColor,
                                              size: 18,
                                            ),
                                          )
                                        : const SizedBox(),
                                    fillColor: tinNumberController.text.isNotEmpty ? AppColor.kAccentColor2 : Colors.white,
                                    enabledBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(eightDp)),
                                      borderSide: BorderSide(color: AppColor.kSecondaryColor, width: 1),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                      borderSide: BorderSide(color: AppColor.kSecondaryColor),
                                    ),
                                  )),
                            ),*/

                            ...countryAndTinNumberList.map((e) => e).toList(),
                            const SizedBox(height: tenDp),
                            Align(alignment: Alignment.bottomRight, child: SvgPicture.asset(SvgPath.deleteIconSvg)),
                            const SizedBox(height: twentyFourDp),
                            Align(
                                alignment: Alignment.center,
                                child: Column(children: [
                                  Image.asset(IconPath.addIcon, width: fiftyDp),
                                  const SizedBox(height: tenDp),
                                  Text(
                                    'Add another country',
                                    style: textTheme.labelLarge!.copyWith(color: AppColor.kOnPrimaryTextColor2),
                                  )
                                ])),
                            const SizedBox(height: thirtyDp),
                            //2
                            Text('2. FATCA related',
                                style: textTheme.titleLarge!
                                    .copyWith(color: AppColor.kSecondaryColor, fontWeight: FontWeight.w600, fontSize: sixteenDp)),
                            const SizedBox(height: sixDp),
                            Text('Please select one of the options by checking the corresponding box below:',
                                style: textTheme.labelLarge!.copyWith(color: Colors.black, fontWeight: FontWeight.w500)),
                            const SizedBox(height: twentyFourDp),
                            Row(
                              children: [
                                Expanded(
                                    child: RichText(
                                  textWidthBasis: TextWidthBasis.parent,
                                  textAlign: TextAlign.start,
                                  text: TextSpan(
                                    text: '',
                                    children: <TextSpan>[
                                      WidgetsUtil.textSpan(
                                          value: 'I herby certify that ',
                                          textStyle: textTheme.labelLarge!.copyWith(color: AppColor.kPinDesColor)),
                                      WidgetsUtil.textSpan(
                                          value: 'I am a tax resident of the United States',
                                          textStyle: textTheme.labelLarge!
                                              .copyWith(color: AppColor.kSecondaryColor, fontWeight: FontWeight.w600)),
                                      WidgetsUtil.textSpan(
                                          value: ' and that I have designated the United States as one of the '
                                              'countries in the above section.',
                                          textStyle: const TextStyle(color: AppColor.kPinDesColor)),
                                    ],
                                  ),
                                )),
                                const SizedBox(width: thirtyDp),
                                selectOption(
                                    onTap: () {
                                      setState(() => isTaxResident = true);
                                    },
                                    bgColor: isTaxResident == true ? AppColor.kSecondaryColor : null,
                                    child: isTaxResident == true ? const Icon(Icons.check_outlined, color: Colors.white) : null),
                              ],
                            ),
                            const SizedBox(height: sixteenDp),
                            divider(),
                            const SizedBox(height: sixteenDp),
                            Row(
                              children: [
                                Expanded(
                                    child: RichText(
                                  textWidthBasis: TextWidthBasis.parent,
                                  textAlign: TextAlign.start,
                                  text: TextSpan(
                                    text: '',
                                    children: <TextSpan>[
                                      WidgetsUtil.textSpan(
                                          value: 'I herby certify that ',
                                          textStyle: const TextStyle(color: AppColor.kPinDesColor)),
                                      WidgetsUtil.textSpan(
                                          value: ' I am not a tax resident of the United States.',
                                          textStyle: textTheme.labelLarge!
                                              .copyWith(color: AppColor.kSecondaryColor, fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                )),
                                const SizedBox(width: thirtyDp),
                                selectOption(
                                    onTap: () {
                                      setState(() => isTaxResident = false);
                                    },
                                    bgColor: isTaxResident != null && isTaxResident == false ? AppColor.kSecondaryColor : null,
                                    child: isTaxResident != null && isTaxResident == false
                                        ? const Icon(Icons.check_outlined, color: Colors.white)
                                        : null),
                              ],
                            ),
                            const SizedBox(height: sixteenDp),
                            divider(),
                            const SizedBox(height: twentyFourDp),
                            //3
                            Text('3. Declaration',
                                style: textTheme.titleLarge!
                                    .copyWith(fontSize: sixteenDp, color: AppColor.kSecondaryColor, fontWeight: FontWeight.w600)),
                            const SizedBox(height: sixDp),
                            Row(
                              children: [
                                Expanded(
                                    child: RichText(
                                  textWidthBasis: TextWidthBasis.parent,
                                  textAlign: TextAlign.start,
                                  text: TextSpan(
                                    text: '',
                                    children: <TextSpan>[
                                      WidgetsUtil.textSpan(
                                          value: 'I herby declare that the information provided on this form is complete, correct'
                                              ' and true. The information provided may be used for reporting purposes according to local law. I agree that I will inform you within 30 days if any certification on this form becomes incorrect or will no longer be applied.',
                                          textStyle: textTheme.labelLarge!.copyWith(color: AppColor.kPinDesColor)),
                                    ],
                                  ),
                                )),
                                const SizedBox(width: thirtyDp),
                                selectOption(
                                    onTap: () {
                                      if (declaration) {
                                        setState(() => declaration = false);
                                      } else {
                                        setState(() => declaration = true);
                                      }
                                    },
                                    bgColor: declaration == true ? AppColor.kSecondaryColor : null,
                                    child: declaration == true ? const Icon(Icons.check_outlined, color: Colors.white) : null),
                              ],
                            ),
                            const SizedBox(height: sixteenDp),
                            divider(),
                            const SizedBox(height: twentyFourDp),
                          ]),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(sixteenDp),
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Date: ${FormatDate().format(formatType: 'dd.MM.yyyy', dateTime: DateTime.now())}',
                            // date time
                            style: textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold, color: AppColor.kSecondaryColor),
                          )),
                      const SizedBox(height: tenDp),
                      //todo activate color of button when all requirements are met
                      CustomElevatedButtonAsync(
                        color: AppColor.kGoldColor2,
                        disabledColor: AppColor.kAccentColor2,
                        child: Text(
                          'CONTINUE',
                          style: textTheme.bodyText2,
                        ),
                        onPressed: null,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }

  Widget divider() {
    return const Divider(color: AppColor.kAccentColor2, thickness: 1.5);
  }

  ///Selects option for tax / non - tax resident and declaration
  ///[onTap] triggers whatever function to call
  ///[child] shows a checked mark once selected
  ///[bgColor] changes color of widget
  Widget selectOption({required Function()? onTap, Widget? child, Color? bgColor}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: thirtyDp,
        height: thirtyDp,
        child: child ?? const SizedBox(),
        decoration: BoxDecoration(
            color: bgColor ?? Colors.white,
            borderRadius: BorderRadius.circular(eightDp),
            border: Border.all(color: AppColor.kSecondaryColor)),
      ),
    );
  }

  Widget tinNumberAndCountry({required TextEditingController controller, Function()? onPickCountryTapped}) {
    return Column(
      children: [
        PickerContainer(hint: 'Country', country: _selectCountryViewModel.country, onPressed: onPickCountryTapped),
        const SizedBox(height: sixteenDp),
        SizedBox(
          height: fiftySixDp,
          child: TextFormField(
              cursorWidth: 1,
              focusNode: focusNode,
              controller: controller,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                if (value.length < 2) {
                  setState(() {});
                }
              },
              style: const TextStyle(color: Color(0xFF000000), fontSize: fourteenDp, fontWeight: FontWeight.w400, fontFamily: ""),
              decoration: InputDecoration(
                labelText: 'Enter TIN',
                labelStyle: const TextStyle(
                    color: AppColor.kPinDesColor, fontSize: fourteenDp, fontWeight: FontWeight.w400, fontFamily: ""),
                filled: true,
                suffixIcon: controller.text.isNotEmpty
                    ? InkWell(
                        onTap: () {
                          tinNumberController.clear();
                          setState(() {});
                        },
                        child: const Icon(
                          Icons.cancel,
                          color: AppColor.kSecondaryColor,
                          size: 18,
                        ),
                      )
                    : const SizedBox(),
                fillColor: controller.text.isNotEmpty ? AppColor.kAccentColor2 : Colors.white,
                enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(eightDp)),
                    borderSide: BorderSide(color: AppColor.kSecondaryColor, width: 1)),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide(color: AppColor.kSecondaryColor),
                ),
              )),
        ),
      ],
    );
  }

  Future<void> _showCountryPicker({required Country? selectedCountry, required Function(Country country) onTap}) async {
/*    await showCustomScrollableSheet(
        context: context,
        child: CountryListWidget(
          selectedCountry: selectedCountry,
          onTap: (country) {
            _selectCountryViewModel.setCountry = country;
            countries.add(country);
            setState(() {});
          },
        ));*/
  }
}
