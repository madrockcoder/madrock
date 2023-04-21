import 'package:flutter/material.dart';

import '../../util/color_scheme.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    this.onPressed,
    required this.child,
    this.height = 50.0,
    this.width = double.infinity,
    this.radius = 12.0,
    this.color,
    this.disabledColor,
    this.onPrimary,
    this.padding,
    this.borderColor,
    this.transparentBackground = false,
  }) : super(key: key);
  final VoidCallback? onPressed;
  final Widget child;
  final double? height;
  final double? width;
  final double radius;
  final Color? color;
  final Color? disabledColor;
  final Color? onPrimary;
  final EdgeInsetsGeometry? padding;
  final Color? borderColor;
  final bool transparentBackground;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return color?.withOpacity(0.5) ??
                    AppColor.kDarkGreenColor.withOpacity(0.5);
              } else if (states.contains(MaterialState.disabled)) {
                return disabledColor ?? AppColor.kDisabledContinueButtonColor;
              }
              return color ?? AppColor.kDarkGreenColor;
            },
          ),
          elevation: transparentBackground
              ? MaterialStateProperty.all<double>(0)
              : MaterialStateProperty.all<double>(0.15),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius),
                side: borderColor == null
                    ? disabledColor != null
                    ? BorderSide(color: disabledColor!)
                    : const BorderSide(color: Colors.white)
                    : BorderSide(color: borderColor!)),
          ),

          // shape:
        ),
        // style: ElevatedButton.styleFrom(
        //   padding: padding,
        //   elevation: 0.3,
        //   // onSurface: AppColor.kDarkGreenColor,
        //   primary: color ?? AppColor.kDarkGreenColor,
        // onPrimary: onPrimary ?? Colors.white,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.all(Radius.circular(radius)),
        // ),
        // ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
