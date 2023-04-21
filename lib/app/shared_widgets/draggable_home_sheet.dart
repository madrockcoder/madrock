import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/util/color_scheme.dart';

class DraggableHomeSheet extends StatelessWidget {
  final double initialChildSize;
  final double minChildSize;
  final Widget child;
  final bool onlyTopRadius;
  final bool noBottomMargin;

  const DraggableHomeSheet({
    Key? key,
    required this.child,
    this.initialChildSize = 0.48,
    this.minChildSize = 0.2,
    this.onlyTopRadius = false,
    this.noBottomMargin = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: initialChildSize,
      minChildSize: minChildSize,
      maxChildSize: 0.95,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
            width: double.infinity,
            margin: noBottomMargin ? null : const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: onlyTopRadius
                  ? const BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30))
                  : BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.22),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                )
              ],
            ),
            child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    const Gap(12),
                    Container(
                      width: 20,
                      height: 2,
                      color: AppColor.kAccentColor2,
                    ),
                    child
                  ],
                )));
      },
    );
  }
}
