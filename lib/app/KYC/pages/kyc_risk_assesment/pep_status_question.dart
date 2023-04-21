import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/KYC/pages/kyc_risk_assesment/account_purpose_page.dart';
import 'package:geniuspay/app/KYC/pages/kyc_risk_assesment/equivalent_page.dart';
import 'package:geniuspay/app/KYC/pages/kyc_risk_assesment/us_person_page.dart';
import 'package:geniuspay/app/KYC/view_models.dart/kyc_view_model.dart';
import 'package:geniuspay/app/auth/pages/sign_up/widgets/waring_widget.dart';
import 'package:geniuspay/app/shared_widgets/continue_button.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/enums.dart';
import 'package:geniuspay/util/widgets_util.dart';

class PepStatusPage extends StatefulWidget {
  const PepStatusPage({Key? key}) : super(key: key);
  static Future<void> show(
    BuildContext context,
  ) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const PepStatusPage(),
      ),
    );
  }

  @override
  State<PepStatusPage> createState() => _PepStatusPageState();
}

class _PepStatusPageState extends State<PepStatusPage> {
  PepStatus? status;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BaseView<KycViewModel>(builder: (context, model, snapshot) {
      return Scaffold(
        appBar: WidgetsUtil.onBoardingAppBar(
          context,
          title: 'PEP Status',
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Please, provide the details of your PEP status.',
                  style: textTheme.bodyLarge
                      ?.copyWith(fontSize: 16, color: AppColor.kSecondaryColor),
                ),
                const Gap(20),
                Text(
                  'Which of your close family members or associates have been elected to prominent political positions or assigned high-profile public roles in the last 12 months?',
                  style: textTheme.bodyMedium?.copyWith(
                    fontSize: 14,
                    color: AppColor.kPinDesColor,
                  ),
                ),
                const Gap(10),
                WarningWidget(
                  title: 'What is the difference',
                  backgroundColor: Colors.transparent,
                  textColor: AppColor.kSecondaryColor,
                  onTap: () {
                    EquivalentPage.show(
                      context: context,
                      title: 'What\'s the difference?',
                      firstText: 'Close Associate:',
                      firstSubText:
                          '1. Any individual who has joint beneficial ownership of a legal entity, or a legal arrangement, or close business relationship, with a PEP;\n2. Any individual who has sole beneficial ownership of a legal entity, or legal arrangement set up for the actual benefit of a PEP.',
                      secondText: 'Close Family Member:',
                      secondSubText:
                          '1. Any spouse of the PEP;\n2. Any ex-spouse of PEP;\n3. Any person who is considered to be the equivalent to a spouse of the PEP;\n4. Any cohabitant of the PEP;\n5. Any child of the PEP;\n6. Any spouse who is considered to be the equivalent to a spouse of a child of the PEP;\n7. Any cohabitant of a child of the PEP;\n8. Any parent of the PEP;\n9. Any other family member of the PEP who is of a prescribed class.',
                    );
                  },
                ),
                const Divider(
                  color: AppColor.kAccentColor2,
                ),
                const Gap(10),
                USPersonWidget(
                  textTheme: textTheme,
                  text: 'Myself',
                  selected: model.pepStatus != null &&
                      model.pepStatus == PepStatus.mySelf,
                  onTap: () {
                    setState(() {
                      model.setPepStatus = PepStatus.mySelf;
                    });
                  },
                ),
                USPersonWidget(
                  textTheme: textTheme,
                  text: 'My family member',
                  selected: model.pepStatus != null &&
                      model.pepStatus == PepStatus.family,
                  onTap: () {
                    setState(() {
                      model.setPepStatus = PepStatus.family;
                    });
                  },
                ),
                USPersonWidget(
                  textTheme: textTheme,
                  text: 'My close associate',
                  selected: model.pepStatus != null &&
                      model.pepStatus == PepStatus.associate,
                  onTap: () {
                    setState(() {
                      model.setPepStatus = PepStatus.associate;
                    });
                  },
                ),
                const Spacer(),
                ContinueButton(
                  context: context,
                  color: AppColor.kGoldColor2,
                  textColor: Colors.black,
                  disabledColor: AppColor.kAccentColor3,
                  disable: model.pepStatus == null,
                  onPressed: () async {
                    AccountPurposePage.show(context);
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

class PepSelectionWidget extends StatelessWidget {
  const PepSelectionWidget({
    Key? key,
    required this.isSelected,
    required this.title,
    required this.onTap,
  }) : super(key: key);
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          color: isSelected ? AppColor.kAccentColor2 : Colors.transparent,
        ),
        child: Row(children: [
          Radio(
            value: isSelected,
            activeColor: Colors.black,
            groupValue: true,
            onChanged: (value) {
              onTap();
            },
          ),
          Expanded(
            child: Text(
              title,
              style: textTheme.bodyMedium?.copyWith(
                fontSize: 16,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
