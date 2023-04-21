import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'icon_container.dart';

class CustomListTile extends ListTile {
  CustomListTile({
    Key? key,
    required Widget title,
    Widget? trailing,
    Widget? subtitle,
    String? icon,
    Color? iconColor,
    Widget? leadingIcon,
    double? iconHeight = 16.0,
    double? iconWidth = 16.0,
    bool? isSvg = true,
    VoidCallback? onTap,
    VisualDensity? visualDensity,
    double? verticalPadding = 0.0,
    double? horizontalPadding = 0.0,
    double? iconContainerRadius = 50.0,
  }) : super(
          key: key,
          contentPadding: EdgeInsets.symmetric(
              vertical: verticalPadding!, horizontal: horizontalPadding!),
          dense: true,
          visualDensity: visualDensity,
          title: title,
          subtitle: subtitle,
          trailing: trailing,
          onTap: onTap,
          leading: leadingIcon ??
              (icon == null
                  ? null
                  : IconContainer(
                      icon: !isSvg!
                          ? Image.asset(icon,
                              height: iconHeight, width: iconWidth)
                          : (SvgPicture.asset(icon,
                              color: iconColor,
                              height: iconHeight,
                              width: iconWidth)),
                      radius: iconContainerRadius)),
        );
}
