import 'package:flutter/material.dart';

import '../../../models/onboarding_model.dart';
import '../../../util/color_scheme.dart';

class OnboardItem extends StatelessWidget {
  const OnboardItem({
    Key? key,
    required this.padding,
    required this.data,
    required this.currIndex,
    required this.lastIndex,
  }) : super(key: key);

  final EdgeInsetsGeometry padding;
  final Onboard data;
  final int currIndex;
  final int lastIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(data.image!),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        Padding(
          padding: padding,
          child: Text(
            data.title,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: AppColor.kOnPrimaryTextColor2, fontSize: 25.0),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 8.0,
          ),
          child: Text(
            data.subTitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: currIndex == 1 ? const Color(0xffFE7748) : Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.w300),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
