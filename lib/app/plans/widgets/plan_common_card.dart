import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/plans/widgets/plan_main_card.dart';
import 'package:geniuspay/util/color_scheme.dart';

class PlanCommonCard extends StatelessWidget {
  final PlanCommonContent content;
  const PlanCommonCard({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.22),
            blurRadius: 6,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Padding(
          padding: const EdgeInsets.all(24),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'ALL PLANS GET',
              style: textTheme.bodyLarge?.copyWith(color: content.color),
            ),
            const Gap(24),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) =>
                  const Divider(height: 1, color: AppColor.kAccentColor2),
              itemCount: content.tileContents.length,
              itemBuilder: (context, index) => ListTile(
                onTap: () {},
                leading: Container(
                    width: 24,
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      content.tileContents[index].asset,
                      color: content.color,
                    )),
                minLeadingWidth: 0,
                title: Text(content.tileContents[index].title),
                subtitle: Text(
                  content.tileContents[index].subtitle,
                  style: textTheme.titleSmall?.copyWith(
                      color: AppColor.kGreyColor,
                      fontWeight: FontWeight.w300,
                      fontSize: 10),
                ),
                trailing: SvgPicture.asset(
                  'assets/images/Arrow-Down2.svg',
                  color: content.color,
                ),
              ),
            )
          ])),
    );
  }
}

class PlanCommonContent {
  final Color color;
  final List<PlanTileContent> tileContents;
  PlanCommonContent({required this.tileContents, required this.color});
}
