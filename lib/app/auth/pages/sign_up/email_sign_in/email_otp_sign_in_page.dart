import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/auth/pages/sign_up/widgets/terms_and_policies_page.dart';
import 'package:geniuspay/app/auth/view_models/signup_email_view_model.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button_async.dart';
import 'package:geniuspay/app/shared_widgets/textfield_decoration.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/services/firebase_dynamic_link.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/enums.dart';
import 'package:geniuspay/util/widgets_util.dart';

import '../widgets/shared_functions.dart';
import '../widgets/validators.dart';

class EmailOTPSignInPage extends StatefulWidget
    with SignInValidators, SharedFunctions {
  EmailOTPSignInPage({
    Key? key,
  }) : super(key: key);

  static Future<void> show(BuildContext context,
      {bool replacePage = false}) async {
    if (!replacePage) {
      await Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => EmailOTPSignInPage()),
      );
    } else {
      await Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => EmailOTPSignInPage()),
        ((route) => route.isFirst),
      );
    }
  }

  @override
  State<EmailOTPSignInPage> createState() => _EmailOTPSignInPageState();
}

class _EmailOTPSignInPageState extends State<EmailOTPSignInPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _inviteCodeController = TextEditingController();
  final _emailFocus = FocusNode();
  final _inviteCodeFocus = FocusNode();
  late Image logoImage;

  @override
  void initState() {
    logoImage = Image.asset(
      'assets/images/logo.png',
      height: 32,
      width: 140,
    );
    if (DynamicLinkService.inviteCode.isNotEmpty) {
      _inviteCodeController.text = DynamicLinkService.inviteCode;
    }
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BaseView<SignupEmailViewModel>(
      builder: (context, model, snapshot) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: WidgetsUtil.onBoardingAppBar(context, title: 'Sign up'),
          body: Form(
              key: _formKey,
              child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Logo
                      logoImage,
                      const Gap(32),

                      //Email
                      TextFormField(
                        controller: _emailController,
                        decoration: TextFieldDecoration(
                          focusNode: _emailFocus,
                          hintText: 'Email',
                          context: context,
                          onClearTap: () {
                            setState(() {
                              _emailController.clear();
                            });
                            _emailFocus.requestFocus();
                          },
                          controller: _emailController,
                        ).inputDecoration(),
                        focusNode: _emailFocus,
                        keyboardType: TextInputType.emailAddress,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (val) {},
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Email can't be empty";
                          } else if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(val)) {
                            return "Please enter a valid Email address";
                          }
                          return null;
                        },
                      ),
                      const Gap(8),

                      //Invite Code
                      TextFormField(
                        controller: _inviteCodeController,
                        decoration: TextFieldDecoration(
                          focusNode: _inviteCodeFocus,
                          context: context,
                          hintText: 'Invite Code (optional)',
                          onClearTap: () {
                            setState(() {
                              _inviteCodeController.clear();
                            });
                            _inviteCodeFocus.requestFocus();
                          },
                          controller: _inviteCodeController,
                        ).inputDecoration(),
                        focusNode: _inviteCodeFocus,
                        keyboardType: TextInputType.name,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (val) {
                          model.setReferralIsValid = val;
                        },
                        validator: (val) {
                          if (val!.isNotEmpty && !model.referralIsValid) {
                            return "Please enter a valid invite code";
                          }
                          return null;
                        },
                      ),
                      const Gap(8),

                      //Radio Button Content
                      Row(
                        children: [
                          Radio(
                            value: model.terms,
                            activeColor: AppColor.kSecondaryColor,
                            groupValue: true,
                            onChanged: (value) {
                              model.setTerms = true;
                              model.setDisableButton(_emailController.text);
                            },
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                style: textTheme.bodyMedium?.copyWith(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                                text: 'I agree to geniuspay\'s ',
                                children: [
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => TermsAndPoliciesPage.show(
                                          context,
                                          policy: Policy.termsAndConditions),
                                    text: 'Terms of Use',
                                    style: const TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: AppColor.kSecondaryColor),
                                  ),
                                  const TextSpan(
                                    text: ' and ',
                                  ),
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => TermsAndPoliciesPage.show(
                                          context,
                                          policy: Policy.privacyPolicy),
                                    text: 'Privacy Policy',
                                    style: const TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: AppColor.kSecondaryColor),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      const Gap(8),
                      Row(
                        children: [
                          Radio(
                            value: model.amlTerms,
                            activeColor: AppColor.kSecondaryColor,
                            groupValue: true,
                            onChanged: (value) {
                              model.setAmlTerms = true;
                              model.setDisableButton(_emailController.text);
                            },
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                style: textTheme.bodyMedium?.copyWith(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                                text:
                                    'I consent to geniuspay using the provided data, including consent for us to verify your identity with our service providers and database owners in accordance with the ',
                                children: [
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => TermsAndPoliciesPage.show(
                                          context,
                                          policy: Policy.amlPolicy),
                                    text: 'AML/KYC policy',
                                    style: const TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: AppColor.kSecondaryColor),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      const Spacer(),

                      //Submit Button
                      CustomElevatedButtonAsync(
                        color: AppColor.kGoldColor2,
                        disabledColor: AppColor.kAccentColor2,
                        child: Text(
                          'CONTINUE',
                          style: textTheme.bodyLarge,
                        ),
                        onPressed: _emailController.text.isNotEmpty &&
                                model.terms &&
                                model.amlTerms &&
                                (_formKey.currentState?.validate() ?? true)
                            ? () async {
                                if (_formKey.currentState!.validate()) {
                                  model.setEmail = _emailController.text;
                                  if (_inviteCodeController.text.isNotEmpty) {
                                    model.setReferralCode =
                                        _inviteCodeController.text;
                                  }

                                  // OtpCodePage.show(context);
                                  await model.canContinue(context);
                                }
                              }
                            : null,
                      )
                    ],
                  ))),
        );
      },
    );
  }
}
