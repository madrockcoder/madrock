import 'package:flutter/material.dart';

class HeaderSection extends StatefulWidget {
  final String heading;
  final Widget actionWidget;
  const HeaderSection(
      {Key? key, required this.heading, required this.actionWidget})
      : super(key: key);

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0, bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
          Text(
            widget.heading,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          widget.actionWidget
        ],
      ),
    );
  }
}
