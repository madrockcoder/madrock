import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geniuspay/util/color_scheme.dart';

class TileSelector extends StatelessWidget {
  final String svgAsset;
  final String title;
  final VoidCallback? onPressed;
  const TileSelector(
      {Key? key, required this.svgAsset, required this.title, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Theme(
        data: ThemeData(
            splashColor: AppColor.kAccentColor2,
            highlightColor: AppColor.kAccentColor2),
        child: ListTile(
          onTap: onPressed,
          selectedTileColor: AppColor.kAccentColor2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          minLeadingWidth: 0,
          leading: CircleAvatar(
            backgroundColor: AppColor.kAccentColor2,
            child: SvgPicture.asset(
              svgAsset,
              color: Colors.black,
            ),
            radius: 23,
          ),
          title: Text(
            title,
            style: textTheme.bodyMedium?.copyWith(fontSize: 16),
          ),
        ));
  }
}
