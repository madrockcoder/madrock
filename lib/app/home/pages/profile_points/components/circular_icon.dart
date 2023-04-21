import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geniuspay/util/color_scheme.dart';

class CircularIcon extends StatefulWidget {
  final String asset;
  final double assetWidth;
  final String? heading;
  final bool showMiniIcon;

  const CircularIcon(
      {Key? key,
      required this.asset,
      required this.assetWidth,
      this.heading,
      this.showMiniIcon = false})
      : super(key: key);

  @override
  State<CircularIcon> createState() => _CircularIconState();
}

class _CircularIconState extends State<CircularIcon> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: widget.showMiniIcon ? 40 : 48,
          height: widget.showMiniIcon ? 40 : 48,
          child: Center(
            child: SvgPicture.asset(widget.asset, width: widget.assetWidth),
          ),
          decoration: const BoxDecoration(
              color: AppColor.kAccentColor2, shape: BoxShape.circle),
        ),
        widget.heading != null
            ? Column(
                children: [
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    widget.heading!,
                    style: const TextStyle(fontSize: 12),
                  )
                ],
              )
            : const SizedBox()
      ],
    );
  }
}
