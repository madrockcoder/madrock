import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:google_fonts/google_fonts.dart';

class CardWidgetTemplate extends StatefulWidget {
  final Color cardBgColor;
  final Color logoColor;
  final Color? border;
  final bool metallic;
  final Color? textColor;
  const CardWidgetTemplate(
      {Key? key,
      required this.cardBgColor,
      required this.logoColor,
      required this.metallic,
      this.border,
      this.textColor})
      : super(key: key);

  @override
  State<CardWidgetTemplate> createState() => _CardWidgetTemplateState();
}

class _CardWidgetTemplateState extends State<CardWidgetTemplate> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    double height = MediaQuery.of(context).size.height - 60;
    return FlipCard(
      direction: FlipDirection.HORIZONTAL,
      front: Container(
        // height: height * 0.50,
        width: (height * 0.50) * .64,
        padding: const EdgeInsets.only(
          top: 25,
          bottom: 14,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          border:
              widget.border != null ? Border.all(color: widget.border!) : null,
          image: widget.metallic
              ? DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.4), BlendMode.dstATop),
                  image:
                      const AssetImage('assets/card_items/metal_texture.jpg'),
                  fit: BoxFit.cover)
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.8),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 5),
            ),
          ],
          color: widget.cardBgColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RotatedBox(
                    quarterTurns: 1,
                    child: SvgPicture.asset(
                      'assets/card_items/gold_emv.svg',
                      width: 35,
                    )),
                const Gap(19),
                SvgPicture.asset(
                  'assets/card_items/wifi.svg',
                  color: widget.logoColor,
                ),
                const Gap(13),
              ],
            ),
            Container(
              alignment: Alignment.center,
              width: height / 12,
              child: SvgPicture.asset(
                'assets/images/logo_white.svg',
                color: widget.logoColor,
                fit: BoxFit.scaleDown,
              ),
            ),
            Container(
                padding: const EdgeInsets.only(right: 12),
                alignment: Alignment.bottomRight,
                child: SvgPicture.asset(
                  'assets/card_items/mastercard_logo.svg',
                  width: height / 10,
                  color: Colors.black,
                ))
          ],
        ),
      ),

      /////////////////////////////////////////

      back: Container(
        // height: height * 0.50,
        width: (height * 0.50) * .64,
        padding:
            const EdgeInsets.only(top: 25, bottom: 20, right: 25, left: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.8),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 5),
            ),
          ],
          color: widget.cardBgColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('CARD NUMBER',
                style: textTheme.bodyMedium?.copyWith(
                    color: widget.textColor ?? AppColor.kOnPrimaryTextColor)),
            Container(
                margin: const EdgeInsets.only(top: 5),
                child: Text('4241\n6200\n0012\n8946\n8946',
                    style: GoogleFonts.spaceMono(
                        fontWeight: FontWeight.w900,
                        color: widget.textColor ?? AppColor.kOnPrimaryTextColor,
                        fontSize: height / 50))),
            Container(
                margin: const EdgeInsets.only(top: 15),
                child: Text('CARD HOLDER NAME',
                    style: textTheme.bodyLarge?.copyWith(
                        fontSize: 7,
                        color:
                            widget.textColor ?? AppColor.kOnPrimaryTextColor))),
            Container(
                margin: const EdgeInsets.only(top: 15),
                child: Text('EXPIRY DATE',
                    style: textTheme.bodyMedium?.copyWith(
                        fontSize: 7,
                        color:
                            widget.textColor ?? AppColor.kOnPrimaryTextColor))),
            Text('12/2026',
                style: textTheme.bodyLarge?.copyWith(
                    fontSize: 10,
                    color: widget.textColor ?? AppColor.kOnPrimaryTextColor)),
            Row(
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: Column(
                      children: [
                        Text('CVC',
                            style: textTheme.bodyMedium?.copyWith(
                                fontSize: 7,
                                color: widget.textColor ??
                                    AppColor.kOnPrimaryTextColor)),
                        Text('993',
                            style: textTheme.bodyLarge?.copyWith(
                                fontSize: 9,
                                color: widget.textColor ??
                                    AppColor.kOnPrimaryTextColor)),
                      ],
                    )),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: 45,
                  width: 59.9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.8),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: const Offset(0, 0),
                        ),
                      ],
                      gradient: const LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color(0xff9F9B9A),
                          Color(0xffD4D1BC),
                          Color(0xff9F9B9A),
                        ],
                      )),
                )
              ],
            )
          ],
        ),
      ),
      ////////////////////////////////
    );
  }
}
