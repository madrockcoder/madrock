import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  const RoundButton(
      {Key? key,
      required this.voidCallback,
      required this.backgroundColor,
      this.labelColor,
      this.borderRadius,
      required this.label,
      this.height,
      this.margin,
      this.labelSize})
      : super(key: key);
  final VoidCallback voidCallback;
  final Color backgroundColor;
  final Color? labelColor;
  final double? borderRadius;
  final String label;
  final double? labelSize;
  final double? height;
  final double? margin;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        voidCallback();
      },
      child: Container(
        height: height ?? 50,
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: margin ?? 45),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius ?? 9),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            label,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontSize: labelSize ?? 14, color: labelColor ?? Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
