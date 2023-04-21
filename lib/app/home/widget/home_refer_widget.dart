import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/Profile/refer/refer_a_friend_homescreen.dart';
import 'package:geniuspay/util/color_scheme.dart';

class HomeReferWidget extends StatelessWidget {
  const HomeReferWidget({
    Key? key,
    required this.textTheme,
  }) : super(key: key);

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          ReferAFriendHomeScreen.show(context);
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.kSecondaryColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 4),
                blurRadius: 8,
                color: Colors.black.withOpacity(0.16),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Refer & earn up to \$20',
                        style: textTheme.bodyLarge?.copyWith(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        '\$2 sign up bonus for every invite.\nClick here to start inviting friends now.',
                        style: textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 90,
                width: 90,
                child: Image.asset(
                  'assets/images/refer_gift.png',
                ),
              ),
            ],
          ),
        ));
  }
}
