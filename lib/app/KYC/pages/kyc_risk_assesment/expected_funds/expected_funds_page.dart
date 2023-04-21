import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/KYC/pages/kyc_risk_assesment/source_of_funds/source_of_funds_page.dart';
import 'package:geniuspay/app/KYC/view_models.dart/kyc_view_model.dart';
import 'package:geniuspay/app/KYC/widgets/horizontal_picker.dart';
import 'package:geniuspay/app/shared_widgets/custom_section_heading.dart';
import 'package:geniuspay/app/shared_widgets/custom_yellow_elevated_button.dart';
import 'package:geniuspay/core/injections/injections.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:intl/intl.dart';

import '../../../../../../util/constants.dart';
import '../../../../../../util/widgets_util.dart';

class ExpectedFundsPage extends StatefulWidget {
  const ExpectedFundsPage({
    Key? key,
  }) : super(key: key);

  static Future<void> show(
    BuildContext context,
  ) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const ExpectedFundsPage(),
      ),
    );
  }

  @override
  State<ExpectedFundsPage> createState() => _ExpectedFundsPageState();
}

class _ExpectedFundsPageState extends State<ExpectedFundsPage> {
  final AuthenticationService _auth = sl<AuthenticationService>();
  late String amount;
  int divisions = 10000;
  double minValue = 500;
  double maxValue = 3000000;

  @override
  void initState() {
    amount = "1500.00";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BaseView<KycViewModel>(builder: (context, model, snapshot) {
      return Scaffold(
        appBar: WidgetsUtil.onBoardingAppBar(context,
            title: 'Expected Funds',
            automaticallyImplyLeading: true,
            backButton: IconButton(
                onPressed: () {}, icon: const Icon(Icons.arrow_back))),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: commonPadding,
              child: Text(
                'What is your expected monthly turnover for the account?',
                style: textTheme.bodyMedium
                    ?.copyWith(fontSize: 14, color: AppColor.kPinDesColor),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Set the amount",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColor.kSecondaryColor),
                  ),
                  const Gap(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          _auth.user?.userProfile.defaultCurrency ?? "\$",
                          style: const TextStyle(
                              fontSize: 30,
                              color: AppColor.kSecondaryColor,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Text(
                        formatAmount(amount),
                        style: const TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.w700,
                            color: AppColor.kSecondaryColor),
                      ),
                    ],
                  ),
                  const Gap(40),
                  HorizontalPicker(
                    minValue: minValue,
                    // these are dollars
                    maxValue: maxValue,
                    // these are dollars
                    divisions: divisions,
                    onChanged: (value) {
                      amount = value.toStringAsFixed(0);
                      amount = amount.substring(0, amount.length - 2) + "00";
                      setState(() {});
                    },
                    height: 120,
                  ),
                  const Gap(100),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: CustomYellowElevatedButton(
                text: "CONTINUE",
                onTap: () {
                  double _amount = double.parse(amount);
                  String requestText;
                  if (_amount < 500) {
                    requestText = "LESS_THAN_500";
                  } else if (_amount >= 500 && _amount <= 1000) {
                    requestText = "FROM_500_1000";
                  } else if (_amount >= 1001 && _amount <= 1500) {
                    requestText = "FROM_1001_1500";
                  } else if (_amount >= 1501 && _amount <= 2000) {
                    requestText = "FROM_1501_2000";
                  } else if (_amount >= 2001 && _amount <= 3000) {
                    requestText = "FROM_2001_3000";
                  } else {
                    requestText = "MORE_THAN_3000";
                  }
                  model.expectedFunds = requestText;
                  SourceOfFundsPage.show(
                    context,
                  );
                },
              ),
            ),
            const Gap(8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: CustomYellowElevatedButton(
                  text: "WHY ARE WE ASKING?",
                  transparentBackground: true,
                  onTap: () {
                    CreditTurnover.show(context);
                  }),
            ),
            const Gap(24)
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     for (var es in AccountItemList.expectedFunds)
            //       StatusWidget(
            //         text: es.name,
            //         onTap: () {
            //           model.setExpectedFunds = es.requestText;
            //           SourceOfFundsPage.show(
            //             context,
            //           );
            //         },
            //       )
            //   ],
            // ),
          ],
        ),
      );
    });
  }

  String formatAmount(String amount) {
    final myFormat = NumberFormat.decimalPattern('en_us');
    return myFormat.format(double.parse(amount));
  }
}

class CreditTurnover extends StatefulWidget {
  const CreditTurnover({Key? key}) : super(key: key);
  static Future<void> show(
    BuildContext context,
  ) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const CreditTurnover(),
      ),
    );
  }

  @override
  State<CreditTurnover> createState() => _CreditTurnoverState();
}

class _CreditTurnoverState extends State<CreditTurnover> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kAccentColor2,
      appBar: WidgetsUtil.onBoardingAppBar(context,
          title: 'Expected Funds',
          automaticallyImplyLeading: true,
          backButton: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back))),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: CustomSectionHeading(
              heading: "Credit Turnover",
              topSpacing: 16,
              headingTextStyle: TextStyle(
                  color: AppColor.kSecondaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
              headingAndChildGap: 8,
              child: Text(
                'Credit Turnover is simply the total of all credit transaction you will have in your geniuspay account in a particular statement period - (Monthly). This amount is an estimate.',
                style: TextStyle(
                    color: AppColor.kPinDesColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
