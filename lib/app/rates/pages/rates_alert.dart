import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geniuspay/app/rates/pages/create_alert.dart';
import 'package:geniuspay/app/shared_widgets/circle_border_icon.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/util/color_scheme.dart';

class RatesAlert extends StatefulWidget {
  const RatesAlert({Key? key}) : super(key: key);

  @override
  State<RatesAlert> createState() => _RatesAlertState();
}

class _RatesAlertState extends State<RatesAlert> {
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
        centerTitle: true,
        title: Text(
          'Rate alerts',
          style: textTheme.titleLarge?.copyWith(color: AppColor.kOnPrimaryTextColor, fontWeight: FontWeight.w700),
        ),
        actions: [
          HelpIconButton(
            onTap: () {},
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 30, bottom: 20),
                child: CircleBorderIcon(
                    gradientStart: const Color(0xff008AA7).withOpacity(.2),
                    gradientEnd: AppColor.kAccentColor2,
                    gapColor: Colors.white,
                    bgColor: AppColor.kAccentColor2,
                    child: Image.asset(
                      'assets/rates_icons/bell.png',
                      height: 50,
                      width: 50,
                      fit: BoxFit.scaleDown,
                    ))),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 20),
              child: Text(
                'Never miss a great rate again. Get notified for the exchange rates daily or when they reach your target.',
                textAlign: TextAlign.center,
                style:
                    textTheme.titleSmall?.copyWith(color: AppColor.kOnPrimaryTextColor, fontWeight: FontWeight.w400, fontSize: 14),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomElevatedButton(
                    child: Text('CREATE ALERT', style: Theme.of(context).textTheme.bodyLarge),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateAlert()));
                    },
                    color: AppColor.kGoldColor2,
                    radius: 8,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
