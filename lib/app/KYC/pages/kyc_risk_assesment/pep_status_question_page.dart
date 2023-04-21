import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/KYC/pages/kyc_risk_assesment/account_purpose_page.dart';
import 'package:geniuspay/app/KYC/pages/kyc_risk_assesment/pep_status_question.dart';
import 'package:geniuspay/app/KYC/view_models.dart/kyc_view_model.dart';
import 'package:geniuspay/app/shared_widgets/continue_button.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/widgets_util.dart';

class PepStatusQuestionPage extends StatelessWidget {
  const PepStatusQuestionPage({Key? key}) : super(key: key);
  static Future<void> show(
    BuildContext context,
  ) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const PepStatusQuestionPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BaseView<KycViewModel>(builder: (context, model, snapshot) {
      return Scaffold(
        appBar: WidgetsUtil.onBoardingAppBar(
          context,
          title: 'Are you PEP Person?',
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'A PEP is a person who either himself/herself or any of his/her close family members or associates hold or held at any time in the last 12 months, a prominent public function, for example heads of state or of government, senior politicians, senior goverment, judicial or military officials, senior executives of state-owned corporations and important political party officials.',
                  style: textTheme.bodyMedium?.copyWith(
                    fontSize: 14,
                    color: AppColor.kPinDesColor,
                  ),
                ),
                const Spacer(),
                ContinueButton(
                  context: context,
                  color: AppColor.kGoldColor2,
                  textColor: Colors.black,
                  onPressed: () async {
                    model.setIsPep = true;
                    PepStatusPage.show(context);
                  },
                  text: 'YES, I AM A PEP',
                ),
                const Gap(6),
                Center(
                  child: TextButton(
                    onPressed: () {
                      model.setIsPep = false;
                      AccountPurposePage.show(context);
                    },
                    child: Text(
                      'NO, I AM NOT A PEP',
                      style: textTheme.bodyMedium?.copyWith(
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
        ),
      );
    });
  }
}
