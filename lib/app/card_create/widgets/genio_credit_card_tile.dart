import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/shared_widgets/size_config.dart';
import 'package:geniuspay/util/color_scheme.dart';
// import 'package:taskproject/app/shared_widgets/size_config.dart';
// import 'package:taskproject/application/const.dart';
// import 'package:taskproject/util/color_scheme.dart';

class GenioCreditCardTile extends StatelessWidget {
  const GenioCreditCardTile({
    Key? key,
    required this.card,
    required this.icon,
    required this.subtitle,
    required this.title,
  }) : super(key: key);

  final Widget icon;
  final String title;
  final String subtitle;
  final Widget card;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColor.kSecondaryColor),
      ),
      margin: const EdgeInsets.only(
        right: 24,
        left: 24,
      ),
      padding: EdgeInsets.only(
        top: SizeConfig.blockSizeVertical! * 02,
        left: 16,
        right: 16,
        bottom: SizeConfig.blockSizeVertical! * 02,
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              icon,
              Gap(SizeConfig.blockSizeVertical! * 01.5),
              Text(title, style: textTheme.headlineMedium?.copyWith(color: AppColor.kSecondaryColor)),
              Gap(SizeConfig.blockSizeVertical! * 01.6),
              SizedBox(
                width: SizeConfig.blockSizeVertical! * 022,
                child: Text(subtitle, style: textTheme.titleMedium?.copyWith(color: AppColor.kGreyColor)),
              ),
            ],
          ),
          const Spacer(),
          card,
        ],
      ),
    );
  }
}
