// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:geniuspay/app/shared_widgets/circle_border_icon.dart';
import 'package:geniuspay/util/color_scheme.dart';

class AccountRestricted extends StatefulWidget {
  const AccountRestricted({Key? key}) : super(key: key);

  @override
  State<AccountRestricted> createState() => _AccountRestrictedState();
}

class _AccountRestrictedState extends State<AccountRestricted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(
          onPressed: () {
            accountRestricted(context);
          },
          child: const Text("Account restricted"),
          color: Colors.blueAccent,
        ),
      ),
    );
  }
}

//To open this just call this function and provide context inside onTap/onPressed function
Future<String?> accountRestricted(BuildContext context) {
  return showModalBottomSheet<String>(
    backgroundColor: Colors.transparent,
    context: context,
    isScrollControlled: true,
    builder: (BuildContext ctx) {
      final height = MediaQuery.of(context).size.height;
      final textTheme = Theme.of(context).textTheme;
      return StatefulBuilder(
        builder: (BuildContext context, setState) => Container(
            padding: const EdgeInsets.only(
              top: 30,
            ),
            height: height / 1.2,
            decoration: const BoxDecoration(
                color: Color(0xffFFFFFF),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(right: 30, left: 30),
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: AppColor.kSecondaryColor,
                      )),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(right: 30, left: 30),
                  margin: const EdgeInsets.only(top: 25),
                  child: Text(
                    'Your account is restricted',
                    style: textTheme.headline3
                        ?.copyWith(color: AppColor.kSecondaryColor),
                  ),
                ),
                Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 30, bottom: 20),
                    child: CircleBorderIcon(
                        gradientStart: const Color(0xff008AA7).withOpacity(.2),
                        gradientEnd: AppColor.kAccentColor2,
                        gapColor: Colors.white,
                        bgColor: AppColor.kAccentColor2,
                        child: Icon(
                          Icons.block_flipped,
                          size: 50,
                          color: AppColor.kSecondaryColor,
                        ))),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 30),
                  margin: const EdgeInsets.only(top: 20),
                  child: Text(
                    'Your KYC questionnaire is under review, which will take up to 10 working days.',
                    textAlign: TextAlign.center,
                    style: textTheme.bodyText2
                        ?.copyWith(color: AppColor.kOnPrimaryTextColor3),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.only(
                    left: 30,
                    right: 30,
                  ),
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: AppColor.kSecondaryColor,
                    ),
                    child: Image.asset('assets/create_categories/Vector.png'),
                  ),
                  title: Text(
                    'Card Payments',
                    style: textTheme.subtitle1,
                  ),
                  trailing: Text(
                    'RESTRICTED',
                    style: textTheme.subtitle1
                        ?.copyWith(color: AppColor.kRedColor),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.only(
                    left: 30,
                    right: 30,
                  ),
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: AppColor.kSecondaryColor,
                    ),
                    child:
                        Image.asset('assets/create_categories/Vector (1).png'),
                  ),
                  title: Text(
                    'Transfer',
                    style: textTheme.subtitle1,
                  ),
                  trailing: Text(
                    'RESTRICTED',
                    style: textTheme.subtitle1
                        ?.copyWith(color: AppColor.kRedColor),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.only(
                    left: 30,
                    right: 30,
                  ),
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: AppColor.kSecondaryColor,
                    ),
                    child:
                        Image.asset('assets/create_categories/Vector (2).png'),
                  ),
                  title: Text(
                    'Currency Exchange',
                    style: textTheme.subtitle1,
                  ),
                  trailing: Text(
                    'RESTRICTED',
                    style: textTheme.subtitle1
                        ?.copyWith(color: AppColor.kRedColor),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.only(
                    left: 30,
                    right: 30,
                  ),
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: (BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: AppColor.kSecondaryColor)),
                    child:
                        Image.asset('assets/create_categories/Vector (3).png'),
                  ),
                  title: Text(
                    'Account details',
                    style: textTheme.subtitle1,
                  ),
                  trailing: Text(
                    'RESTRICTED',
                    style: textTheme.subtitle1
                        ?.copyWith(color: AppColor.kRedColor),
                  ),
                )
              ],
            )),
      );
    },
  );
}
