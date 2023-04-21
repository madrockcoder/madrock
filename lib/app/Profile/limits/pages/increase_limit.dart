import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geniuspay/app/Profile/limits/pages/increase_limit_steps.dart';
import 'package:geniuspay/app/shared_widgets/circle_border_icon.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/util/color_scheme.dart';

class IncreaseLimitScreen extends StatefulWidget {
  const IncreaseLimitScreen({Key? key}) : super(key: key);

  @override
  State<IncreaseLimitScreen> createState() => _IncreaseLimitScreenState();
}

class _IncreaseLimitScreenState extends State<IncreaseLimitScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    double height = MediaQuery.of(context).size.height;
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
          'Increase Limits',
          style: textTheme.titleLarge
              ?.copyWith(color: AppColor.kOnPrimaryTextColor),
        ),
        actions: const [HelpIconButton()],
      ),
      body: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'To increase your limit, let us quickly verify your residential address',
              textAlign: TextAlign.center,
              style: textTheme.headlineMedium
                  ?.copyWith(color: AppColor.kSecondaryColor, fontSize: 20),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30, bottom: 30),
              child: CircleBorderIcon(
                size: 200,
                gradientStart: const Color(0xff008AA7).withOpacity(.2),
                gradientEnd: AppColor.kAccentColor2,
                gapColor: Colors.white,
                bgColor: AppColor.kAccentColor2,
                child: Image.asset(
                  'assets/limits/image1.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Text(
              'We must ask you for it as part of the money laundring regulations.',
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(left: 24, right: 24),
        height: height / 6,
        child: Column(
          children: [
            CustomElevatedButton(
                color: AppColor.kGoldColor2,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const IncreaseLimitSteps())));
                },
                child: Text(
                  'CONTINUE',
                  style: textTheme.bodyLarge,
                )),
            CustomElevatedButton(
                color: AppColor.kWhiteColor,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'NOT NOW',
                  style: textTheme.bodyLarge,
                )),
          ],
        ),
      ),
    );
  }
}
