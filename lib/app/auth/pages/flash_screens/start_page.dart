import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/auth/pages/sign_up/widgets/terms_and_policies_page.dart';
import 'package:geniuspay/app/onboarding/onboarding_page.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/repos/local_repo.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/enums.dart';
import 'package:geniuspay/util/widgets_util.dart';

class Startpage extends StatefulWidget {
  const Startpage({Key? key}) : super(key: key);

  @override
  State<Startpage> createState() => _StartpageState();
}

class _StartpageState extends State<Startpage> {
  bool _terms = false;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: WidgetsUtil.onboardingBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome!',
                    style: textTheme.displayLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 25,
                    ),
                  ),
                  const Gap(20),
                  Text(
                    'Here\'s a few things to be aware of.',
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  const Gap(50),
                  StartItemWidget(
                    textTheme: textTheme,
                    title: 'Like a real bank, but better',
                    body:
                        'Open a free account in minutes right from your phone, and make your money go borderless.',
                    icon: 'assets/icons/bank-2.svg',
                  ),
                  StartItemWidget(
                    textTheme: textTheme,
                    title: 'Get your card today',
                    body:
                        'Start planting trees with the geniuspay account, all you have to do is spend.',
                    icon: 'assets/images/genioCard.svg',
                  ),
                  StartItemWidget(
                    textTheme: textTheme,
                    title: 'Don\'t forget your ID',
                    body:
                        'You will need your passport or driving license to prove who you are.',
                    icon: 'assets/images/passportNa.svg',
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColor.kAccentColor2,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.error,
                          color: AppColor.kSecondaryColor,
                        ),
                        const Gap(4),
                        Expanded(
                          child: Text(
                            'We only ask for essential information and we do not perform credit checks',
                            style: textTheme.bodyMedium?.copyWith(
                              fontSize: 12,
                              color: AppColor.kSecondaryColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Gap(56),
                  Row(
                    children: [
                      Checkbox(
                        value: _terms,
                        onChanged: (value) {
                          setState(() {
                            _terms = !_terms;
                          });
                        },
                      ),
                      Expanded(
                          child: RichText(
                        text: TextSpan(
                          style: textTheme.bodyMedium?.copyWith(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                          text: 'I have read and agree to the ',
                          children: [
                            TextSpan(
                              text: 'Terms of Service',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => TermsAndPoliciesPage.show(
                                    context,
                                    policy: Policy.termsAndConditions),
                              style: const TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                            )
                          ],
                        ),
                      ))
                    ],
                  ),
                  const Gap(30),
                  SizedBox(
                    width: 150,
                    child: CustomElevatedButton(
                      onPressed: _terms
                          ? () async {
                              final localBase = sl<LocalBase>();
                              localBase.acceptPrivacyAndTerms();
                              await Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (_) => const OnboardingPage(),
                                ),
                              );
                            }
                          : null,
                      color: AppColor.kSecondaryColor,
                      disabledColor: AppColor.kAccentColor2,
                      child: Text(
                        'GOT IT!',
                        style: textTheme.bodyMedium?.copyWith(
                          fontSize: 14,
                          color: _terms
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StartItemWidget extends StatelessWidget {
  const StartItemWidget(
      {Key? key,
      required this.textTheme,
      required this.body,
      required this.icon,
      required this.title})
      : super(key: key);

  final TextTheme textTheme;
  final String icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: AppColor.kSecondaryColor,
            child: SvgPicture.asset(icon),
          ),
          const Gap(15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.displayMedium?.copyWith(fontSize: 20),
                ),
                Text(
                  body,
                  style: textTheme.bodyMedium?.copyWith(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
