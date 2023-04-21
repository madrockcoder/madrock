import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/shared_widgets/custom_checkbox.dart';
import 'package:geniuspay/app/shared_widgets/custom_circular_icon.dart';
import 'package:geniuspay/app/shared_widgets/custom_divider.dart';
import 'package:geniuspay/app/shared_widgets/custom_section_heading.dart';
import 'package:geniuspay/app/shared_widgets/custom_shadow_container.dart';
import 'package:geniuspay/app/shared_widgets/custom_text_field.dart';
import 'package:geniuspay/app/shared_widgets/custom_yellow_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/radio_list_tile.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/converter.dart';

class CopyOfData extends StatefulWidget {
  static Future<void> show(
    BuildContext context,
  ) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const CopyOfData(),
      ),
    );
  }

  const CopyOfData({Key? key}) : super(key: key);

  @override
  State<CopyOfData> createState() => _CopyOfDataState();
}

class _CopyOfDataState extends State<CopyOfData> {
  TextEditingController fileTypeController = TextEditingController(text: "PDF");
  List<int> personalCheckBoxValues = [];
  List<int> financialCheckBoxValues = [];
  int selectedIndex = 0;

  bool get isAllSelected =>
      personalCheckBoxValues.length == 4 && financialCheckBoxValues.length == 3;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Get a copy of your data'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSectionHeading(
                  heading: 'Submit a request to download a copy of your data',
                  headingTextStyle: textTheme.displayMedium
                      ?.copyWith(fontSize: 18, color: AppColor.kSecondaryColor),
                  topSpacing: 16,
                  child: Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColor.kAccentColor2),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 22),
                    child: RichText(
                        text: TextSpan(
                            text:
                                "To request or download a copy of your transaction activity, ",
                            children: [
                              TextSpan(
                                  text: "go to activity download.",
                                  style: textTheme.titleMedium?.copyWith(
                                      color: AppColor.kSecondaryColor,
                                      fontSize: 12))
                            ],
                            style: textTheme.bodyMedium?.copyWith(
                                color: AppColor.kSecondaryColor,
                                fontSize: 12))),
                  ),
                  headingAndChildGap: 16),
              const Gap(24),
              Row(
                children: [
                  Text(
                    "What data should we include?",
                    style: textTheme.titleSmall?.copyWith(
                        color: AppColor.kOnPrimaryTextColor3,
                        fontWeight: FontWeight.w300),
                  ),
                  const Spacer(),
                  InkWell(
                    borderRadius: BorderRadius.circular(4),
                    onTap: () {
                      if (!isAllSelected) {
                        personalCheckBoxValues.clear();
                        financialCheckBoxValues.clear();
                        personalCheckBoxValues.addAll([1, 2, 3, 4]);
                        financialCheckBoxValues.addAll([1, 2, 3]);
                      }else{
                        personalCheckBoxValues.clear();
                        financialCheckBoxValues.clear();
                      }
                      setState(() {});
                    },
                    child: Container(
                      height: 30,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Center(
                        child: Text(
                          isAllSelected ? 'Deselect all' : 'Select all',
                          style: textTheme.titleSmall
                              ?.copyWith(color: AppColor.kSecondaryColor),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const CustomDivider(
                color: AppColor.kSecondaryColor,
                thickness: 0.7,
                sizedBoxHeight: 8,
              ),
              CustomSectionHeading(
                heading: 'Personal information',
                headingTextStyle: textTheme.titleSmall
                    ?.copyWith(fontSize: 14, color: AppColor.kSecondaryColor),
                topSpacing: 16,
                child: Column(
                  children: [
                    Text(
                      "We use this information to keep your account safe, personalize your experience and contact you when needed.",
                      style: textTheme.bodyMedium,
                    ),
                    const Gap(8),
                    CustomShadowContainer(
                        child: Column(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset("assets/icons/card-solid.svg"),
                            const Gap(12),
                            Text(
                              "Name and date of birth",
                              style: textTheme.titleMedium,
                            ),
                            const Spacer(),
                            CustomCheckbox(
                              tileValue: 1,
                              values: personalCheckBoxValues,
                              onChanged: () {
                                if(personalCheckBoxValues.contains(1)){
                                  personalCheckBoxValues.remove(1);
                                }else{
                                  personalCheckBoxValues.add(1);
                                }
                                setState(() {});
                              },
                              checkboxShape: CustomCheckboxShape.rectangle,
                            )
                          ],
                        ),
                        const Gap(16),
                        Row(
                          children: [
                            SvgPicture.asset("assets/icons/house.svg"),
                            const Gap(12),
                            Text(
                              "Address",
                              style: textTheme.titleMedium,
                            ),
                            const Spacer(),
                            CustomCheckbox(
                              tileValue: 2,
                              values: personalCheckBoxValues,
                              onChanged: () {
                                if(personalCheckBoxValues.contains(2)){
                                  personalCheckBoxValues.remove(2);
                                }else{
                                  personalCheckBoxValues.add(2);
                                }
                                setState(() {});
                              },
                              checkboxShape: CustomCheckboxShape.rectangle,
                            )
                          ],
                        ),
                        const Gap(16),
                        Row(
                          children: [
                            SvgPicture.asset("assets/icons/email-at.svg"),
                            const Gap(12),
                            Text(
                              "Emails",
                              style: textTheme.titleMedium,
                            ),
                            const Spacer(),
                            CustomCheckbox(
                              tileValue: 3,
                              values: personalCheckBoxValues,
                              onChanged: () {
                                if(personalCheckBoxValues.contains(3)){
                                  personalCheckBoxValues.remove(3);
                                }else{
                                  personalCheckBoxValues.add(3);
                                }
                                setState(() {});
                              },
                              checkboxShape: CustomCheckboxShape.rectangle,
                            )
                          ],
                        ),
                        const Gap(16),
                        Row(
                          children: [
                            SvgPicture.asset("assets/icons/mobile-phone.svg"),
                            const Gap(12),
                            Text(
                              "Phone numbers",
                              style: textTheme.titleMedium,
                            ),
                            const Spacer(),
                            CustomCheckbox(
                              tileValue: 4,
                              values: personalCheckBoxValues,
                              onChanged: () {
                                if(personalCheckBoxValues.contains(4)){
                                  personalCheckBoxValues.remove(4);
                                }else{
                                  personalCheckBoxValues.add(4);
                                }
                                setState(() {});
                              },
                              checkboxShape: CustomCheckboxShape.rectangle,
                            )
                          ],
                        ),
                      ],
                    ))
                  ],
                ),
                headingAndChildGap: 8,
              ),
              CustomSectionHeading(
                heading: 'Financial information',
                headingTextStyle: textTheme.titleSmall
                    ?.copyWith(fontSize: 14, color: AppColor.kSecondaryColor),
                topSpacing: 24,
                child: Column(
                  children: [
                    Text(
                      "We use this information to enable you to checkout faster, and send or receive money, in just few clicks.",
                      style: textTheme.bodyMedium,
                    ),
                    const Gap(8),
                    CustomShadowContainer(
                        child: Column(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset("assets/icons/bank.svg"),
                            const Gap(12),
                            Text(
                              "Bank accounts",
                              style: textTheme.titleMedium,
                            ),
                            const Spacer(),
                            CustomCheckbox(
                              tileValue: 1,
                              values: financialCheckBoxValues,
                              onChanged: () {
                                if(financialCheckBoxValues.contains(1)){
                                  financialCheckBoxValues.remove(1);
                                }else{
                                  financialCheckBoxValues.add(1);
                                }
                                setState(() {});
                              },
                              checkboxShape: CustomCheckboxShape.rectangle,
                            )
                          ],
                        ),
                        const Gap(16),
                        Row(
                          children: [
                            SvgPicture.asset("assets/icons/credit-card.svg"),
                            const Gap(12),
                            Text(
                              "Debit or credit cards",
                              style: textTheme.titleMedium,
                            ),
                            const Spacer(),
                            CustomCheckbox(
                              tileValue: 2,
                              values: financialCheckBoxValues,
                              onChanged: () {
                                if(financialCheckBoxValues.contains(2)){
                                  financialCheckBoxValues.remove(2);
                                }else{
                                  financialCheckBoxValues.add(2);
                                }
                                setState(() {});
                              },
                              checkboxShape: CustomCheckboxShape.rectangle,
                            )
                          ],
                        ),
                        const Gap(16),
                        Row(
                          children: [
                            SvgPicture.asset("assets/icons/document-2.svg"),
                            const Gap(12),
                            SizedBox(
                              width: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Credit information",
                                    style: textTheme.titleMedium,
                                  ),
                                  Text(
                                    "Includes your credit application information",
                                    style: textTheme.bodyMedium?.copyWith(
                                        fontSize: 9,
                                        color: AppColor.kOnPrimaryTextColor3),
                                  )
                                ],
                              ),
                            ),
                            const Spacer(),
                            CustomCheckbox(
                              tileValue: 3,
                              values: financialCheckBoxValues,
                              onChanged: () {
                                if(financialCheckBoxValues.contains(3)){
                                  financialCheckBoxValues.remove(3);
                                }else{
                                  financialCheckBoxValues.add(3);
                                }
                                setState(() {});
                              },
                              checkboxShape: CustomCheckboxShape.rectangle,
                            )
                          ],
                        ),
                      ],
                    ))
                  ],
                ),
                headingAndChildGap: 8,
              ),
              const Gap(24),
              Row(
                children: [
                  Text(
                    "Other information ",
                    style: textTheme.bodyMedium?.copyWith(
                        color: AppColor.kSecondaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "(not included in file)",
                    style: textTheme.bodyMedium
                        ?.copyWith(color: AppColor.kSecondaryColor),
                  ),
                  const Spacer(),
                  SvgPicture.asset(
                    'assets/images/help.svg',
                    width: 18,
                    color: AppColor.kSecondaryColor,
                  ),
                ],
              ),
              const Gap(8),
              Text(
                "Includes device info, technical usage data, geolocation info, marketing preferences, consent history, and data used for other services such as credit, identity verification, communications with geniuspay, and third-party processors.",
                style: textTheme.bodyMedium,
              ),
              const Gap(24),
              Text(
                'Choose file type',
                style: textTheme.displayMedium
                    ?.copyWith(fontSize: 18, color: AppColor.kSecondaryColor),
              ),
              const CustomDivider(
                color: AppColor.kSecondaryColor,
                thickness: 0.7,
                sizedBoxHeight: 8,
              ),
              CustomTextField(
                radius: 8,
                validationColor: AppColor.kSecondaryColor,
                fillColor: AppColor.kAccentColor2,
                hasBorder: false,
                readOnly: true,
                filled: true,
                onTap: () async {
                  int? value = await showModalBottomSheet(
                      isDismissible: true,
                      context: context,
                      builder: (context) {
                        return ChooseFileType(initialChecked: selectedIndex,);
                      });
                  if (value != null) {
                    selectedIndex = value;
                    switch (value) {
                      case 0:
                        fileTypeController.text = "PDF";
                        break;
                      case 1:
                        fileTypeController.text = "CSV";
                        break;
                      case 2:
                        fileTypeController.text = "JSON";
                        break;
                    }
                  }
                },
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Transform.rotate(
                      angle: Converter.getRadianFromDegree(90),
                      child: SvgPicture.asset(
                        "assets/icons/arrow.svg",
                        width: 12,
                        height: 12,
                      )),
                ),
                onChanged: (val) {},
                hint: '',
                style: textTheme.bodyMedium,
                controller: fileTypeController,
                label: 'File type',
              ),
              const Gap(40),
              CustomYellowElevatedButton(
                text: "SUBMIT REQUEST",
                disable: !(financialCheckBoxValues.isNotEmpty ||
                    personalCheckBoxValues.isNotEmpty),
              ),
              const Gap(24)
            ],
          ),
        ),
      ),
    );
  }

  Widget customListTile(
      {required String title,
      required String subtitle,
      required String icon,
      GestureTapCallback? onTap}) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap ?? () {},
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: AppColor.kSecondaryColor),
              borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomCircularIcon(SvgPicture.asset(icon),
                    color: AppColor.kSecondaryColor),
                const Gap(12),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: textTheme.headlineSmall,
                      ),
                      Text(
                        subtitle,
                        style: textTheme.bodyMedium
                            ?.copyWith(color: AppColor.kPinDesColor),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChooseFileType extends StatefulWidget {
  final int initialChecked;

  const ChooseFileType({Key? key, required this.initialChecked})
      : super(key: key);

  @override
  State<ChooseFileType> createState() => _ChooseFileTypeState();
}

class _ChooseFileTypeState extends State<ChooseFileType> {
  int? _isChecked = 0;

  @override
  void initState() {
    _isChecked = widget.initialChecked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Gap(33),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                const Spacer(),
                Text('Select currency',
                    style: textTheme.displayLarge
                        ?.copyWith(fontSize: 16, fontWeight: FontWeight.w700)),
                const Spacer(),
              ],
            )),
        const Gap(16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ListView(
            shrinkWrap: true,
            children: [
              CustomRadioListTile(
                groupValue: _isChecked,
                title: const Text("PDF"),
                tileValue: 0,
                subtitle: null,
                onTap: (int value) {
                  setState(() => _isChecked = value);
                  Navigator.pop(context, 0);
                },
                leading: null,
              ),
              CustomRadioListTile(
                groupValue: _isChecked,
                title: const Text("CSV"),
                tileValue: 1,
                subtitle: null,
                onTap: (int value) {
                  setState(() => _isChecked = value);
                  Navigator.pop(context, 1);
                },
                leading: null,
              ),
              CustomRadioListTile(
                groupValue: _isChecked,
                title: const Text("JSON"),
                tileValue: 2,
                subtitle: null,
                onTap: (int value) {
                  setState(() => _isChecked = value);
                  Navigator.pop(context, 2);
                },
                leading: null,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
