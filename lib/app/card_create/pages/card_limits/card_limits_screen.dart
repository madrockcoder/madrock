import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/card_create/dialogs_popups/dialogs_and_popups.dart';
import 'package:geniuspay/app/card_create/pages/card_limits/card_limit_atm.dart';
import 'package:geniuspay/app/card_create/pages/card_limits/card_limit_internet.dart';
import 'package:geniuspay/app/card_create/pages/card_limits/card_limit_shop.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:google_fonts/google_fonts.dart';

class CardLimit extends StatefulWidget {
  const CardLimit({Key? key}) : super(key: key);

  @override
  State<CardLimit> createState() => _CardLimitState();
}

class _CardLimitState extends State<CardLimit> {
  String maskAccountId(String accountId) {
    /** Condition will only executes if accountId is *not* undefined, null, empty, false or 0*/
    final accountIdLength = accountId.length;
    final maskedLength = accountIdLength - 4;
    /** Modify the length as per your wish */
    String newString = accountId;
    for (var i = 0; i < accountIdLength; i++) {
      if (i < maskedLength) {
        newString = newString.replaceFirst(accountId[i], '*');
      }
    }

    return newString;

    /**Will handle if no string is passed */
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset(
              'assets/share_with_contact/arrowback.svg',
              fit: BoxFit.scaleDown,
              height: 15,
              width: 15,
              color: Colors.black,
            ),
          ),
          title: Container(
            margin: const EdgeInsets.only(right: 30),
            child: Center(
              child: Text(
                'Card limits',
                style: textTheme.titleLarge
                    ?.copyWith(color: AppColor.kOnPrimaryTextColor),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 38, left: 24, right: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.width / 1.9,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: AppColor.kGoldColor2,
                  borderRadius: BorderRadius.circular(9),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: const Offset(2, 5),
                        spreadRadius: 2,
                        blurRadius: 10)
                  ],
                ),
                child: Stack(
                  fit: StackFit.passthrough,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Transform.translate(
                        offset: const Offset(-10, -10),
                        child: InkWell(
                          onTap: () {
                            cardView(context);
                          },
                          child: Container(
                            height: 31,
                            width: 31,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.black),
                            child: const Center(
                              child: Icon(Icons.visibility_outlined,
                                  size: 26, color: AppColor.kWhiteColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 24.0, top: 11),
                        child: Image.asset('assets/backgrounds/chip.png',
                            height: 52, width: 34),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 24.0, top: 11),
                        child: Image.asset('assets/backgrounds/master_card.png',
                            height: 54, width: 46),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 24.0, top: 11),
                        child: Image.asset('assets/backgrounds/cloud.png',
                            height: 54, width: 46),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 24.0, bottom: 11),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text('99999999 9999 9999'),
                            const Gap(11),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'EXPIRY DATE',
                                      style: GoogleFonts.spaceMono(
                                          fontSize: 10, color: Colors.black),
                                    ),
                                    Text(
                                      '12/2026',
                                      style: GoogleFonts.spaceMono(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                const Gap(30),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'CVV',
                                      style: GoogleFonts.spaceMono(
                                          fontSize: 10, color: Colors.black),
                                    ),
                                    Text(
                                      '***',
                                      style: GoogleFonts.spaceMono(
                                          fontSize: 8,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 12),
                      child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        const CardLimitAtm())));
                          },
                          title: Text(
                            "ATMs",
                            style: textTheme.titleMedium?.copyWith(
                                color: AppColor.kOnPrimaryTextColor2),
                          ),
                          subtitle: Text(
                            'Cash transactions limit - how much you can withdraw from ATMs.',
                            style: textTheme.titleSmall?.copyWith(
                                color: AppColor.kOnPrimaryTextColor3),
                          ),
                          trailing: SvgPicture.asset(
                            'assets/faq/Arrow - Down.svg',
                            width: 14.0,
                            height: 14.0,
                          )),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        const CardLimitShop())));
                          },
                          title: Text(
                            "Shops",
                            style: textTheme.titleMedium?.copyWith(
                                color: AppColor.kOnPrimaryTextColor2),
                          ),
                          subtitle: Text(
                            'Contactless payments limit - how much you can pay with your card for shopping.',
                            style: textTheme.titleSmall?.copyWith(
                                color: AppColor.kOnPrimaryTextColor3),
                          ),
                          trailing: SvgPicture.asset(
                            'assets/faq/Arrow - Down.svg',
                            width: 14.0,
                            height: 14.0,
                          )),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        const CardLimitInternet())));
                          },
                          title: Text(
                            "Internet",
                            style: textTheme.titleMedium?.copyWith(
                                color: AppColor.kOnPrimaryTextColor2),
                          ),
                          subtitle: Text(
                            'Internet transactions limit - how much you can pay with your card online.',
                            style: textTheme.titleSmall?.copyWith(
                                color: AppColor.kOnPrimaryTextColor3),
                          ),
                          trailing: SvgPicture.asset(
                            'assets/faq/Arrow - Down.svg',
                            width: 14.0,
                            height: 14.0,
                          )),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
