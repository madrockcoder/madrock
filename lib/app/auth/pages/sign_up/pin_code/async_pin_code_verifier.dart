import 'package:flutter/material.dart';
import 'package:geniuspay/app/auth/pages/sign_up/widgets/auth_provider.dart';
import 'package:geniuspay/app/shared_widgets/continue_button.dart';
import 'package:geniuspay/app/shared_widgets/http_exception.dart';
import 'package:geniuspay/app/shared_widgets/pin_text_field.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/constants.dart';
import 'package:geniuspay/util/enums.dart';
import 'package:geniuspay/util/widgets_util.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AsyncPinCodeVerifier extends StatefulWidget {
  const AsyncPinCodeVerifier({
    Key? key,
    required this.callBack,
  }) : super(key: key);

  final ValueChanged<UserState> callBack;

  @override
  _AsyncPinCodeVerifierState createState() => _AsyncPinCodeVerifierState();
}

class _AsyncPinCodeVerifierState extends State<AsyncPinCodeVerifier> {
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
  var _isLoading = false;

  int trial = 0; // count number of times user try to enter incorrect PIN

  var _disableButton = true;

  @override
  void initState() {
    otp = '';
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    for (var pin in _pins) {
      pin.dispose();
    }
  }

  void reset() {
    for (var pin in _pins) {
      pin.clear();
    }
    activeField = 0;
    _disableButton = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: Padding(
        padding: commonPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      WidgetsUtil.pageTitle(
                        context,
                        title: 'Enter your PIN',
                        description: '',
                      ),
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
                                      style: GoogleFonts.lato(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              color:
                                                  AppColor.kTextFieldTextColor,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 25.0,
                                            ),
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
                    ],
                  ),
                  const SizedBox(),
                  const SizedBox(),
                ],
              ),
            ),
            Column(
              children: [
                ContinueButton(
                  context: context,
                  isLoading: _isLoading,
                  onPressed: _disableButton
                      ? null
                      : () async {
                          if (otp.length <= 6) {
                            for (var pin in _pins) {
                              otp += pin.text;
                            }
                          }

                          context.read<AuthProvider>().updateWith(pin: otp);

                          if (otp.length != _pins.length) return;
                          setState(() => _isLoading = true);

                          await verify();
                          setState(() => _isLoading = false);

                          otp = '';
                        },
                  text: 'Unlock',
                ),
                const SizedBox(height: 24.0),
                Column(
                  children: [
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 13.5,
                        mainAxisSpacing: 13.5,
                        childAspectRatio: 1.5,
                      ),
                      itemCount: 12,
                      itemBuilder: (_, i) {
                        return InkWell(
                          onTap: () {
                            keysPressed(i);
                            if (_pins.last.text.isEmpty) {
                              setState(() => _disableButton = true);
                            } else {
                              setState(() => _disableButton = false);
                            }
                          },
                          child: SizedBox(
                            height: 30.0,
                            width: 30.0,
                            child: Center(
                              child: i == 11
                                  ? const Icon(
                                      Icons.backspace_outlined,
                                      size: 24.0,
                                      color: AppColor.kOnPrimaryTextColor2,
                                    )
                                  : Text(
                                      i == 10
                                          ? '0'
                                          : (i == 9 ? '' : '${i + 1}'),
                                      style: GoogleFonts.lato(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .displaySmall
                                            ?.copyWith(
                                                color: AppColor
                                                    .kOnPrimaryTextColor2,
                                                fontWeight: FontWeight.w600),
                                      ),
                                    ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
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

  Future<void> verify() async {
    try {
      final response = await context.read<AuthProvider>().verifyUserPin();
      trial++;
      reset();
      if (!response && trial < 3) {
        PopupDialogs(context).errorMessage(
            'Incorrect PIN entered, you have ${3 - trial} trials left.');
        return;
      } else if (!response && trial >= 3) {
        widget.callBack(UserState.hold);
      } else {
        widget.callBack(UserState.unlock);
      }
    } on CustomHttpException {
      PopupDialogs(context).errorMessage(
          'Action couldn\'t be completed. Please try again later.');
      reset();
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      PopupDialogs(context).errorMessage(
          'Action couldn\'t be completed. Please try again later.');
      reset();
    }
  }
}
