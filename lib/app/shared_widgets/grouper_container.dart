import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../util/color_scheme.dart';
import 'custom_container.dart';

class GrouperContainer extends CustomContainer {
  const GrouperContainer({
    Key? key,
    EdgeInsetsGeometry? padding,
    double? radius,
    Color? color,
    VoidCallback? onTap,
    required Widget child,
    required BuildContext context,
  }) : super(
          key: key,
          padding: padding,
          onPressed: onTap,
          radius: radius ?? 20.0,
          width: double.infinity,
          borderColor: color ?? AppColor.kContainerBorderColor,
          child: child,
        );
}
