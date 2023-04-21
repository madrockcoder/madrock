import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/deposit_funds/widgets/round_tag_button.dart';
import 'package:geniuspay/app/home/widget/onboarding_status_widget.dart';
import 'package:geniuspay/app/home/widget/wallet_selector.dart';
import 'package:geniuspay/app/payout/beneficiaries/screens/borderless/borderless_recipient.dart';
import 'package:geniuspay/app/payout/international_transfer/international_transfer_main.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/enums.dart';
import 'package:geniuspay/util/essentials.dart';

class PayoutSelectorPage extends StatelessWidget {
  final Wallet? wallet;
  PayoutSelectorPage({Key? key, this.wallet}) : super(key: key);
  static Future<void> show(
      {required BuildContext context, Wallet? wallet}) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
          builder: (_) => PayoutSelectorPage(
                wallet: wallet,
              )),
    );
  }

  final AuthenticationService _authenticationService =
      sl<AuthenticationService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Pay-Out option'),
        centerTitle: true,
        actions: const [HelpIconButton()],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        children: [
          SelectorButton(
              svgAsset: 'assets/images/logo_white.svg',
              title: 'geniuspay to geniuspay',
              subtitle:
                  'Send to anyone on geniuspay. If they don’t have geniuspay account yet.',
              tags: const ['Fee 0%', 'Instant', 'Worldwide'],
              onTap: () async {
                if (_authenticationService.user!.userProfile.onboardingStatus ==
                    OnboardingStatus.onboardingCompleted) {
                  if (wallet == null) {
                    final result = await showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return const WalletSelectorList(
                            disable: true,
                          );
                        });
                    if (result.runtimeType == Wallet) {
                      BorderlessRecipientHomeScreen.show(context,
                          wallet: result);
                    }
                  } else {
                    BorderlessRecipientHomeScreen.show(context,
                        wallet: wallet!);
                  }
                } else {
                  return OnboardingStatusPage.show(
                      context,
                      _authenticationService
                          .user!.userProfile.onboardingStatus);
                }
              }),
          const Gap(8),
          SelectorButton(
              svgAsset: 'assets/payout/european_payments.svg',
              title: 'European Payments',
              subtitle: 'Send money within EU and SEPA region.',
              tags: const ['Fee 0%', 'Fast', 'Europe'],
              onTap: () {
                // PopupDialogs(context).comingSoonSnack();
                if (_authenticationService.user!.userProfile.onboardingStatus ==
                    OnboardingStatus.onboardingCompleted) {
                  InternationalTransferPage.show(context, true);
                } else {
                  return OnboardingStatusPage.show(
                      context,
                      _authenticationService
                          .user!.userProfile.onboardingStatus);
                }
              }),
          const Gap(8),
          SelectorButton(
              svgAsset: 'assets/payout/international_payments.svg',
              title: 'International Payments',
              subtitle: 'Send money within non-EU countries bank accounts.',
              tags: const ['Fee 1%', 'Fast', 'International'],
              onTap: () async {
                // PopupDialogs(context).comingSoonSnack();
                if (_authenticationService.user!.userProfile.onboardingStatus ==
                    OnboardingStatus.onboardingCompleted) {
                  InternationalTransferPage.show(context, false);
                } else {
                  return OnboardingStatusPage.show(
                      context,
                      _authenticationService
                          .user!.userProfile.onboardingStatus);
                }
              }),
          const Gap(8),
          if(!shouldTemporaryHideForEarlyLaunch)
            SelectorButton(
                svgAsset: 'assets/payout/mobile_money.svg',
                title: 'Mobile Money',
                subtitle: 'Send money to accounts linked with phone numbers.',
                tags: const ['Fee 0.5%', 'Fast', 'International'],
                onTap: () {
                  // MobileMoneyRecipientHomeScreen.show(context);
                  PopupDialogs(context).comingSoonSnack();
                }),
          // const Gap(8),
          // SelectorButton(
          //     svgAsset: 'assets/payout/request_money.svg',
          //     title: 'Request Money',
          //     subtitle:
          //         'Request from anyone even if they don\'t have a geniuspay account, send them a link to pay.',
          //     tags: const ['Free', 'Instant'],
          //     onTap: () {
          //       PopupDialogs(context).comingSoonSnack();
          //     }),
          const Gap(8),
        ],
      ),
    );
  }
}

class SelectorButton extends StatelessWidget {
  final String svgAsset;
  final String title;
  final String subtitle;
  final List<String> tags;
  final Function() onTap;
  const SelectorButton(
      {Key? key,
      required this.svgAsset,
      required this.title,
      required this.subtitle,
      required this.tags,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              blurRadius: 25,
              color: Color.fromRGBO(7, 5, 26, 0.07),
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: onTap,
                child: Container(
                    padding: const EdgeInsets.all(20),
                    constraints: const BoxConstraints(minHeight: 139),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: AppColor.kAccentColor2,
                          child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: SvgPicture.asset(
                                svgAsset,
                                color: Colors.black,
                              )),
                        ),
                        const Gap(8),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              title,
                              style: textTheme.bodyLarge,
                            ),
                            const Gap(4),
                            Text(
                              subtitle,
                              style: textTheme.bodyMedium
                                  ?.copyWith(fontSize: 10, height: 1.5),
                            ),
                            const Gap(8),
                            Wrap(
                              spacing: 5,
                              runSpacing: 5,
                              children: [
                                for (String tagText in tags) ...[
                                  RoundTag(label: tagText),
                                ],
                              ],
                            )
                          ],
                        )),
                        const Gap(24),
                        SvgPicture.asset('assets/images/Arrow-Down2.svg')
                      ],
                    )))));
  }
}
