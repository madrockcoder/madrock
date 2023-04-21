import 'package:flutter/material.dart';
import 'package:geniuspay/util/color_scheme.dart';

class CurvedBackground extends StatelessWidget {
  final Widget child;
  final Color bgColor;
  final List<Color> gradientColors;
  final double borderRadius;
  const CurvedBackground({
    Key? key,
    required this.child,
    this.bgColor = AppColor.kAccentColor2,
    this.gradientColors = const [
      AppColor.kSecondaryColor,
      AppColor.kAccentColor2,
    ],
    this.borderRadius = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Padding(
            padding: const EdgeInsets.all(2),
            child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 22,
                  horizontal: 14,
                ),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(borderRadius - 2),
                ),
                child: child)));
  }
}
