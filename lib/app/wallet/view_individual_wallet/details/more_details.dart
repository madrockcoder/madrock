import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/payout/beneficiaries/widgets/text_field_decoration.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button_async.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/app/shared_widgets/tile_selector.dart';
import 'package:geniuspay/app/wallet/view_individual_wallet/details/individual_wallet_details_vm.dart';
import 'package:geniuspay/app/wallet/view_individual_wallet/transactions/transactions_all_page.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/util/color_scheme.dart';

class MoreDetails {
  closeWallet(BuildContext context, Wallet wallet) {
    final textTheme = Theme.of(context).textTheme;
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40))),
        context: context,
        builder: (context) {
          return Padding(
              padding: EdgeInsets.only(
                  top: 42,
                  left: 26,
                  right: 26,
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      height: 90,
                      width: 90,
                      padding: const EdgeInsets.all(10.5),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/circle.png'),
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundColor: AppColor.kSecondaryColor,
                        child: SvgPicture.asset(
                          'assets/images/heart_break.svg',
                          width: 28,
                          color: Colors.white,
                        ),
                      )),
                  const Gap(30),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: textTheme.headlineMedium?.copyWith(fontSize: 20),
                      children: <TextSpan>[
                        const TextSpan(
                          text: 'Are you sure you want to delete this',
                        ),
                        TextSpan(
                            text: ' ${wallet.currency} Wallet?',
                            style: textTheme.headlineMedium?.copyWith(
                                fontSize: 20, color: AppColor.kSecondaryColor)),
                      ],
                    ),
                  ),
                  const Gap(17),
                  Text(
                    'This action is irreversible. Deleting this Wallet means that you cannot receive funds in this wallet. You can deactivate instead.',
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium,
                  ),
                  const Gap(30),
                  CustomElevatedButtonAsync(
                      color: Colors.white,
                      borderColor: AppColor.kSecondaryColor,
                      // showLoaderScreen: true,
                      onPressed: () async {
                        await WalletDetailsVM().closeWallet(context, wallet);
                      },
                      child: Text(
                        'YES, DELETE THIS WALLET',
                        style: textTheme.titleLarge
                            ?.copyWith(color: AppColor.kSecondaryColor),
                      )),
                  const Gap(10),
                  CustomElevatedButton(
                      color: AppColor.kGoldColor2,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('CANCEL', style: textTheme.titleLarge)),
                  const Gap(32),
                ],
              ));
        });
  }

  showMoreWalletDetails(BuildContext context, Wallet wallet) {
    final textTheme = Theme.of(context).textTheme;
    final _walletNameController =
        TextEditingController(text: wallet.friendlyName);
    final _walletFocus = FocusNode();
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return ListView(
            shrinkWrap: true,
            padding:
                const EdgeInsets.only(top: 42, left: 26, right: 26, bottom: 42),
            children: [
              TileSelector(
                svgAsset: 'assets/images/rename.svg',
                title: 'Rename',
                onPressed: () {
                  Navigator.pop(context);
                  showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return Padding(
                            padding: EdgeInsets.only(
                                top: 26,
                                left: 26,
                                right: 26,
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Icon(Icons.close),
                                    ),
                                    const Spacer(),
                                    Text(
                                      'Rename',
                                      style: textTheme.headlineSmall,
                                    ),
                                    const Spacer(),
                                    const HelpIconButton()
                                  ],
                                ),
                                const Gap(20),
                                TextFormField(
                                  controller: _walletNameController,
                                  focusNode: _walletFocus,
                                  autofocus: true,
                                  maxLength: 15,
                                  style: textTheme.bodyMedium,
                                  validator: (val) {
                                    if (val != null && val.length < 5) {
                                      return 'Minimum 5 characters are needed';
                                    }
                                    return null;
                                  },
                                  decoration: TextFieldDecoration(
                                    controller: _walletNameController,
                                    focusNode: _walletFocus,
                                    hintText: 'Friendly name',
                                    onClearTap: () {},
                                  ).inputDecoration(),
                                ),
                                const Gap(50),
                                SizedBox(
                                    width: double.infinity,
                                    child: CustomElevatedButtonAsync(
                                      child: Text(
                                        'SAVE',
                                        style: textTheme.titleLarge,
                                      ),
                                      onPressed: () async {
                                        await WalletDetailsVM().renameWallet(
                                            context,
                                            wallet.walletID!,
                                            _walletNameController.text);
                                      },
                                      color: AppColor.kGoldColor2,
                                    )),
                                const Gap(32),
                              ],
                            ));
                      });
                },
              ),
              TileSelector(
                svgAsset: 'assets/images/view_transactions.svg',
                title: 'View transactions',
                onPressed: () {
                  AllWalletTransactions.show(context, wallet.walletID!);
                },
              ),
              // TileSelector(
              //   svgAsset: 'assets/images/deactivate.svg',
              //   title: wallet.status == WalletStatus.ACTIVE
              //       ? 'Deactivate'
              //       : 'Activate',
              //   onPressed: () {
              //     Navigator.pop(context);
              //     showModalBottomSheet(
              //         isScrollControlled: true,
              //         shape: const RoundedRectangleBorder(
              //             borderRadius: BorderRadius.only(
              //                 topLeft: Radius.circular(40),
              //                 topRight: Radius.circular(40))),
              //         context: context,
              //         builder: (context) {
              //           return Padding(
              //               padding: EdgeInsets.only(
              //                   top: 42,
              //                   left: 26,
              //                   right: 26,
              //                   bottom:
              //                       MediaQuery.of(context).viewInsets.bottom),
              //               child: Column(
              //                 mainAxisSize: MainAxisSize.min,
              //                 children: [
              //                   Container(
              //                       height: 90,
              //                       width: 90,
              //                       padding: const EdgeInsets.all(10.5),
              //                       decoration: const BoxDecoration(
              //                         image: DecorationImage(
              //                           image: AssetImage(
              //                               'assets/images/circle.png'),
              //                         ),
              //                       ),
              //                       child: CircleAvatar(
              //                         backgroundColor: AppColor.kSecondaryColor,
              //                         child: SvgPicture.asset(
              //                           'assets/images/deactivate.svg',
              //                           width: 28,
              //                           color: Colors.white,
              //                         ),
              //                       )),
              //                   const Gap(30),
              //                   RichText(
              //                     textAlign: TextAlign.center,
              //                     text: TextSpan(
              //                       style: textTheme.headline4
              //                           ?.copyWith(fontSize: 20),
              //                       children: <TextSpan>[
              //                         TextSpan(
              //                           text:
              //                               'Are you sure you want to ${wallet.status == WalletStatus.ACTIVE ? 'deactivate' : 'activate'} this',
              //                         ),
              //                         TextSpan(
              //                             text: ' ${wallet.currency} Wallet?',
              //                             style: textTheme.headline4?.copyWith(
              //                                 fontSize: 20,
              //                                 color: AppColor.kSecondaryColor)),
              //                       ],
              //                     ),
              //                   ),
              //                   const Gap(17),
              //                   if (wallet.status == WalletStatus.ACTIVE)
              //                     Text(
              //                       'You may want to temporarily deactivate an account if you want to prevent spending funds on this account when paying with geniuspay card. However, incoming payments into this account will still be processed as usual. You will be able to reactivate this account at any time.',
              //                       textAlign: TextAlign.center,
              //                       style: textTheme.bodyText2,
              //                     ),
              //                   const Gap(36),
              //                   CustomElevatedButtonAsync(
              //                       color: Colors.white,
              //                       borderColor: AppColor.kSecondaryColor,
              //                       onPressed: () async {
              //                         await WalletDetailsVM()
              //                             .changeWalletStatus(
              //                                 context,
              //                                 wallet,
              //                                 wallet.status ==
              //                                         WalletStatus.ACTIVE
              //                                     ? 'DEACTIVATE'
              //                                     : 'ACTIVATE');
              //                       },
              //                       child: Text(
              //                         'YES, ${wallet.status == WalletStatus.ACTIVE ? 'DEACTIVATE' : 'ACTIVATE'} THIS WALLET',
              //                         style: textTheme.headline6?.copyWith(
              //                             color: AppColor.kSecondaryColor),
              //                       )),
              //                   const Gap(10),
              //                   CustomElevatedButton(
              //                       color: AppColor.kGoldColor2,
              //                       onPressed: () {
              //                         Navigator.pop(context);
              //                       },
              //                       child: Text('CANCEL',
              //                           style: textTheme.headline6)),
              //                   const Gap(32),
              //                 ],
              //               ));
              //         });
              //   },
              // ),
              if(wallet.availableBalance!.value==0)
                TileSelector(
                svgAsset: 'assets/images/heart_break.svg',
                title: 'Close wallet',
                onPressed: () {
                  closeWallet(context, wallet);
                },
              ),
            ],
          );
        });
  }
}
