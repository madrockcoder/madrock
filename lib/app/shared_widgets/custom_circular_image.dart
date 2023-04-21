import 'package:flutter/material.dart';

class CustomCircularImage extends StatelessWidget {
  final double radius;
  final String assetImage;
  final String? package;
  final BoxFit? fit;

  const CustomCircularImage(this.assetImage,
      {Key? key, this.radius = 40, this.package, this.fit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: AssetImage(assetImage, package: package), fit: fit)),
    );
  }
}
