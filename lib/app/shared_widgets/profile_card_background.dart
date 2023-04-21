import 'package:flutter/material.dart';

class ElevatedCardBackground extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  const ElevatedCardBackground(
      {Key? key,
      required this.child,
      this.padding = const EdgeInsets.symmetric(
        horizontal: 41,
        vertical: 15,
      )})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: padding,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              blurRadius: 50,
              color: Color.fromRGBO(7, 5, 26, 0.07),
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: child);
  }
}
