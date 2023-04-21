import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/util/color_scheme.dart';

class ExchangeRatesWidget extends StatelessWidget {
  const ExchangeRatesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Opacity(
        opacity: 0.3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Exchange rates',
              style: textTheme.titleLarge
                  ?.copyWith(color: AppColor.kSecondaryColor),
            ),
            const Gap(8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border:
                      Border.all(color: AppColor.kSecondaryColor, width: 1.5),
                  borderRadius: BorderRadius.circular(8)),
              child: Column(children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: AppColor.kAccentColor2,
                  child: Image.asset(
                    'assets/home/exchange.png',
                    width: 44,
                  ),
                ),
                const Gap(8),
                const Text('Sending money abroad? Enjoy our live-rates!'),
                const Gap(8),
                IntrinsicWidth(
                    child: CustomElevatedButton(
                        onPressed: () {},
                        height: 42,
                        color: AppColor.kSecondaryColor,
                        child: Text(
                          'CHECK OUR RATES',
                          style: textTheme.bodyLarge
                              ?.copyWith(color: Colors.white),
                        )))
              ]),
            ),
          ],
        ));
  }
}
