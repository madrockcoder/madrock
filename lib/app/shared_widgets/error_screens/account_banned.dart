import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/auth/pages/sign_up/help/help_screen.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/enums.dart';

class AccountBanned extends StatefulWidget {
  static Future<void> show(
      BuildContext context, ProfileStatus profileStatus) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AccountBanned(profileStatus: profileStatus),
      ),
    );
  }

  final ProfileStatus profileStatus;
  const AccountBanned({Key? key, required this.profileStatus})
      : super(key: key);

  @override
  State<AccountBanned> createState() => _AccountBannedState();
}

class _AccountBannedState extends State<AccountBanned> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: AppColor.kSecondaryColor, width: 5)),
                          child: Padding(
                              padding: const EdgeInsets.all(22),
                              child: SvgPicture.asset(
                                "assets/icons/close.svg",
                                color: AppColor.kSecondaryColor,
                                width: 28,
                              ))),
                      const Gap(30.25),
                      Text(
                        'Sorry, your account is\ntemporarily ${widget.profileStatus.name.toLowerCase()}',
                        style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            color: AppColor.kSecondaryColor, fontSize: 20),
                      ),
                      const Gap(40),
                      Text(
                        'We have detected unusual activity on your\ngeniuspay account.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const Gap(16),
                      Text(
                        'Please contact support for more information.\nYou may need to provide additional documents\nto verify your identity.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
            child: CustomElevatedButton(
              onPressed: () {
                HelpScreen.show(context);
              },
              radius: 8,
              color: AppColor.kGoldColor2,
              child: Text('Contact Support', style: textTheme.bodyLarge),
            ),
          ),
        ));
  }
}
