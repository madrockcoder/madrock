import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/card_create/pages/customise_card/card_widget.dart';
import 'package:geniuspay/util/color_scheme.dart';

///variables for this screen

///
class TransparentBlackCard extends StatefulWidget {
  const TransparentBlackCard({Key? key}) : super(key: key);

  @override
  State<TransparentBlackCard> createState() => _TransparentBlackCardState();
}

class _TransparentBlackCardState extends State<TransparentBlackCard> {
  List<Color> colors = [Colors.black, Colors.white];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    double height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Gap(24),
        Flexible(
            child: Container(
                constraints: BoxConstraints(
                    maxHeight: height / 2, maxWidth: (height / 2) * .646),
                child: CardWidgetTemplate(
                    cardBgColor: AppColor.kAccentColor2,
                    logoColor: colors[index],
                    border: colors[index],
                    metallic: false))),
        Gap(height / 25),
        Text(
          'Transparent Black',
          textAlign: TextAlign.center,
          style: textTheme.displaySmall
              ?.copyWith(color: AppColor.kOnPrimaryTextColor, fontSize: 18),
        ),
        const Gap(8),
        Text(
          'Our transparent cards will make you stand out from the crowd',
          textAlign: TextAlign.center,
          style: textTheme.bodyMedium
              ?.copyWith(color: AppColor.kGreyColor, fontSize: 12),
        ),
        Gap(height / 35),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < colors.length; i++) ...[
              InkWell(
                borderRadius: BorderRadius.circular(35),
                onTap: () {
                  setState(() {
                    index = i;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(3),
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: Colors.transparent,
                      border: Border.all(
                          color: index == i ? Colors.black : Colors.transparent,
                          width: 2)),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: colors[i]),
                  ),
                ),
              ),
              const Gap(8)
            ],
          ],
        ),
      ],
    );
  }
}
