import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button_async.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/size_util.dart';

class AppUpdatePage extends StatelessWidget {
  const AppUpdatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kWhiteColor,
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: const Padding(
              padding: EdgeInsets.all(18.0),
              child: Text(
                'Not now',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  color: AppColor.kSecondaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(25.0),
        child: CustomElevatedButtonAsync(
          color: AppColor.kGoldColor2,
          child: const Text(
            "UPDATE APP",
            style: TextStyle(
              fontSize: 14,
              color: AppColor.kDropShadowColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: () async {},
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/icons/app-update.svg'),
              SizedBox(
                height: displayHeight(context) * 0.04,
              ),
              const Text(
                'Update the app \nto get new features',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: AppColor.kSecondaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: displayHeight(context) * 0.04,
              ),
              const Text(
                'We make geniuspay better with every release so you get new features and improved app experience',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: AppColor.kDropShadowColor,
                  fontWeight: FontWeight.w500,
                ),
              ),

              //Spacer(),
              // Align(
              //   alignment: Alignment.bottomCenter,
              //   child: CustomElevatedButtonAsync(
              //     color: AppColor.kGoldColor2,
              //     child: const Text(
              //       "UPDATE APP",
              //       style: TextStyle(
              //         fontSize: 14,
              //         color: AppColor.kPinDesColor,
              //         fontWeight: FontWeight.w600,
              //       ),
              //     ),
              //     onPressed: () async {},
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
