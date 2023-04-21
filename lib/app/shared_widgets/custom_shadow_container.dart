import 'package:flutter/material.dart';

class CustomShadowContainer extends StatelessWidget {
  final Widget child;
  final GestureTapCallback? onTap;
  final EdgeInsets? padding;

  const CustomShadowContainer({Key? key, required this.child, this.onTap, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Ink(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 50,
              color: Color.fromRGBO(7, 5, 26, 0.07),
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: padding??const EdgeInsets.all(24.0),
          child: child,
        ),
      ),
    );
  }
}
