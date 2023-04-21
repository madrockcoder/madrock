import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/util/color_scheme.dart';

class CalculateScreen extends StatelessWidget {
  const CalculateScreen({Key? key}) : super(key: key);
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const CalculateScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Calculate'),
        centerTitle: true,
        actions: const [HelpIconButton()],
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(children: [
            const Gap(32),
            Image.asset(
              'assets/images/geniogreen_calculate.png',
              width: 300,
            ),
            const Gap(32),
            Text(
              'Calculate your carbon footprint automatically with our simple tracker. ',
              textAlign: TextAlign.center,
              style: textTheme.bodyLarge,
            ),
            const Spacer(),
            CustomElevatedButton(
              child: Text(
                'ENABLE',
                style:
                    textTheme.bodyLarge?.copyWith(color: AppColor.kWhiteColor),
              ),
              color: AppColor.greenbg,
              onPressed: () {},
            ),
            CustomElevatedButton(
              child: Text(
                'MAYBE LATER',
                style: textTheme.bodyLarge?.copyWith(color: Colors.black),
              ),
              color: AppColor.kWhiteColor,
              onPressed: () {},
            ),
            const Gap(54)
          ])),
    );
  }
}
