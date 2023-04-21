import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/Profile/refer/refer_a_friend_homescreen.dart';
import 'package:geniuspay/app/geniogreen/screens/geniogreen_main.dart';
import 'package:geniuspay/app/home/pages/profile_points/components/points_history.dart';
import 'package:geniuspay/app/home/pages/profile_points/components/section_heading.dart';
import 'package:geniuspay/app/home/pages/profile_points/models/earn.dart';
import 'package:geniuspay/app/home/pages/profile_points/models/history.dart';
import 'package:geniuspay/app/home/pages/profile_points/models/ways_to_redeem.dart';
import 'package:geniuspay/app/home/pages/profile_points/view_models/profile_points_vm.dart';
import 'package:geniuspay/app/payout/payout_selector.dart';
import 'package:geniuspay/app/perks/pages/perk_page.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/app/shared_widgets/size_config.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/models/points_stat.dart';
import 'package:geniuspay/models/user.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/essentials.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import 'components/earn_section.dart';
import 'components/points_banner.dart';
import 'components/ways_to_redeem_grid_view.dart';

class ProfilePointsScreen extends StatefulWidget {
  final User user;
  const ProfilePointsScreen({Key? key, required this.user}) : super(key: key);

  static Future<void> show(BuildContext context, User user) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
          builder: (_) => ProfilePointsScreen(
                user: user,
              )),
    );
  }

  @override
  State<ProfilePointsScreen> createState() => _ProfilePointsScreenState();
}

class _ProfilePointsScreenState extends State<ProfilePointsScreen> {
  List<List<WaysToRedeem>> waysToRedeemList(BuildContext context) {
    return [
      [
        WaysToRedeem(
            asset: "assets/icons/profile/points/perks.svg",
            text: "Perks",
            assetWidth: 21.24,
            onPressed: () {
              PerkPage.show(context);
            }),
        WaysToRedeem(
            asset: "assets/icons/profile/points/internet.svg",
            text: "Internet",
            assetWidth: 20,
            onPressed: () {
              PopupDialogs(context).comingSoonSnack();
            }),
        WaysToRedeem(
            asset: "assets/icons/profile/points/airtime.svg",
            text: "Airtime",
            assetWidth: 13.33,
            onPressed: () {
              PopupDialogs(context).comingSoonSnack();
            }),
        WaysToRedeem(
            asset: "assets/icons/profile/points/electricity.svg",
            text: "Electricity",
            assetWidth: 14.91,
            onPressed: () {
              PopupDialogs(context).comingSoonSnack();
            }),
      ],
      [
        WaysToRedeem(
            asset: "assets/icons/profile/points/water.svg",
            text: "Water",
            assetWidth: 14.12,
            onPressed: () {
              PopupDialogs(context).comingSoonSnack();
            }),
        WaysToRedeem(
            asset: "assets/icons/profile/points/discounts.svg",
            text: "Discounts",
            assetWidth: 20,
            onPressed: () {
              PopupDialogs(context).comingSoonSnack();
            }),
        WaysToRedeem(
            asset: "assets/icons/profile/points/plant_trees.svg",
            text: "Plant trees",
            assetWidth: 20,
            onPressed: () {
              GenioGreenPage.show(context);
            }),
        WaysToRedeem(
            asset: "assets/icons/profile/points/npo.svg",
            text: "NPO",
            assetWidth: 13.15,
            onPressed: () {
              PopupDialogs(context).comingSoonSnack();
            }),
      ]
    ];
  }

  List<Earn> earnList(BuildContext context) {
    return [
      Earn(
          asset: "assets/icons/profile/points/refer_friend.svg",
          heading: "Refer a friend",
          onPressed: () {
            ReferAFriendHomeScreen.show(context);
          }),
      Earn(
          asset: "assets/icons/profile/points/transfer.svg",
          heading: "Make a transfer",
          onPressed: () {
            PayoutSelectorPage.show(context: context);
          }),
    ];
  }

  List<History> historyList = [
    History(
        asset: "assets/icons/profile/points/transfer.svg",
        heading: "Money Transfer",
        dateTime: DateTime(2021, 5, 4),
        amount: 10000),
    History(
        asset: "assets/icons/profile/points/refer_friend.svg",
        heading: "Friend Referral",
        dateTime: DateTime(2021, 5, 4),
        amount: 10000),
    History(
        asset: "assets/icons/profile/points/transfer.svg",
        heading: "Money Transfer",
        dateTime: DateTime(2021, 5, 4),
        amount: 10000),
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final textTheme = Theme.of(context).textTheme;
    return BaseView<ProfilePointsVM>(
        onModelReady: (p0) => p0.getPointsList(context),
        builder: (context, model, snapshot) {
          return Scaffold(
            backgroundColor: AppColor.kWhiteColor,
            appBar: AppBar(
              title: const Text("Genio Points"),
              centerTitle: true,
              actions: const [HelpIconButton()],
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: SizedBox(
                      width: double.maxFinite,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TotalPointsBanner(
                              points: double.parse(
                                  widget.user.userProfile.points!)),
                          if (!shouldTemporaryHideForEarlyLaunch) ...[
                            const SectionHeading(
                              heading: "Ways to Redeem",
                            ),
                            WaysToRedeemGridView(
                                waysToRedeemList: waysToRedeemList(context)),
                          ],
                          const SectionHeading(
                            heading: "Earn",
                          ),
                          EarnSection(earnList: earnList(context)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'History',
                                style: textTheme.bodyText1,
                              ),
                              TextButton(
                                  onPressed: () {
                                    if (model.baseModelState ==
                                        BaseModelState.success) {
                                      PointsHistoryPage.show(
                                          context, model.pointsList);
                                    }
                                  },
                                  child: Text(
                                    'View All',
                                    style: textTheme.subtitle2?.copyWith(
                                        color: AppColor.kGreyColor,
                                        decoration: TextDecoration.underline),
                                  ))
                            ],
                          ),
                          if (model.baseModelState == BaseModelState.loading)
                            for (int index = 0; index < 3; index++)
                              Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: PointsTile(
                                      point: PointStat(
                                          reason: 'Sign Up points',
                                          points: 10,
                                          date: DateTime.now())))
                          else
                            for (int index = 0;
                                index <
                                    (model.pointsList.length > 5
                                        ? 5
                                        : model.pointsList.length);
                                index++)
                              PointsTile(point: model.pointsList[index])
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class PointsTile extends StatelessWidget {
  final PointStat point;
  const PointsTile({Key? key, required this.point}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            CircleAvatar(
                backgroundColor: AppColor.kAccentColor2,
                child: SvgPicture.asset(
                  "assets/icons/profile/points/transfer.svg",
                )),
            const Gap(16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(point.reason),
                const Gap(4),
                Text(
                  DateFormat('dd.MM.yyyy').format(point.date),
                  style: textTheme.bodyText2
                      ?.copyWith(color: AppColor.kGreyColor, fontSize: 10),
                ),
              ],
            ),
            const Spacer(),
            Text(point.points.toString()),
            const Gap(4),
            SvgPicture.asset(
              'assets/icons/profile/points/star.svg',
              width: 16,
            ),
          ],
        ));
  }
}
