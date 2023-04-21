// import 'package:flutter/material.dart';
// import 'package:geniuspay/app/currency_exchange/pages/main_currency_exchange.dart';
// import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
// import 'package:geniuspay/models/wallet.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:gap/gap.dart';
// import 'package:geniuspay/app/shared_widgets/custom_elevated_button_icon.dart';
// import 'package:geniuspay/app/shared_widgets/custom_tab_indicator.dart';
// import 'package:geniuspay/app/wallet/view_individual_wallet/details/more_details.dart';
// import 'package:geniuspay/app/wallet/view_individual_wallet/statements/choose_statements.dart';
// import 'package:geniuspay/models/wallet_account_details.dart';

// import 'package:geniuspay/util/color_scheme.dart';
// import 'package:geniuspay/util/converter.dart';
// import 'package:flutter/services.dart';
// import 'package:share_plus/share_plus.dart';

// class WalletDetailsWidget extends StatefulWidget {
//   final Wallet wallet;
//   final List<WalletAccountDetails> walletDetailsList;
//   const WalletDetailsWidget({
//     Key? key,
//     required this.wallet,
//     required this.walletDetailsList,
//   }) : super(key: key);

//   @override
//   State<WalletDetailsWidget> createState() => _WalletDetailsWidgetState();
// }

// class _WalletDetailsWidgetState extends State<WalletDetailsWidget>
//     with SingleTickerProviderStateMixin {
//   final Converter _walletHelper = Converter();
//   late TabController _tabController;
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(
//         vsync: this,
//         length: widget.walletDetailsList[0].funding_accounts.isEmpty
//             ? 1
//             : widget.walletDetailsList[0].funding_accounts.length);
//     _tabController.addListener(() {
//       setState(() {});
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final walletDetailsList = widget.walletDetailsList;
//     final wallet = widget.wallet;
//     final textTheme = Theme.of(context).textTheme;
//     return SingleChildScrollView(
//         child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     gradient: const LinearGradient(colors: [
//                       AppColor.kSecondaryColor,
//                       AppColor.kAccentColor2,
//                     ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
//                     borderRadius: BorderRadius.circular(9),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(2),
//                     child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 30, vertical: 15),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               wallet.friendlyName,
//                               style: textTheme.bodyText2?.copyWith(
//                                   color: AppColor.kSecondaryColor,
//                                   fontSize: 12),
//                             ),
//                             const Gap(4),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Expanded(
//                                   child: FittedBox(
//                                     fit: BoxFit.scaleDown,
//                                     alignment: Alignment.centerLeft,
//                                     child: Text(
//                                       _walletHelper.formatCurrency(
//                                               wallet.availableBalance!) ??
//                                           '',
//                                       style: textTheme.headline1?.copyWith(
//                                         color: AppColor.kSecondaryColor,
//                                         fontSize: 44,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 const Gap(48),
//                                 CircleAvatar(
//                                     radius: 30,
//                                     backgroundImage: AssetImage(
//                                         'icons/flags/png/${_walletHelper.getLocale(wallet.currency)}.png',
//                                         package: 'country_icons')),
//                               ],
//                             ),
//                             const Gap(4),
//                             InkWell(
//                               child: Container(
//                                 padding: const EdgeInsets.symmetric(
//                                   vertical: 5,
//                                   horizontal: 8,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   color:
//                                       AppColor.kSecondaryColor.withOpacity(0.3),
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 child: Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Text(
//                                       wallet.availableBalance!.currency,
//                                       style: textTheme.bodyText2?.copyWith(
//                                           color: AppColor.kSecondaryColor,
//                                           fontSize: 10),
//                                     ),
//                                     const Icon(
//                                       Icons.keyboard_arrow_down,
//                                       color: AppColor.kSecondaryColor,
//                                       size: 12,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         )),
//                   ),
//                 ),
//                 const Gap(20),
//                 Row(children: [
//                   Expanded(
//                       child: CustomElevatedButtonIcon(
//                           icon: SvgPicture.asset('assets/images/exchange.svg'),
//                           label: const Text(
//                             'Exchange',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           onPressed: () {
//                             MainCurrencyExchangePage.show(
//                                 context: context, selectedWallet: wallet);
//                           })),
//                   const Gap(5),
//                   CustomElevatedButtonIcon(
//                       icon: SvgPicture.asset(
//                         'assets/images/statements.svg',
//                         color: Colors.white,
//                       ),
//                       label: const Text(
//                         'Statements',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       onPressed: () => ChooseStatements.show(context)),
//                   const Gap(5),
//                   Container(
//                       decoration: BoxDecoration(
//                           color: AppColor.kSecondaryColor,
//                           borderRadius: BorderRadius.circular(9)),
//                       child: IconButton(
//                         icon: const Icon(
//                           Icons.more_vert,
//                           color: Colors.white,
//                         ),
//                         onPressed: () {
//                           MoreDetails().showMoreWalletDetails(context, wallet);
//                         },
//                       ))
//                 ]),
//                 const Gap(20),
//                 if (widget
//                     .walletDetailsList[0].funding_accounts.isNotEmpty) ...[
//                   Container(
//                       height: 40,
//                       padding: const EdgeInsets.all(2),
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(34),
//                           border: Border.all(
//                               color: AppColor.kSecondaryColor, width: 3)),
//                       child: TabBar(
//                         labelColor: Colors.white,
//                         controller: _tabController,
//                         unselectedLabelColor: AppColor.kSecondaryColor,
//                         indicator: WalletTabIndicator(),
//                         tabs: [
//                           for (final fundingAccount
//                               in walletDetailsList[0].funding_accounts)
//                             Tab(
//                               text: fundingAccount.localOrInternational,
//                             ),
//                         ],
//                       )),
//                   WalletDetailList(
//                     accountHolderName:
//                         walletDetailsList[0].account_holder_name ?? '',
//                     fundingAccount: walletDetailsList[0]
//                         .funding_accounts[_tabController.index],
//                     currency: widget.wallet.currency,
//                   )
//                 ] else
//                   Column(
//                     children: const [
//                       Gap(
//                         24,
//                       ),
//                       Text('Bank account details currently unavailable')
//                     ],
//                   ),
//               ],
//             )));
//   }
// }

// class WalletDetailList extends StatelessWidget {
//   final FundingAccounts fundingAccount;
//   final String accountHolderName;
//   final String currency;
//   const WalletDetailList(
//       {Key? key,
//       required this.fundingAccount,
//       required this.accountHolderName,
//       required this.currency})
//       : super(key: key);
//   Widget _detailListTile(String title, String subtitle, TextTheme textTheme,
//       BuildContext context) {
//     return ListTile(
//       title: Text(
//         title,
//         style: textTheme.headline5
//             ?.copyWith(color: AppColor.kSecondaryColor, fontSize: 14),
//       ),
//       subtitle: Text(subtitle,
//           style: textTheme.bodyText2?.copyWith(color: AppColor.kGreyColor)),
//       trailing: IconButton(
//         icon: const Icon(
//           Icons.copy,
//           color: AppColor.kGreyColor,
//         ),
//         onPressed: () {
//           Clipboard.setData(ClipboardData(text: "$title: $subtitle"));
//           PopupDialogs(context).informationMessage('Copied to clipboard');
//         },
//       ),
//     );
//   }

//   Widget _infoListTile(String svgAsset, String title, TextTheme textTheme) {
//     return ListTile(
//       leading: CircleAvatar(
//         radius: 40,
//         backgroundColor: AppColor.kAccentColor2,
//         child: SvgPicture.asset(svgAsset),
//       ),
//       minVerticalPadding: 24,
//       title: Text(
//         title,
//         style: textTheme.bodyText2,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme;
//     return ListView(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       children: [
//         const Gap(15),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Text('For $currency transfers only'),
//             TextButton(
//                 onPressed: () {
//                   String text =
//                       "Hi There!\n\nHere are my geniuspay bank account details:\n\n";
//                   text += "Account Name: $accountHolderName\n";
//                   if (fundingAccount.account_number.isNotEmpty) {
//                     text +=
//                         "${fundingAccount.account_number_type}: ${fundingAccount.account_number}\n";
//                   }
//                   if (fundingAccount.identifier_value.isNotEmpty) {
//                     text +=
//                         "${fundingAccount.identifier_type.replaceAll('_', ' ')}:${fundingAccount.identifier_value}\n";
//                   }
//                   text +=
//                       "Bank / Payment institution: ${fundingAccount.bank_name}\n";
//                   text +=
//                       "Bank address: ${fundingAccount.bank_address.addressLine1}, ${fundingAccount.bank_address.addressLine2}, ${fundingAccount.bank_address.city}, ${fundingAccount.bank_address.state}";
//                   Share.share(text,
//                       subject:
//                           "Here are my bank details for my geniuspay accoubt");
//                 },
//                 child: Text(
//                   'Share',
//                   style: textTheme.subtitle1
//                       ?.copyWith(color: AppColor.kSecondaryColor),
//                 )),
//           ],
//         ),
//         Card(
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//             elevation: 5,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
//               child: Column(children: [
//                 if (accountHolderName.isNotEmpty)
//                   _detailListTile(
//                       'Account name', accountHolderName, textTheme, context),
//                 if (fundingAccount.account_number.isNotEmpty)
//                   _detailListTile(fundingAccount.account_number_type,
//                       fundingAccount.account_number, textTheme, context),
//                 if (fundingAccount.identifier_value.isNotEmpty)
//                   _detailListTile(
//                       fundingAccount.identifier_type.replaceAll('_', ' '),
//                       fundingAccount.identifier_value,
//                       textTheme,
//                       context),
//                 _detailListTile('Bank name', fundingAccount.bank_name ?? '',
//                     textTheme, context),
//                 _detailListTile(
//                     'Bank address',
//                     "${fundingAccount.bank_address.addressLine1}, ${fundingAccount.bank_address.addressLine2}, ${fundingAccount.bank_address.city}, ${fundingAccount.bank_address.state}",
//                     textTheme,
//                     context),
//               ]),
//             )),
//         const Gap(20),
//         Card(
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//             elevation: 5,
//             child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
//                 child: Column(children: [
//                   _infoListTile(
//                       'assets/images/coins.svg',
//                       'Your bank may charge you for International payments',
//                       textTheme),
//                   _infoListTile(
//                       'assets/images/bx_time-five.svg',
//                       'Transfers may take 1 - 3 business days to appear on your geniuspay account',
//                       textTheme)
//                 ])))
//       ],
//     );
//   }
// }
