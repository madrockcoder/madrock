// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/util/color_scheme.dart';

//Variables for this screen
bool tapToPay = false;
bool contactlessPayments = false;
bool addToApplePay = false;
//

class DeliveryCard extends StatefulWidget {
  const DeliveryCard({Key? key}) : super(key: key);

  @override
  State<DeliveryCard> createState() => _DeliveryCardState();
}

class _DeliveryCardState extends State<DeliveryCard> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColor.kAccentColor3, Colors.white],
        )),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: AppColor.kAccentColor3,
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
                'Delivery',
                style: textTheme.titleLarge
                    ?.copyWith(color: AppColor.kOnPrimaryTextColor),
              ),
            ),
            elevation: 0,
            automaticallyImplyLeading: false,
            actions: const [
              Padding(
                  padding: EdgeInsets.only(right: 20), child: HelpIconButton())
            ],
          ),
          body: Center(
            child: Container(
              padding:
                  EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 35),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'Your card is on its way',
                        style: textTheme.displayMedium
                            ?.copyWith(color: AppColor.kOnPrimaryTextColor),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(
                          'to Sienkiewicza 123/5, 50-305, Wrocław, Poland  ',
                          style: textTheme.bodyMedium
                              ?.copyWith(color: AppColor.kSecondaryColor),
                        ),
                      ),
                      Container(
                        height: height / 4.5,
                        width: width / 1.3,
                        margin: EdgeInsets.only(top: 50),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [0.5, 0],
                            colors: const [
                              Color(0xffFDAE09),
                              Color(0xff038CA8)
                            ],
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: (height / 4.5) / 1.5,
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 8),
                                    child: RotatedBox(
                                      quarterTurns: 1,
                                      child: Image.asset(
                                        'assets/customize_cards/geniuspay-icon.png',
                                        fit: BoxFit.scaleDown,
                                        color: Colors.black,
                                        height: 50.0,
                                        width: 50.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      bottom: 10, left: 15, right: 15),
                                  child: RotatedBox(
                                    quarterTurns: 1,
                                    child: SvgPicture.asset(
                                      'assets/customize_cards/mastercard-icon.svg',
                                      fit: BoxFit.scaleDown,
                                      height: 30.0,
                                      width: 40.0,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      bottom: 10, left: 15, right: 10),
                                  child: RotatedBox(
                                    quarterTurns: 1,
                                    child: Image.asset(
                                      'assets/customize_cards/chip.png',
                                      fit: BoxFit.scaleDown,
                                      height: 30.0,
                                      width: 50.0,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 25),
                        child: ListTile(
                            contentPadding: EdgeInsets.all(0),
                            leading: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: Color(0xff008AA7),
                                  borderRadius: BorderRadius.circular(25)),
                              child: SvgPicture.asset(
                                'assets/icons/fingerprint.svg',
                                fit: BoxFit.scaleDown,
                                height: 30,
                              ),
                            ),
                            title: Text(
                              "Include tap to pay funcionality",
                              style: textTheme.titleMedium?.copyWith(
                                  color: AppColor.kOnPrimaryTextColor2),
                            ),
                            subtitle: Text(
                              'You can lock and unlock it anytime',
                              style: textTheme.titleSmall?.copyWith(
                                  color: AppColor.kOnPrimaryTextColor3),
                            ),
                            trailing: CupertinoSwitch(
                              value: tapToPay,
                              onChanged: (value) {
                                setState(() {
                                  tapToPay = value;
                                });
                              },
                              activeColor: Color(0xff008AA7),
                              trackColor: Color(0xffE0F7FE),
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: ListTile(
                            contentPadding: EdgeInsets.all(0),
                            leading: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: Color(0xff008AA7),
                                  borderRadius: BorderRadius.circular(25)),
                              child: SvgPicture.asset(
                                'assets/icons/signals.svg',
                                fit: BoxFit.scaleDown,
                                height: 30,
                              ),
                            ),
                            title: Text(
                              "Add contactless payments",
                              style: textTheme.titleMedium?.copyWith(
                                  color: AppColor.kOnPrimaryTextColor2),
                            ),
                            subtitle: Text(
                              'Enable additional protection',
                              style: textTheme.titleSmall?.copyWith(
                                  color: AppColor.kOnPrimaryTextColor3),
                            ),
                            trailing: CupertinoSwitch(
                              value: contactlessPayments,
                              onChanged: (value) {
                                setState(() {
                                  contactlessPayments = value;
                                });
                              },
                              activeColor: Color(0xff008AA7),
                              trackColor: Color(0xffE0F7FE),
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: ListTile(
                            contentPadding: EdgeInsets.all(0),
                            leading: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: Color(0xff008AA7),
                                  borderRadius: BorderRadius.circular(25)),
                              child: SvgPicture.asset(
                                'assets/icons/apple.svg',
                                fit: BoxFit.scaleDown,
                                height: 30,
                              ),
                            ),
                            title: Text(
                              "Add this card to Apple Pay",
                              style: textTheme.titleMedium?.copyWith(
                                  color: AppColor.kOnPrimaryTextColor2),
                            ),
                            subtitle: Text(
                              'Enable additional protection',
                              style: textTheme.titleSmall?.copyWith(
                                  color: AppColor.kOnPrimaryTextColor3),
                            ),
                            trailing: CupertinoSwitch(
                              value: addToApplePay,
                              onChanged: (value) {
                                setState(() {
                                  addToApplePay = value;
                                });
                              },
                              activeColor: Color(0xff008AA7),
                              trackColor: Color(0xffE0F7FE),
                            )),
                      ),
                    ],
                  ),
                  CustomElevatedButton(
                    child: Text('SAVE',
                        style: Theme.of(context).textTheme.bodyLarge),
                    onPressed: () {},
                    color: AppColor.kGoldColor2,
                    radius: 8,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
