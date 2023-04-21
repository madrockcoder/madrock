import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/home/widget/onboarding_status_widget.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/app/wallet/connect_bank_account/select_bank_page.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/enums.dart';

class LinkABankPage extends StatelessWidget {
  const LinkABankPage({Key? key}) : super(key: key);
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const LinkABankPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final titleTheme = Theme.of(context)
        .textTheme
        .bodyMedium
        ?.copyWith(fontSize: 25, color: AppColor.kSecondaryColor);
    return Scaffold(
      backgroundColor: AppColor.kAccentColor2,
      appBar: AppBar(
        backgroundColor: AppColor.kAccentColor2,
        title: const Text('Link a bank'),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(),
              Image.asset(
                'assets/wallets/link_bank_banner.png',
                width: 300,
              ),
              const Gap(40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('geniuspay uses ', style: titleTheme),
                      Text(
                        'Nordigen',
                        style: textTheme.bodyLarge?.copyWith(
                            fontSize: 25, color: AppColor.kSecondaryColor),
                      )
                    ],
                  ),
                  Text(
                    'to link your bank',
                    style: titleTheme,
                  )
                ],
              ),
              const Gap(16),
              const CustomTile(
                  title: 'Secure',
                  subtitle:
                      'Encryption helps protect your personal financial data'),
              const Gap(16),
              const CustomTile(
                  title: 'Private',
                  subtitle:
                      'Your credentials will never be made accessible to geniuspay'),
              const Spacer(),
              RichText(
                text: TextSpan(
                  style: textTheme.bodyMedium?.copyWith(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                  text: 'By selecting "add account" you agree to the ',
                  children: const [
                    TextSpan(
                      text: 'Nordigen End User Privacy Policy',
                      // recognizer: TapGestureRecognizer()
                      //   ..onTap = () => TermsAndPoliciesPage.show(
                      //       context,
                      //       policy: Policy.termsAndConditions),
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    )
                  ],
                ),
              ),
              const Gap(16),
              CustomElevatedButton(
                  color: AppColor.kGoldColor2,
                  borderColor: AppColor.kGoldColor2,
                  onPressed: () {
                    final AuthenticationService _authenticationService =
                        sl<AuthenticationService>();
                    if (_authenticationService
                            .user!.userProfile.onboardingStatus ==
                        OnboardingStatus.onboardingCompleted) {
                      SelectBankPage.show(context);
                    } else {
                      OnboardingStatusPage.show(
                          context,
                          _authenticationService
                              .user!.userProfile.onboardingStatus);
                    }
                  },
                  child: Text(
                    'ADD ACCOUNT',
                    style: textTheme.bodyLarge,
                  )),
              const Gap(24),
            ],
          )),
    );
  }
}

class CustomTile extends StatelessWidget {
  final String title;
  final String subtitle;
  const CustomTile({Key? key, required this.title, required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListTile(
      leading: Container(
          width: 30,
          alignment: Alignment.topCenter,
          child: const Icon(
            Icons.check_circle,
            color: AppColor.kSecondaryColor,
          )),
      title: Text(
        title,
        style: textTheme.bodyLarge
            ?.copyWith(color: AppColor.kSecondaryColor, fontSize: 16),
      ),
      subtitle: Text(
        subtitle,
        style: textTheme.bodyMedium?.copyWith(fontSize: 16),
      ),
    );
  }
}
