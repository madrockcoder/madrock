import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/auth/pages/sign_up/help/help_screen.dart';
import 'package:geniuspay/app/geniogreen/screens/geniogreen_main.dart';
import 'package:geniuspay/app/home/pages/notifications/notifications_page.dart';
import 'package:geniuspay/app/home/pages/notifications/notifications_vm.dart';
import 'package:geniuspay/app/home/pages/profile_points/profile_points_screen.dart';
import 'package:geniuspay/models/user.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/essentials.dart';

class HomeAppBar extends StatefulWidget {
  final User? user;
  final PageController pageController;
  const HomeAppBar({Key? key, required this.user, required this.pageController})
      : super(key: key);

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  User? get user => widget.user;
  PageController get pageController => widget.pageController;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        InkWell(
            onTap: () {
              pageController.animateToPage(
                4,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
              );
            },
            child: Container(
              height: 50,
              width: 50,
              padding: const EdgeInsets.all(4.1),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/circle.png'),
                ),
              ),
              child: CircleAvatar(
                backgroundColor: AppColor.kSecondaryColor,
                foregroundImage: CachedNetworkImageProvider(user!.avatar),
              ),
            )),
        const Gap(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user!.helloMessage,
                style: textTheme.bodyText2
                    ?.copyWith(color: AppColor.kSecondaryColor, fontSize: 12),
              ),
              Text(
                user!.firstName.isEmpty ? 'Rockstar' : "${user?.firstName}",
                style: textTheme.bodyText1
                    ?.copyWith(color: AppColor.kSecondaryColor, fontSize: 18),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Row(
              children: [
                if (!shouldTemporaryHideForEarlyLaunch) ...[
                  InkWell(
                    onTap: () {
                      GenioGreenPage.show(context);
                    },
                    child: SvgPicture.asset('assets/images/treee.svg'),
                  ),
                  const Gap(10),
                ],
                InkWell(
                  onTap: () async {
                    final result = await NotificationsPage.show(context);
                    setState(() {});
                  },
                  child: Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      SvgPicture.asset('assets/images/notification.svg'),
                      if (NotificationsVM().unreadNotifications > 0)
                        CircleAvatar(
                          radius: 5,
                          backgroundColor: AppColor.kRedColor,
                          child: FittedBox(
                              child: Center(
                            child: Text(
                              "${NotificationsVM().unreadNotifications}",
                              style: textTheme.bodyText2?.copyWith(
                                color: Colors.white,
                                fontSize: 8,
                              ),
                            ),
                          )),
                        ),
                    ],
                  ),
                ),
                const Gap(10),
                InkWell(
                  onTap: () {
                    HelpScreen.show(context);
                  },
                  child: SvgPicture.asset('assets/images/help.svg'),
                )
              ],
            ),
            const Gap(5),
            InkWell(
                onTap: () {
                  ProfilePointsScreen.show(context, user!);
                },
                child: Row(
                  children: [
                    Text(
                      user!.userProfile.points!,
                      style: textTheme.bodyText1?.copyWith(
                        color: AppColor.kSecondaryColor,
                        fontSize: 12,
                      ),
                    ),
                    const Gap(8),
                    SvgPicture.asset('assets/images/star.svg')
                  ],
                ))
          ],
        )
      ],
    );
  }
}
