import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/KYC/pages/kyc_risk_assesment/equivalent_page.dart';
import 'package:geniuspay/app/KYC/pages/kyc_risk_assesment/pep_status_question_page.dart';
import 'package:geniuspay/app/KYC/view_models.dart/kyc_view_model.dart';
import 'package:geniuspay/app/shared_widgets/continue_button.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/widgets_util.dart';

class UsPersonScreen extends StatefulWidget {
  const UsPersonScreen({Key? key}) : super(key: key);

  static Future<void> show(
    BuildContext context,
  ) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const UsPersonScreen(),
      ),
    );
  }

  @override
  State<UsPersonScreen> createState() => _UsPersonScreenState();
}

class _UsPersonScreenState extends State<UsPersonScreen> {
  bool isUsPerson = false;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BaseView<KycViewModel>(builder: (context, model, snapshot) {
      return Scaffold(
        appBar: WidgetsUtil.onBoardingAppBar(
          context,
          title: 'Are you a “US Person”?',
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Please, let us know if you are a US person and have to pay taxes in the United States',
                style: textTheme.bodyMedium?.copyWith(
                  fontSize: 14,
                ),
              ),
              const Gap(20),
              USPersonWidget(
                textTheme: textTheme,
                text: 'No, I am not a “US Person”',
                selected: model.isUs != null && !model.isUs!,
                onTap: () {
                  model.setIsUs = false;
                },
              ),
              USPersonWidget(
                textTheme: textTheme,
                text: 'Yes, I am a “US Person”',
                selected: model.isUs != null && model.isUs!,
                onTap: () {
                  model.setIsUs = true;
                },
              ),
              const Spacer(),
              ContinueButton(
                context: context,
                color: AppColor.kGoldColor2,
                disabledColor: AppColor.kAccentColor3,
                disable: model.isUs == null,
                onPressed: model.isUs == null
                    ? null
                    : () async {
                        PepStatusQuestionPage.show(context);
                      },
              ),
              const Gap(20),
              Center(
                child: TextButton(
                  onPressed: () => EquivalentPage.show(
                      context: context,
                      title: 'Equivalent',
                      firstText: 'United States IRS Definition of US Person',
                      firstSubText:
                          'All United States tax laws and regulations apply to every US Person whether he/she is working in the United States or in a foreign country. When it comes to your international tax obligations, it\'s important to understand exactly how ‘US Person\' is defined by the IRS and what it means to you. Failure to understand your tax responsibilities as a US Person can result in hefty penaltes associated with your US expat tax liability.',
                      secondText: 'United States Citizens Born Outside of the United States',
                      secondSubText: "If you were born outside of the United States and have dual citizenship with the US  and the foreign country in which you were born you have a different set of options - especially i fyou’ve never lived in the United States. It’s important to realize, however, that - until you exercise those options - you are still considered a US Person for tax reporting purposes, and you must meet all your US tax obligations. If you wish to voluntary terminate your US Citizenship to avoid being responsible for US taxes, you have the right to do so."),
                  child: Text(
                    'WHO IS A US PERSON?',
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const Gap(20)
            ],
          ),
        ),
      );
    });
  }
}

class USPersonWidget extends StatelessWidget {
  const USPersonWidget(
      {Key? key,
      required this.textTheme,
      this.selected = false,
      required this.text,
      required this.onTap})
      : super(key: key);

  final TextTheme textTheme;
  final String text;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Container(
              height: 12,
              width: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? AppColor.kSecondaryColor : Colors.transparent,
                border: Border.all(color: AppColor.kSecondaryColor),
              ),
              child: selected
                  ? const Center(
                      child: Icon(
                        Icons.done,
                        size: 10,
                        color: Colors.white,
                      ),
                    )
                  : const SizedBox(),
            ),
            const Gap(10),
            Text(
              text,
              style: textTheme.bodyMedium?.copyWith(
                color: AppColor.kSecondaryColor,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
