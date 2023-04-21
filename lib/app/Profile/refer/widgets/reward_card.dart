import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/util/color_scheme.dart';

class RewardCard extends StatelessWidget {
  const RewardCard({Key? key}) : super(key: key);
  Row customTile(
      int index, String title, String subtitle, TextTheme textTheme) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: AppColor.kAccentColor2,
          child: Text('$index'),
        ),
        const Gap(8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: textTheme.bodyLarge,
            ),
            Text(subtitle)
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const RadialGradient(
          colors: [Colors.white, AppColor.kAccentColor4],
          radius: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How it works',
            style:
                textTheme.headlineSmall?.copyWith(color: AppColor.kSecondaryColor),
          ),
          const Gap(16),
          customTile(1, 'Invite a friend', 'just share your link', textTheme),
          Container(
            width: 1,
            height: 40,
            margin: const EdgeInsets.only(left: 20),
            color: Colors.black,
          ),
          customTile(2, r'They get $20', 'on joining', textTheme),
          Container(
            width: 1,
            height: 40,
            margin: const EdgeInsets.only(left: 20),
            color: Colors.black,
          ),
          customTile(
            3,
            r'You make $20',
            'on first qualified transaction',
            textTheme,
          ),
        ],
      ),
    );
  }
}
