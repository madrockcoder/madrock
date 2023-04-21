import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/util/color_scheme.dart';

class BudgetWidget extends StatelessWidget {
  const BudgetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Opacity(
        opacity: 0.3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Budget',
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
                    'assets/home/budget.png',
                    width: 44,
                  ),
                ),
                const Gap(8),
                const Text(
                    'Take control of your spendings, track\nyour progress and save money!'),
                const Gap(8),
                IntrinsicWidth(
                    child: CustomElevatedButton(
                        onPressed: () {},
                        height: 42,
                        color: AppColor.kSecondaryColor,
                        child: Text(
                          'SET A BUDGET',
                          style: textTheme.bodyLarge
                              ?.copyWith(color: Colors.white),
                        )))
              ]),
            ),
          ],
        ));
  }
}
