import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/auth/pages/sign_up/help/help_screen.dart';
import 'package:geniuspay/app/shared_widgets/continue_button.dart';
import 'package:geniuspay/util/color_scheme.dart';

class BlockedAccount extends StatelessWidget {
  const BlockedAccount({Key? key}) : super(key: key);
  static Future<void> show(
    BuildContext context,
  ) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const BlockedAccount(),
      ),
      // ((route) => false),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColor.kAccentColor2,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Gap(62),
              SizedBox(
                height: 137,
                width: 137,
                child: Image.asset('assets/images/pinn.png'),
              ),
              const Gap(24),
              SizedBox(
                width: 260,
                child: Text(
                  'Your account has been locked. If you think this is a mistake kindly contact support to reactivate account.',
                  textAlign: TextAlign.center,
                  style: textTheme.bodyLarge?.copyWith(
                    color: AppColor.kSecondaryColor,
                    fontSize: 16,
                  ),
                ),
              ),
              const Spacer(),
              ContinueButton(
                context: context,
                color: Colors.black,
                textColor: Colors.white,
                onPressed: () async {
                  HelpScreen.show(context);
                },
                text: 'CONTACT SUPPORT',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
