import 'package:flutter/material.dart';
import 'package:geniuspay/util/constants.dart';

Future<bool?> showDraggableScrollableSheet(
  BuildContext context,
  Widget child, [
  double? initialChildSize,
  bool? isDismissible,
  EdgeInsetsGeometry? padding,
]) {
  return showModalBottomSheet(
    backgroundColor: Colors.white,
    isScrollControlled: true,
    isDismissible: isDismissible ?? true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
    ),
    builder: (_) => DraggableScrollableSheet(
      expand: false,
      minChildSize: 0.5,
      initialChildSize: initialChildSize ?? 0.8,
      maxChildSize: 0.8,
      builder: (_, controller) => Padding(
        padding: padding ?? commonPadding,
        child: SingleChildScrollView(
          controller: controller,
          child: child,
        ),
      ),
    ),
  );
}

Future<bool?> showCustomModal(
  BuildContext context,
  Widget child, {
  bool? isDismissible,
  bool? isScrollControlled = false,
  BoxConstraints? constraints,
}) {
  return showModalBottomSheet(
    backgroundColor: Colors.white,
    isScrollControlled: isScrollControlled!,
    constraints: constraints,
    isDismissible: isDismissible ?? true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
    ),
    builder: (_) => child,
  );
}

Future<dynamic> showCustomScrollableSheet(
    {required BuildContext context,
    required Widget child,
    double borderRadius = 20}) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(borderRadius),
              topRight: Radius.circular(borderRadius))),
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * .8),
      builder: (context) {
        return child;
      });
}
