import 'package:flutter/material.dart';
import 'package:geniuspay/util/color_scheme.dart';

class OnboardProgressIndicator extends StatelessWidget {
  const OnboardProgressIndicator({
    Key? key,
    required this.isCurrentPage,
  }) : super(key: key);
  final bool isCurrentPage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 15,
      height: 4,
      decoration: BoxDecoration(
        color: AppColor.kAccentColor3,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Container(
        width: 15,
        height: 4,
        decoration: BoxDecoration(
          color: isCurrentPage ? AppColor.kGoldColor2 : Colors.transparent,
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}
