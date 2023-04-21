import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/Profile/business_profile/screens/business_profile.dart';
import 'package:geniuspay/app/Profile/business_profile/screens/no_business_account.dart';
import 'package:geniuspay/app/Profile/business_profile/screens/verify_documents.dart';
import 'package:geniuspay/app/shared_widgets/custom_loader.dart';
import 'package:geniuspay/core/injections/injections.dart';
import 'package:geniuspay/services/auth_services.dart';

class HorizontalCardListWidget extends StatefulWidget {
  const HorizontalCardListWidget({Key? key}) : super(key: key);

  @override
  State<HorizontalCardListWidget> createState() =>
      _HorizontalCardListWidgetState();
}

class _HorizontalCardListWidgetState extends State<HorizontalCardListWidget> {
  late List<Banner> banners;
  final AuthenticationService _auth = sl<AuthenticationService>();

  @override
  void initState() {
    banners = [
      Banner(
          "Invite your friends",
          "For every invite, you win \$20!\nClick here to start inviting your friends.",
          "assets/home/home_banner_1.png",
          const Color(0xFF117AFA),
          80,
          () {}),
      // Banner(
      //     "Create a Jar",
      //     "Save and grow your money effortlessly.\nYou can start wit as little as \$1.00.",
      //     "assets/home/home_banner_2.png",
      //     const Color(0xFFDF334F),
      //     80),
      // Banner(
      //     "Plant a tree",
      //     "Calculate and offset your carbon footprint by planting a tree.",
      //     "assets/home/home_banner_3.png",
      //     const Color(0xFF496E2D),
      //     80),
      if (_auth.user!.userProfile.businessProfile == null)
        Banner(
            "Open Business Account",
            " Automate your business payments and track all clients in one place.",
            "assets/home/home_banner_4.png",
            const Color(0xFFBEA475),
            50.89, () async {
          CustomLoaderScreen.show(context);
          await _auth.getUser();
          Navigator.pop(context);
          if (_auth.user!.userProfile.businessProfile == null) {
            NoBusinessAccount.show(context);
          } else {
            if (_auth.user!.userProfile.businessProfile!.verificationStatus ==
                'VERIFIED') {
              BusinessProfile.show(
                  context,
                  _auth.user!.userProfile.businessProfile!,
                  _auth.user!.userProfile.customerNumber!);
            } else {
              VerifyDocuments.show(
                  context, _auth.user!.userProfile.customerNumber!);
            }
          }
        }),
      // Banner("Sign up to Avios rewards", "Track and collect with geniuspay",
      //     "assets/home/home_banner_5.png", const Color(0xFFB3B2B1), 80),
      // Banner("Link your PayPal account", "", "assets/home/home_banner_6.png",
      //     const Color(0xFF27346A), 80),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
            banners.length,
            (index) => Padding(
                  padding: EdgeInsets.only(
                      right: index == banners.length - 1 ? 24 : 16,
                      left: index == 0 ? 24 : 0),
                  child: GestureDetector(
                    onTap: () async {
                      banners[index].onTap();
                    },
                    child: Container(
                      width: 296,
                      height: 93,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: banners[index].color),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  banners[index].heading,
                                  style: textTheme.subtitle1?.copyWith(
                                      fontSize: 14,
                                      color: const Color(0xFFF9FAFB)),
                                ),
                                const Gap(4),
                                Text(banners[index].description,
                                    style: textTheme.bodyText2?.copyWith(
                                        fontSize: 10,
                                        color: const Color(0xFFF9FAFB)))
                              ],
                            ),
                          ),
                          Image.asset(
                            banners[index].image,
                            height: banners[index].imageHeight,
                          ),
                          // if(index == 4 || index == 5)
                          //   Padding(
                          //     padding: const EdgeInsets.only(left: 10),
                          //     child: Column(
                          //       children: const [
                          //         Gap(8),
                          //         Icon(Icons.close, color: Colors.white, size: 16,)
                          //       ],
                          //     ),
                          //   )
                        ],
                      ),
                    ),
                  ),
                )),
      ),
    );
  }
}

class Banner {
  final String heading;
  final String description;
  final String image;
  final double imageHeight;
  final Color color;
  final GestureTapCallback onTap;

  Banner(this.heading, this.description, this.image, this.color,
      this.imageHeight, this.onTap);
}
