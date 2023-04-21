// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/util/color_scheme.dart';

class ChangesComingSoon extends StatefulWidget {
  static Future<void> show(
    BuildContext context,
  ) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const ChangesComingSoon(),
      ),
    );
  }

  const ChangesComingSoon({Key? key}) : super(key: key);

  @override
  State<ChangesComingSoon> createState() => _ChangesComingSoonState();
}

class _ChangesComingSoonState extends State<ChangesComingSoon> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding:
            const EdgeInsets.only(top: 50, left: 25, right: 25, bottom: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SafeArea(
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/changes_screen/changes.svg',
                    height: 300,
                    width: width,
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 40),
                      child: Text(
                        'Changes are coming',
                        style: textTheme.headlineMedium
                            ?.copyWith(color: AppColor.kSecondaryColor),
                      )),
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: Text(
                      'we\'re making some changes over the next few months, which means we can\'t open GbP wallets for anyone living in the European Economic Area righ now.',
                      style: textTheme.bodyMedium
                          ?.copyWith(color: AppColor.kOnPrimaryTextColor2),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
            Column(children: [
              Container(
                margin: const EdgeInsets.only(top: 5),
                child: CustomElevatedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/changes_screen/bell.svg',
                        fit: BoxFit.scaleDown,
                        height: 16,
                        width: 16,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'NOTIFY ME',
                        style: textTheme.bodyLarge
                            ?.copyWith(color: AppColor.kWhiteColor),
                      ),
                    ],
                  ),
                  color: const Color(0xff008AA7),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8),
                child: CustomElevatedButton(
                  child: Text(
                    'GOT IT',
                    style: textTheme.bodyLarge
                        ?.copyWith(color: AppColor.kSecondaryColor),
                  ),
                  color: const Color(0xffFFFFFF),
                  onPressed: () {
                    Navigator.pop(context);
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => Promotions()));
                  },
                  radius: 8,
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
