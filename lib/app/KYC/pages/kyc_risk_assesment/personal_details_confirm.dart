import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/KYC/view_models.dart/kyc_view_model.dart';
import 'package:geniuspay/app/shared_widgets/continue_button.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button_async.dart';
import 'package:geniuspay/app/shared_widgets/textfield_decoration.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/widgets_util.dart';
import 'package:intl/intl.dart';

class PersonalDetailsConfirmPage extends StatefulWidget {
  const PersonalDetailsConfirmPage({
    Key? key,
  }) : super(key: key);

  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const PersonalDetailsConfirmPage(),
      ),
    );
  }

  @override
  State<PersonalDetailsConfirmPage> createState() =>
      _PersonalDetailsConfirmPageState();
}

class _PersonalDetailsConfirmPageState
    extends State<PersonalDetailsConfirmPage> {
  bool manualDetails = false;
  var _firstNameController = TextEditingController();
  final _firstNameFocus = FocusNode();
  var _lastNameController = TextEditingController();
  final _lastNameFocus = FocusNode();
  var _DOBController = TextEditingController();
  final _DOBFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BaseView<KycViewModel>(onModelReady: (p0) async {
      _firstNameController = TextEditingController(text: p0.user?.firstName);
      _lastNameController = TextEditingController(text: p0.user?.lastName);
      _DOBController =
          TextEditingController(text: p0.user?.userProfile.birthDate);
      await p0.getUser(context);
      setState(() {
        _firstNameController = TextEditingController(text: p0.user!.firstName);
        _lastNameController = TextEditingController(text: p0.user!.lastName);
        _DOBController =
            TextEditingController(text: p0.user!.userProfile.birthDate);
      });
    }, builder: (context, model, snapshot) {
      return Scaffold(
        appBar: WidgetsUtil.onBoardingAppBar(
          context,
          title: '',
        ),
        body: Form(
            key: _formKey,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Sub header text
                            Text(
                              'Please confirm your details',
                              style: textTheme.bodyText1?.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColor.kSecondaryColor,
                              ),
                            ),
                            const Gap(48),

                            //First Name
                            TextFormField(
                              enabled: manualDetails,
                              controller: _firstNameController,
                              inputFormatters: [
                                FilteringTextInputFormatter(RegExp(r'[a-zA-Z]'),
                                    allow: true),
                              ],
                              decoration: TextFieldDecoration(
                                focusNode: _firstNameFocus,
                                context: context,
                                hintText: "First Name",
                                onClearTap: () {
                                  if (manualDetails) {
                                    setState(() {
                                      _firstNameController.clear();
                                    });
                                    _firstNameFocus.requestFocus();
                                  }
                                },
                                controller: _firstNameController,
                              ).inputDecoration(),
                              focusNode: _firstNameFocus,
                              keyboardType: TextInputType.name,
                              onChanged: (val) {
                                setState(() {});
                              },
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'First name cannot be empty';
                                } else if (val.length < 2) {
                                  return 'Minimum 2 characters required';
                                } /* else if (model.nameValidator.isValidAlphabetText(val)) {
                                  return 'First name cannot contain numbers';
                                }*/
                                return null;
                              },
                            ),
                            const Gap(16),

                            //Last Name
                            TextFormField(
                              enabled: manualDetails,
                              controller: _lastNameController,
                              inputFormatters: [
                                FilteringTextInputFormatter(RegExp(r'[a-zA-Z]'),
                                    allow: true),
                              ],
                              decoration: TextFieldDecoration(
                                context: context,
                                focusNode: _lastNameFocus,
                                hintText: "Last Name",
                                onClearTap: () {
                                  if (manualDetails) {
                                    setState(() {
                                      _lastNameController.clear();
                                    });
                                    _lastNameFocus.requestFocus();
                                  }
                                },
                                controller: _lastNameController,
                              ).inputDecoration(),
                              focusNode: _lastNameFocus,
                              keyboardType: TextInputType.name,
                              onChanged: (val) {
                                setState(() {});
                              },
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Last name cannot be empty';
                                } else if (val.length < 2) {
                                  return 'Minimum 2 characters required';
                                } /*else if (model.nameValidator.isValidAlphabetText(val)) {
                                  return 'Last name cannot contain numbers';
                                }*/
                                return null;
                              },
                            ),
                            const Gap(16),

                            //Date of Birth
                            TextFormField(
                              enabled: manualDetails,
                              onTap: () {
                                _selectDate();
                              },
                              controller: _DOBController,
                              decoration: TextFieldDecoration(
                                focusNode: _DOBFocus,
                                context: context,
                                hintText: "Date of birth",
                                onClearTap: () {
                                  if (manualDetails) {
                                    setState(() {
                                      _DOBController.clear();
                                    });
                                  }
                                },
                                controller: _DOBController,
                              ).inputDecoration(),
                              onChanged: (val) {
                                setState(() {});
                              },
                              textInputAction: TextInputAction.none,
                              keyboardType: TextInputType.none,
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Date of birth cannot be empty';
                                }
                                return null;
                              },
                            ),
                            const Gap(16),
                          ],
                        ),
                      ),
                    ),

                    //Primary YES Button
                    CustomElevatedButtonAsync(
                      color: AppColor.kGoldColor2,
                      child: Text(
                        'YES, ALL IS CORRECT',
                        style: textTheme.bodyText1,
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (manualDetails) {
                            await model.enterManualDetails(
                                context,
                                _firstNameController.text,
                                _lastNameController.text,
                                _DOBController.text);
                            if (model.manualDetailsEntered) {
                              await model.riskAssessment(context);
                            }
                          } else {
                            await model.riskAssessment(context);
                          }
                        }
                      },
                    ),

                    //Secondary NO Button
                    Center(
                      child: TextButton(
                        onPressed: () async {
                          final result = await showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return const PersonalDetailsModal();
                            },
                          );
                          if (result == true) {
                            setState(() {
                              manualDetails = true;
                            });
                            WidgetsBinding.instance
                                .addPostFrameCallback((_) async {
                              _firstNameFocus.requestFocus();
                            });
                          }
                        },
                        child: Text(
                          'NO, SOMETHING IS WRONG ',
                          style: textTheme.bodyText2?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      );
    });
  }

  Future _selectDate() async {
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
        initialDate: DateTime(1999),
        firstDate: DateTime(1920),
        lastDate: DateTime.now());
    if (picked != null) {
      setState(
          () => _DOBController.text = DateFormat('yyy-MM-dd').format(picked));
    }
  }
}

class PersonalDetailsModal extends StatefulWidget {
  const PersonalDetailsModal({
    Key? key,
  }) : super(key: key);

  @override
  State<PersonalDetailsModal> createState() => _PersonalDetailsModalState();
}

class _PersonalDetailsModalState extends State<PersonalDetailsModal> {
  bool firstName = false;
  bool lastName = false;
  bool DOB = false;
  Widget _checkListTile(
      {required String title,
      required bool selected,
      required Function() onTap}) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
        splashColor: AppColor.kAccentColor2,
        highlightColor: AppColor.kAccentColor2,
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                      color: selected
                          ? AppColor.kSecondaryColor
                          : AppColor.kWhiteColor,
                      border:
                          Border.all(width: 1, color: AppColor.kSecondaryColor),
                      shape: BoxShape.circle),
                  child: selected
                      ? const Icon(
                          Icons.check,
                          size: 8,
                          color: Colors.white,
                        )
                      : null,
                ),
                const Gap(10),
                Text(
                  title,
                  style: textTheme.bodyText1
                      ?.copyWith(color: AppColor.kSecondaryColor, fontSize: 16),
                ),
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 34),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(20),
          Text(
            'What exactly is wrong?',
            style: textTheme.bodyText1?.copyWith(
              fontSize: 18,
            ),
          ),
          const Gap(20),
          _checkListTile(
              title: 'First name',
              selected: firstName,
              onTap: () {
                setState(() {
                  firstName = !firstName;
                });
              }),
          _checkListTile(
              title: 'Last name',
              selected: lastName,
              onTap: () {
                setState(() {
                  lastName = !lastName;
                });
              }),
          _checkListTile(
              title: 'Date of birth',
              selected: DOB,
              onTap: () {
                setState(() {
                  DOB = !DOB;
                });
              }),
          const Gap(30),
          ContinueButton(
            context: context,
            color: AppColor.kGoldColor2,
            textColor: Colors.black,
            text: 'CONFIRM',
            onPressed: firstName || lastName || DOB
                ? () async {
                    Navigator.pop(context, true);
                  }
                : null,
          ),
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'OOPS! ALL IS OK ',
                style: textTheme.bodyText2?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
