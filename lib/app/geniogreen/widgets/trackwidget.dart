import 'package:flutter/material.dart';

class TrackWidget extends StatelessWidget {
  final Widget child;
  final Color bgColor;
  const TrackWidget({Key? key, required this.child, required this.bgColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(padding: const EdgeInsets.all(14), child: child),
            )));
  }
}
