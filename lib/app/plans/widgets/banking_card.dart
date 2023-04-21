import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class BankingCard extends StatelessWidget {
  final Color cardBgColor;
  final Color logoColor;
  final bool metallic;
  const BankingCard({
    Key? key,
    required this.cardBgColor,
    required this.logoColor,
    required this.metallic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: 227,
            height: 250,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.22),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  )
                ],
                image: metallic
                    ? DecorationImage(
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.4), BlendMode.dstATop),
                        image: const AssetImage(
                            'assets/card_items/metal_texture.jpg'),
                        fit: BoxFit.cover)
                    : null,
                color: cardBgColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(9), topRight: Radius.circular(9))),
            child: Column(children: [
              const Gap(25),
              Row(
                children: [
                  const Spacer(),
                  RotatedBox(
                      quarterTurns: 1,
                      child: SvgPicture.asset(
                        'assets/card_items/gold_emv.svg',
                        width: 36,
                      )),
                  const Gap(19),
                  SvgPicture.asset(
                    'assets/card_items/wifi.svg',
                    color: logoColor,
                  ),
                  const Gap(13),
                ],
              ),
              const Spacer(),
              Image.asset(
                'assets/icons/geniuspay_icon.png',
                width: 65,
                color: logoColor,
              ),
              const Gap(21),
            ]),
          )),
    ]);
  }
}
