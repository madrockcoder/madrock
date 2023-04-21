import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/auth/pages/sign_up/widgets/auth_provider.dart';
import 'package:geniuspay/app/auth/view_models/finger_print_view_model.dart';
import 'package:geniuspay/app/onboarding/support_pin_screen.dart';
import 'package:geniuspay/app/shared_widgets/continue_button.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/widgets_util.dart';
import 'package:provider/provider.dart';

class FingerPrintPage extends StatefulWidget {
  const FingerPrintPage({
    Key? key,
    required this.value,
  }) : super(key: key);
  final AuthProvider value;

  static Future<void> show(
    BuildContext context,
  ) async {
    await Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => Consumer<AuthProvider>(
            builder: (_, value, __) => FingerPrintPage(value: value),
          ),
        ),
        (route) => false);
  }

  @override
  _FingerPrintPageState createState() => _FingerPrintPageState();
}

class _FingerPrintPageState extends State<FingerPrintPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BaseView<FingerPrintViewModel>(
        onModelReady: (p0) => p0.checkIfPrintExist(),
        builder: (context, model, snapshot) {
          return Scaffold(
            backgroundColor: AppColor.kAccentColor2,
            appBar: WidgetsUtil.onBoardingAppBar(context),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset('assets/images/finger_print.svg'),
                const Gap(40),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      children: [
                        const Gap(20),
                        Text(
                          'Use BIOMETRICS for a fast\nand secure login',
                          textAlign: TextAlign.center,
                          style: textTheme.headlineSmall?.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Gap(12),
                        Text.rich(
                          TextSpan(
                            text:
                                'Login quickly and securely with the fingerprint or face ID stored on this device.\n',
                            style: textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.black),
                            children: const [
                              TextSpan(
                                  text:
                                      'You will not have to enter your Passcode every time',
                                  style: TextStyle(
                                      color: AppColor.kSecondaryColor))
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const Spacer(),
                        ContinueButton(
                          context: context,
                          isLoading: model.busy,
                          color: AppColor.kGoldColor2,
                          textColor: Colors.black,
                          onPressed: () async {
                            await model.autenticate(context);
                          },
                          text: 'USE BIOMETRICS ',
                        ),
                        const SizedBox(height: 24.0),
                        TextButton(
                          child: Text(
                            'NO, I WILL USE MY PASSCODE',
                            style: textTheme.headlineSmall?.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                          onPressed: () => SupportPin.show(context),
                        ),
                        const SizedBox(height: 25.0),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
