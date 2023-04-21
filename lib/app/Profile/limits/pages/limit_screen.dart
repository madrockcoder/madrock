// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geniuspay/app/Profile/limits/pages/increase_limit.dart';
import 'package:geniuspay/app/home/widget/onboarding_status_widget.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/models/transaction_limit.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/converter.dart';
import 'package:geniuspay/util/enums.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class LimitsScreen extends StatefulWidget {
  const LimitsScreen({Key? key}) : super(key: key);

  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => LimitsScreen(),
      ),
    );
  }

  @override
  State<LimitsScreen> createState() => _LimitsScreenState();
}

class _LimitsScreenState extends State<LimitsScreen> {
  final AuthenticationService _authenticationService =
      sl<AuthenticationService>();

  TransactionLimits get limits =>
      _authenticationService.user!.userProfile.transactionLimits!;

  String getExpireDate(String date) {
    try {
      final dateFormat = Converter().getDateFormatFromString(date);
      final formatted = DateFormat('dd MMM yyyy').format(dateFormat);
      return 'left until $formatted';
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
          'Limits',
          style: textTheme.titleLarge
              ?.copyWith(color: AppColor.kOnPrimaryTextColor),
        ),
        actions: const [HelpIconButton()],
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 24, right: 24),
        children: [
          Container(
            height: height / 8,
            // ignore: prefer_const_literals_to_create_immutables
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xffE0F7FE),
                  ),
                  BoxShadow(
                    color: Color(0xffFFFFFF),
                    spreadRadius: -12.0,
                    blurRadius: 25.0,
                  ),
                ]),
            child: Center(
              child: ListTile(
                contentPadding: EdgeInsets.only(left: 30, right: 30),
                title: Text(
                  'Basic',
                  style: textTheme.headlineMedium,
                ),
                subtitle: Text(
                  'Just the basics',
                  style: textTheme.titleSmall,
                ),
                trailing: Container(
                  alignment: Alignment.center,
                  height: 30,
                  width: 85,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColor.kSecondaryColor),
                  child: Text(
                    'Active',
                    style: textTheme.titleSmall
                        ?.copyWith(color: AppColor.kWhiteColor),
                  ),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 15, bottom: 10),
            child: Text(
              'Sending limit',
              style: textTheme.headlineMedium,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'From cards and accounts of other banks',
              style: textTheme.bodyMedium,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            child: SfLinearGauge(
              axisTrackStyle: LinearAxisTrackStyle(
                thickness: 10,
                edgeStyle: LinearEdgeStyle.bothCurve,
                color: AppColor.kAccentColor2,
              ),
              maximum: limits.payoutLimit.value,
              minimum: 0,
              barPointers: [
                LinearBarPointer(
                    value: limits.payoutLimit.value -
                        limits.payoutLimitRemaining.value,
                    edgeStyle: LinearEdgeStyle.bothCurve,
                    thickness: 10,
                    shaderCallback: (bounds) => RadialGradient(
                          radius: 5 * 2,
                          // ignore: prefer_const_literals_to_create_immutables
                          colors: [
                            AppColor.kSecondaryColor,
                            Color(0xff05D4FF),
                          ],
                        ).createShader(bounds))
              ],
              showLabels: false,
              showTicks: false,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (limits.payoutLimit.value -
                                  limits.payoutLimitRemaining.value)
                              .toStringAsFixed(2) +
                          " ${limits.payoutLimit.currency}",
                      style: textTheme.titleLarge
                          ?.copyWith(color: AppColor.kSecondaryColor),
                    ),
                    Text(
                      'Spent',
                      style: textTheme.bodyMedium
                          ?.copyWith(color: AppColor.kSecondaryColor),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${limits.exchangeLimitRemaining.value} ${limits.exchangeLimitRemaining.currency}",
                      style: textTheme.titleLarge
                          ?.copyWith(color: AppColor.kSecondaryColor),
                    ),
                    Text(
                      getExpireDate(limits.expireDate),
                      style: textTheme.bodyMedium
                          ?.copyWith(color: AppColor.kSecondaryColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (_authenticationService.user?.userProfile.limitRaised == false)
            Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    onIncreaseLimitClicked();
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 15),
                    height: 35,
                    width: width / 2.5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColor.kAccentColor2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_circle_up_rounded,
                          size: 20,
                        ),
                        Text(
                          ' Increase limit',
                          style: textTheme.bodyMedium,
                        )
                      ],
                    ),
                  )),
            ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 18),
            child: Text(
              'From geniuspay accounts',
              style: textTheme.bodyMedium,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 10, bottom: 10),
            child: Text(
              'UNLIMITED',
              style: textTheme.titleLarge
                  ?.copyWith(color: AppColor.kSecondaryColor),
            ),
          ),
          Divider(
            color: AppColor.kAccentColor2,
            height: 14,
            thickness: 1,
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 10, bottom: 10),
            child: Text(
              'Top-up limit',
              style: textTheme.headlineMedium,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            child: SfLinearGauge(
              axisTrackStyle: LinearAxisTrackStyle(
                thickness: 10,
                edgeStyle: LinearEdgeStyle.bothCurve,
                color: AppColor.kAccentColor2,
              ),
              maximum: limits.topUpLimit.value,
              minimum: 0,
              barPointers: [
                LinearBarPointer(
                    value: limits.topUpLimit.value -
                        limits.topUpLimitRemaining.value,
                    edgeStyle: LinearEdgeStyle.bothCurve,
                    thickness: 10,
                    shaderCallback: (bounds) => RadialGradient(
                          radius: 5 * 2,
                          // ignore: prefer_const_literals_to_create_immutables
                          colors: [
                            AppColor.kSecondaryColor,
                            Color(0xff05D4FF),
                          ],
                        ).createShader(bounds))
              ],
              showLabels: false,
              showTicks: false,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (limits.topUpLimit.value -
                                  limits.topUpLimitRemaining.value)
                              .toStringAsFixed(2) +
                          " ${limits.topUpLimit.currency}",
                      style: textTheme.titleLarge
                          ?.copyWith(color: AppColor.kSecondaryColor),
                    ),
                    Text(
                      'Spent',
                      style: textTheme.bodyMedium
                          ?.copyWith(color: AppColor.kSecondaryColor),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${limits.topUpLimitRemaining.value} ${limits.topUpLimitRemaining.currency}",
                      style: textTheme.titleLarge
                          ?.copyWith(color: AppColor.kSecondaryColor),
                    ),
                    Text(
                      getExpireDate(limits.expireDate),
                      style: textTheme.bodyMedium
                          ?.copyWith(color: AppColor.kSecondaryColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (_authenticationService.user?.userProfile.limitRaised == false)
            Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    onIncreaseLimitClicked();
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 15, bottom: 10),
                    height: 35,
                    width: width / 2.5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColor.kAccentColor2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_circle_up_rounded,
                          size: 20,
                        ),
                        Text(
                          ' Increase limit',
                          style: textTheme.bodyMedium,
                        )
                      ],
                    ),
                  )),
            ),
          Divider(
            color: AppColor.kAccentColor2,
            height: 14,
            thickness: 1,
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 10, bottom: 10),
            child: Text(
              'Currency exchange limit',
              style: textTheme.headlineMedium,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            child: SfLinearGauge(
              axisTrackStyle: LinearAxisTrackStyle(
                thickness: 10,
                edgeStyle: LinearEdgeStyle.bothCurve,
                color: AppColor.kAccentColor2,
              ),
              maximum: limits.exchangeLimit.value,
              minimum: 0,
              barPointers: [
                LinearBarPointer(
                    value: limits.exchangeLimit.value -
                        limits.exchangeLimitRemaining.value,
                    edgeStyle: LinearEdgeStyle.bothCurve,
                    thickness: 10,
                    shaderCallback: (bounds) => RadialGradient(
                          radius: 5 * 2,
                          // ignore: prefer_const_literals_to_create_immutables
                          colors: [
                            AppColor.kSecondaryColor,
                            Color(0xff05D4FF),
                          ],
                        ).createShader(bounds))
              ],
              showLabels: false,
              showTicks: false,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (limits.exchangeLimit.value -
                                  limits.exchangeLimitRemaining.value)
                              .toStringAsFixed(2) +
                          " ${limits.exchangeLimit.currency}",
                      style: textTheme.titleLarge
                          ?.copyWith(color: AppColor.kSecondaryColor),
                    ),
                    Text(
                      'Spent',
                      style: textTheme.bodyMedium
                          ?.copyWith(color: AppColor.kSecondaryColor),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${limits.exchangeLimitRemaining.value} ${limits.exchangeLimit.currency}",
                      style: textTheme.titleLarge
                          ?.copyWith(color: AppColor.kSecondaryColor),
                    ),
                    Text(
                      getExpireDate(limits.expireDate),
                      style: textTheme.bodyMedium
                          ?.copyWith(color: AppColor.kSecondaryColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (_authenticationService.user?.userProfile.limitRaised == false)
            Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    onIncreaseLimitClicked();
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 15),
                    height: 35,
                    width: width / 2.5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColor.kAccentColor2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_circle_up_rounded,
                          size: 20,
                        ),
                        Text(
                          ' Increase limit',
                          style: textTheme.bodyMedium,
                        )
                      ],
                    ),
                  )),
            ),
          if (_authenticationService.user?.userProfile.limitRaised == false)
            Container(
              padding: EdgeInsets.only(top: 32, bottom: 100),
              child: CustomElevatedButton(
                  color: AppColor.kGoldColor2,
                  onPressed: () {
                    onIncreaseLimitClicked();
                  },
                  child: Text(
                    'UPGRADE',
                    style: textTheme.bodyLarge,
                  )),
            ),
        ],
      ),
    );
  }

  onIncreaseLimitClicked() {
    if (_authenticationService.user!.userProfile.onboardingStatus ==
        OnboardingStatus.onboardingCompleted) {
      Navigator.push(context,
          MaterialPageRoute(builder: ((context) => IncreaseLimitScreen())));
    } else {
      OnboardingStatusPage.show(
          context, _authenticationService.user!.userProfile.onboardingStatus);
    }
  }
}
