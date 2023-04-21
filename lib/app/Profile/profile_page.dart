import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/Profile/business_profile/screens/business_profile.dart';
import 'package:geniuspay/app/Profile/business_profile/screens/no_business_account.dart';
import 'package:geniuspay/app/Profile/business_profile/screens/verify_documents.dart';
import 'package:geniuspay/app/Profile/general/pages/notification_settings.dart';
import 'package:geniuspay/app/Profile/limits/pages/limit_screen.dart';
import 'package:geniuspay/app/Profile/profile/personal_profile_page.dart';
import 'package:geniuspay/app/Profile/profile_page_vm.dart';
import 'package:geniuspay/app/Profile/refer/refer_a_friend_homescreen.dart';
import 'package:geniuspay/app/Profile/security/pages/security_settings.dart';
import 'package:geniuspay/app/Profile/widgets/profile_header_widget.dart';
import 'package:geniuspay/app/auth/pages/sign_up/help/help_screen.dart';
import 'package:geniuspay/app/auth/pages/sign_up/widgets/terms_and_policies_page.dart';
import 'package:geniuspay/app/payout/beneficiaries/screens/beneficiary_home_screen.dart';
import 'package:geniuspay/app/perks/pages/perk_page.dart';
import 'package:geniuspay/app/plans/screens/choose_plan_personal_user.dart';
import 'package:geniuspay/app/shared_widgets/custom_loader.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/app/shared_widgets/profile_card_background.dart';
import 'package:geniuspay/app/supplementary_screens/about.dart';
import 'package:geniuspay/app/supplementary_screens/data_privacy.dart';
import 'package:geniuspay/app/supplementary_screens/imprint.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/enum_converter.dart';
import 'package:geniuspay/util/enums.dart';
import 'package:geniuspay/util/essentials.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with EnumConverter {
  final AuthenticationService _auth = sl<AuthenticationService>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(23.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProfileHeaderWidget(),
                const Gap(30),
                if (!shouldTemporaryHideForEarlyLaunch) ...[
                  InkWell(
                      onTap: () {
                        ChooseSubscriptionPlanPage.show(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 15,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          color: AppColor.kSecondaryColor,
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/icons/magic-star.svg'),
                            const Gap(13),
                            Text(
                              getPlanName(
                                  _auth.user!.userProfile.subscriptionPlan),
                              style: textTheme.bodyText2?.copyWith(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                            const Spacer(),
                            Text(
                              'Upgrade account',
                              style: textTheme.bodyText2?.copyWith(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      )),
                  const Gap(10),
                ],
                InkWell(
                    onTap: () {
                      ReferAFriendHomeScreen.show(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 15,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: AppColor.kAccentColor2,
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/icons/people_add.svg'),
                          const Gap(13),
                          Text(
                            'Refer a friend',
                            style: textTheme.bodyText2?.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    )),
                // if (_auth.user!.userProfile.optForBeta != true) ...[
                //   const Gap(10),
                //   InkWell(
                //       onTap: () {
                //         showModalBottomSheet(
                //             isScrollControlled: true,
                //             backgroundColor: Colors.transparent,
                //             context: context,
                //             builder: (context) {
                //               return Stack(
                //                   alignment: AlignmentDirectional.bottomCenter,
                //                   children: [
                //                     Container(
                //                         margin: const EdgeInsets.only(top: 50),
                //                         decoration: const BoxDecoration(
                //                             color: Colors.white,
                //                             borderRadius: BorderRadius.only(
                //                                 topLeft: Radius.circular(40),
                //                                 topRight: Radius.circular(40))),
                //                         padding: EdgeInsets.only(
                //                             top: 26,
                //                             left: 26,
                //                             right: 26,
                //                             bottom: MediaQuery.of(context)
                //                                 .viewInsets
                //                                 .bottom),
                //                         child: Column(
                //                           mainAxisSize: MainAxisSize.min,
                //                           children: [
                //                             const Gap(30),
                //                             Text(
                //                               'Are you ready to be\na Bug hunter?',
                //                               textAlign: TextAlign.center,
                //                               style: textTheme.headline4
                //                                   ?.copyWith(fontSize: 20),
                //                             ),
                //                             const Gap(17),
                //                             Text(
                //                               'Joining our beta testing program means that you will have access to additional features to help us test',
                //                               textAlign: TextAlign.center,
                //                               style: textTheme.bodyText2,
                //                             ),
                //                             const Gap(30),
                //                             CustomElevatedButtonAsync(
                //                                 color: AppColor.kGoldColor2,
                //                                 onPressed: () async {
                //                                   final result = await _auth
                //                                       .joinBeta(_auth.user!.id);
                //                                   result.fold((l) {
                //                                     PopupDialogs(context)
                //                                         .errorMessage(
                //                                             'Unable to join beta at the moment. Please try agian later');
                //                                   }, (r) {
                //                                     HomeWidget.show(context,
                //                                         resetUser: true,
                //                                         showSuccessDialog:
                //                                             'Welcome to the beta program!');
                //                                   });
                //                                 },
                //                                 child: Text(
                //                                   "YES I'M IN",
                //                                   style: textTheme.headline6,
                //                                 )),
                //                             const Gap(10),
                //                             CustomElevatedButton(
                //                                 color: AppColor.kWhiteColor,
                //                                 onPressed: () {
                //                                   Navigator.pop(context);
                //                                 },
                //                                 child: Text('CANCEL',
                //                                     style:
                //                                         textTheme.headline6)),
                //                             const Gap(32),
                //                           ],
                //                         )),
                //                     Positioned(
                //                         top: 0,
                //                         child: Container(
                //                           height: 100,
                //                           width: 100,
                //                           padding: const EdgeInsets.all(10),
                //                           decoration: const BoxDecoration(
                //                             shape: BoxShape.circle,
                //                             color: Colors.white,
                //                           ),
                //                           child: const CircleAvatar(
                //                             backgroundColor:
                //                                 AppColor.kGoldColor2,
                //                             child: Icon(
                //                               Ionicons.hammer_outline,
                //                               size: 32,
                //                               color: Colors.black,
                //                             ),
                //                           ),
                //                         )),
                //                   ]);
                //             });
                //       },
                //       child: Container(
                //         padding: const EdgeInsets.symmetric(
                //           horizontal: 22,
                //           vertical: 15,
                //         ),
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(9),
                //           color: AppColor.kAccentColor2.withOpacity(.5),
                //         ),
                //         child: Row(
                //           children: [
                //             const Icon(
                //               Ionicons.hammer_outline,
                //               size: 16,
                //             ),
                //             const Gap(13),
                //             Text(
                //               'Join Beta',
                //               style: textTheme.bodyText2?.copyWith(
                //                   fontSize: 16, fontWeight: FontWeight.w300),
                //             ),
                //           ],
                //         ),
                //       ))
                // ],
                const Gap(20),
                Text(
                  'Profile',
                  style: textTheme.bodyText2?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Gap(20),
                ElevatedCardBackground(
                  child: Column(
                    children: [
                      ProfileWidget(
                        icon: 'assets/icons/person.svg',
                        name: 'My profile',
                        onTap: () =>
                            PersonalProfilePage.show(context, _auth.user!),
                      ),
                      ProfileWidget(
                        icon: 'assets/images/business_profile.svg',
                        name: 'Business account',
                        onTap: () async {
                          CustomLoaderScreen.show(context);
                          await _auth.getUser();
                          Navigator.pop(context);
                          if (_auth.user!.userProfile.businessProfile == null) {
                            NoBusinessAccount.show(context);
                          } else {
                            if (_auth.user!.userProfile.businessProfile!
                                    .verificationStatus ==
                                'VERIFIED') {
                              BusinessProfile.show(
                                context,
                                _auth.user!.userProfile.businessProfile!,
                                _auth.user!.userProfile.customerNumber!,
                              );
                            } else {
                              VerifyDocuments.show(
                                context,
                                _auth.user!.userProfile.customerNumber!,
                              );
                            }
                          }
                        },
                      ),
                      // ProfileWidget(
                      //   icon: 'assets/images/merchant_profile.svg',
                      //   name: 'Merchant Profile',
                      // ),
                      // ProfileWidget(
                      //   icon: 'assets/images/statements_profile.svg',
                      //   name: 'Statements',
                      //   onTap: () => PopupDialogs(context).comingSoonSnack(),
                      // ),
                      // ProfileWidget(
                      //   icon: 'assets/images/subscription_profile.svg',
                      //   name: 'Subscription',
                      //   onTap: () => PopupDialogs(context).comingSoonSnack(),
                      // ),
                      ProfileWidget(
                        onTap: () => LimitsScreen.show(context),
                        icon: 'assets/icons/home/more/speed.svg',
                        name: 'Limits',
                      ),
                      ProfileWidget(
                        onTap: () async {
                          BeneficiaryHomeScreen.show(context);
                        },
                        icon: 'assets/icons/home/more/beneficiaries.svg',
                        name: 'Beneficiaries',
                      ),
                      if (!shouldTemporaryHideForEarlyLaunch)
                        ProfileWidget(
                          onTap: () => PopupDialogs(context).comingSoonSnack(),
                          icon: 'assets/icons/home/more/credit-card.svg',
                          name: 'Linked Cards',
                        ),
                      ProfileWidget(
                        onTap: () => PerkPage.show(context),
                        icon: 'assets/icons/home/more/perks.svg',
                        name: 'Perks',
                      ),
                    ],
                  ),
                ),
                const Gap(20),
                Text(
                  'Settings',
                  style: textTheme.bodyText2?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Gap(20),
                ElevatedCardBackground(
                  child: Column(
                    children: [
                      ProfileWidget(
                        icon: 'assets/images/security_profile.svg',
                        name: 'Security Settings',
                        onTap: () {
                          SecuritySettingsPage.show(context);
                        },
                      ),
                      ProfileWidget(
                        icon: 'assets/images/privacy_profile.svg',
                        name: 'Data & Privacy',
                        onTap: () {
                          DataPrivacy.show(context);
                        },
                      ),
                      ProfileWidget(
                        icon: 'assets/images/notification_profile.svg',
                        name: 'Notification Settings',
                        onTap: () {
                          NotificationsSettingsPage.show(context);
                        },
                      ),
                      if (!shouldTemporaryHideForEarlyLaunch)
                        ProfileWidget(
                          icon: 'assets/images/app_appearance.svg',
                          name: 'App Appearance',
                          onTap: () => PopupDialogs(context).comingSoonSnack(),
                        ),
                    ],
                  ),
                ),
                const Gap(20),
                Text(
                  'About',
                  style: textTheme.bodyText2?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Gap(20),
                ElevatedCardBackground(
                  child: Column(
                    children: [
                      ProfileWidget(
                        icon: 'assets/images/rate_profile.svg',
                        name: 'About',
                        onTap: () => About.show(context),
                      ),
                      ProfileWidget(
                        onTap: () => TermsAndPoliciesPage.show(context,
                            policy: Policy.privacyPolicy),
                        icon: 'assets/images/statements_profile.svg',
                        name: 'Privacy Policy',
                      ),
                      ProfileWidget(
                        onTap: () => TermsAndPoliciesPage.show(context,
                            policy: Policy.termsAndConditions),
                        icon: 'assets/images/terms_profile.svg',
                        name: 'Terms & Conditions',
                      ),
                      ProfileWidget(
                        onTap: () => Imprint.show(context),
                        icon: 'assets/images/statements_profile.svg',
                        name: 'Imprint',
                      ),
                    ],
                  ),
                ),
                const Gap(20),
                ElevatedCardBackground(
                  child: Column(
                    children: [
                      ProfileWidget(
                        icon: 'assets/images/logout_profile.svg',
                        name: 'Log Out',
                        onTap: () async {
                          ProfilePageVM().logout(context);
                        },
                      ),
                      ProfileWidget(
                        icon: 'assets/images/help_profile.svg',
                        name: 'Help',
                        onTap: () => HelpScreen.show(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    Key? key,
    required this.icon,
    required this.name,
    this.onTap,
  }) : super(key: key);

  final String icon;
  final String name;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            SizedBox(
              height: 17,
              width: 18,
              child: SvgPicture.asset(
                icon,
                color: AppColor.kSecondaryColor,
              ),
            ),
            const Gap(30),
            Text(
              name,
              style: textTheme.bodyText2?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
