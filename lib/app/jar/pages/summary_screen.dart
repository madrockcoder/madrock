import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/jar/widgets/dont_have_enough_fund_bottom_sheet.dart';
import 'package:geniuspay/app/shared_widgets/custom_divider.dart';

import 'package:geniuspay/app/jar/widgets/assets.gen.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import '../../../util/color_scheme.dart';
import '../widgets/jar_app_bar.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({
    Key? key,
    this.amount,
    this.image,
    this.name,
    this.contribution,
    this.endDate,
  }) : super(key: key);

  final Widget? image;
  final String? name;
  final String? amount;
  final String? endDate;
  final String? contribution;

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  bool? roundup = false;
  bool? lockJar = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColor.kWhiteColor,
      appBar: const JarAppBar(text: 'Summary', backgroundColor: AppColor.kWhiteColor),
      body: Padding(
        padding: const EdgeInsets.only(top: 32.0, left: 24, right: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  height: 140,
                  width: 140,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Assets.backgrounds.arcStyle
                            .image(height: 140, width: 140, color: AppColor.kSecondaryColor, fit: BoxFit.contain),
                      ),
                      Center(
                        child: Container(
                          width: 100,
                          height: 100,
                          padding: EdgeInsets.all(widget.image == null ? 30 : 0),
                          decoration: BoxDecoration(
                              color: AppColor.kAccentColor2,
                              boxShadow: [
                                BoxShadow(
                                    color: const Color(0xff0A6375).withOpacity(0.2),
                                    offset: const Offset(0, 4),
                                    blurRadius: 14,
                                    spreadRadius: 0)
                              ],
                              shape: BoxShape.circle),
                          child: widget.image != null
                              ? ClipRRect(borderRadius: BorderRadius.circular(50), child: widget.image)
                              : SvgPicture.asset('assets/icons/camera.svg', height: 40, width: 40, fit: BoxFit.contain),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(16),
              Text(
                'You want to save ${widget.amount}',
                style: textTheme.headlineSmall,
              ),
              const Gap(8),
              Text(
                widget.name ?? '',
                style: textTheme.headlineSmall,
              ),
              const Gap(32),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'End date',
                    style: textTheme.titleSmall,
                  ),
                  const Gap(4),
                  Text(
                    widget.endDate ?? '',
                    style: textTheme.titleSmall,
                  ),
                  const CustomDivider(
                    sizedBoxHeight: 16,
                  ),
                  Text(
                    'Contribution',
                    style: textTheme.titleSmall,
                  ),
                  const Gap(4),
                  Text(
                    widget.contribution ?? '',
                    style: textTheme.titleSmall,
                  ),
                ],
              ),
              const Gap(
                24,
              ),
              Container(
                height: 200,
                padding: const EdgeInsets.all(
                  16,
                ),
                decoration: BoxDecoration(
                  color: AppColor.kWhiteColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff07051A).withOpacity(0.07),
                      offset: const Offset(0, 4),
                      blurRadius: 50,
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Goal Accelerator',
                      style: textTheme.bodyMedium,
                    ),
                    const Gap(16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Round up payments',
                              style: textTheme.bodyMedium,
                            ),
                            const Gap(4),
                            SizedBox(
                              width: 150,
                              child: Text(
                                'Automaticaly save spare change from round-up transactions.',
                                style: textTheme.titleSmall,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                          width: 48,
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: CupertinoSwitch(
                              activeColor: AppColor.kSecondaryColor,
                              value: roundup!,
                              onChanged: (value) {
                                setState(() {
                                  roundup = value;
                                });
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    const CustomDivider(
                      sizedBoxHeight: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Lock this Jar',
                              style: textTheme.bodyMedium,
                            ),
                            const Gap(4),
                            Text(
                              'Unlocked',
                              style: textTheme.bodyMedium,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 30,
                          width: 48,
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: CupertinoSwitch(
                              activeColor: AppColor.kSecondaryColor,
                              value: lockJar!,
                              onChanged: (value) {
                                setState(() {
                                  lockJar = value;
                                });
                              },
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const Gap(32),
              CustomElevatedButton(
                onPressed: () {
                  dontHaveEnoughFundButtomSheet(context);
                },
                radius: 8,
                color: AppColor.kGoldColor2,
                child: Text(
                  'CREATE A JAR',
                  style: textTheme.bodyLarge,
                ),
              ),
              const Gap(45),
            ],
          ),
        ),
      ),
    );
  }
}
