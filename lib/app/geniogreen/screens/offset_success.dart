import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/util/color_scheme.dart';

class OffsetSuccessScreen extends StatelessWidget {
  const OffsetSuccessScreen({Key? key}) : super(key: key);
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const OffsetSuccessScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColor.greenbg,
      appBar: AppBar(
        backgroundColor: AppColor.greenbg,
        title: const Text('Offset'),
        centerTitle: true,
        actions: const [HelpIconButton()],
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(children: [
            const Spacer(),
            Container(
              width: 140,
              height: 140,
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    colors: [AppColor.darkGreen, AppColor.greenbg],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: AppColor.greenbg,
                  shape: BoxShape.circle,
                ),
                child: const CircleAvatar(
                  backgroundColor: AppColor.darkGreen,
                  child: Icon(Icons.cloud),
                ),
              ),
            ),
            const Gap(16),
            Text(
              'Carbon Offset Successful!',
              textAlign: TextAlign.center,
              style: textTheme.headlineMedium?.copyWith(color: AppColor.darkGreen),
            ),
            const Gap(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'You have offset',
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium?.copyWith(color: Colors.white),
                ),
                Text(
                  ' 350 tons',
                  textAlign: TextAlign.center,
                  style:
                      textTheme.bodyMedium?.copyWith(color: AppColor.darkGreen),
                )
              ],
            ),
            Text(
              'of CO2',
              style: textTheme.bodyMedium?.copyWith(color: Colors.white),
            ),
            const Spacer(),
            CustomElevatedButton(
              child: Text(
                'ENABLE',
                style:
                    textTheme.bodyLarge?.copyWith(color: AppColor.kWhiteColor),
              ),
              borderColor: AppColor.darkGreen,
              color: AppColor.darkGreen,
              onPressed: () {},
            ),
            const Gap(16),
            CustomElevatedButton(
              onPressed: () {},
              child: Text(
                "BACK HOME",
                style: textTheme.bodyLarge?.copyWith(color: Colors.white),
              ),
              borderColor: AppColor.greenbg,
              color: AppColor.greenbg,
            ),
            const Gap(54)
          ])),
    );
  }
}
