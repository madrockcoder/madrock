import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/perks/view_models/perk_vm.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button_async.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/models/perk.dart';
import 'package:geniuspay/models/user.dart';
import 'package:geniuspay/util/color_scheme.dart';

class PerkDetailPage extends StatelessWidget {
  final Perk perk;
  final User user;
  const PerkDetailPage({Key? key, required this.perk, required this.user})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: SvgPicture.asset('assets/icons/cancel.svg'),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColor.kSecondaryColor)),
                  child: Column(children: [
                    const Gap(16),
                    SizedBox(
                        width: 75,
                        height: 75,
                        child: Image.network(
                          perk.company.logo,
                          fit: BoxFit.fitHeight,
                        )),
                    const Gap(8),
                    Text(
                      perk.company.name,
                      style: textTheme.headline4
                          ?.copyWith(color: AppColor.kSecondaryColor),
                    ),
                    Text(
                      perk.name,
                      style: textTheme.bodyMedium,
                    ),
                    Text(
                      '(End date ${perk.validUntil})',
                      style: textTheme.bodyText2
                          ?.copyWith(color: AppColor.kSecondaryColor),
                    ),
                    const Gap(8),
                    IntrinsicWidth(
                        child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColor.kGoldColor2)),
                      child: Row(children: [
                        SvgPicture.asset(
                          'assets/icons/yellow_star.svg',
                          width: 13,
                        ),
                        const Gap(4),
                        Text(
                          perk.points.toString(),
                          style: textTheme.bodyText1
                              ?.copyWith(color: AppColor.kSecondaryColor),
                        )
                      ]),
                    )),
                    const Gap(16),
                  ]),
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomElevatedButton(
                    color: AppColor.kSecondaryColor,
                    onPressed: double.parse(user.userProfile.points!) <
                            perk.points
                        ? null
                        : () {
                            showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) {
                                  return Stack(
                                      alignment:
                                          AlignmentDirectional.bottomCenter,
                                      children: [
                                        Container(
                                            margin:
                                                const EdgeInsets.only(top: 50),
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(40),
                                                    topRight:
                                                        Radius.circular(40))),
                                            padding: EdgeInsets.only(
                                                top: 26,
                                                left: 26,
                                                right: 26,
                                                bottom: MediaQuery.of(context)
                                                    .viewInsets
                                                    .bottom),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Gap(30),
                                                Text(
                                                  'Claim this offer?',
                                                  textAlign: TextAlign.center,
                                                  style: textTheme.headline4
                                                      ?.copyWith(
                                                          fontSize: 20,
                                                          color: AppColor
                                                              .kSecondaryColor),
                                                ),
                                                const Gap(17),
                                                Text(
                                                  'Redeem ${perk.points} points to claim the offer.',
                                                  textAlign: TextAlign.center,
                                                  style: textTheme.bodyText2,
                                                ),
                                                const Gap(30),
                                                CustomElevatedButtonAsync(
                                                    color: AppColor.kGoldColor2,
                                                    onPressed: () async {
                                                      final PerksViewModel
                                                          _perkViewModel =
                                                          sl<PerksViewModel>();
                                                      await _perkViewModel
                                                          .claimPerk(
                                                              context, perk);
                                                    },
                                                    child: Text(
                                                      'YES, CLAIM THIS OFFER',
                                                      style:
                                                          textTheme.headline6,
                                                    )),
                                                const Gap(10),
                                                CustomElevatedButton(
                                                    color: AppColor.kWhiteColor,
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('CANCEL',
                                                        style: textTheme
                                                            .headline6)),
                                                const Gap(32),
                                              ],
                                            )),
                                        Positioned(
                                            top: 0,
                                            child: Container(
                                              height: 100,
                                              width: 100,
                                              padding: const EdgeInsets.all(10),
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                              ),
                                              child: CircleAvatar(
                                                  backgroundColor:
                                                      AppColor.kSecondaryColor,
                                                  child: SvgPicture.asset(
                                                    'assets/icons/profile/gift.svg',
                                                    width: 32,
                                                    height: 32,
                                                    color: Colors.white,
                                                  )),
                                            )),
                                      ]);
                                });
                          },
                    child: Text(
                      'CLAIM THIS OFFER',
                      style: textTheme.bodyLarge?.copyWith(color: Colors.white),
                    )),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'About this offer',
                    style: textTheme.bodyText2
                        ?.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  perk.description,
                  style: textTheme.bodyText2
                      ?.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
        ));
  }
}
