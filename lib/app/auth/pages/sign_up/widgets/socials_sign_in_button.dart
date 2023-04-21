import 'package:flutter/cupertino.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/text_theme.dart';

class SocialsSignInButton extends CustomElevatedButton {
  SocialsSignInButton({
    Key? key,
    required VoidCallback onPressed,
    required String text,
    required Widget icon,
  }) : super(
          key: key,
          onPressed: onPressed,
          color: AppColor.kSurfaceColorVariant,
          padding: const EdgeInsets.symmetric(horizontal: 24.25),
          child: Row(
            children: [
              icon,
              const SizedBox(width: 23.5),
              Text(text, style: socialsButtonTitleTextStyle),
            ],
          ),
        );
}
