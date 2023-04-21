import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/util/color_scheme.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    Key? key,
    required this.icon,
    this.onTab,
    required this.text,
    this.disabled = false,
    this.buttonColor = AppColor.kSecondaryColor,
    this.disabledColor,
  }) : super(key: key);

  final String icon;
  final String text;
  final Function()? onTab;
  final bool disabled;
  final Color buttonColor;
  final Color? disabledColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Card(
            elevation: 0,
            color: disabled ? disabledColor ?? buttonColor.withOpacity(0.3) : buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: InkWell(
                borderRadius: BorderRadius.circular(20.0),
                onTap: () {
                  if (!disabled) {
                    onTab!();
                  }
                },
                child: Container(
                  width: 50,
                  height: 50,
                  padding: const EdgeInsets.all(13),
                  child: SvgPicture.asset(icon),
                ))),
        const Gap(8),
        Text(
          text,
          style: textTheme.bodyMedium?.copyWith(
            color: disabled ? buttonColor.withOpacity(0.3) : buttonColor,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
