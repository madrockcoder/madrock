import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/auth/pages/sign_up/email_sign_in/otp_page.dart';
import 'package:geniuspay/app/auth/pages/sign_up/mobile_number/mobile_number_otp.dart';
import 'package:geniuspay/util/color_scheme.dart';

class VerificationSentPage extends StatefulWidget {
  const VerificationSentPage(
      {Key? key,
      required this.isMobile,
      required this.isLogin,
      this.mobileNumber})
      : super(key: key);

  final bool isMobile;
  final String? mobileNumber;
  final bool isLogin;

  static Future<void> show(BuildContext context,
      {bool isMobile = false,
      bool isLogin = false,
      String? mobileNumber}) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => VerificationSentPage(
          isMobile: isMobile,
          isLogin: isLogin,
          mobileNumber: mobileNumber,
        ),
      ),
    );
  }

  @override
  State<VerificationSentPage> createState() => _VerificationSentPageState();
}

class _VerificationSentPageState extends State<VerificationSentPage> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 3),
      () {
        if (widget.isMobile) {
          MobileNumberOtpPage.show(
              context: context,
              isLogin: widget.isLogin,
              mobileNumber: widget.mobileNumber!);
        } else {
          EmailOtpPage.show(context: context, isLogin: widget.isLogin);
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColor.kAccentColor2,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              padding: const EdgeInsets.all(13.87),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/circle.png'),
                ),
              ),
              child: CircleAvatar(
                backgroundColor: AppColor.kSecondaryColor,
                child: Center(
                  child: SvgPicture.asset('assets/icons/tick.svg'),
                ),
              ),
            ),
            const Gap(22),
            Text(
              widget.isMobile
                  ? 'SMS verification sent'
                  : 'Email verification sent',
              style: textTheme.bodyLarge?.copyWith(
                color: AppColor.kSecondaryColor,
                fontSize: 25,
              ),
            )
          ],
        ),
      ),
    );
  }
}
