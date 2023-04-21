import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/geniogreen/screens/offset_choose_plan.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/util/color_scheme.dart';

class OffsetScreen extends StatelessWidget {
  const OffsetScreen({Key? key}) : super(key: key);
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const OffsetScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Offset'),
        centerTitle: true,
        actions: const [HelpIconButton()],
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(children: [
            const Gap(32),
            Stack(alignment: Alignment.center, children: [
              Image.asset(
                'assets/images/geniogreen_offset_co2.png',
                width: 300,
              ),
              Column(
                children: [
                  Text(
                    'Co2',
                    style:
                        textTheme.bodyLarge?.copyWith(color: AppColor.greenbg),
                  ),
                  Text('100 kg', style: textTheme.displaySmall),
                  Text(
                    'So far this week',
                    style:
                        textTheme.bodyMedium?.copyWith(color: AppColor.greenbg),
                  )
                ],
              )
            ]),
            const Gap(32),
            Text(
              'Choose your favorite project to offset the actual carbon you have emitted.',
              textAlign: TextAlign.center,
              style: textTheme.bodyLarge,
            ),
            const Gap(16),
            Text(
              'Change the Climate Change with one simple click.',
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(color: AppColor.greenbg),
            ),
            const Spacer(),
            CustomElevatedButton(
              child: Text(
                'ENABLE',
                style:
                    textTheme.bodyLarge?.copyWith(color: AppColor.kWhiteColor),
              ),
              color: AppColor.greenbg,
              onPressed: () {
                OffsetChoosePlan.show(context);
              },
            ),
            const Gap(54)
          ])),
    );
  }
}
