import 'package:flutter/material.dart';

class CustomSectionHeading extends StatefulWidget {
  final String heading;
  final TextStyle? headingTextStyle;
  final Widget child;
  final double headingAndChildGap;
  final double topSpacing;

  const CustomSectionHeading(
      {Key? key,
      required this.heading,
      required this.child,
      required this.headingAndChildGap,
      this.headingTextStyle,
      this.topSpacing = 16})
      : super(key: key);

  @override
  State<CustomSectionHeading> createState() => _CustomSectionHeadingState();
}

class _CustomSectionHeadingState extends State<CustomSectionHeading> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: widget.topSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.heading,
              style: widget.headingTextStyle ??
                  const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13.5,
                      fontStyle: FontStyle.normal),
            ),
            SizedBox(
              height: widget.headingAndChildGap,
            ),
            widget.child
          ],
        ));
  }
}
