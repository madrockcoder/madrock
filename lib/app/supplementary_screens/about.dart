import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/shared_widgets/custom_circular_image.dart';
import 'package:geniuspay/app/shared_widgets/custom_section_heading.dart';
import 'package:geniuspay/app/shared_widgets/custom_shadow_container.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/essentials.dart';
import 'package:geniuspay/util/widgets_util.dart';
import 'package:url_launcher/url_launcher.dart';

String version = '1.0.0+16';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const About(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 18.0, right: 25.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Gap(16),
            Text('About',
                style: textTheme.displayMedium
                    ?.copyWith(color: AppColor.kSecondaryColor, fontSize: 20)),
            CustomSectionHeading(
              heading: "Service Provider",
              child: CustomShadowContainer(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  children: const [
                    CustomCircularImage('icons/flags/png/ca.png',
                        radius: 40, package: 'country_icons', fit: BoxFit.fill),
                    Gap(12),
                    Text("geniuspay Inc.")
                  ],
                ),
              ),
              headingAndChildGap: 8,
              topSpacing: 24,
              headingTextStyle: textTheme.bodyMedium?.copyWith(
                color: AppColor.kSecondaryColor,
              ),
            ),
            CustomSectionHeading(
              heading: "Rate us",
              child: CustomShadowContainer(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    customListTile(
                        "assets/icons/app-store.svg",
                        "Rate Us on the ${Platform.isIOS ? "App Store" : "Play Store"}",
                        Platform.isAndroid
                            ? "https://play.google.com/store/apps/details?id=com.geniuspay.geniuspay"
                            : "https://testflight.apple.com/join/LQ9jECOl",
                        context),
                    const Gap(16),
                    customListTile(
                        "assets/icons/trustpilot.svg",
                        "Leave a Review on Trustpilot",
                        "https://www.trustpilot.com/review/geniuspay.com",
                        context),
                  ],
                ),
              ),
              headingAndChildGap: 8,
              topSpacing: 16,
              headingTextStyle: textTheme.bodyMedium?.copyWith(
                color: AppColor.kSecondaryColor,
              ),
            ),
            CustomSectionHeading(
              heading: "Social Media",
              child: CustomShadowContainer(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    customListTile(
                        "assets/icons/facebook.svg",
                        "Follow Us on Facebook",
                        "https://facebook.com/geniuspayglobal",
                        context),
                    const Gap(16),
                    customListTile("assets/icons/twitter.svg",
                        "Follow Us on Twitter", "https://twitter.com", context),
                    const Gap(16),
                    customListTile(
                        "assets/icons/instagram.svg",
                        "Follow Us on Instagram",
                        "https://instagram.com/geniuspay",
                        context),
                    const Gap(16),
                    customListTile(
                        "assets/icons/youtube.svg",
                        "Follow Us on YouTube",
                        "https://www.youtube.com/channel/UCdJMkR5ayt4VDgaTcxVSgNg/videos",
                        context),
                  ],
                ),
              ),
              headingAndChildGap: 8,
              topSpacing: 16,
              headingTextStyle: textTheme.bodyMedium?.copyWith(
                color: AppColor.kSecondaryColor,
              ),
            ),
            const Gap(48),
            Center(
              child: Text(
                "Version $version",
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColor.kOnPrimaryTextColor2,
                ),
              ),
            ),
            const Gap(48),
          ]),
        ),
      ),
      appBar: WidgetsUtil.onBoardingAppBar(context,
          automaticallyImplyLeading: true),
    );
  }

  Widget customListTile(
      String asset, String title, String url, BuildContext context) {
    return InkWell(
      onTap: () {
        Essentials.launchCustomUrl(Uri.parse(url), context,
            launchMode: LaunchMode.externalApplication);
      },
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(asset),
            ),
            decoration: const BoxDecoration(
                color: AppColor.kSecondaryColor, shape: BoxShape.circle),
          ),
          const Gap(12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              color: AppColor.kOnPrimaryTextColor2,
              letterSpacing: 0.3,
            ),
          ),
          const Spacer(),
          SvgPicture.asset(
            "assets/icons/arrow.svg",
          )
        ],
      ),
    );
  }
}
