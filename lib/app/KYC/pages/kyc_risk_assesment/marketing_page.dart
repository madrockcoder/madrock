import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/KYC/pages/kyc_risk_assesment/personal_details_confirm.dart';
import 'package:geniuspay/app/shared_widgets/continue_button.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/widgets_util.dart';

class MarketingPage extends StatefulWidget {
  const MarketingPage({Key? key}) : super(key: key);
  static Future<void> show(
    BuildContext context,
  ) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const MarketingPage(),
      ),
    );
  }

  @override
  State<MarketingPage> createState() => _MarketingPageState();
}

class _MarketingPageState extends State<MarketingPage> {
  bool _terms = false;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: WidgetsUtil.onBoardingAppBar(
        context,
        title: 'One last thing!',
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Please tick below to keep yourself updated with\nrelevant offers and news about our products and\nservices.',
                style: textTheme.bodyMedium,
              ),
              const Gap(20),
              const Gap(20),
              InkWell(
                onTap: () {
                  setState(() {
                    _terms = !_terms;
                  });
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 12,
                      width: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _terms
                            ? AppColor.kSecondaryColor
                            : Colors.transparent,
                        border: Border.all(color: AppColor.kSecondaryColor),
                      ),
                      child: _terms
                          ? const Center(
                              child: Icon(
                                Icons.done,
                                size: 10,
                                color: Colors.white,
                              ),
                            )
                          : const SizedBox(),
                    ),
                    const Gap(10),
                    Expanded(
                      child: Text(
                        'I would like to receive marketing communications from geniuspay related to special offers, promotions and marketing via any of my provided information in line with the Privacy Policy',
                        style: textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text.rich(
                TextSpan(
                  text:
                      'You can withdraw your consent to receive such marketing comunications at any time by sending an email to\n',
                  children: [
                    TextSpan(
                      text: 'support@geniuspay.com',
                      style: textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                        color: AppColor.kSecondaryColor,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    )
                  ],
                  style: textTheme.bodyMedium?.copyWith(
                    fontSize: 12,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
              const Gap(20),
              ContinueButton(
                context: context,
                color: AppColor.kGoldColor2,
                disabledColor: AppColor.kAccentColor2,
                textColor: Colors.black,
                onPressed: () async {
                  PersonalDetailsConfirmPage.show(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
