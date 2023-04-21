import 'package:flutter/material.dart';
import 'package:geniuspay/util/color_scheme.dart';

import '../app/shared_widgets/custom_container.dart';

class AppBarBackButton extends CustomContainer {
  AppBarBackButton({
    Key? key,
    required BuildContext context,
    IconData? icon,
    VoidCallback? onTap,
  }) : super(
          key: key,
          height: 40.0,
          width: 40.0,
          radius: 12.0,
          onPressed: onTap,
          borderColor: AppColor.kBorderColor,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: icon == null
                ? const Icon(Icons.chevron_left_rounded,
                    color: AppColor.kOnPrimaryTextColor2)
                : Icon(icon, color: AppColor.kOnPrimaryTextColor2),
          ),
        );
}
