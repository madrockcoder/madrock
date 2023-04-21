import 'package:flutter/material.dart';

import '../../util/color_scheme.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    Key? key,
    this.onPressed,
    required this.child,
    this.height = 50.0,
    this.width = double.infinity,
    this.radius = 12.0,
    this.color,
    this.onPrimary,
    this.backgroundColor,
    this.padding,
  }) : super(key: key);
  final VoidCallback? onPressed;
  final Widget child;
  final double? height;
  final double? width;
  final double radius;
  final Color? color;
  final Color? onPrimary;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: color ?? AppColor.kDarkGreenColor, padding: padding,
          elevation: 0.3,
          backgroundColor: backgroundColor ?? Colors.white,
          side: BorderSide(
            color: color ?? AppColor.kDarkGreenColor,
          ),
          // onPrimary: onPrimary ?? Colors.white,
          // textStyle: ,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius)),
          ),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
