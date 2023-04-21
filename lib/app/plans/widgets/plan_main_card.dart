import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/plans/widgets/modal_sheet_content.dart';
import 'package:geniuspay/util/color_scheme.dart';

class PlanMainCard extends StatelessWidget {
  final PlanMainContent content;
  const PlanMainCard({Key? key, required this.content}) : super(key: key);

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
          child: Column(children: [
            Text(
              content.name,
              style: textTheme.displayMedium?.copyWith(fontSize: 30),
            ),
            Text(
              content.amount,
              style: textTheme.bodyMedium?.copyWith(color: content.color),
            ),
            const Gap(32),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) =>
                  const Divider(height: 1, color: AppColor.kAccentColor2),
              itemCount: content.tileContents.length,
              itemBuilder: (context, index) => ListTile(
                onTap: () {
                  if (content.tileContents[index].modalContent != null) {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.8,
                              child: ModalSheet(
                                modalContent:
                                    content.tileContents[index].modalContent!,
                              ));
                        });
                  }
                },
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
                  style: textTheme.titleMedium?.copyWith(color: content.color),
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

class PlanTileContent {
  final String asset;
  final String title;
  final String subtitle;
  final PlanModalContent? modalContent;
  PlanTileContent(
      {required this.asset,
      required this.title,
      required this.subtitle,
      this.modalContent});
}

class PlanMainContent {
  final String name;
  final String amount;
  final Color color;
  final String nameString;
  final List<PlanTileContent> tileContents;
  PlanMainContent(
      {required this.name,
      required this.amount,
      required this.tileContents,
      required this.color,
      required this.nameString});
}
