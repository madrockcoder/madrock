import 'package:flutter/material.dart';

import 'package:geniuspay/util/color_scheme.dart';

class RewardReusableIconCard extends StatelessWidget {
  final String imagePath;
  final String header;
  final String content;
  const RewardReusableIconCard(this.imagePath, this.header, this.content,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.kAccentColor2,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: const BorderSide(color: AppColor.kScaffoldBackgroundColor)),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
        child: Row(
          children: [
            Image.asset(
              imagePath,
              height: 50,
              width: 50,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  header,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontSize: 12),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(content,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 16, color: AppColor.kSecondaryColor))
              ],
            )
          ],
        ),
      ),
    );
  }
}
