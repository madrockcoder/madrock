import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/card_create/dialogs_popups/dialogs_and_popups.dart';
import 'package:geniuspay/app/card_create/pages/cancel_card/cancel_card_screen.dart';
import 'package:geniuspay/app/card_create/pages/card_limits/card_limits_screen.dart';
import 'package:geniuspay/app/card_create/pages/change_pin/change_pin_screen.dart';
import 'package:geniuspay/app/shared_widgets/add_icon_button.dart';
import 'package:google_fonts/google_fonts.dart';

// import '../../../../application/const.dart';
// import '../../../../gen/assets.gen.dart';
import '../../../../util/color_scheme.dart';

//Variables for this screen
bool lockCard = false;
bool twoFA = false;
//

class YourCardScreen extends StatefulWidget {
  const YourCardScreen({Key? key}) : super(key: key);
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const YourCardScreen()),
    );
  }

  @override
  State<YourCardScreen> createState() => _YourCardScreenState();
}

class _YourCardScreenState extends State<YourCardScreen> {
  bool showDetails = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      initialDialog(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColor.kWhiteColor,
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
        title: Center(
          child: Text(
            'Your Cards',
            style: textTheme.titleLarge
                ?.copyWith(color: AppColor.kOnPrimaryTextColor),
          ),
        ),
        actions: [
          AddIconButton(
            onTap: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
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
                          Text(
                              showDetails
                                  ? '1234 5678 14456 1289'
                                  : '**** **** **** 1289',
                              style: Theme.of(context).textTheme.bodyLarge),
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
              margin: const EdgeInsets.only(top: 35),
              child: InkWell(
                  onTap: () {},
                  child: Image.asset(
                    'assets/backgrounds/apple-wallet-button.png',
                    width: 112,
                  )),
            ),
            Container(
              margin: const EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  ListTile(
                      leading: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: const Color(0xff008AA7),
                            borderRadius: BorderRadius.circular(25)),
                        child: SvgPicture.asset(
                          'assets/icons/lock-card.svg',
                          fit: BoxFit.scaleDown,
                          height: 30,
                        ),
                      ),
                      title: Text(
                        "Lock card",
                        style: textTheme.titleMedium
                            ?.copyWith(color: AppColor.kOnPrimaryTextColor2),
                      ),
                      subtitle: Text(
                        'You can lock and unlock it anytime',
                        style: textTheme.titleSmall
                            ?.copyWith(color: AppColor.kOnPrimaryTextColor3),
                      ),
                      trailing: CupertinoSwitch(
                        value: lockCard,
                        onChanged: (value) {
                          setState(() {
                            lockCard = value;
                          });
                        },
                        activeColor: const Color(0xff008AA7),
                        trackColor: const Color(0xffE0F7FE),
                      )),
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    child: ListTile(
                        leading: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: const Color(0xff008AA7),
                              borderRadius: BorderRadius.circular(25)),
                          child: SvgPicture.asset(
                            'assets/icons/Shield Done.svg',
                            fit: BoxFit.scaleDown,
                            height: 30,
                          ),
                        ),
                        title: Text(
                          "2-Factor authentication",
                          style: textTheme.titleMedium
                              ?.copyWith(color: AppColor.kOnPrimaryTextColor2),
                        ),
                        subtitle: Text(
                          'Enable additional protection',
                          style: textTheme.titleSmall
                              ?.copyWith(color: AppColor.kOnPrimaryTextColor3),
                        ),
                        trailing: CupertinoSwitch(
                          value: twoFA,
                          onChanged: (value) {
                            setState(() {
                              twoFA = value;
                            });
                          },
                          activeColor: const Color(0xff008AA7),
                          trackColor: const Color(0xffE0F7FE),
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => const ChangePin())));
                        },
                        leading: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: const Color(0xff008AA7),
                              borderRadius: BorderRadius.circular(25)),
                          child: SvgPicture.asset(
                            'assets/icons/123.svg',
                            fit: BoxFit.scaleDown,
                            height: 30,
                          ),
                        ),
                        title: Text(
                          "Change PIN",
                          style: textTheme.titleMedium
                              ?.copyWith(color: AppColor.kOnPrimaryTextColor2),
                        ),
                        subtitle: Text(
                          'Set new PIN',
                          style: textTheme.titleSmall
                              ?.copyWith(color: AppColor.kOnPrimaryTextColor3),
                        ),
                        trailing: SvgPicture.asset(
                          'assets/faq/Arrow - Down.svg',
                          width: 14.0,
                          height: 14.0,
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => const CardLimit())));
                        },
                        leading: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: const Color(0xff008AA7),
                              borderRadius: BorderRadius.circular(25)),
                          child: SvgPicture.asset(
                            'assets/icons/card-limits.svg',
                            fit: BoxFit.scaleDown,
                            height: 30,
                          ),
                        ),
                        title: Text(
                          "Card Limits",
                          style: textTheme.titleMedium
                              ?.copyWith(color: AppColor.kOnPrimaryTextColor2),
                        ),
                        subtitle: Text(
                          'Manage spending amounts',
                          style: textTheme.titleSmall
                              ?.copyWith(color: AppColor.kOnPrimaryTextColor3),
                        ),
                        trailing: SvgPicture.asset(
                          'assets/faq/Arrow - Down.svg',
                          width: 14.0,
                          height: 14.0,
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => const CancelCard())));
                        },
                        leading: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: const Color(0xff008AA7),
                              borderRadius: BorderRadius.circular(25)),
                          child: SvgPicture.asset(
                            'assets/icons/cancel-card.svg',
                            fit: BoxFit.scaleDown,
                            height: 30,
                          ),
                        ),
                        title: Text(
                          "Cancel Card",
                          style: textTheme.titleMedium
                              ?.copyWith(color: AppColor.kOnPrimaryTextColor2),
                        ),
                        subtitle: Text(
                          'Manage spending amounts',
                          style: textTheme.titleSmall
                              ?.copyWith(color: AppColor.kOnPrimaryTextColor3),
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
      )),
    );
  }
}
