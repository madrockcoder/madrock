import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geniuspay/app/landing_page_vm.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';

import '../util/color_scheme.dart';

class SplashScreen extends StatefulWidget {
  final LandingPageVM model;
  const SplashScreen({Key? key, required this.model}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  double scale = 1;
  @override
  Widget build(BuildContext context) {
    if (widget.model.baseModelState != BaseModelState.loading) {
      setState(() {
        scale = 10;
      });
    }
    return Scaffold(
      backgroundColor: AppColor.kSplashColor,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedScale(
                scale: scale,
                duration: const Duration(milliseconds: 300),
                onEnd: () {
                  widget.model.markSplashDone();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25)),
                  padding: const EdgeInsets.all(16),
                  width: 92,
                  height: 92,
                )),
            SvgPicture.asset(
              'assets/images/logo_icon.svg',
              width: 52,
            )
          ],
        ),
      ),
    );
  }
}
