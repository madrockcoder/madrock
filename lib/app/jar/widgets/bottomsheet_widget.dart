import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/jar/pages/name_selection_screen.dart';

import 'package:geniuspay/util/color_scheme.dart';

class JarTypeSheet extends StatelessWidget {
  const JarTypeSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final titleStyle = textTheme.bodyLarge;
    final subtitleStyle = textTheme.bodyMedium;

    return Container(
      height: 332,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      padding: const EdgeInsets.only(top: 35, left: 25, right: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.close,
                  color: AppColor.kSecondaryColor,
                  size: 23,
                ),
              ),
              Text(
                'Jar type',
                style: textTheme.bodyLarge,
              ),
              const SizedBox.shrink(),
            ],
          ),
          const Gap(30),
          Text(
            'Choose your Jar',
            style: textTheme.titleLarge,
          ),
          const Gap(24),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const NameSelectionScreen();
                }),
              );
            },
            child: Row(
              children: [
                SvgPicture.asset('assets/icons/goalSaving.svg',
                    height: 44, width: 44, fit: BoxFit.cover),
                const Gap(16),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Goal savings',
                        style: titleStyle,
                      ),
                      Text(
                        'Rent? Holiday? New car? Set a saving goal to make your dream a reality.',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: subtitleStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Gap(16),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const NameSelectionScreen();
              }));
            },
            child: Row(
              children: [
                SvgPicture.asset('assets/icons/investment.svg',
                    height: 44, width: 44, fit: BoxFit.cover),
                const Gap(16),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Investment',
                        style: titleStyle,
                      ),
                      Text(
                        'Put your money to work and earn up to 15% per annum paid on a daily basis.',
                        maxLines: 2,
                        style: subtitleStyle,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
