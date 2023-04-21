import 'package:flutter/material.dart';

class CircleBorderIcon extends StatelessWidget {
  final Color gradientStart;
  final Color gradientEnd;
  final Color bgColor;
  final Color gapColor;
  final Widget child;
  final double spaceBetweenRingAndWidget;
  final double size;
  final double borderWidth;

  const CircleBorderIcon({
    Key? key,
    required this.gradientStart,
    required this.gradientEnd,
    required this.bgColor,
    required this.gapColor,
    required this.child,
    this.size = 140,
    this.spaceBetweenRingAndWidget = 20,
    this.borderWidth = 6,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(borderWidth),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
            colors: [gradientStart, gradientEnd],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      child: Container(
        padding: EdgeInsets.all(spaceBetweenRingAndWidget),
        decoration: BoxDecoration(
          color: gapColor,
          shape: BoxShape.circle,
        ),
        child: CircleAvatar(backgroundColor: bgColor, child: child),
      ),
    );
  }
}
