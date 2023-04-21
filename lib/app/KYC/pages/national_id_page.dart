import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/KYC/pages/kyc_risk_assesment/pep_status_question_page.dart';
import 'package:geniuspay/app/KYC/pages/kyc_risk_assesment/equivalent_page.dart';
import 'package:geniuspay/app/KYC/view_models.dart/kyc_view_model.dart';
import 'package:geniuspay/app/auth/pages/sign_up/widgets/waring_widget.dart';
import 'package:geniuspay/app/shared_widgets/continue_button.dart';
import 'package:geniuspay/app/shared_widgets/country_flag_container.dart';
import 'package:geniuspay/app/shared_widgets/custom_text_field.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/widgets_util.dart';

class NationalIdPage extends StatefulWidget {
  const NationalIdPage({
    Key? key,
  }) : super(key: key);

  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const NationalIdPage(),
      ),
    );
  }

  @override
  State<NationalIdPage> createState() => _NationalIdPageState();
}

class _NationalIdPageState extends State<NationalIdPage> {
  final _nationalIdController = TextEditingController();
  final _nationalIdFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BaseView<KycViewModel>(builder: (context, model, snapshot) {
      return Scaffold(
        appBar: WidgetsUtil.onBoardingAppBar(
          context,
          title: 'National ID Number',
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
                        Row(
                          children: [
                            CountryFlagContainer(flag: model.taxCountry!.iso2),
                            const Gap(10),
                            Text(
                              '${model.taxCountry?.name}',
                              style: textTheme.bodyMedium?.copyWith(
                                fontSize: 16,
                                color: AppColor.kSecondaryColor,
                              ),
                            ),
                          ],
                        ),
                        const Gap(20),
                        Text.rich(
                          TextSpan(
                            text: 'Enter your national ID number for ',
                            style: textTheme.bodyMedium?.copyWith(
                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                text: model.taxCountry?.name,
                                style: textTheme.bodyMedium?.copyWith(
                                  fontSize: 14,
                                  color: AppColor.kSecondaryColor,
                                ),
                              )
                            ],
                          ),
                        ),
                        const Gap(8),
                        CustomTextField(
                          validationColor: _nationalIdFocus.hasFocus &&
                                  model.idNumber.isEmpty
                              ? AppColor.kAlertColor2
                              : AppColor.kSecondaryColor,
                          fillColor: _nationalIdFocus.hasFocus
                              ? AppColor.kAccentColor2
                              : Colors.transparent,
                          controller: _nationalIdController,
                          height: 60,
                          radius: 9,
                          fieldFocusNode: _nationalIdFocus,
                          // enabled: InputBorder.none,

                          keyboardType: TextInputType.text,
                          label: 'National ID Number',
                          hint: 'National ID Number',
                          // onSaved: (e) => widget.authProvider.updateWith(email: e),
                          onChanged: (_) {
                            model.idNumber = _;
                          },
                        ),
                        const Gap(8),
                        WarningWidget(
                          title: 'What\'s national ID number or its equivalent?',
                          textColor: AppColor.kSecondaryColor,
                          backgroundColor: Colors.transparent,
                          onTap: () {
                            EquivalentPage.show(
                              context: context,
                              title: 'Equivalent',
                              firstText: 'National ID number',
                              firstSubText:
                                  'A Taxpayer Identification Number or a national ID number, is a unique combination of characters assigned by a country\'s tax authority to a person (individual or entity) and used to identify that person for the purposes od administering the country\'s tax laws.',
                              secondText: 'Functional equivalent',
                              secondSubText:
                                  'In some countries, another high integrity number with an equivalent level of identification (a funcional equivalent) may be used instead of a natiopnal ID number to identify a particular person.',
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                ContinueButton(
                  context: context,
                  color: AppColor.kGoldColor2,
                  textColor: Colors.black,
                  disabledColor: AppColor.kAccentColor3,
                  disable: model.idNumber.isEmpty,
                  isLoading: model.busy,
                  onPressed: model.idNumber.isEmpty
                      ? null
                      : () async {
                          // await model.taxAssessment(context);
                        },
                ),
                const Gap(20),
                TextButton(
                  onPressed: () {
                    PepStatusQuestionPage.show(context);
                  },
                  child: Text(
                    'CAN\'T PROVIDE ID NUMBER ',
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Gap(20),
              ],
            ),
          ),
        ),
      );
    });
  }
}
