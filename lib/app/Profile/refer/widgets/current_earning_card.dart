import 'package:flutter/material.dart';
import 'package:geniuspay/app/Profile/refer/widgets/reward_reusable_icon_card.dart';
import 'package:geniuspay/app/Profile/refer/widgets/string_constants.dart';

class CurrentEarningCard extends StatelessWidget {
  const CurrentEarningCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const RewardReusableIconCard(
        kCoin, "You've earned till now", "\$200");
  }
}
