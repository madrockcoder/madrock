import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geniuspay/app/auth/pages/sign_up/help/help_screen.dart';
import 'package:geniuspay/util/color_scheme.dart';

class HelpIconButton extends StatelessWidget {
  final VoidCallback? onTap;
  const HelpIconButton({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      constraints: const BoxConstraints(minWidth: 30),
      onPressed: onTap ?? () => HelpScreen.show(context),
      child: SvgPicture.asset(
        'assets/images/help.svg',
        width: 18,
        color: AppColor.kOnPrimaryTextColor,
      ),
      shape: const CircleBorder(),
    );
  }
}
