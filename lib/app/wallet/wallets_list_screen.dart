import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/wallet/connect_bank_account/link_a_bank_page.dart';
import 'package:geniuspay/app/wallet/open_account.dart';
import 'package:geniuspay/app/wallet/view_individual_wallet/bonus_wallet.dart';
import 'package:geniuspay/app/wallet/view_individual_wallet/individual_wallet.dart';
import 'package:geniuspay/app/wallet/wallet_screen_vm.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/converter.dart';

class WalletsListScreen extends StatefulWidget {
  final List<Wallet> wallets;
  final WalletScreenVM model;
  final bool loading;
  final Function() onRefreshed;
  const WalletsListScreen(
      {Key? key,
      required this.wallets,
      required this.model,
      this.loading = false,
      required this.onRefreshed})
      : super(key: key);

  @override
  State<WalletsListScreen> createState() => _WalletsListScreenState();
}

class _WalletsListScreenState extends State<WalletsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              "My Wallets ",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: AppColor.kOnPrimaryTextColor2),
            ),
            Text("(${widget.wallets.length})",
                style: const TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    color: AppColor.kOnPrimaryTextColor2)),
            const Spacer(),
            InkWell(
                borderRadius: BorderRadius.circular(9),
                onTap: () {
                  if (!widget.loading) {
                    OpenAccount.show(context: context);
                  }
                },
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(9),
                  dashPattern: const [4],
                  color: AppColor.kSecondaryColor,
                  strokeWidth: 2,
                  child: const Center(
                    child: Icon(
                      Icons.add,
                      color: AppColor.kSecondaryColor,
                    ),
                  ),
                )),
            const Gap(4),
            InkWell(
                borderRadius: BorderRadius.circular(9),
                onTap: () {
                  if (!widget.loading) {
                    LinkABankPage.show(context);
                  }
                },
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                      color: AppColor.kSecondaryColor,
                      borderRadius: BorderRadius.circular(9)),
                  child: Center(
                    child: SvgPicture.asset(
                        'assets/icons/building-bank-link.svg',
                        width: 18.69,
                        height: 20,
                        color: Colors.white),
                  ),
                ))
          ],
        ),
        const Gap(21),
        Expanded(
          child: RefreshIndicator(
              onRefresh: () async {
                widget.model.fetchWallets(context);
              },
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  customWalletListTile(
                      Wallet(
                          user: 'user',
                          friendlyName: 'Bonus Wallet',
                          currency: widget.model.user.userProfile.earnings
                                  ?.availableBalance.currency ??
                              '',
                          availableBalance: widget.model.user.userProfile
                              .earnings?.availableBalance,
                          isDefault: false),
                      true),
                  const Gap(8),
                  for (Wallet wallet in widget.wallets) ...[
                    customWalletListTile(wallet, false),
                    const Gap(8)
                  ]
                ],
              )),
        )
      ],
    );
  }

  final Converter _walletHelper = Converter();
  Widget customWalletListTile(Wallet wallet, bool isBonus) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: wallet.isDefault
              ? const [
                  BoxShadow(
                      color: AppColor.kSecondaryColor,
                      spreadRadius: 0.1,
                      offset: Offset(3, 3))
                ]
              : [
                  const BoxShadow(
                    blurRadius: 10,
                    color: Color.fromRGBO(7, 5, 26, 0.07),
                  ),
                ],
          border: isBonus ? Border.all(color: AppColor.korange) : null,
          borderRadius: BorderRadius.circular(8)),
      child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          margin: EdgeInsets.zero,
          child: InkWell(
              onTap: () {
                if (!widget.loading) {
                  if (!isBonus) {
                    IndividualWalletWidget.show(
                        context: context,
                        wallet: wallet,
                        disableExchange: false);
                  } else {
                    BonusWalletWidget.show(context: context);
                  }
                }
              },
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    if (!isBonus)
                      CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(
                              'icons/flags/png/${_walletHelper.getLocale(wallet.currency)}.png',
                              package: 'country_icons'))
                    else
                      const Icon(Icons.star, color: AppColor.korange, size: 40),
                    const Gap(16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          wallet.friendlyName,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 12),
                        ),
                        Text(wallet.currency,
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: AppColor.kSecondaryColor))
                      ],
                    ),
                    const Spacer(),
                    Text(
                      wallet.availableBalance?.valueWithCurrency ?? "\$0,00",
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: AppColor.kSecondaryColor),
                    )
                  ],
                ),
              ))),
    );
  }
}
