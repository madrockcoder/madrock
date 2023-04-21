import 'package:flutter/material.dart';

class SectionHeading extends StatefulWidget {
  final String heading;

  const SectionHeading({Key? key, required this.heading}) : super(key: key);

  @override
  State<SectionHeading> createState() => _SectionHeadingState();
}

class _SectionHeadingState extends State<SectionHeading> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 16),
      child: Text(
        widget.heading,
        style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13.5,
            fontStyle: FontStyle.normal),
      ),
    );
  }
}
