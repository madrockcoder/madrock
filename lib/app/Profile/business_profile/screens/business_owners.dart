import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/Profile/business_profile/screens/turnover.dart';
import 'package:geniuspay/app/Profile/business_profile/screens/ultimate_beneficial_owners.dart';
import 'package:geniuspay/app/Profile/business_profile/widgets/custom_text_field.dart';
import 'package:geniuspay/app/shared_widgets/custom_checkbox.dart';
import 'package:geniuspay/app/shared_widgets/custom_section_heading.dart';
import 'package:geniuspay/app/shared_widgets/custom_yellow_elevated_button.dart';
import 'package:geniuspay/core/injections/injections.dart';
import 'package:geniuspay/models/business_profile_model.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:intl/intl.dart';

class BusinessOwners extends StatefulWidget {
  static Future<void> show(
      BuildContext context, BusinessProfileModel businessProfileModel,
      {bool isUpdate = false}) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BusinessOwners(
            businessProfileModel: businessProfileModel, isUpdate: isUpdate),
      ),
    );
  }

  final BusinessProfileModel businessProfileModel;
  final bool isUpdate;

  const BusinessOwners(
      {Key? key, required this.businessProfileModel, required this.isUpdate})
      : super(key: key);

  @override
  State<BusinessOwners> createState() => _BusinessOwnersState();
}

class _BusinessOwnersState extends State<BusinessOwners> {
  DateTime? selectedDate;

  final int? _isChecked = 0;

  late List<BusinessOwner> owners;

  bool termsAccepted = false;

  final _formKey = GlobalKey<FormState>();

  bool get areAllImportantFieldsFilled =>
      owners
              .where((owner) =>
                  owner.firstNameController.text.trim().isNotEmpty &&
                  owner.lastNameController.text.trim().isNotEmpty &&
                  owner.dobController.text.trim().isNotEmpty)
              .toList()
              .length ==
          owners.length &&
      (owners.isNotEmpty
          ? (owners
                  .map((e) => double.tryParse(e.percentageController.text) ?? 0)
                  .toList()
                  .reduce((a, b) => a + b) ==
              100)
          : true) &&
      termsAccepted &&
      _formKey.currentState!.validate();

  Future<String> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: AppColor.kSecondaryColor, // header background color
                onPrimary: Colors.white, // header text color
                onSurface: Colors.black, // body text color
              ),
            ),
            child: child!,
          );
        },
        context: context,
        initialDate: selectedDate ?? DateTime(1999),
        firstDate: DateTime(1920),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      return DateFormat('yyyy-MM-dd').format(selectedDate!);
    } else {
      return '';
    }
  }

  bool isAdult(int index) => DateFormat('yyyy-MM-dd')
      .parse(owners[index].dobController.text)
      .add(const Duration(days: 6575))
      .isBefore(DateTime.now());

  @override
  void initState() {
    if (widget.isUpdate) {
      owners = widget.businessProfileModel.beneficialOwners!;
      for (var d in owners) {
        d.dobController.text = d.dob;
        d.firstNameController.text = d.firstName;
        d.lastNameController.text = d.lastName;
        d.percentageController.text = d.percentage.toStringAsFixed(2);
      }
    } else {
      final AuthenticationService _auth = sl<AuthenticationService>();
      owners = [
        BusinessOwner(
            firstName: _auth.user!.firstName,
            lastName: _auth.user!.lastName,
            dob: _auth.user!.userProfile.birthDate!,
            percentage: 100)
      ];
      var d = owners[0];
      d.dobController.text = d.dob.substring(0, 10);
      d.percentageController.text = d.percentage.toStringAsFixed(2);
      d.firstNameController.text = d.firstName;
      d.lastNameController.text = d.lastName;
    }
    super.initState();
  }

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
            title: const Text('')),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                height: owners.length == 1
                    ? MediaQuery.of(context).size.height * 0.88
                    : null,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomSectionHeading(
                      heading: "Business owners",
                      headingAndChildGap: 8,
                      topSpacing: 8,
                      headingTextStyle: textTheme.headline2?.copyWith(
                          fontSize: 20, color: AppColor.kSecondaryColor),
                      child: Text(
                        "We require the details of any individuals who own or control at least 25% of the business. As a regulated payments processor, we must collect these details to meet our regulatory requirements.",
                        style: textTheme.bodyText2
                            ?.copyWith(color: AppColor.kPinDesColor),
                      ),
                    ),
                    // const Gap(24),
                    // Text(
                    //   'Are there any people who own or control at least 25% of the business?',
                    //   style: textTheme.subtitle2?.copyWith(
                    //       color: AppColor.kSecondaryColor, fontSize: 14),
                    // ),
                    // const Gap(16),
                    // Row(
                    //   children: [
                    //     CustomRadioButton(
                    //         tileValue: 0,
                    //         groupValue: _isChecked,
                    //         onChanged: (value) {
                    //           setState(() => _isChecked = value);
                    //         }),
                    //     const Gap(22),
                    //     const Text('YES')
                    //   ],
                    // ),
                    // const Gap(16),
                    // Row(
                    //   children: [
                    //     CustomRadioButton(
                    //         tileValue: 1,
                    //         groupValue: _isChecked,
                    //         onChanged: (value) {
                    //           owners.clear();
                    //           setState(() => _isChecked = value);
                    //         }),
                    //     const Gap(22),
                    //     const Text('NO')
                    //   ],
                    // ),
                    const Gap(8),
                    RichText(
                      text: TextSpan(
                          text: 'Not sure? Read our ',
                          style: textTheme.bodyText2?.copyWith(
                              color: AppColor.kSecondaryColor, fontSize: 12),
                          children: [
                            TextSpan(
                              text: 'FAQs',
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () =>
                                    UltimateBeneficialOwners.show(context),
                            ),
                            const TextSpan(text: ' about business owners')
                          ]),
                    ),
                    const Gap(24),
                    if (_isChecked == 0) ...[
                      for (int index = 0; index < owners.length; index++) ...[
                        Row(
                          children: [
                            Text(
                              'Business owner ${index + 1}',
                              style: textTheme.bodyText1
                                  ?.copyWith(color: AppColor.kSecondaryColor),
                            ),
                            const Spacer(),
                            if (index != 0)
                              InkWell(
                                  onTap: () {
                                    owners.removeAt(index);
                                    if (owners.length == 1) {
                                      owners[0].percentageController.text =
                                          "100";
                                    }
                                    setState(() {});
                                  },
                                  borderRadius: BorderRadius.circular(24),
                                  child: const CircleAvatar(
                                    radius: 8,
                                    backgroundColor: AppColor.kSecondaryColor,
                                    child: Icon(
                                      Icons.close,
                                      size: 8 + 2,
                                      color: Colors.white,
                                    ),
                                  ))
                          ],
                        ),
                        const Gap(8),
                        Row(
                          children: [
                            Flexible(
                              child: CustomTextField(
                                  controller: owners[index].firstNameController,
                                  setState: setState,
                                  focusNode: owners[index].firstNameFocusNode,
                                  readOnly: index == 0,
                                  hintText: 'First name'),
                            ),
                            const Gap(8),
                            Flexible(
                              child: CustomTextField(
                                  controller: owners[index].lastNameController,
                                  setState: setState,
                                  focusNode: owners[index].lastNameFocusNode,
                                  readOnly: index == 0,
                                  hintText: 'Last name'),
                            ),
                          ],
                        ),
                        if (owners.length != 1) ...[
                          const Gap(12),
                          CustomTextField(
                              controller: owners[index].percentageController,
                              setState: setState,
                              validator: (val) {
                                if ((double.tryParse(val ?? '') ?? 0) > 100) {
                                  return 'A  UBO share percentage can be between 25 - 100';
                                } else if (owners
                                        .map((e) =>
                                            double.tryParse(
                                                e.percentageController.text) ??
                                            0)
                                        .toList()
                                        .reduce((a, b) => a + b) >
                                    100) {
                                  return 'Total share % of all owners should not exceed 100%';
                                }
                                return null;
                              },
                              focusNode: owners[index].percentageFocusNode,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              hintText: 'Percentage shares'),
                        ],
                        const Gap(12),
                        CustomTextField(
                            controller: owners[index].dobController,
                            setState: setState,
                            validator: (val) {
                              if (val?.isNotEmpty ?? false) {
                                if (isAdult(index)) {
                                  return null;
                                } else {
                                  return 'Selected DOB should be 18+';
                                }
                              } else {
                                return null;
                              }
                            },
                            focusNode: owners[index].dobFocusNode,
                            onTap: () async {
                              if (index != 0) {
                                String date = await _selectDate(context);
                                owners[index].dobController.text = date;
                                setState(() {});
                              }
                            },
                            readOnly: true,
                            hintText: 'Date of birth (yyyy-mm-dd)'),
                        const Gap(16),
                      ],
                      Center(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (owners.length == 1) {
                                  owners[0].percentageController.text = '';
                                }
                                owners.add(BusinessOwner(
                                    firstName: '',
                                    lastName: '',
                                    dob: '',
                                    percentage: owners.isEmpty ? 100 : 0));
                                setState(() {});
                              },
                              child: const CircleAvatar(
                                backgroundColor: AppColor.kAccentColor2,
                                radius: 20,
                                child: Icon(
                                  Icons.add,
                                  size: 25,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text('Add another business owner',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith())
                          ],
                        ),
                      ),
                    ],
                    owners.length == 1 ? const Spacer() : const Gap(36),
                    if (owners.isNotEmpty) ...[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomCheckbox(
                            values: termsAccepted ? [0] : [],
                            tileValue: 0,
                            onChanged: () {
                              termsAccepted = !termsAccepted;
                              setState(() {});
                            },
                            checkboxShape: CustomCheckboxShape.rectangle,
                          ),
                          const Gap(10),
                          Flexible(
                            child: Text(
                              'I can confirm I have provided accurate details of all individuals owning or controlling more than 25% of the company’s shares or voting rights.',
                              style: textTheme.bodyText2?.copyWith(
                                  color: AppColor.kPinDesColor, fontSize: 10),
                            ),
                          )
                        ],
                      ),
                      const Gap(16),
                    ],
                    CustomYellowElevatedButton(
                      onTap: () {
                        List<BusinessOwner> _owners = [];
                        AuthenticationService _auth =
                            sl<AuthenticationService>();
                        for (var d in owners) {
                          _owners.add(BusinessOwner(
                              firstName: d.firstNameController.text,
                              lastName: d.lastNameController.text,
                              dob: d.dobController.text,
                              percentage:
                                  double.parse(d.percentageController.text),
                              address: _auth.user!.userProfile.addresses
                                  ?.toRegisteredAddress()));
                        }
                        widget.businessProfileModel.beneficialOwners = _owners;
                        if (!widget.isUpdate) {
                          Turnover.show(context, widget.businessProfileModel);
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      disable: !areAllImportantFieldsFilled,
                      text: 'CONTINUE',
                    ),
                    const Gap(24)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
