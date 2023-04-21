import 'package:flutter/material.dart';
import 'package:geniuspay/util/color_scheme.dart';

class CustomCircularIcon extends StatelessWidget {
  final double radius;
  final Widget icon;
  final Color color;
  final GestureTapCallback? onTap;

  const CustomCircularIcon(this.icon,
      {Key? key,
      this.radius = 40,
      this.color = AppColor.kAccentColor2,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: Center(
          child: icon,
        ),
      ),
    );
  }
}
