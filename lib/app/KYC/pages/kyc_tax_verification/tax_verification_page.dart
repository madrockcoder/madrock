import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/KYC/view_models.dart/kyc_view_model.dart';
import 'package:geniuspay/app/auth/pages/sign_up/widgets/auth_provider.dart';
import 'package:geniuspay/app/auth/pages/sign_up/widgets/waring_widget.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button_async.dart';
import 'package:geniuspay/app/shared_widgets/custom_text_field.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/widgets_util.dart';
import 'package:provider/provider.dart';

class KYCTaxVerificationPage extends StatefulWidget {
  const KYCTaxVerificationPage({
    Key? key,
    required this.authProvider,
  }) : super(key: key);
  final AuthProvider authProvider;
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) =>
              Consumer<AuthProvider>(builder: (_, authProvider, __) {
            return KYCTaxVerificationPage(
              authProvider: authProvider,
            );
          }),
        ),
        ((route) => false));
  }

  @override
  State<KYCTaxVerificationPage> createState() => _KYCTaxVerificationPageState();
}

class _KYCTaxVerificationPageState extends State<KYCTaxVerificationPage> {
  final _taxNoController = TextEditingController();
  final _taxNoFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BaseView<KycViewModel>(builder: (context, model, snapshot) {
      return Scaffold(
        appBar: WidgetsUtil.onBoardingAppBar(
          context,
          title: 'Tax number',
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'For tax reporting purposes, please enter your Tax identification number for ${model.currentUser?.userProfile.countryIso2}.',
                          style: textTheme.bodyMedium?.copyWith(
                            fontSize: 14,
                          ),
                        ),
                        const Gap(20),
                        CustomTextField(
                          validationColor:
                              _taxNoFocus.hasFocus && model.peselNumber.isEmpty
                                  ? AppColor.kAlertColor2
                                  : AppColor.kSecondaryColor,
                          fillColor: _taxNoFocus.hasFocus
                              ? AppColor.kAccentColor2
                              : Colors.transparent,
                          controller: _taxNoController,
                          height: 60,
                          radius: 9,
                          fieldFocusNode: _taxNoFocus,
                          keyboardType: TextInputType.number,
                          label: 'Tax ID',
                          hint: 'Tax ID',
                          // onSaved: (e) => widget.authProvider.updateWith(email: e),
                          onChanged: (_) {
                            model.peselNumber = _;
                            // setDisableButton();
                          },
                        ),
                        const Gap(5),
                        const WarningWidget(
                          backgroundColor: Colors.transparent,
                          title:
                              'Remember, it\'s very important that the code is correct as per your documents.',
                          textColor: AppColor.kSecondaryColor,
                        )
                      ],
                    ),
                  ),
                ),
                CustomElevatedButtonAsync(
                  color: AppColor.kGoldColor2,
                  disabledColor: AppColor.kAccentColor3,
                  child: Text(
                    'CONTINUE',
                    style: textTheme.bodyLarge,
                  ),
                  onPressed: model.peselNumber.isEmpty
                      ? null
                      : () async {
                          await model.taxAssessment(
                              context, _taxNoController.text);
                        },
                ),
                const Gap(20),
                CustomElevatedButtonAsync(
                  color: Colors.white,
                  child: Text(
                    "CAN'T PROVIDE TAX ID",
                    style: textTheme.bodyLarge,
                  ),
                  onPressed: () async {
                    // showModalBottomSheet(
                    //     context: context,
                    //     builder: (context) {
                    //       return ListView(
                    //         padding: const EdgeInsets.all(24),
                    //         children: [
                    //           Text(
                    //             'Why a not? ',
                    //             style: textTheme.headline3,
                    //           ),
                    //           const Gap(32),
                    //           ListTile(
                    //             title: Text('NOT_ASSIGNED_YET'),
                    //           ),
                    //           ListTile(
                    //             title: Text('NOT_ASSIGNED_BY_COUNTRY'),
                    //           ),
                    //         ],
                    //       );
                    //     });
                    // await model.taxAssessment(context, null);
                    // await model.getUser(context);
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
