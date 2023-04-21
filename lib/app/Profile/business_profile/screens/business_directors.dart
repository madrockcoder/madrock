import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/Profile/business_profile/screens/business_owners.dart';
import 'package:geniuspay/app/Profile/business_profile/widgets/custom_text_field.dart';
import 'package:geniuspay/app/shared_widgets/custom_section_heading.dart';
import 'package:geniuspay/app/shared_widgets/custom_yellow_elevated_button.dart';
import 'package:geniuspay/core/injections/injections.dart';
import 'package:geniuspay/models/business_profile_model.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:intl/intl.dart';

class BusinessDirectors extends StatefulWidget {
  static Future<void> show(
      BuildContext context, BusinessProfileModel businessProfileModel,
      {bool isUpdate = false}) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BusinessDirectors(
            businessProfileModel: businessProfileModel, isUpdate: isUpdate),
      ),
    );
  }

  final BusinessProfileModel businessProfileModel;
  final bool isUpdate;

  const BusinessDirectors(
      {Key? key, required this.businessProfileModel, required this.isUpdate})
      : super(key: key);

  @override
  State<BusinessDirectors> createState() => _BusinessDirectorsState();
}

class _BusinessDirectorsState extends State<BusinessDirectors> {
  DateTime? selectedDate;

  final _formKey = GlobalKey<FormState>();

  late List<BusinessDirector> directors;

  bool get areAllImportantFieldsFilled =>
      directors
              .where((director) =>
                  director.firstNameController.text.trim().isNotEmpty &&
                  director.lastNameController.text.trim().isNotEmpty &&
                  director.dobController.text.trim().isNotEmpty)
              .toList()
              .length ==
          directors.length &&
      directors.isNotEmpty &&
      (_formKey.currentState?.validate() ?? false);

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

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
    if (widget.isUpdate) {
      directors = widget.businessProfileModel.directors!;
      for (var d in directors) {
        d.dobController.text = d.dob ?? '';
        d.firstNameController.text = d.firstName;
        d.lastNameController.text = d.lastName;
      }
    } else {
      final auth = sl<AuthenticationService>();
      directors = [
        BusinessDirector(
            firstName: auth.user!.firstName,
            lastName: auth.user!.lastName,
            dob: auth.user!.userProfile.birthDate)
      ];
      var d = directors[0];
      d.dobController.text = d.dob?.substring(0, 10) ?? '';
      d.firstNameController.text = d.firstName;
      d.lastNameController.text = d.lastName;
    }
    super.initState();
  }

  bool isAdult(int index) => DateFormat('yyyy-MM-dd')
      .parse(directors[index].dobController.text)
      .add(const Duration(days: 6575))
      .isBefore(DateTime.now());

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
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                height: directors.length <= 1
                    ? MediaQuery.of(context).size.height * 0.88
                    : null,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomSectionHeading(
                      heading: "Business directors",
                      headingAndChildGap: 8,
                      topSpacing: 8,
                      headingTextStyle: textTheme.displayMedium?.copyWith(
                          fontSize: 20, color: AppColor.kSecondaryColor),
                      child: Text(
                        "We need to know the names and date of births for all directors as they appear in any official record. As a regulated payments processor, we must collect these details to meet our regulatory requirements.",
                        style: textTheme.bodyMedium
                            ?.copyWith(color: AppColor.kPinDesColor),
                      ),
                    ),
                    const Gap(24),
                    for (int index = 0; index < directors.length; index++) ...[
                      Row(
                        children: [
                          Text(
                            'Business director ${index + 1}',
                            style: textTheme.bodyLarge
                                ?.copyWith(color: AppColor.kSecondaryColor),
                          ),
                          const Spacer(),
                          if (index != 0)
                            InkWell(
                                onTap: () {
                                  directors.removeAt(index);
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
                                controller:
                                    directors[index].firstNameController,
                                focusNode: directors[index].firstNameFocusNode,
                                setState: setState,
                                readOnly: index == 0,
                                hintText: 'First name'),
                          ),
                          const Gap(8),
                          Flexible(
                            child: CustomTextField(
                                controller: directors[index].lastNameController,
                                focusNode: directors[index].lastNameFocusNode,
                                setState: setState,
                                readOnly: index == 0,
                                hintText: 'Last name'),
                          ),
                        ],
                      ),
                      const Gap(12),
                      CustomTextField(
                          controller: directors[index].dobController,
                          focusNode: directors[index].dobFocusNode,
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
                          onTap: () async {
                            if (index != 0) {
                              String date = await _selectDate(context);
                              directors[index].dobController.text = date;
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
                              directors.add(BusinessDirector(
                                  firstName: '', lastName: '', dob: ''));
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
                          Text('Add another business director',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith())
                        ],
                      ),
                    ),
                    directors.length <= 1 ? const Spacer() : const Gap(36),
                    CustomYellowElevatedButton(
                      onTap: () {
                        List<BusinessDirector> _directors = [];
                        AuthenticationService _auth =
                            sl<AuthenticationService>();
                        for (var d in directors) {
                          _directors.add(BusinessDirector(
                              firstName: d.firstNameController.text,
                              lastName: d.lastNameController.text,
                              dob: d.dobController.text,
                              address: _auth.user!.userProfile.addresses
                                  ?.toRegisteredAddress()));
                        }
                        widget.businessProfileModel.directors = _directors;
                        if (!widget.isUpdate) {
                          BusinessOwners.show(
                              context, widget.businessProfileModel);
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
