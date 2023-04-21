import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geniuspay/app/auth/pages/sign_up/help/help_screen.dart';
import 'package:geniuspay/core/injections/injections.dart';
import 'package:geniuspay/repos/local_repo.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:google_fonts/google_fonts.dart';

class TimerButton extends StatefulWidget {
  const TimerButton({
    Key? key,
    required this.onTap,
    this.buttonText,
    this.secs = 10,
    required this.isLoading,
  }) : super(key: key);
  final void Function(void Function())? onTap;
  final String? buttonText;
  final int secs;
  final bool isLoading;

  @override
  _TimerButtonState createState() => _TimerButtonState();
}

class _TimerButtonState extends State<TimerButton> {
  Timer? _timer;
  late int _start;
  final LocalBase _localBase = sl<LocalBase>();

  bool get isTotalResendCountLimitExceeded =>
      _localBase.availableOtpResends() == 0;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    if (!isTotalResendCountLimitExceeded) {
      _start = widget.secs;
      startTimer();
    } else {
      _start = 0;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _start > 0
          ? null
          : () {
              if (isTotalResendCountLimitExceeded) {
                HelpScreen.show(context);
              } else {
                widget.onTap!(startTimer);
                _start = widget.secs;
                _localBase.decrementAvailableOtpResends();
                setState(() {});
              }
            },
      child: widget.isLoading
          ? const Center(
              child: CircularProgressIndicator.adaptive(
                  backgroundColor: AppColor.kSwitchActiveColor))
          : Text(
              _start > 0
                  ? 'Resend Code 00:${_start.toString().length == 1 ? "0$_start" : _start}'
                  : isTotalResendCountLimitExceeded
                      ? 'Contact support team'
                      : (widget.buttonText ?? 'Resend Code'),
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: _start > 0
                          ? Colors.grey
                          : AppColor.kSwitchActiveColor,
                    ),
              ),
            ),
    );
  }
}
