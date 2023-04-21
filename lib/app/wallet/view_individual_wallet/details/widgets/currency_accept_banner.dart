import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/core/injections/injections.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/util/color_scheme.dart';

class CurrencyAcceptBanner extends StatefulWidget {
  const CurrencyAcceptBanner({Key? key}) : super(key: key);

  @override
  State<CurrencyAcceptBanner> createState() => _CurrencyAcceptBannerState();
}

class _CurrencyAcceptBannerState extends State<CurrencyAcceptBanner> {
  final AuthenticationService _auth = sl<AuthenticationService>();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: AppColor.kAccentColor2,
          borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 24, right: 21),
        child: Column(
          children: [
            Text(
              "This account only accept ${_auth.user!.userProfile.defaultCurrency} transfers.",
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: AppColor.kSecondaryColor),
            ),
            const Gap(8),
            const Text(
              "Payments made in one of these currencies will be added to the same currency account if you have one, if not, we will add it to your main account.",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: AppColor.kSecondaryColor),
            )
          ],
        ),
      ),
    );
  }
}
