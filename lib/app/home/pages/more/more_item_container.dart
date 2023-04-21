import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geniuspay/util/color_scheme.dart';

// class MoreItemContainer extends CustomContainer {
//   MoreItemContainer({Key? key, required String assetName})
//       : super(
//           key: key,
// containerColor: AppColor.kGenioGreenColor,
// maxHeight: 40.0,
// maxWidth: 40.0,
// radius: 12.0,
// child: SvgPicture.asset(assetName),
//         );
// }

class MoreItemContainer extends StatelessWidget {
  const MoreItemContainer({
    Key? key,
    this.assetName,
    this.image,
    required this.title,
    this.onTap,
    this.hasColor = false,
    this.imageWidth,
    this.imageHeight,
  }) : super(key: key);
  final String? assetName;
  final String? image;
  final String title;
  final VoidCallback? onTap;
  final bool hasColor;
  final double? imageWidth;
  final double? imageHeight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          image != null
              ? Image.asset(
                  image!,
                  fit: imageWidth != null ? null : BoxFit.cover,
                  width: imageWidth,
                  height: imageWidth ?? 24,
                )
              : SvgPicture.asset(
                  assetName!,
                  color: hasColor ? null : AppColor.kSecondaryColor,
                  height: imageHeight ?? 24.0,
                  width: imageWidth ?? 24.0,
                ),
          const SizedBox(height: 8.0),
          SizedBox(
            width: 89,
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
