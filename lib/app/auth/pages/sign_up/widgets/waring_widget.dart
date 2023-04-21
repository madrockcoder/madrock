import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/util/color_scheme.dart';

class WarningWidget extends StatelessWidget {
  const WarningWidget({
    Key? key,
    required this.title,
    this.backgroundColor,
    this.textColor,
    this.onTap,
  }) : super(key: key);

  final String title;
  final Color? textColor;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: backgroundColor ?? AppColor.kGreyColor,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.error_outline,
              color: textColor ?? AppColor.kOnPrimaryTextColor3,
              size: 16,
            ),
            const Gap(10),
            Expanded(
              child: Text(
                title,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: textColor ?? AppColor.kOnPrimaryTextColor3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
