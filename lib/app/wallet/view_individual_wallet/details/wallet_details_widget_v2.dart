import 'package:flutter/material.dart';
import 'package:geniuspay/app/deposit_funds/pages/choose_payment_page.dart';
import 'package:geniuspay/app/shared_widgets/custom_circular_image.dart';
import 'package:geniuspay/app/shared_widgets/custom_divider.dart';
import 'package:geniuspay/app/shared_widgets/custom_gradient_border.dart';
import 'package:geniuspay/app/shared_widgets/custom_section_heading.dart';
import 'package:geniuspay/app/shared_widgets/custom_tab_indicator.dart';
import 'package:geniuspay/app/wallet/view_individual_wallet/details/more_details.dart';
import 'package:geniuspay/app/wallet/view_individual_wallet/details/widgets/account_details_list_tiles.dart';
import 'package:geniuspay/app/wallet/view_individual_wallet/details/widgets/add_copy_trailing_widget.dart';
import 'package:geniuspay/app/wallet/view_individual_wallet/details/widgets/bottomsheets/share_account_details_bottomsheet.dart';
import 'package:geniuspay/app/wallet/view_individual_wallet/details/widgets/currency_accept_banner.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/wallet/view_individual_wallet/statements/choose_statements.dart';
import 'package:geniuspay/app/wallet/view_individual_wallet/transactions/transactions_widget.dart';
import 'package:geniuspay/core/injections/injections.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/models/wallet_account_details.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/util/enums.dart';
import 'package:geniuspay/util/essentials.dart';
import 'package:tuple/tuple.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/converter.dart';

enum WalterDetailsMenuType { svg, png, icon }
enum SelectedWalletType { local, international }

class WalletDetailsWidgetV2 extends StatefulWidget {
  final Wallet wallet;
  final List<WalletAccountDetails> walletDetailsList;

  const WalletDetailsWidgetV2({
    Key? key,
    required this.wallet,
    required this.walletDetailsList,
  }) : super(key: key);

  @override
  State<WalletDetailsWidgetV2> createState() => _WalletDetailsWidgetV2State();
}

class _WalletDetailsWidgetV2State extends State<WalletDetailsWidgetV2>
    with TickerProviderStateMixin {
  List<Tuple3<dynamic, String, WalterDetailsMenuType>> walletDetailMenus = [
    const Tuple3("assets/icons/payin.svg", "Pay in", WalterDetailsMenuType.svg),
    const Tuple3("assets/icons/profile/refer/share.png", "Share",
        WalterDetailsMenuType.png),
    const Tuple3("assets/images/statements.svg", "Statements",
        WalterDetailsMenuType.svg),
    const Tuple3(Icons.more_horiz, "More", WalterDetailsMenuType.icon),
  ];
  bool showMoreDetails = false;

  int selectedAccountDetailsIndex = 0;

  final Converter _walletHelper = Converter();
  final AuthenticationService _authenticationService =
      sl<AuthenticationService>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        vsync: this,
        length: widget.walletDetailsList[0].funding_accounts.isEmpty
            ? 1
            : widget.walletDetailsList[0].funding_accounts.length);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    final walletDetailsList = widget.walletDetailsList;
    final wallet = widget.wallet;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
          child: Container(
            decoration: BoxDecoration(
              border: const CustomGradientBorder(
                  gradient: LinearGradient(colors: [
                AppColor.kSecondaryColor,
                AppColor.kAccentColor2
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 17, vertical: 30.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CustomCircularImage(
                            'icons/flags/png/${_walletHelper.getLocale(wallet.currency)}.png',
                            radius: 16,
                            package: 'country_icons',
                            fit: BoxFit.fill),
                        const Gap(8),
                        Text(
                          wallet.currency,
                          style: const TextStyle(
                              color: AppColor.kSecondaryColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                        ),
                        const Gap(8),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 8.0),
                            child: Text(
                              wallet.status == WalletStatus.ACTIVE
                                  ? "Activated"
                                  : "Deactivated",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 8,
                                  color: AppColor.kSecondaryColor),
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColor.kSecondaryColor.withOpacity(0.3)),
                        ),
                        const Spacer(),
                        if (wallet.isDefault)
                          SvgPicture.asset(
                            "assets/icons/bookmark.svg",
                            width: 13.5,
                            height: 18,
                          ),
                        const Gap(15),
                      ],
                    ),
                    const Gap(4),
                    Text(
                      _walletHelper.formatCurrency(wallet.availableBalance!) ??
                          '',
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 44,
                          color: AppColor.kSecondaryColor),
                    ),
                    const CustomDivider(
                      sizedBoxHeight: 16,
                      thickness: 0.2,
                      color: AppColor.kSecondaryColor,
                    ),
                    const Gap(4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children:
                          List.generate(walletDetailMenus.length, (index) {
                        var menu = walletDetailMenus[index];
                        return InkWell(
                          onTap: walletDetailsList[0]
                              .funding_accounts.isNotEmpty?() {
                            switch (index) {
                              case 0:
                                ChoosePaymentPage.show(context, wallet);
                                break;
                              case 1:
                                Essentials.showBottomSheet(
                                    ShareAccountDetailsBottomSheet(
                                        walletDetailsList: walletDetailsList[0],
                                        fundingAccount: walletDetailsList[0]
                                            .funding_accounts[0]),
                                    context);
                                break;
                              case 2:
                                ChooseStatements.show(context);
                                break;
                              case 3:
                                MoreDetails()
                                    .showMoreWalletDetails(context, wallet);
                                break;
                            }
                          }:null,
                          child: Column(
                            children: [
                              if (menu.item3 == WalterDetailsMenuType.svg)
                                SvgPicture.asset(
                                  menu.item1,
                                  color: AppColor.kSecondaryColor,
                                )
                              else if (menu.item3 == WalterDetailsMenuType.png)
                                Image.asset(
                                  menu.item1,
                                  width: 24,
                                  height: 20,
                                  color: walletDetailsList[0]
                                      .funding_accounts.isNotEmpty?AppColor.kSecondaryColor:AppColor.kSecondaryColor.withOpacity(0.3),
                                )
                              else if (menu.item3 == WalterDetailsMenuType.icon)
                                Icon(
                                  menu.item1,
                                  size: 24,
                                  color: AppColor.kSecondaryColor,
                                ),
                              const Gap(4),
                              Text(
                                menu.item2,
                                style: const TextStyle(
                                    color: AppColor.kSecondaryColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12),
                              )
                            ],
                          ),
                        );
                      }),
                    ),
                  ],
                )),
          ),
        ),
        const Gap(16),
        if (walletDetailsList[0].funding_accounts.isNotEmpty)
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 17),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 20,
                          height: 2,
                          color: AppColor.kSecondaryColor.withOpacity(0.1),
                        )
                      ],
                    ),
                    const Gap(16),
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          if (walletDetailsList[0].funding_accounts.length > 1) ...[
                            Container(
                                height: 38,
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(34),
                                    border: Border.all(
                                        color: AppColor.kSecondaryColor, width: 2)),
                                child: TabBar(
                                  labelColor: Colors.white,
                                  controller: _tabController,
                                  unselectedLabelColor: AppColor.kSecondaryColor,
                                  indicator: WalletTabIndicator(),
                                  tabs: [
                                    for (final fundingAccount
                                    in walletDetailsList[0].funding_accounts)
                                      Tab(
                                        text: fundingAccount.localOrInternational,
                                      ),
                                  ],
                                ))
                          ],
                          const Gap(16),
                          CustomSectionHeading(
                              heading: "Account Details",
                              child: Text(
                                "For ${walletDetailsList[0].funding_accounts[_tabController.index].localOrInternational} transfers only",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w300, fontSize: 14),
                              ),
                              topSpacing: 0,
                              headingTextStyle: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                              headingAndChildGap: 8),
                          const Gap(24),
                          AccountDetailsListTiles(
                            fundingAccount: walletDetailsList[0]
                                .funding_accounts[_tabController.index],
                            accountName:
                                "${_authenticationService.user?.firstName} ${_authenticationService.user?.lastName}",
                            reference: _authenticationService
                                    .user?.userProfile.customerNumber ??
                                '',
                          ),
                          const Gap(16),
                          InkWell(
                              onTap: () {
                                setState(() {
                                  showMoreDetails = !showMoreDetails;
                                });
                              },
                              child: Row(
                                children: [
                                  Text(
                                    !showMoreDetails
                                        ? "More details "
                                        : "Less details",
                                    style: const TextStyle(
                                        color: AppColor.kSecondaryColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                                  ),
                                  if (!showMoreDetails)
                                    const Text(
                                      "(If asked for)",
                                      style: TextStyle(
                                          color: AppColor.kOnPrimaryTextColor3,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 14),
                                    ),
                                  const Spacer(),
                                  RotatedBox(
                                      quarterTurns: showMoreDetails ? 2 : 0,
                                      child: SvgPicture.asset(
                                        "assets/icons/chevron-down.svg",
                                        width: 16,
                                        height: 16,
                                      )),
                                ],
                              )),
                          const CustomDivider(
                            sizedBoxHeight: 16,
                            thickness: 0.2,
                            color: AppColor.kSecondaryColor,
                          ),
                          if (showMoreDetails)
                            Column(
                              children: [
                                AddCopyTrailingWidget(
                                  title: "Bank Address",
                                  subtitle: walletDetailsList[0]
                                      .funding_accounts[_tabController.index]
                                      .bank_address
                                      .addressLine1,
                                  onTap: () {},
                                ),
                                const Gap(16),
                                AddCopyTrailingWidget(
                                    title: "Zip code",
                                    subtitle: walletDetailsList[0]
                                        .funding_accounts[_tabController.index]
                                        .bank_address
                                        .zipCode,
                                    onTap: () {}),
                                const Gap(16),
                                AddCopyTrailingWidget(
                                  title: "City",
                                  subtitle: walletDetailsList[0]
                                      .funding_accounts[_tabController.index]
                                      .bank_address
                                      .city,
                                  onTap: () {},
                                ),
                                const Gap(16),
                                AddCopyTrailingWidget(
                                  title: "Country",
                                  subtitle: walletDetailsList[0]
                                      .funding_accounts[_tabController.index]
                                      .bank_address
                                      .countryIso2,
                                  onTap: () {},
                                ),
                                const CustomDivider(
                                  sizedBoxHeight: 16,
                                  thickness: 0.2,
                                  color: AppColor.kSecondaryColor,
                                ),
                              ],
                            ),
                          const CurrencyAcceptBanner(),
                          const CustomDivider(
                            sizedBoxHeight: 16,
                            thickness: 0.2,
                            color: AppColor.kSecondaryColor,
                          ),
                          addLeadingWidget(
                            icon: "assets/icons/carbon_time.svg",
                            title: "When will the money arrive?",
                            description:
                                "Payment delivery time depends on the instructions from the sending bank. Generally this takes 1-3 business days.\n\nPlease consult with the sender.\n\nMoney received on the weekends or bank holidays will be processed on the next business day.",
                          ),
                          const CustomDivider(
                            sizedBoxHeight: 16,
                            thickness: 0.2,
                            color: AppColor.kSecondaryColor,
                          ),
                          addLeadingWidget(
                            icon: "assets/icons/pricetag-outline.svg",
                            title: "This is free",
                            description:
                                "geniuspay will not charge any fees but the sending bank may charge a fee for transfers.",
                          ),
                          const Gap(42)
                        ],
                      ),
                    )

                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * .4,
                    //   child: Center(
                    //     child: Column(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: const [
                    //         Text(
                    //           "No Account Details",
                    //           style: TextStyle(color: AppColor.kSecondaryColor),
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
          )
        else
          Expanded(
            child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.22),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    )
                  ],
                ),
                child: WalletTransactionsWidget(
                  wallet: wallet,
                )),
          ),
      ],
    );
  }

  Widget addLeadingWidget(
      {required String icon,
      required String title,
      required String description}) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          icon,
          width: 16,
          height: 16,
        ),
        const Gap(8),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: textTheme.bodyLarge,
            ),
            const Gap(8),
            Text(
              description,
              style: textTheme.bodyMedium
                  ?.copyWith(fontSize: 12, color: const Color(0xff5D5D5D)),
            )
          ],
        ))
      ],
    );
  }
}
