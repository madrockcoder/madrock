import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/Profile/refer/widgets/reward_card.dart';
import 'package:geniuspay/app/Profile/refer/widgets/share_link_card.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/util/color_scheme.dart';

class ReferAFriend extends StatefulWidget {
  const ReferAFriend({Key? key}) : super(key: key);
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const ReferAFriend(),
      ),
    );
  }

  @override
  State<ReferAFriend> createState() => _ReferAFriendState();
}

class _ReferAFriendState extends State<ReferAFriend> {
  final AuthenticationService _authenticationService =
      sl<AuthenticationService>();

  @override
  void initState() {
    getUser();
    super.initState();
  }

  getUser() async {
    await _authenticationService.getUser();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Refer a friend'),
        centerTitle: true,
        actions: const [HelpIconButton()],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        children: [
          const RewardCard(),
          const SizedBox(height: 24),
          Text(
            'Referral Code',
            style:
                textTheme.headlineSmall?.copyWith(color: AppColor.kSecondaryColor),
          ),
          DottedBorder(
              color: AppColor.kSecondaryColor,
              strokeWidth: 2,
              dashPattern: const [8, 3],
              radius: const Radius.circular(8),
              borderType: BorderType.RRect,
              child: InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(
                        text: _authenticationService.user?.username ?? ''));
                    PopupDialogs(context)
                        .informationMessage('Copied to clipboard');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColor.kAccentColor2,
                        borderRadius: BorderRadius.circular(8)),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _authenticationService.user?.username ?? '',
                            style: textTheme.bodyLarge?.copyWith(
                                color: AppColor.kSecondaryColor, fontSize: 16),
                          ),
                          const Text('Tap to copy')
                        ]),
                  ))),
          const Gap(16),
          const ShareLinkCard(),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
            decoration: BoxDecoration(
                color: AppColor.kAccentColor2,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColor.kSecondaryColor)),
            child: Row(children: [
              const Spacer(),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/coins.svg',
                    width: 32,
                  ),
                  const Gap(8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Earned'),
                      Text(
                        "\$${_authenticationService.user!.userProfile.refferal.earned}",
                        style: textTheme.bodyLarge
                            ?.copyWith(color: AppColor.kSecondaryColor),
                      )
                    ],
                  )
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Image.asset(
                    "assets/icons/profile/refer/friend.png",
                    width: 32,
                  ),
                  const Gap(8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Joined'),
                      Text(
                        '${_authenticationService.user!.userProfile.refferal.joined} friends',
                        style: textTheme.bodyLarge
                            ?.copyWith(color: AppColor.kSecondaryColor),
                      )
                    ],
                  )
                ],
              ),
              const Spacer(),
            ]),
          ),
        ],
      ),
    );
  }
}
