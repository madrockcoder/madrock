import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/card_create/pages/customise_card/card_widget.dart';
import 'package:geniuspay/util/color_scheme.dart';

///variables for this screen

///
class MetalSilver extends StatefulWidget {
  const MetalSilver({Key? key}) : super(key: key);

  @override
  State<MetalSilver> createState() => _MetalSilverState();
}

class _MetalSilverState extends State<MetalSilver> {
  List<Color> colors = [
    const Color(0xffCACCCC),
    const Color(0xff272828),
    const Color(0xffC8A053),
  ];
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
                    cardBgColor: colors[index],
                    textColor: index == 1 ? Colors.white : Colors.black,
                    logoColor: Colors.black,
                    metallic: true))),
        Gap(height / 25),
        Text(
          'Metal Silver',
          textAlign: TextAlign.center,
          style: textTheme.displaySmall
              ?.copyWith(color: AppColor.kOnPrimaryTextColor, fontSize: 18),
        ),
        const Gap(8),
        Text(
          'Our exclusive metal cards will make you feel special',
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
