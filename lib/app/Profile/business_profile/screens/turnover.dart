import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/Profile/business_profile/screens/countries_of_operations.dart';
import 'package:geniuspay/app/Profile/business_profile/widgets/custom_text_field.dart';
import 'package:geniuspay/app/Profile/business_profile/widgets/dropdown_options.dart';
import 'package:geniuspay/app/shared_widgets/custom_section_heading.dart';
import 'package:geniuspay/app/shared_widgets/custom_yellow_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/models/business_profile_model.dart';
import 'package:geniuspay/util/color_scheme.dart';

class Turnover extends StatefulWidget {
  static Future<void> show(
      BuildContext context, BusinessProfileModel businessProfileModel,
      {bool isUpdate = false}) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => Turnover(
            businessProfileModel: businessProfileModel, isUpdate: isUpdate),
      ),
    );
  }

  final BusinessProfileModel businessProfileModel;
  final bool isUpdate;

  const Turnover(
      {Key? key, required this.businessProfileModel, required this.isUpdate})
      : super(key: key);

  @override
  State<Turnover> createState() => _TurnoverState();
}

class _TurnoverState extends State<Turnover> {
  final TextEditingController annualTurnoverController =
      TextEditingController();
  final FocusNode annualTurnoverFocusNode = FocusNode();
  List<CustomEnum> annualTurnoverItems = [
    CustomEnum('LESS_THAN_100K', 'Less than 100,000'),
    CustomEnum('From_100_000_TO_500_000', 'From 100,000 to 500,000'),
    CustomEnum('More_Than_500_000', 'More than 500,000'),
  ];
  int annualTurnoverIndex = 0;

  final TextEditingController monthlyIncomingController =
      TextEditingController();
  final FocusNode monthlyIncomingFocusNode = FocusNode();
  List<CustomEnum> monthlyIncomingItems = [
    CustomEnum('Up_To_10_000', 'Up To 10,000'),
    CustomEnum('From_10_000_TO_250_000', 'From 10,000 to 250,000'),
    CustomEnum('From_250_000_TO_1_000_000', 'From 250,000 to 1,000,000'),
    CustomEnum('More_Than_1_000_000', 'More than 1,000,000'),
  ];
  int monthlyIncomingIndex = 0;

  final TextEditingController monthlyOutgoingController =
      TextEditingController();
  final FocusNode monthlyOutgoingFocusNode = FocusNode();
  List<CustomEnum> monthlyOutgoingItems = [
    CustomEnum('Up_To_10_000', 'Up To 10,000'),
    CustomEnum('From_10_000_TO_250_000', 'From 10,000 to 250,000'),
    CustomEnum('From_250_000_TO_1_000_000', 'From 250,000 to 1,000,000'),
    CustomEnum('More_Than_1_000_000', 'More than 1,000,000'),
  ];
  int monthlyOutgoingIndex = 0;

  bool get areAllImportantFieldsFilled =>
      annualTurnoverController.text.trim().isNotEmpty &&
      monthlyIncomingController.text.trim().isNotEmpty &&
      monthlyOutgoingController.text.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: true,
            leading: const BackButton(),
            actions: const [HelpIconButton()],
            title: const Text('Turnover')),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSectionHeading(
                heading: "What is expected annual turnover for this account?",
                headingAndChildGap: 8,
                topSpacing: 8,
                headingTextStyle: textTheme.titleSmall
                    ?.copyWith(fontSize: 14, color: AppColor.kSecondaryColor),
                child: Text(
                  "Annual turnover is the percentage rate at which something changes ownership over the course of a year. For a business, this rate could be related to its yearly turnover in inventories, receivables, payables, or assets.",
                  style: textTheme.bodyMedium
                      ?.copyWith(color: AppColor.kPinDesColor, fontSize: 12),
                ),
              ),
              const Gap(8),
              CustomTextField(
                  controller: annualTurnoverController,
                  setState: setState,
                  focusNode: annualTurnoverFocusNode,
                  readOnly: true,
                  suffix: const Icon(Icons.keyboard_arrow_down,
                      color: AppColor.kSecondaryColor, size: 20),
                  onTap: () {
                    _showDialog('Annual turnover', annualTurnoverIndex,
                        annualTurnoverItems, (_index) {
                      annualTurnoverController.text =
                          annualTurnoverItems[_index].string;
                      annualTurnoverIndex = _index;
                      setState(() {});
                    }, context);
                  },
                  hintText: 'Annual turnover'),
              CustomSectionHeading(
                heading:
                    "What is your expected monthly turnover of incoming payments?",
                headingAndChildGap: 8,
                topSpacing: 8,
                headingTextStyle: textTheme.titleSmall
                    ?.copyWith(fontSize: 14, color: AppColor.kSecondaryColor),
                child: CustomTextField(
                    controller: monthlyIncomingController,
                    setState: setState,
                    focusNode: monthlyIncomingFocusNode,
                    readOnly: true,
                    suffix: const Icon(Icons.keyboard_arrow_down,
                        color: AppColor.kSecondaryColor, size: 20),
                    onTap: () {
                      _showDialog('Monthly turnover', monthlyIncomingIndex,
                          monthlyIncomingItems, (_index) {
                        monthlyIncomingController.text =
                            monthlyIncomingItems[_index].string;
                        monthlyIncomingIndex = _index;
                        setState(() {});
                      }, context);
                    },
                    helperText: 'Monthly Turnover of Incoming Payment. - Valued in your local currency. e.g. EUR, USD, PLN etc.',
                    hintText: 'Monthly turnover'),
              ),
              CustomSectionHeading(
                heading:
                    "What is your expected monthly turnover of outgoing payments?",
                headingAndChildGap: 8,
                topSpacing: 8,
                headingTextStyle: textTheme.titleSmall
                    ?.copyWith(fontSize: 14, color: AppColor.kSecondaryColor),
                child: CustomTextField(
                    controller: monthlyOutgoingController,
                    setState: setState,
                    focusNode: monthlyOutgoingFocusNode,
                    readOnly: true,
                    helperText: 'Planned monthly turnover of outgoing payments. - Valued in your local currency. e.g. EUR, USD, PLN etc.',
                    helperMaxLines: 3,
                    suffix: const Icon(Icons.keyboard_arrow_down,
                        color: AppColor.kSecondaryColor, size: 20),
                    onTap: () {
                      _showDialog('Monthly turnover', monthlyOutgoingIndex,
                          monthlyOutgoingItems, (_index) {
                        monthlyOutgoingController.text =
                            monthlyOutgoingItems[_index].string;
                        monthlyOutgoingIndex = _index;
                        setState(() {});
                      }, context);
                    },
                    hintText: 'Monthly turnover'),
              ),
              const Spacer(),
              CustomYellowElevatedButton(
                onTap: () {
                  widget.businessProfileModel.businessAssessment
                          ?.annualTurnover =
                      annualTurnoverItems[annualTurnoverIndex].enumString;
                  widget.businessProfileModel.businessAssessment
                          ?.monthlyTurnoverIncoming =
                      monthlyIncomingItems[monthlyIncomingIndex].enumString;
                  widget.businessProfileModel.businessAssessment
                          ?.monthlyTurnoverOutgoing =
                      monthlyOutgoingItems[monthlyOutgoingIndex].enumString;
                  if (!widget.isUpdate) {
                    CountriesOfOperations.show(
                        context, widget.businessProfileModel);
                  } else {
                    Navigator.pop(context);
                  }
                },
                disable: !areAllImportantFieldsFilled,
                text: "CONTINUE",
              ),
              const Gap(24)
            ],
          ),
        ),
      ),
    );
  }

  _showDialog(String heading, int selectedIndex, List<CustomEnum> items,
      ValueSetter<int> onChanged, BuildContext context) async {
    int? value = await showModalBottomSheet(
        isDismissible: true,
        context: context,
        builder: (context) {
          return DropDownOptions(
            initialChecked: selectedIndex,
            heading: heading,
            items: items.map((e) => e.string).toList(),
          );
        });
    if (value != null) {
      onChanged(value);
    }
  }
}

class CustomEnum {
  final String enumString;
  final String string;

  CustomEnum(this.enumString, this.string);
}
