import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/auth/pages/sign_up/help/help_screen.dart';
import 'package:geniuspay/app/auth/pages/sign_up/widgets/waring_widget.dart';
import 'package:geniuspay/app/auth/view_models/pin_code_view_model.dart';
import 'package:geniuspay/app/shared_widgets/custom_keyboard.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'dart:io' show Platform;

class PINCodeSettingPage extends StatefulWidget {
  const PINCodeSettingPage({
    Key? key,
    required this.isLogin,
    required this.onVerified,
    this.passcodeTitle = 'Enter your Passcode',
  }) : super(key: key);

  final bool isLogin;
  final Function(BuildContext) onVerified;
  final String passcodeTitle;

  static Future<void> show({
    required BuildContext context,
    required Function(BuildContext) onVerified,
    bool isLogin = false,
    String passcodeTitle = 'Enter your Passcode',
    bool replaceScreen = false,
  }) async {
    if (replaceScreen) {
      await Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => PINCodeSettingPage(
            isLogin: isLogin,
            onVerified: onVerified,
            passcodeTitle: passcodeTitle,
          ),
        ),
      );
    } else {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => PINCodeSettingPage(
            isLogin: isLogin,
            onVerified: onVerified,
            passcodeTitle: passcodeTitle,
          ),
        ),
      );
    }
  }

  @override
  _PINCodeSettingPageState createState() => _PINCodeSettingPageState();
}

class _PINCodeSettingPageState extends State<PINCodeSettingPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BaseView<PinCodeViewModel>(onModelReady: (p0) {
      p0.initialize();
    }, builder: (context, model, snapshot) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Spacer(),
              SizedBox(
                height: 137,
                width: 137,
                child: Image.asset('assets/images/pinn.png'),
              ),
              Text(
                widget.isLogin
                    ? widget.passcodeTitle
                    : model.isConfirm
                        ? 'Re-enter a 6-digit Passcode'
                        : 'Create a 6-digit Passcode',
                textAlign: TextAlign.center,
                style: textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              if (!widget.isLogin) ...[
                const Gap(24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'Please, remember the Passcode as it will be required for confirming important operations and logging into the app',
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
              const Gap(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < 6; i++)
                    SizedBox(
                      width: 28,
                      height: 60,
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          AnimatedPositioned(
                            top: model.selected ? 0.0 : 30.0,
                            duration: Duration(milliseconds: i * 100 + 500),
                            curve: Curves.fastOutSlowIn,
                            child: Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: AppColor.kSecondaryColor,
                                      width: 1),
                                  color: model.pins.length >= (i + 1)
                                      ? AppColor.kSecondaryColor
                                      : Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              const Gap(8),
              if (widget.isLogin && model.attempt < 3)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: WarningWidget(
                      backgroundColor: Colors.transparent,
                      textColor: AppColor.kAlertColor2,
                      title:
                          'Wrong Passcode. You have ${model.attempt} more attempts',
                    ),
                  ),
                ),
              const Spacer(),
              if (widget.isLogin)
                Center(
                  child: TextButton(
                    onPressed: () => HelpScreen.show(context),
                    child: Text(
                      'FORGOT MY PASSCODE',
                      style: textTheme.bodyLarge
                          ?.copyWith(color: AppColor.kSecondaryColor),
                    ),
                  ),
                ),
              const Gap(10),
              CustomKeyboard(
                onKeypressed: (i) {
                  model.keysPressed(
                      i: i,
                      isLogin: widget.isLogin,
                      context: context,
                      onVerified: widget.onVerified);
                },
                customButton: widget.isLogin && model.fingerPrint
                    ? InkWell(
                        onTap: () {
                          model.biometricAuth(context, widget.onVerified);
                        },
                        child: Align(
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              Platform.isAndroid
                                  ? 'assets/images/fingerprint_passcode.svg'
                                  : 'assets/icons/face_id.svg',
                              color: AppColor.kSecondaryColor,
                              width: 32,
                              height: 32,
                            )))
                    : null,
              ),
            ],
          ),
        ),
      );
    });
  }
}
