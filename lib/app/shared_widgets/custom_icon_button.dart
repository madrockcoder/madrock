import 'package:flutter/material.dart';
import 'package:geniuspay/util/color_scheme.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData iconData;
  final bool useRawMaterialButton;
  final Color? iconColor;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;

  const CustomIconButton({
    Key? key,
    this.onTap,
    required this.iconData,
    this.useRawMaterialButton = true,
    this.iconColor,
    this.alignment,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return useRawMaterialButton ?
      RawMaterialButton(
      constraints: const BoxConstraints(minWidth: 17.5),
      onPressed: onTap ??
              () {
            // HelpScreen.show(context);
          },
      child: Icon(
        iconData,
        color: AppColor.kOnPrimaryTextColor,
        size: 20,
      ),
      shape: const CircleBorder(),
    )
        :
    IconButton(
      icon: Icon(
        iconData,
        color: iconColor,
        size: 20,
      ),
      onPressed: onTap,
      alignment: alignment ?? Alignment.topLeft,
      padding: padding?? EdgeInsets.zero,
    );
  }
}
