import 'package:flutter/material.dart';
import 'package:geniuspay/app/Profile/refer/widgets/reward_reusable_icon_card.dart';
import 'package:geniuspay/app/Profile/refer/widgets/string_constants.dart';

class AcceptedReferralCard extends StatelessWidget {
  const AcceptedReferralCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const RewardReusableIconCard(
        kFriend, 'Accepted your referral invite', '2 friends');
  }
}
