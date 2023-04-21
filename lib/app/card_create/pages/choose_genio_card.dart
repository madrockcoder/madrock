import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/card_create/pages/customise_card/customize_card_screen.dart';
import 'package:geniuspay/app/card_create/widgets/genio_credit_card_tile.dart';
import 'package:geniuspay/app/changes/pages/changes_screen.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/app/shared_widgets/size_config.dart';
// import 'package:taskproject/app/card_create/widgets/genio_credit_card_tile.dart';
// import 'package:taskproject/app/shared_widgets/size_config.dart';
// import 'package:taskproject/application/rich_txt_widget.dart';
// import 'package:taskproject/presentation/router/routes.dart';

// import '../../../application/const.dart';
// import '../../../gen/assets.gen.dart';
import '../../../util/color_scheme.dart';

class ChooseGenioCard extends StatelessWidget {
  const ChooseGenioCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.kAccentColor2,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        actions: const [HelpIconButton()],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [AppColor.kAccentColor2, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(SizeConfig.blockSizeVertical! * 10),
            RichText(
              text: TextSpan(
                text: 'Choose your ',
                style: Theme.of(context).textTheme.displayMedium,
                children: [
                  TextSpan(
                    text: 'Genio',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  TextSpan(
                    text: ' Card',
                    style: Theme.of(context).textTheme.displayMedium,
                  )
                ],
              ),
            ),
            Gap(SizeConfig.blockSizeVertical! * 03),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const CustomizeCard())));
                // LinkWallet.show(context);
              },
              child: GenioCreditCardTile(
                card: Image.asset(
                  'assets/icons/plastic_card.png',
                  width: 118,
                ),
                icon: SvgPicture.asset('assets/icons/cardBlue.svg',
                    height: SizeConfig.blockSizeVertical! * 04,
                    width: SizeConfig.blockSizeVertical! * 04,
                    fit: BoxFit.cover),
                subtitle:
                    'Pay online and touchless and never deal with the hassle of forgeting your card again.',
                title: 'Plastic',
              ),
            ),
            const Gap(16),
            GestureDetector(
              onTap: () {
                ChangesComingSoon.show(context);
                // final AuthenticationService _authenticationService =
                //     sl<AuthenticationService>();
                // if (_authenticationService.user!.userProfile.onboardingStatus ==
                //     OnboardingStatus.onboardingCompleted) {
                //   YourCardScreen.show(context);
                // } else {
                //   OnboardingStatusPage.show(
                //       context,
                //       _authenticationService
                //           .user!.userProfile.onboardingStatus);
                // }
              },
              child: GenioCreditCardTile(
                card: Image.asset(
                  'assets/icons/virtual_card.png',
                  width: 118,
                ),
                icon: SvgPicture.asset('assets/icons/card_virtual_blue.svg',
                    height: SizeConfig.blockSizeVertical! * 04,
                    width: SizeConfig.blockSizeVertical! * 04,
                    fit: BoxFit.cover),
                subtitle:
                    'Make your money move with you, always  at the live-rates.',
                title: 'Virtual',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
