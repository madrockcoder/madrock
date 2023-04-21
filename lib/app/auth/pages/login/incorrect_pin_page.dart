import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/auth/pages/sign_up/help/help_screen.dart';
import 'package:geniuspay/app/shared_widgets/continue_button.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/widgets_util.dart';

class IncorrectPin extends StatelessWidget {
  const IncorrectPin({Key? key}) : super(key: key);
  static Future<void> show(BuildContext context,
      {bool isConfirm = false, bool isLogin = false}) async {
    await Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const IncorrectPin(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColor.kAccentColor2,
      appBar: WidgetsUtil.onBoardingAppBar(context),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(45.0),
        child: Column(
          children: [
            SizedBox(
              height: 137,
              width: 137,
              child: Image.asset('assets/images/pinn.png'),
            ),
            const Gap(37),
            SizedBox(
              width: 260,
              child: Text(
                'Your account has been locked\ndue to multiple wrong\nPasscode trials. Please contact\nsupport to reactivate account.',
                style: textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            ContinueButton(
              context: context,
              color: Colors.black,
              onPressed: () {
                HelpScreen.show(context);
              },
              textColor: Colors.white,
              text: 'CONTACT SUPPORT',
            )
          ],
        ),
      )),
    );
  }
}
