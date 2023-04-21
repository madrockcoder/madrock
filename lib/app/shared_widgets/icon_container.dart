import 'package:flutter/cupertino.dart';

import '../../util/color_scheme.dart';
import 'custom_container.dart';

class IconContainer extends CustomContainer {
  IconContainer(
      {Key? key,
      required Widget icon,
      double? height,
      double? width,
      double? padding,
      Color? color,
      VoidCallback? onPressed,
      double? radius = 50.0})
      : super(
          key: key,
          height: height ?? 40.0,
          width: width ?? 40.0,
          radius: radius,
          padding: EdgeInsets.all(padding ?? 13.0),
          onPressed: onPressed,
          containerColor: color ?? AppColor.kFilledColor,
          child: icon,
        );
}
