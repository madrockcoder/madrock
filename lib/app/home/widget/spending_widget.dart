import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/util/color_scheme.dart';

class SpendingWidget extends StatelessWidget {
  const SpendingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Opacity(
        opacity: 0.3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Spending',
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
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'June',
                            style: textTheme.bodyLarge
                                ?.copyWith(color: AppColor.kSecondaryColor),
                          ),
                          const Gap(8),
                          const Text('You haven’t made any\ntransaction yet! ')
                        ]),
                    Image.asset(
                      'assets/home/spending.png',
                      width: 80,
                    )
                  ]),
            ),
          ],
        ));
  }
}
