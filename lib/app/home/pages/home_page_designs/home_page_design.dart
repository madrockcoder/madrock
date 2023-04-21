import 'package:geniuspay/app/Profile/refer/refer_a_friend_homescreen.dart';
import 'package:geniuspay/app/geniogreen/screens/geniogreen_main.dart';
import 'package:geniuspay/app/home/pages/home_page_designs/home_page_design_list.dart';
import 'package:geniuspay/app/payout/payout_selector.dart';
import 'package:geniuspay/app/shared_widgets/custom_yellow_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/size_config.dart';
import 'package:flutter/material.dart';
import 'package:geniuspay/app/wallet/create_individual_wallet/create_wallet.dart';

import 'models/home_page_design_model.dart';

class HomePageDesign extends StatefulWidget {
  final HomePageDesigns homePageDesign;

  const HomePageDesign({Key? key, required this.homePageDesign})
      : super(key: key);

  static Future<void> show(
      BuildContext context, HomePageDesigns homePageDesign) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
          builder: (_) => HomePageDesign(
                homePageDesign: homePageDesign,
              )),
    );
  }

  @override
  State<HomePageDesign> createState() => _HomePageDesignState();
}

class _HomePageDesignState extends State<HomePageDesign> {
  String assetPath = "assets/home_designs";
  late HomePageDesignModel homePageDesignModel;

  @override
  void initState() {
    homePageDesignModel = getHomePageDesignModel(widget.homePageDesign);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: homePageDesignModel.backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 16,
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 24),
            //   child: Container(
            //     width: double.maxFinite,
            //     height: 5,
            //     child: Padding(
            //       padding: const EdgeInsets.only(right: 170.0),
            //       child: Container(
            //         height: 5,
            //         decoration: const BoxDecoration(
            //             color: AppColor.kAccentColor2,
            //             borderRadius: BorderRadius.all(Radius.circular(100))),
            //       ),
            //     ),
            //     decoration: BoxDecoration(
            //         color: const Color(0xFFFFFFFF).withOpacity(0.5),
            //         borderRadius: const BorderRadius.all(Radius.circular(100))),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
              child: InkWell(
                child: const Icon(Icons.close, color: Colors.white),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: widget.homePageDesign == HomePageDesigns.sendMoney
                  ? const EdgeInsets.only(left: 24)
                  : const EdgeInsets.symmetric(horizontal: 24),
              child: Text(homePageDesignModel.title,
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                homePageDesignModel.subtitle,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w300),
              ),
            ),
            SizedBox(
              height: homePageDesignModel.imageTopSpacing,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: homePageDesignModel.imageHorizontalPadding),
              child: Image.asset(
                homePageDesignModel.asset,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: CustomYellowElevatedButton(
                  onTap: () {
                    switch (widget.homePageDesign) {
                      case HomePageDesigns.sendMoney:
                        PayoutSelectorPage.show(context: context);
                        break;
                      case HomePageDesigns.refer:
                        ReferAFriendHomeScreen.show(context);
                        break;
                      case HomePageDesigns.twoFactorAuthentication:
                        ReferAFriendHomeScreen.show(context);
                        break;
                      case HomePageDesigns.interest:
                        // TODO: Handle this case.
                        break;
                      case HomePageDesigns.plantTree:
                        GenioGreenPage.show(context);
                        break;
                      case HomePageDesigns.hybridWallet:
                        CreateWalletScreen.show(context);
                        break;
                      case HomePageDesigns.connect:
                        CreateWalletScreen.show(context);
                        break;
                    }
                  },
                  text: homePageDesignModel.buttonText),
            ),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
