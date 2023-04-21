//images
import 'package:flutter/foundation.dart';
import 'package:geniuspay/services/remote_config_service.dart';

const String kWelcome = "assets/icons/profile/refer/socialmedia.png";
const String kValid = "assets/icons/profile/refer/valid.png";
const String kInvalid = "assets/icons/profile/refer/invalid.png";
const String kBack = "assets/icons/profile/refer/back.png";
const String kAirtime = "assets/icons/profile/refer/airtime.png";
const String kDiscount = "assets/icons/profile/refer/discounts.png";
const String kInternet = "assets/icons/profile/refer/internet.png";
const String kElectricity = "assets/icons/profile/refer/electricity.png";
const String kPerks = "assets/icons/profile/refer/perks.png";
const String kPlantTrees = "assets/icons/profile/refer/planttrees.png";
const String kReferFriend = "assets/icons/profile/refer/referafriend.png";
const String kTransfer = "assets/icons/profile/refer/transfer.png";
const String kEarn = "assets/icons/profile/refer/earn.png";
const String kFilledstar = "assets/icons/profile/refer/filledstar.png";
const String kOutlinedStar = "assets/icons/profile/refer/outlinedstar.png";
const String kReward = "assets/icons/profile/refer/reward.png";
const String kCoin = "assets/icons/profile/refer/coins.png";
const String kFriend = "assets/icons/profile/refer/friend.png";
const String kMessenger = "assets/icons/profile/refer/messenger.png";
const String kGoogle = "assets/icons/profile/refer/google.png";
const String kLinkedIn = "assets/icons/profile/refer/linkedin.png";
const String kWhatsapp = "assets/icons/profile/refer/whatsapp.png";
const String kShare = "assets/icons/profile/refer/share.png";

//text
const String kInviteHeader = 'Invite someone';
const String kInviteMessage =
    "Help them supercharge their finances with geniuspay. Plus, their first transfer fees is on us!";
const String kQualifyHeader = 'How to qualify';
const String kQualifyCondition1 =
    "Your friends will need to make a single transaction of USD 1000 (or equivalent) in one go to qualify.";
const String kQualifyCondition2 =
    "Fee* credit will be included in for all of their tansfers until it runs out.";
const String kQualifyCondition3 =
    "Same currency transfers don’t count towards this program.";
const String kReferralTermsHeader = "Referral terms";
const String kEarnPointsHeader = "Fancy a reward?";
const String kEarnPointsContent =
    "Earn everytime you transact on geniuspay. Send, pay, refer and earn instantly.";
const String kRewardMessage = 'Spread the word and be rewarded!';

// stripe credentials
String get publishableKey =>
    RemoteConfigService.getRemoteData.stripeCredentials[
        kDebugMode ? 'STRIPE_PUBLIC_KEY_TEST' : 'STRIPE_PUBLIC_KEY_LIVE']!;

String get secretKey => RemoteConfigService.getRemoteData.stripeCredentials[
    kDebugMode ? 'STRIPE_SECRET_KEY_TEST' : 'STRIPE_SECRET_KEY_LIVE']!;
