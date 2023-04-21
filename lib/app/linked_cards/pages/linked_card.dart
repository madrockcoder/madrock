// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geniuspay/app/linked_cards/pages/auto_card_details.dart';
import 'package:geniuspay/app/shared_widgets/circle_border_icon.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/util/color_scheme.dart';

class LinkedCardScreen extends StatefulWidget {
  const LinkedCardScreen({Key? key}) : super(key: key);

  @override
  State<LinkedCardScreen> createState() => _LinkedCardScreenState();
}

class _LinkedCardScreenState extends State<LinkedCardScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    double width = MediaQuery.of(context).size.width;
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
        centerTitle: true,
        title: Text(
          'Linked cards',
          style: textTheme.titleLarge?.copyWith(color: AppColor.kOnPrimaryTextColor),
        ),
        actions: [
          HelpIconButton(
            onTap: () {},
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 30, bottom: 20),
                child: CircleBorderIcon(
                    gradientStart: const Color(0xff008AA7).withOpacity(.2),
                    gradientEnd: AppColor.kAccentColor2,
                    gapColor: Colors.white,
                    bgColor: AppColor.kAccentColor2,
                    child: Image.asset(
                      'assets/linked_cards/cards.png',
                      height: 75,
                      width: 75,
                      fit: BoxFit.scaleDown,
                    ))),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 20),
              child: Text(
                'Add a credit or debit card to geniuspay to make secue payments.',
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(color: AppColor.kOnPrimaryTextColor3),
              ),
            ),

// Use this ListTile to show already created cards

            // ListTile(
            //   leading: Image.asset('assets/linked_cards/colorful_mastercard.png'),
            //   title: Transform.translate(
            //     offset: Offset(-13, 0),
            //     child: Text(
            //       'Mastercard x-123',
            //       style: textTheme.subtitle1,
            //     ),
            //   ),
            //   trailing: Container(
            //     width: width / 3.2,
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Text(
            //           'Expires 03/24',
            //           style: textTheme.subtitle2?.copyWith(color: AppColor.kblue),
            //         ),
            //         Icon(Icons.delete)
            //       ],
            //     ),
            //   ),
            // )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(24),
          child: CustomElevatedButton(
              color: AppColor.kGoldColor2,
              onPressed: () {
                addCardAuto(context);
              },
              child: Text(
                'ADD CARD',
                style: textTheme.bodyLarge,
              ))),
    );
  }
}
