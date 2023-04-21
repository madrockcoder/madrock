import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/Profile/business_profile/screens/summary.dart';
import 'package:geniuspay/app/Profile/business_profile/screens/turnover.dart';
import 'package:geniuspay/app/Profile/business_profile/widgets/custom_text_field.dart';
import 'package:geniuspay/app/Profile/business_profile/widgets/dropdown_options.dart';
import 'package:geniuspay/app/shared_widgets/custom_section_heading.dart';
import 'package:geniuspay/app/shared_widgets/custom_yellow_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/models/business_profile_model.dart';
import 'package:geniuspay/util/color_scheme.dart';

class Payments extends StatefulWidget {
  static Future<void> show(
      BuildContext context, BusinessProfileModel businessProfileModel,
      {bool isUpdate = false}) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => Payments(
            businessProfileModel: businessProfileModel, isUpdate: isUpdate),
      ),
    );
  }

  final BusinessProfileModel businessProfileModel;
  final bool isUpdate;

  const Payments(
      {Key? key, required this.businessProfileModel, required this.isUpdate})
      : super(key: key);

  @override
  State<Payments> createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  final TextEditingController incomingTransactionSizeController =
      TextEditingController();
  final FocusNode incomingTransactionSizeFocusNode = FocusNode();
  List<CustomEnum> incomingTransactionSizeItems = [
    CustomEnum('Up_To_10_000', 'Up to 10,000'),
    CustomEnum('From_10_000_TO_100_000', 'From 10,000 to 100,000'),
    CustomEnum('From_100_000_TO_500_000', 'From 100,000 to 500,000'),
    CustomEnum('More_Than_500_000', 'More than 500,000'),
  ];
  int incomingTransactionSizeIndex = 0;

  final TextEditingController monthlyOutgoingFrequencyController =
      TextEditingController();
  final FocusNode monthlyIncomingFrequencyFocusNode = FocusNode();
  List<CustomEnum> monthlyOutgoingFrequencyItems = [
    CustomEnum('Up_TO_10', 'Up to 10'),
    CustomEnum('From_10_TO_50', 'From 10 to 50'),
    CustomEnum('From_50_TO_500', 'From 50 to 500'),
    CustomEnum('More_Than_500', 'More than 500'),
  ];
  int monthlyOutgoingFrequencyIndex = 0;

  final TextEditingController averageTransactionOutgoingController =
      TextEditingController();
  final FocusNode averageTransactionOutgoingFocusNode = FocusNode();
  List<CustomEnum> averageTransactionOutgoingItems = [
    CustomEnum('Up_To_10_000', 'Up to 10,000'),
    CustomEnum('From_10_000_TO_250_000', 'From 10,000 to 100,000'),
    CustomEnum('From_250_000_TO_500_000', 'From 100,000 to 500,000'),
    CustomEnum('More_Than_500_000', 'More than 500,000'),
  ];
  int averageTransactionOutgoingIndex = 0;

  final TextEditingController monthlyIncomingFrequencyController =
      TextEditingController();
  final FocusNode monthlyOutgoingFrequencyFocusNode = FocusNode();
  List<CustomEnum> monthlyIncomingFrequencyItems = [
    CustomEnum('Up_TO_10', 'Up to 10'),
    CustomEnum('From_10_TO_50', 'From 10 to 50'),
    CustomEnum('From_50_TO_500', 'From 50 to 500'),
    CustomEnum('More_Than_500', 'More than 500'),
  ];
  int monthlyIncomingFrequencyIndex = 0;

  bool get areAllImportantFieldsFilled =>
      incomingTransactionSizeController.text.trim().isNotEmpty &&
      monthlyIncomingFrequencyController.text.trim().isNotEmpty &&
      averageTransactionOutgoingController.text.trim().isNotEmpty &&
      monthlyOutgoingFrequencyController.text.trim().isNotEmpty;

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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: CustomYellowElevatedButton(
            onTap: () {
              widget.businessProfileModel.businessAssessment ??=
                  BusinessAssessment();

              widget.businessProfileModel.businessAssessment!
                  .avgIncomingTransactionSize =
                  incomingTransactionSizeItems[incomingTransactionSizeIndex]
                      .enumString;

              widget.businessProfileModel.businessAssessment!
                  .monthlyFrequencyIncoming =
                  monthlyOutgoingFrequencyItems[
                  monthlyOutgoingFrequencyIndex]
                      .enumString;

              widget.businessProfileModel.businessAssessment!
                  .avgOutgoingTransactionSize =
                  averageTransactionOutgoingItems[
                  averageTransactionOutgoingIndex]
                      .enumString;

              widget.businessProfileModel.businessAssessment!
                  .monthlyFrequencyOutgoing = monthlyIncomingFrequencyItems[
              monthlyIncomingFrequencyIndex]
                  .enumString;
              if(!widget.isUpdate){
                Summary.show(context, widget.businessProfileModel);
              }else{
                Navigator.pop(context);
              }
            },
            disable: !areAllImportantFieldsFilled,
            text: "CONTINUE",
          ),
        ),
        appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: true,
            leading: const BackButton(),
            actions: const [HelpIconButton()],
            title: const Text('Payments')),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSectionHeading(
                    heading:
                        "What is average transaction value/size on incoming transactions?",
                    headingAndChildGap: 8,
                    topSpacing: 8,
                    headingTextStyle: textTheme.titleSmall
                        ?.copyWith(fontSize: 14, color: AppColor.kSecondaryColor),
                    child: CustomTextField(
                        controller: incomingTransactionSizeController,
                        setState: setState,
                        focusNode: incomingTransactionSizeFocusNode,
                        readOnly: true,
                        suffix: const Icon(Icons.keyboard_arrow_down,
                            color: AppColor.kSecondaryColor, size: 20),
                        onTap: () {
                          _showDialog(
                              'Incoming transaction size',
                              incomingTransactionSizeIndex,
                              incomingTransactionSizeItems, (_index) {
                            incomingTransactionSizeController.text =
                                incomingTransactionSizeItems[_index].string;
                            incomingTransactionSizeIndex = _index;
                            setState(() {});
                          }, context);
                        },
                        helperText: 'The Average transaction value or size on Incoming transaction. - Valued in your local currency. e.g. EUR, USD, PLN etc.',
                        helperMaxLines: 3,
                        hintText: 'Incoming transaction size'),
                  ),
                  CustomSectionHeading(
                    heading: "What is the monthly frequency of incoming payments?",
                    headingAndChildGap: 8,
                    topSpacing: 8,
                    headingTextStyle: textTheme.titleSmall
                        ?.copyWith(fontSize: 14, color: AppColor.kSecondaryColor),
                    child: CustomTextField(
                        controller: monthlyIncomingFrequencyController,
                        setState: setState,
                        focusNode: monthlyOutgoingFrequencyFocusNode,
                        readOnly: true,
                        suffix: const Icon(Icons.keyboard_arrow_down,
                            color: AppColor.kSecondaryColor, size: 20),
                        onTap: () {
                          _showDialog(
                              'Monthly frequency',
                              monthlyIncomingFrequencyIndex,
                              monthlyIncomingFrequencyItems, (_index) {
                            monthlyIncomingFrequencyController.text =
                                monthlyIncomingFrequencyItems[_index].string;
                            monthlyIncomingFrequencyIndex = _index;
                            setState(() {});
                          }, context);
                        },
                        helperText: 'Monthly frequency of incoming payments.',
                        helperMaxLines: 3,
                        hintText: 'Monthly frequency'),
                  ),
                  CustomSectionHeading(
                    heading:
                        "What is average transaction value/size on outgoing transactions?",
                    headingAndChildGap: 8,
                    topSpacing: 8,
                    headingTextStyle: textTheme.titleSmall
                        ?.copyWith(fontSize: 14, color: AppColor.kSecondaryColor),
                    child: CustomTextField(
                        controller: averageTransactionOutgoingController,
                        setState: setState,
                        focusNode: averageTransactionOutgoingFocusNode,
                        readOnly: true,
                        suffix: const Icon(Icons.keyboard_arrow_down,
                            color: AppColor.kSecondaryColor, size: 20),
                        onTap: () {
                          _showDialog(
                              'Monthly frequency',
                              averageTransactionOutgoingIndex,
                              averageTransactionOutgoingItems, (_index) {
                            averageTransactionOutgoingController.text =
                                averageTransactionOutgoingItems[_index].string;
                            averageTransactionOutgoingIndex = _index;
                            setState(() {});
                          }, context);
                        },
                        helperText: 'Average outgoing transaction value/size. - Valued in your local currency. e.g. EUR, USD, PLN etc.',
                        hintText: 'Outgoing transaction size'),
                  ),
                  CustomSectionHeading(
                    heading: "What is the monthly frequency of outgoing payments?",
                    headingAndChildGap: 8,
                    topSpacing: 8,
                    headingTextStyle: textTheme.titleSmall
                        ?.copyWith(fontSize: 14, color: AppColor.kSecondaryColor),
                    child: CustomTextField(
                        controller: monthlyOutgoingFrequencyController,
                        setState: setState,
                        focusNode: monthlyIncomingFrequencyFocusNode,
                        readOnly: true,
                        suffix: const Icon(Icons.keyboard_arrow_down,
                            color: AppColor.kSecondaryColor, size: 20),
                        onTap: () {
                          _showDialog(
                              'Monthly frequency',
                              monthlyOutgoingFrequencyIndex,
                              monthlyOutgoingFrequencyItems, (_index) {
                            monthlyOutgoingFrequencyController.text =
                                monthlyOutgoingFrequencyItems[_index].string;
                            monthlyOutgoingFrequencyIndex = _index;
                            setState(() {});
                          }, context);
                        },
                        helperText: 'Monthly frequency of outgoing payments.',
                        hintText: 'Monthly frequency'),
                  ),
                  const Gap(52)
                ],
              ),
            ),
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
