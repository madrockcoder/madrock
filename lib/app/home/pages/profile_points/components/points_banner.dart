import 'package:flutter/material.dart';
import 'package:geniuspay/util/color_scheme.dart';

class TotalPointsBanner extends StatefulWidget {
  final double points;
  const TotalPointsBanner({Key? key, required this.points}) : super(key: key);

  @override
  State<TotalPointsBanner> createState() => _TotalPointsBannerState();
}

class _TotalPointsBannerState extends State<TotalPointsBanner> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            Text(
              "Total Points",
              style: TextStyle(
                  color: AppColor.kWhiteColor.withOpacity(0.6), fontSize: 11),
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icons/profile/points/trophy.png',
                  width: 32,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  widget.points.toStringAsFixed(0),
                  style: const TextStyle(
                      color: AppColor.kWhiteColor,
                      fontSize: 44,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
