import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/Profile/refer/referfriend_screen.dart';
import 'package:geniuspay/app/Profile/refer/widgets/how_to_qualify_card.dart';
import 'package:geniuspay/app/Profile/refer/widgets/string_constants.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/repos/local_repo.dart';

import 'package:geniuspay/util/color_scheme.dart';

class ReferAFriendHomeScreen extends StatelessWidget {
  const ReferAFriendHomeScreen({Key? key}) : super(key: key);
  static Future<void> show(BuildContext context) async {
    final LocalBase _localBase = sl<LocalBase>();
    if (_localBase.isReferAndEarnPageOpenedOnce()) {
      ReferAFriend.show(context);
    } else {
      _localBase.setReferAndEarnPageAsOpened();
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const ReferAFriendHomeScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.kAccentColor2,
      ),
      backgroundColor: AppColor.kAccentColor2,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset(
              kWelcome,
              height: 240,
              width: 240,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(kInviteHeader,
                style: textTheme.displaySmall
                    ?.copyWith(color: AppColor.kSecondaryColor)),
            const SizedBox(
              height: 15,
            ),
            Text(
              kInviteMessage,
              style: textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (builder) {
                      return const HowToQualifyCard();
                    });
              },
              child: Text(kQualifyHeader,
                  style: textTheme.bodyLarge?.copyWith(
                    color: AppColor.kSecondaryColor,
                    decoration: TextDecoration.underline,
                  )),
            ),
            const Spacer(),
            CustomElevatedButton(
              disabledColor: AppColor.kSecondaryColor,
              child: Text(
                'INVITE FRIENDS',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.white),
              ),
              onPressed: () {
                ReferAFriend.show(context);
              },
            ),
            if(Platform.isIOS)
              const Gap(24)
          ],
        ),
      ),
    );
  }
}
