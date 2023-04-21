import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/jar/pages/set_frequency_screen.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/radio_list_tile.dart';
import 'package:geniuspay/app/shared_widgets/size_config.dart';

import '../../../util/color_scheme.dart';

class SetGoalDurationSheet extends StatefulWidget {
  const SetGoalDurationSheet({
    Key? key,
    this.amount,
    this.endDate,
    this.name,
    this.image,
  }) : super(key: key);

  final Widget? image;
  final String? name;
  final String? amount;
  final String? endDate;

  @override
  State<SetGoalDurationSheet> createState() => _SetGoalDurationSheetState();
}

class _SetGoalDurationSheetState extends State<SetGoalDurationSheet> {
  bool? isSelected = false;
  final List<String> _texts = [
    '1 month (3% interest p.a)',
    '3 month (4% interest p.a)',
    '6 month (5% interest p.a)',
    '1 year (6% interest p.a)',
    '2 years (7% interest p.a)',
  ];

  int? _isChecked = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: SizeConfig.screenHeight! / 1.2,
      child: Padding(
        padding: const EdgeInsets.only(top: 27.0, left: 24, right: 24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close,
                    color: AppColor.kSecondaryColor,
                    size: 23,
                  ),
                ),
                Text('Set a goal duration', style: textTheme.titleLarge),
                const SizedBox.shrink(),
              ],
            ),
            const Gap(24),
            Container(
              height: 32,
              width: 335,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(34),
                  border: Border.all(color: AppColor.kSecondaryColor)),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isSelected = false;
                          });
                        },
                        child: Container(
                          height: 28,
                          width: 165,
                          decoration: BoxDecoration(
                              color: !isSelected!
                                  ? AppColor.kSecondaryColor
                                  : AppColor.kWhiteColor,
                              borderRadius: BorderRadius.circular(100)),
                          child: Center(
                            child: Text('Fixed term',
                                style: !isSelected!
                                    ? textTheme.bodyMedium
                                        ?.copyWith(color: Colors.white)
                                    : textTheme.bodyMedium),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isSelected = true;
                          });
                        },
                        child: Container(
                          height: 28,
                          width: 165,
                          decoration: BoxDecoration(
                              color: isSelected!
                                  ? AppColor.kSecondaryColor
                                  : AppColor.kWhiteColor,
                              borderRadius: BorderRadius.circular(100)),
                          child: Center(
                            child: Text('I’m flexible',
                                style: isSelected!
                                    ? textTheme.bodyMedium
                                        ?.copyWith(color: Colors.white)
                                    : textTheme.bodyMedium),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(24),
            Text(
                'Earn an interest rate of up to 7% p.a when you save with a fixed term',
                style: textTheme.bodyLarge),
            const Gap(24),
            Expanded(
              child: ListView(
                children: List.generate(
                  _texts.length,
                  (index) => Column(
                    children: [
                      CustomRadioListTile(
                        groupValue: _isChecked,
                        title: Text(_texts[index]),
                        tileValue: index,
                        subtitle: null,
                        onTap: (int value) {
                          setState(() => _isChecked = value);
                        },
                        leading: null,
                      ),
                      Container(
                        height: 0.1,
                        color: AppColor.kSecondaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            CustomElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                SetFrequencyScreen.show(context, {
                  'image': widget.image,
                  'name': widget.name,
                  'amount': widget.amount,
                  'endDate': widget.endDate
                });
              },
              radius: 8,
              color: Colors.transparent,
              child: Text('SET', style: textTheme.bodyLarge),
            ),
            const Gap(24),
          ],
        ),
      ),
    );
  }
}
