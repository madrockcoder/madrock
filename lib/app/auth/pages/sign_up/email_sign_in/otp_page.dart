import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/auth/view_models/otp_view_model.dart';
import 'package:geniuspay/app/shared_widgets/continue_button.dart';
import 'package:geniuspay/app/shared_widgets/custom_keyboard.dart';
import 'package:geniuspay/app/shared_widgets/pin_text_field.dart';
import 'package:geniuspay/app/shared_widgets/timer_button.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/constants.dart';
import 'package:geniuspay/util/widgets_util.dart';

class EmailOtpPage extends StatefulWidget {
  const EmailOtpPage({
    Key? key,
    required this.isLogin,
  }) : super(key: key);

  final bool isLogin;

  static Future<void> show(
      {required BuildContext context, required bool isLogin}) async {
    await Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => EmailOtpPage(
          isLogin: isLogin,
        ),
      ),
    );
  }

  @override
  _EmailOtpPageState createState() => _EmailOtpPageState();
}

class _EmailOtpPageState extends State<EmailOtpPage> {
  final _pins = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  late String otp;

  var activeField = 0;

  final _resendButtonLoading = false;
  var _disableButton = true;

  @override
  void initState() {
    super.initState();
    otp = '';
  }

  void reset() {
    for (var pin in _pins) {
      pin.clear();
    }
    activeField = 0;
    _disableButton = true;
    otp = '';
  }

  @override
  void dispose() {
    super.dispose();

    for (var pin in _pins) {
      pin.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BaseView<OtpViewModel>(builder: (context, model, snapshot) {
      // model.setBusy(value: false);
      return Scaffold(
        appBar: WidgetsUtil.onBoardingAppBar(
          context,
          title: 'Email Verification',
        ),
        body: Padding(
          padding: commonPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Enter the code we have sent to ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: AppColor.kPinDesColor),
                          ),
                          TextSpan(
                            text: model.email,
                            style:
                                Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: AppColor.kSurfaceColorVariant,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (var pin in _pins)
                          Flexible(
                            child: Row(
                              children: [
                                const SizedBox(width: 5.0),

                                Expanded(
                                  child: PINTextField(
                                    controller: pin,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18.0,
                                        ),
                                  ),
                                ),
                                const SizedBox(width: 5.0),
                                // if (pin != _pins.last)
                                // const SizedBox(width: 10.0),
                              ],
                            ),
                          ),
                      ],
                    ),
                    const Gap(10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 10),
                      decoration: BoxDecoration(
                        color: AppColor.kAccentColor4,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.error,
                            color: AppColor.kSecondaryColor,
                            size: 16,
                          ),
                          const Gap(5),
                          Expanded(
                            child: Text(
                              'If you haven\'t received the email, press Resend Code after the time elapses',
                              style: textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: AppColor.kSecondaryColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // const Spacer(),
              Column(
                children: [
                  Center(
                    child: TimerButton(
                      secs: 20,
                      isLoading: _resendButtonLoading,
                      onTap: (startTimer) async {
                        for (var element in _pins) {
                          element.clear();
                        }
                        model.resendCode(context);
                        startTimer();
                        setState(() {
                          reset();
                        });
                      },
                    ),
                  ),
                  const Gap(10),
                  ContinueButton(
                    context: context,
                    isLoading: model.busy,
                    color: AppColor.kGoldColor2,
                    disabledColor: AppColor.kAccentColor3,
                    textStyle: textTheme.bodyMedium?.copyWith(
                      fontSize: _disableButton ? 13 : 14,
                      color: _disableButton
                          ? AppColor.kOnPrimaryTextColor3
                          : Colors.black,
                      fontWeight:
                          _disableButton ? FontWeight.w400 : FontWeight.w600,
                    ),
                    onPressed: _disableButton
                        ? null
                        : () async {
                            model.verifyOtp(
                                context: context,
                                otp: otp,
                                isMobile: false,
                                isLogin: widget.isLogin);
                          },
                    text: 'CONFIRM',
                  ),
                  const SizedBox(height: 24.0),
                  CustomKeyboard(
                    onKeypressed: (i) {
                      keysPressed(i);
                      if (_pins.last.text.isEmpty) {
                        setState(() => _disableButton = true);
                      } else {
                        otp = '';
                        for (var pin in _pins) {
                          otp += pin.text.toString();
                        }

                        setState(() => _disableButton = false);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  int zeroKeyPressed(int i) {
    if (i == 10) {
      return 0;
    } else {
      return i + 1;
    }
  }

  void keysPressed(int i) {
    if (i == 9) return;
    if (i == 11) {
      if (activeField != 0) {
        _pins[--activeField].clear();
      }
    } else {
      if (activeField != _pins.length) {
        _pins[activeField++].text = zeroKeyPressed(i).toString();
      }
    }
  }

  Future<void> onVerify() async {
    // try {

    // if (widget.isMobile) {
    //   PINCodeSettingPage.show(context);
    // } else {
    //   MobileNumberVerification.show(context);
    // }
    // if (user.firstName.isEmpty || user.lastName.isEmpty) {
    //   // CountryPage.show(context);
    //   SelectUserTypePage.show(context);
    // } else {
    //   TabsRouter.show(context);
    // }
    // } else {
    // if (user.firstName.isEmpty || user.lastName.isEmpty) {
    //   SelectUserTypePage.show(context);
    //   // CountryPage.show(context);
    // } else {
    //   TabsRouter.show(context);
    // }
    // }
    // } on CustomHttpException catch (_) {
    //   setState(() => _isLoading = false);

    //   await PopupDialogs(context).errorMessage(
    //       title: 'Oops 🙊',
    //       description:
    //           'We hit a snag verifying you. Please check code and try again.',
    //       timedDismissible: false);
    //   reset();
    // } catch (e) {
    //   if (!mounted) return;
    //   setState(() => _isLoading = false);

    //   await PopupDialogs(context).errorMessage(
    //       title: 'Oops 🙊',
    //       description:
    //           'We hit a snag verifying you. Please check code and try again.',
    //       timedDismissible: false);
    //   reset();
    // }
  }
}
