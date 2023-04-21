import 'package:flutter/material.dart';
import 'package:geniuspay/app/card_create/pages/customise_card/green_plastic_card.dart';
import 'package:geniuspay/app/card_create/pages/customise_card/metal_silver_screen.dart';
import 'package:geniuspay/app/card_create/pages/customise_card/transparent_black_card.dart';
import 'package:geniuspay/app/changes/pages/changes_screen.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/util/color_scheme.dart';

int currentIndex = 0;

class CustomizeCard extends StatefulWidget {
  const CustomizeCard({Key? key}) : super(key: key);

  @override
  State<CustomizeCard> createState() => _CustomizeCardState();
}

class _CustomizeCardState extends State<CustomizeCard> {
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: .7);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        backgroundColor: AppColor.kAccentColor3,
        appBar: AppBar(
          backgroundColor: AppColor.kAccentColor3,
          title: Center(
            child: Text(
              'Customize your Card',
              style: textTheme.titleLarge
                  ?.copyWith(color: AppColor.kOnPrimaryTextColor),
            ),
          ),
          actions: const [HelpIconButton()],
        ),
        body: Column(children: [
          Expanded(
              child: PageView(
            pageSnapping: true,
            controller: _pageController,
            onPageChanged: (page) {
              setState(() {
                currentIndex = page;
              });
            },
            children: const [
              GreenPlasticCard(),
              TransparentBlackCard(),
              MetalSilver(),
            ],
          )),
          Container(
            // margin: EdgeInsets.only(top: 45),
            padding: const EdgeInsets.all(24),
            child: GestureDetector(
              onTap: (){
                ChangesComingSoon.show(context);
              },
              child: CustomElevatedButton(
                borderColor: AppColor.kDisabledContinueButtonColor,
                child: Text(
                    currentIndex == 0
                        ? 'GET FREE CARD'
                        : currentIndex == 1
                            ? 'GET THE CARD'
                            : 'GET METAL SILVER',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: AppColor.kWhiteColor)),
                onPressed: null,
                  // () {
                  // final AuthenticationService _authenticationService =
                  //     sl<AuthenticationService>();
                  // if (_authenticationService.user!.userProfile.onboardingStatus ==
                  //     OnboardingStatus.onboardingCompleted) {
                  //   YourCardScreen.show(context);
                  //   // LinkWallet.show(context);
                  // } else {
                  //   OnboardingStatusPage.show(
                  //       context,
                  //       _authenticationService
                  //           .user!.userProfile.onboardingStatus);
                  // }
                // },
                color: AppColor.kOnPrimaryTextColor,
                radius: 8,
              ),
            ),
          ),
        ]));
  }
}
