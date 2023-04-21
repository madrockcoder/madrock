import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../models/insurance_onboarding.dart';
import '../../../util/color_scheme.dart';
import '../../../util/constants.dart';
import '../../../util/enums.dart';
import '../../shared_widgets/animated.column.dart';

class InsuranceWalkThrough extends StatefulWidget {
  final InsuranceOnboarding data;
  const InsuranceWalkThrough({Key? key, required this.data}) : super(key: key);

  @override
  State<InsuranceWalkThrough> createState() => _InsuranceWalkThroughState();
}

class _InsuranceWalkThroughState extends State<InsuranceWalkThrough> {
  late InsuranceOnboarding data;

  @override
  void initState() {
    data = widget.data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            if (data.insurancePlan == InsurancePlan.basic)
              const Padding(
                  padding: EdgeInsets.only(left: thirtyDp, right: thirtyDp),
                  child: Text("The more money you send,the better your insurance gets",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColor.kSecondaryColor, fontWeight: FontWeight.w600))),
            const Gap(sixteenDp),
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: fiftyDp),
                  padding: const EdgeInsets.all(twentyDp),
                  decoration: BoxDecoration(boxShadow: [
                    if (data.insurancePlan == InsurancePlan.gold)
                      BoxShadow(
                        color: AppColor.kGoldColor.withOpacity(0.3),
                        offset: const Offset(
                          5.0,
                          5.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      ),
                  ], borderRadius: BorderRadius.circular(thirtyDp), color: Colors.white),
                  child: AnimatedColumnWidget(duration: 200, crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const SizedBox(height: thirtySixDp),
                    Center(
                        child: Text(getInsurancePlaneEnum(data.insurancePlan),
                            style: textTheme.headline1!.copyWith(fontSize: eighteenDp))),
                    const SizedBox(height: sixDp),
                    Center(
                      child: Text(data.description,
                          style: textTheme.labelMedium!.copyWith(
                              color: data.insurancePlan == InsurancePlan.basic
                                  ? AppColor.kSecondaryColor
                                  : data.insurancePlan == InsurancePlan.silver
                                      ? AppColor.kLightBlack
                                      : AppColor.kGold,
                              fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(height: sixteenDp),
                    rowItem(
                        a: Padding(
                          padding: const EdgeInsets.only(top: sixteenDp),
                          child: Text("Accidental death,\ndismemberment, or\nparalysis", style: textTheme.bodyText1!),
                        ),
                        b: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                          Text('Up to', style: textTheme.labelLarge!.copyWith(color: AppColor.kLightBlack)),
                          Text(data.accidentCost, style: textTheme.bodyText1),
                        ])),
                    const SizedBox(height: fourDp),
                    divider(data),
                    rowItem(
                        a: Padding(
                          padding: const EdgeInsets.only(top: fourDp),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Temporary total\ndisability", style: textTheme.bodyText1!),
                              const Text("(caused by an accident)", style: TextStyle(color: AppColor.kLightBlack)),
                            ],
                          ),
                        ),
                        b: data.insurancePlan != InsurancePlan.basic
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('One-time', style: textTheme.labelLarge!.copyWith(color: AppColor.kLightBlack)),
                                  Text('payment of', style: textTheme.labelLarge!.copyWith(color: AppColor.kLightBlack)),
                                  Text('€400', style: textTheme.bodyText1),
                                ],
                              )
                            : Text(data.temporalDisabilityCost)),
                    const SizedBox(height: fourDp),
                    divider(data),
                    const SizedBox(height: fourDp),
                    Text("In case of death due to an accident:",
                        style: textTheme.bodyText1!.copyWith(
                            color: data.insurancePlan == InsurancePlan.basic
                                ? AppColor.kGenioGreenColor
                                : data.insurancePlan == InsurancePlan.silver
                                    ? Colors.black
                                    : AppColor.kGold)),
                    const SizedBox(height: sixDp),
                    rowItem(
                        a: Text("Funeral costs", style: textTheme.bodyText1),
                        b: data.insurancePlan != InsurancePlan.basic
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('Up to', style: textTheme.labelLarge!.copyWith(color: AppColor.kLightBlack)),
                                  Text('€400', style: textTheme.bodyText1)
                                ],
                              )
                            : Text(
                                data.funeralCost,
                                style: textTheme.bodyText1,
                              )),
                    const SizedBox(height: tenDp),
                    const Text('OR', style: TextStyle(color: AppColor.kLightBlack)),
                    const SizedBox(height: tenDp),
                    rowItem(
                        a: Text("Reparation", style: textTheme.bodyText1),
                        b: data.insurancePlan != InsurancePlan.basic
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text('Service', style: TextStyle(color: AppColor.kLightBlack)),
                                  Text('provided by', style: TextStyle(color: AppColor.kLightBlack)),
                                  Text('AIG', style: TextStyle(color: AppColor.kLightBlack)),
                                ],
                              )
                            : Text('N/A', style: textTheme.bodyText1)),
                    const SizedBox(height: twentyFourDp),
                  ]),
                ),
                Center(child: Image.asset(data.icon, width: hundredDp)),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget rowItem({required Widget a, required Widget b}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [a, b],
    );
  }

  TextSpan textSpan(String value, TextStyle textStyle, {TapGestureRecognizer? recognizer}) {
    return TextSpan(
      recognizer: recognizer,
      text: value,
      style: textStyle,
    );
  }

  Widget divider(InsuranceOnboarding data) {
    return Divider(
      color: data.insurancePlan == InsurancePlan.basic
          ? AppColor.kGenioGreenColor.withOpacity(0.2)
          : data.insurancePlan == InsurancePlan.silver
              ? AppColor.kGrayColor
              : AppColor.kGold.withOpacity(0.2),
      thickness: 1.5,
    );
  }
}
