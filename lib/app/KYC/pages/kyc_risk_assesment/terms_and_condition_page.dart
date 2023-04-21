import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/KYC/pages/kyc_risk_assesment/marketing_page.dart';
import 'package:geniuspay/app/auth/pages/sign_up/widgets/terms_and_policies_page.dart';
import 'package:geniuspay/app/shared_widgets/continue_button.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/enums.dart';
import 'package:geniuspay/util/widgets_util.dart';

class TermsAndConditionPage extends StatefulWidget {
  const TermsAndConditionPage({Key? key}) : super(key: key);
  static Future<void> show(
    BuildContext context,
  ) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const TermsAndConditionPage(),
      ),
    );
  }

  @override
  State<TermsAndConditionPage> createState() => _TermsAndConditionPageState();
}

class _TermsAndConditionPageState extends State<TermsAndConditionPage> {
  bool _terms = false;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar:
          WidgetsUtil.onBoardingAppBar(context, title: 'Terms & Conditions'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'To open your account, please read and accept\nthe terms & conditions',
                style: textTheme.bodyMedium,
              ),
              const Gap(20),
              InkWell(
                onTap: () {
                  TermsAndPoliciesPage.show(context,
                      policy: Policy.termsAndConditions);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColor.kSecondaryColor),
                    color: AppColor.kAccentColor2,
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/images/docss.svg'),
                      const Gap(20),
                      Text(
                        'Read Terms & Conditions',
                        style: textTheme.bodyMedium?.copyWith(
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const Gap(20),
              InkWell(
                onTap: () {
                  setState(() {
                    _terms = true;
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
                        'I confirm that all the information provided is true and accurate and that I have read and accept the ‘Terms and Conditions\' above. I also agree that geniuspay may send documents and notices to me by email or throught the App.',
                        style: textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              ContinueButton(
                context: context,
                color: AppColor.kGoldColor2,
                textColor: Colors.black,
                disabledColor: AppColor.kAccentColor2,
                onPressed: !_terms
                    ? null
                    : () async {
                        MarketingPage.show(context);
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
