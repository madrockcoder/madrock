import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget? child;
  final Color? borderColor;
  final double? height;
  final double? width;
  final double? maxWidth;
  final double? maxHeight;
  final Color? containerColor;
  final double? radius;
  final double? topLeftRadius;
  final double? topRightRadius;
  final double? bottomLeftRadius;
  final double? bottomRightRadius;
  final Gradient? gradient;
  final DecorationImage? decorationImage;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onPressed;
  final List<BoxShadow>? boxShadow;

  const CustomContainer({
    Key? key,
    this.child,
    this.borderColor,
    this.height = 100.0,
    this.width = 100.0,
    this.maxWidth,
    this.maxHeight,
    this.containerColor,
    this.topLeftRadius,
    this.radius = 0.0,
    this.topRightRadius,
    this.bottomLeftRadius,
    this.bottomRightRadius,
    this.gradient,
    this.decorationImage,
    this.padding,
    this.onPressed,
    this.boxShadow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: maxHeight ?? double.infinity,
          maxWidth: maxWidth ?? double.infinity,
        ),
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: radius == null
              ? null
              : BorderRadius.only(
                  bottomLeft: Radius.circular(bottomLeftRadius ?? radius!),
                  bottomRight: Radius.circular(bottomRightRadius ?? radius!),
                  topLeft: Radius.circular(topLeftRadius ?? radius!),
                  topRight: Radius.circular(topRightRadius ?? radius!),
                ),
          color: containerColor,
          gradient: gradient,
          image: decorationImage,
          border: borderColor != null
              ? Border.all(color: borderColor!)
              // ? Border(
              //     top: BorderSide(color: borderColor!),
              //     bottom: BorderSide(color: borderColor!),
              //     left: BorderSide(color: borderColor!),
              //     right: BorderSide(color: borderColor!),
              //   )
              : null,
          boxShadow: boxShadow,
        ),
        child: child,
      ),
    );
  }
}
