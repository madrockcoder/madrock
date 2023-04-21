import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/jar/pages/summary_screen.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/size_config.dart';
import '../../../util/color_scheme.dart';
import '../widgets/jar_app_bar.dart';

class SetFrequencyScreen extends StatefulWidget {
  const SetFrequencyScreen({Key? key, this.data}) : super(key: key);
  final Map<String, dynamic>? data;
  static Future<void> show(
      BuildContext context, Map<String, dynamic> data) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
          builder: (_) => SetFrequencyScreen(
                data: data,
              )),
    );
  }

  @override
  State<SetFrequencyScreen> createState() => _SetFrequencyScreenState();
}

class _SetFrequencyScreenState extends State<SetFrequencyScreen> {
  final List<String> listIteam = [
    'Daily',
    'Weekly',
    'Monthly',
  ];

  final List<String> savinglistIteam = [
    'USD 20.00 per day',
    'USD 40.00 per day',
    'USD 100.00 per day',
  ];

  final List<Widget> iconlistIteam = [
    SvgPicture.asset('assets/icons/daily.svg', height: 17, width: 17),
    SvgPicture.asset('assets/icons/weekly.svg', height: 17, width: 17),
    SvgPicture.asset('assets/icons/monthly.svg', height: 17, width: 17),
  ];

  String? selectedValue = '';

  String? selectedValue2 = '';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColor.kWhiteColor,
      appBar: const JarAppBar(
          text: 'Set frequency', backgroundColor: AppColor.kWhiteColor),
      body: Padding(
        padding: const EdgeInsets.only(left: 24.0, right: 24),
        child: Column(
          children: [
            const Gap(24),
            Text('How often would you like to save for this goal?',
                style: textTheme.bodyMedium?.copyWith(fontSize: 16)),
            const Gap(12),
            DropdownButtonFormField2(
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColor.kSecondaryColor),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              hint: const Text(
                'Frequency',
                style: TextStyle(fontSize: 14),
              ),
              icon: SvgPicture.asset('assets/icons/arrow_down.svg', color: AppColor.kSecondaryColor),
              buttonHeight: 60,
              buttonPadding: const EdgeInsets.symmetric(horizontal: 20),
              buttonDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColor.kSecondaryColor),
              ),
              dropdownDecoration: BoxDecoration(
                border: Border.all(color: AppColor.kSecondaryColor),
                borderRadius: BorderRadius.circular(20),
              ),
              offset: const Offset(100, 0),
              items: List.generate(
                listIteam.length,
                (index) => DropdownMenuItem<String>(
                  value: listIteam[index],
                  child: Row(
                    children: [
                      iconlistIteam[index],
                      const Gap(10),
                      Text(
                        listIteam[index],
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // barrierColor: Colors.black45,
              dropdownWidth: SizeConfig.screenWidth! / 1.5,
              dropdownPadding: const EdgeInsets.only(right: 20),
              validator: (value) {
                if (value == null) {
                  return 'Please select frequency.';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  selectedValue = value.toString();
                });
              },
              onSaved: (value) {
                selectedValue = value.toString();
              },
            ),
            const Gap(8),
            DropdownButtonFormField2(
              decoration: InputDecoration(
                // isDense: true,
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColor.kSecondaryColor),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              // isExpanded: true,

              offset: const Offset(100, 0),
              hint: const Text(
                'Savings',
                style: TextStyle(fontSize: 14),
              ),
              icon: SvgPicture.asset('assets/icons/arrow_down.svg', color: AppColor.kSecondaryColor),
              buttonHeight: 60,
              buttonPadding: const EdgeInsets.only(left: 20, right: 20),
              buttonDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColor.kSecondaryColor),
              ),
              // barrierColor: Colors.black45,
              dropdownWidth: SizeConfig.screenWidth! / 1.5,
              dropdownPadding: const EdgeInsets.all(10),
              dropdownDecoration: BoxDecoration(
                border: Border.all(color: AppColor.kSecondaryColor),
                borderRadius: BorderRadius.circular(20),
              ),
              items: List.generate(
                savinglistIteam.length,
                (index) => DropdownMenuItem<String>(
                  value: savinglistIteam[index],
                  child: Text(
                    savinglistIteam[index],
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              validator: (value) {
                if (value == null) {
                  return 'Please select savings.';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  selectedValue2 = value.toString();
                });
              },
              onSaved: (value) {},
            ),
            const Spacer(),
            CustomElevatedButton(
              onPressed: () {
                if (selectedValue!.isNotEmpty || selectedValue2!.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SummaryScreen(
                        image: widget.data?['image'],
                        name: widget.data?['name'],
                        amount: widget.data?['amount'],
                        contribution: selectedValue2,
                        endDate: widget.data?['endDate'],
                      ),
                    ),
                  );
                }
              },
              radius: 8,
              color: selectedValue!.isEmpty || selectedValue2!.isEmpty
                  ? AppColor.kAccentColor2
                  : AppColor.kGoldColor2,
              child: Text('CONTINUE',
                  style: selectedValue!.isEmpty || selectedValue2!.isEmpty
                      ? textTheme.bodyMedium
                      : textTheme.bodyLarge),
            ),
            const Gap(45),
          ],
        ),
      ),
    );
  }
}
