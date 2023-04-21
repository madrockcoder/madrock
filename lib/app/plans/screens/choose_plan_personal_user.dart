import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/plans/plan_data.dart';
import 'package:geniuspay/app/plans/screens/choose_plan_detailed.dart';
import 'package:geniuspay/app/plans/widgets/choose_plan_card.dart';
import 'package:geniuspay/app/shared_widgets/custom_tab_indicator.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/enums.dart';

class ChooseSubscriptionPlanPage extends StatefulWidget {
  const ChooseSubscriptionPlanPage({Key? key}) : super(key: key);
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const ChooseSubscriptionPlanPage(),
      ),
    );
  }

  @override
  State<ChooseSubscriptionPlanPage> createState() =>
      _ChooseSubscriptionPlanPageState();
}

class _ChooseSubscriptionPlanPageState
    extends State<ChooseSubscriptionPlanPage> {
  final AuthenticationService _authenticationService =
      sl<AuthenticationService>();
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        actions: const [HelpIconButton()],
      ),
      body: DefaultTabController(
          length: 2,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(24),
                    Text(
                      'Choose your\nsubscription plan',
                      style: textTheme.displaySmall
                          ?.copyWith(color: AppColor.kSecondaryColor),
                    ),
                    const Gap(24),
                    Container(
                        height: 40,
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(34),
                            border: Border.all(
                                color: AppColor.kSecondaryColor, width: 3)),
                        child: TabBar(
                          labelColor: Colors.white,
                          unselectedLabelColor: AppColor.kSecondaryColor,
                          indicator: WalletTabIndicator(),
                          tabs: const [
                            Tab(
                              text: 'Personal',
                            ),
                            Tab(
                              text: 'Business',
                            ),
                          ],
                        )),
                    const Gap(24),
                    Expanded(
                        child: TabBarView(
                      children: [
                        ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            ChoosePlanCard(
                              title: 'Basic',
                              subtitle: 'Free',
                              badge: _authenticationService
                                      .user?.userProfile.subscriptionPlan ==
                                  Plans.basic,
                              items: const [
                                'Free Account',
                                'Free payments between geniuspay accounts',
                                'Free virtual MasterCard'
                              ],
                              onTap: () {
                                ChoosePlanDetailed.show(
                                    context,
                                    PlanData().getContent(Plans.basic),
                                    UserType.personal,
                                    null);
                              },
                            ),
                            const Gap(24),
                            ChoosePlanCard(
                              title: 'Smart',
                              badge: _authenticationService
                                      .user?.userProfile.subscriptionPlan ==
                                  Plans.smart,
                              subtitle: 'EUR 4.99 / month',
                              items: const [
                                'Free Account',
                                'Free payments between geniuspay accounts',
                                'Free withdrawals up to EUR 200 / month'
                              ],
                              onTap: () {
                                ChoosePlanDetailed.show(
                                    context,
                                    PlanData().getContent(Plans.smart),
                                    UserType.personal,
                                    null);
                              },
                            ),
                            const Gap(24),
                            ChoosePlanCard(
                              title: 'Genius',
                              subtitle: 'EUR 10.99 / month',
                              badge: _authenticationService
                                      .user?.userProfile.subscriptionPlan ==
                                  Plans.genius,
                              items: const [
                                'Free Account',
                                'Free payments between geniuspay accounts',
                                'Free withdrawals up to EUR 200 / month'
                              ],
                              onTap: () {
                                ChoosePlanDetailed.show(
                                    context,
                                    PlanData().getContent(Plans.genius),
                                    UserType.personal,
                                    null);
                              },
                            ),
                            const Gap(24),
                          ],
                        ),
                        ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            ChoosePlanCard(
                              title: 'Small',
                              badge: _authenticationService
                                      .user?.userProfile.subscriptionPlan ==
                                  Plans.small,
                              subtitle: 'EUR 4.99 / month',
                              items: const [
                                'Monthly account turnover up to EUR 50,000',
                              ],
                              onTap: () {
                                ChoosePlanDetailed.show(
                                    context,
                                    PlanData().getContent(Plans.small),
                                    UserType.business,
                                    BusinessType.company);
                              },
                            ),
                            const Gap(24),
                            ChoosePlanCard(
                              title: 'Medium',
                              badge: _authenticationService
                                      .user?.userProfile.subscriptionPlan ==
                                  Plans.medium,
                              subtitle: 'EUR 19.99 / month',
                              subtitleColor: AppColor.pacificBlue,
                              items: const [
                                'Monthly account turnover up to EUR 250,000'
                              ],
                              onTap: () {
                                ChoosePlanDetailed.show(
                                    context,
                                    PlanData().getContent(Plans.medium),
                                    UserType.business,
                                    BusinessType.company);
                              },
                            ),
                            const Gap(24),
                            ChoosePlanCard(
                              title: 'Enterprise',
                              subtitle: 'EUR 99.99 / month',
                              subtitleColor: AppColor.turquoise,
                              badge: _authenticationService
                                      .user?.userProfile.subscriptionPlan ==
                                  Plans.enterprise,
                              items: const [
                                'Monthly account turnover up to EUR 500,000'
                              ],
                              onTap: () {
                                ChoosePlanDetailed.show(
                                    context,
                                    PlanData().getContent(Plans.enterprise),
                                    UserType.business,
                                    BusinessType.company);
                              },
                            ),
                            const Gap(24),
                            ChoosePlanCard(
                              title: 'Enterprise +',
                              subtitle: 'Custom',
                              badge: _authenticationService
                                      .user?.userProfile.subscriptionPlan ==
                                  Plans.enterprisePlus,
                              subtitleColor: AppColor.purple,
                              items: const ['Custom monthly account turnover'],
                              onTap: () {
                                ChoosePlanDetailed.show(
                                    context,
                                    PlanData().getContent(Plans.enterprisePlus),
                                    UserType.business,
                                    BusinessType.company);
                              },
                            ),
                            const Gap(24),
                          ],
                        )
                      ],
                    )),
                  ]))),
    );
  }
}
