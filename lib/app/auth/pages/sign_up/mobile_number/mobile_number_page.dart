import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/auth/pages/sign_up/country/widgets/country_list.dart';
import 'package:geniuspay/app/auth/view_models/mobile_number_view_model.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button_async.dart';
import 'package:geniuspay/app/shared_widgets/picker_container.dart';
import 'package:geniuspay/app/shared_widgets/show_draggable_scrollable_sheet.dart';
import 'package:geniuspay/app/shared_widgets/textfield_decoration.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/models/country.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/widgets_util.dart';
import 'package:phone_number/phone_number.dart';

class MobileNumberVerification extends StatefulWidget {
  final Country selectedCountry;
  final bool isLogin;
  const MobileNumberVerification(
      {Key? key, required this.selectedCountry, this.isLogin = false})
      : super(key: key);

  static Future<void> show(
      BuildContext context, Country selectedCountry, bool isLogin) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MobileNumberVerification(
          selectedCountry: selectedCountry,
          isLogin: isLogin,
        ),
      ),
    );
  }

  @override
  State<MobileNumberVerification> createState() =>
      _MobileNumberVerificationState();
}

class _MobileNumberVerificationState extends State<MobileNumberVerification> {
  final _phoneController = TextEditingController();
  late Country selectedCountry;
  final _phoneFocus = FocusNode();

  @override
  void initState() {
    selectedCountry = widget.selectedCountry;
    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void checkNumber(String number) async {
    try {
      // RegionInfo region = RegionInfo(name: selectedCountry.name, code: selectedCountry.iso2, prefix: selectedCountry.phoneCode);
      final result = await plugin.validate(number, selectedCountry.iso2);
      setState(() {
        isValidNumber = result;
      });
    } catch (e) {
      setState(() {
        isValidNumber = false;
      });
    }
  }

  final _formKey = GlobalKey<FormState>();
  PhoneNumberUtil plugin = PhoneNumberUtil();
  bool isValidNumber = false;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BaseView<MobileNumberViewModel>(
      builder: (context, model, snapshot) {
        // model.setBusy(value: false);
        return Scaffold(
          appBar: WidgetsUtil.onBoardingAppBar(context, title: 'Mobile number'),
          body: Form(
              key: _formKey,
              child: SafeArea(
                  child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        child: Column(
                          children: [
                            PickerContainer(
                              borderColor: AppColor.kSecondaryColor,
                              radius: 8,
                              hint: 'Country Code',
                              country: selectedCountry,
                              isCountryCode: true,
                              onPressed: () async {
                                _showCountryPicker(
                                    selectedCountry: selectedCountry,
                                    onTap: (country) {
                                      setState(() {
                                        selectedCountry = country;
                                      });
                                      checkNumber(_phoneController.text);
                                    });
                              },
                            ),
                            const Gap(12),
                            TextFormField(
                              controller: _phoneController,
                              decoration: TextFieldDecoration(
                                context: context,
                                focusNode: _phoneFocus,
                                hintText: 'Mobile number',
                                onClearTap: () {
                                  setState(() {
                                    _phoneController.clear();
                                  });
                                  _phoneFocus.requestFocus();
                                },
                                controller: _phoneController,
                              ).inputDecoration(),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter mobile number';
                                } else if (!isValidNumber) {
                                  return 'Please enter valid mobile number';
                                }
                                return null;
                              },
                              focusNode: _phoneFocus,
                              keyboardType: TextInputType.phone,
                              onChanged: (val) {
                                setState(() {
                                  _formKey.currentState?.validate();
                                  checkNumber(val);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    CustomElevatedButtonAsync(
                      color: AppColor.kGoldColor2,
                      disabledColor: AppColor.kAccentColor2,
                      child: Text(
                        'CONTINUE',
                        style: textTheme.bodyLarge,
                      ),
                      onPressed: _formKey.currentState?.validate() ?? false
                          ? () async {
                              ConfirmMobileNumberModal.show(
                                context: context,
                                phone:
                                    '${selectedCountry.phoneCode}${_phoneController.text.trim()}',
                                onTap: () async {
                                  await model.checkMobileNumberExists(
                                      context: context,
                                      mobileNumber:
                                          '${selectedCountry.phoneCode}${_phoneController.text.trim()}',
                                      isLogin: widget.isLogin);
                                },
                                loading: model.busy,
                              );
                            }
                          : null,
                    )
                  ],
                ),
              ))),
        );
      },
    );
  }

  Future<void> _showCountryPicker(
      {required Country? selectedCountry,
      required Function(Country country) onTap}) async {
    await showCustomScrollableSheet(
        context: context,
        child: CountryListWidget(
          selectedCountry: selectedCountry,
          onTap: onTap,
          showPhoneCode: true,
        ));
  }
}

class ConfirmMobileNumberModal extends StatelessWidget {
  const ConfirmMobileNumberModal(
      {Key? key,
      required this.phone,
      required this.onTap,
      required this.loading})
      : super(key: key);

  final String phone;
  final Function() onTap;
  final bool? loading;
  static show({
    required BuildContext context,
    required String phone,
    required VoidCallback onTap,
    required bool? loading,
  }) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      builder: (context) {
        return ConfirmMobileNumberModal(
          phone: phone,
          onTap: onTap,
          loading: loading,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.46,
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.clear,
                            color: AppColor.kSecondaryColor,
                          ))
                    ],
                  ),
                  const Gap(16),
                  Text(
                    phone,
                    style: textTheme.bodyLarge?.copyWith(
                      fontSize: 20,
                      color: AppColor.kSecondaryColor,
                    ),
                  ),
                  Text(
                    'Make sure we have the right phone\nnumber connected to your account.',
                    style: textTheme.bodyMedium?.copyWith(fontSize: 16),
                  ),
                  const Gap(24),
                  CustomElevatedButtonAsync(
                    color: AppColor.kGoldColor2,
                    disabledColor: AppColor.kAccentColor3,
                    child: Text(
                      "YEP, THAT'S RIGHT",
                      style: textTheme.bodyLarge,
                    ),
                    onPressed: () async {
                      await onTap();
                    },
                  ),
                  const Gap(50)
                ],
              ),
            ),
            Positioned(
              height: 130,
              width: 130,
              top: 0,
              child: SvgPicture.asset(
                'assets/icons/modal_icon.svg',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
