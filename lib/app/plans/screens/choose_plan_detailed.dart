import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/plans/screens/confirm_plan_screen.dart';
import 'package:geniuspay/app/plans/widgets/banking_card.dart';
import 'package:geniuspay/app/plans/widgets/plan_common_card.dart';
import 'package:geniuspay/app/plans/widgets/plan_main_card.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/enums.dart';

class ChoosePlanDetailed extends StatelessWidget {
  final PlanContent content;
  final UserType userType;
  final BusinessType? businessType;
  const ChoosePlanDetailed(
      {Key? key,
      required this.content,
      required this.userType,
      this.businessType})
      : super(key: key);
  static Future<void> show(BuildContext context, PlanContent content,
      UserType userType, BusinessType? businessType) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ChoosePlanDetailed(
          content: content,
          userType: userType,
          businessType: businessType,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kAccentColor2,
      appBar: AppBar(
        backgroundColor: AppColor.kAccentColor2,
        title: const Text('Choose your plan'),
        centerTitle: true,
        actions: const [HelpIconButton()],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(24),
        child: CustomElevatedButton(
            color: AppColor.kGoldColor2,
            child: const Text('CONTINUE'),
            onPressed: () {
              ConfirmPlanScreen.show(
                  context: context,
                  planName: content.mainContent.name,
                  planString: content.mainContent.nameString);
            }),
      ),
      body: ListView(children: [
        const Gap(24),
        BankingCard(
          cardBgColor: content.cardBgcolor,
          logoColor: Colors.black,
          metallic: content.metallic,
        ),
        PlanMainCard(content: content.mainContent),
        const Gap(24),
        PlanCommonCard(content: content.commonContent),
        const Gap(120),
      ]),
    );
  }
}

class PlanContent {
  final Color cardBgcolor;
  final PlanMainContent mainContent;
  final PlanCommonContent commonContent;
  final bool metallic;
  PlanContent(
      {required this.mainContent,
      required this.commonContent,
      required this.cardBgcolor,
      this.metallic = false});
}
