// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/card_create/pages/virtual_card_screens/create_card_pin.dart';
import 'package:geniuspay/app/shared_widgets/country_flag_container.dart';
import 'package:geniuspay/app/shared_widgets/error_screens/error_screen_selector.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/app/wallet/wallet_screen_vm.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/converter.dart';
import 'package:shimmer/shimmer.dart';

class LinkWallet extends StatefulWidget {
  const LinkWallet({Key? key}) : super(key: key);
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => LinkWallet()),
    );
  }

  @override
  State<LinkWallet> createState() => _LinkWalletState();
}

class _LinkWalletState extends State<LinkWallet> {
  final TextEditingController search = TextEditingController();

  final List<String> nameList = ['USD', 'CANADA', 'EUR', 'GBP'];

  final List<String> amountList = [
    '\$10,250.00',
    '\$5,000.43 ',
    '€50.00',
    '￡50.00'
  ];

  final List<String> subList = [
    'United States Dollar',
    'Canadian Dollar',
    'Euro',
    'British Pound'
  ];
  final Converter _walletHelper = Converter();
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: SvgPicture.asset(
            'assets/share_with_contact/arrowback.svg',
            fit: BoxFit.scaleDown,
            height: 15,
            width: 15,
            color: Colors.black,
          ),
        ),
        title: Center(
          child: Text(
            'Link a Wallet',
            style: textTheme.titleLarge
                ?.copyWith(color: AppColor.kOnPrimaryTextColor),
          ),
        ),
        actions: [
          HelpIconButton(
            onTap: () {},
          )
        ],
      ),
      body: Container(
        color: AppColor.kWhiteColor,
        padding: const EdgeInsets.only(
          left: 24,
          right: 24,
        ),
        child: Column(
          children: [
            Container(
              height: 42,
              margin: const EdgeInsets.only(top: 25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                border: Border.all(color: Color(0xff008AA7), width: 1.5),
              ),
              padding: const EdgeInsets.only(left: 18, right: 0),
              child: TextField(
                controller: search,
                decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  icon: SvgPicture.asset(
                    'assets/faq/search.svg',
                    width: 14.0,
                    height: 14.0,
                  ),
                  suffixIcon: IconButton(
                      splashRadius: 10,
                      icon: const Icon(
                        Icons.cancel,
                        size: 18,
                        color: Color(0xff008AA7),
                      ),
                      onPressed: () {
                        search.clear();
                        setState(() {});
                      }),
                  hintText: 'Search',
                  hintStyle: textTheme.bodyLarge
                      ?.copyWith(color: AppColor.kTextFieldTextColor),
                ),
                // style: style,
                onChanged: (value) {},
              ),
            ),
            const Gap(24),
            BaseView<WalletScreenVM>(
              onModelReady: (p0) => p0.fetchWallets(context),
              builder: (context, model, snapshot) {
                if (model.baseModelState == BaseModelState.success) {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: model.wallets.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            CreateCardPin.show(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Row(
                              children: [
                                CountryFlagContainer(
                                  flag: _walletHelper
                                      .getLocale(model.wallets[index].currency),
                                  size: 40,
                                ),
                                const Gap(12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(model.wallets[index].friendlyName,
                                        style: textTheme.bodyLarge),
                                    Text(model.wallets[index].currency,
                                        style: textTheme.bodyMedium
                                            ?.copyWith(color: AppColor.kblue))
                                  ],
                                ),
                                const Spacer(flex: 2),
                                Text(
                                    model.wallets[index].availableBalance
                                            ?.valueWithCurrency ??
                                        '',
                                    style: textTheme.bodyLarge
                                        ?.copyWith(color: AppColor.kblue))
                              ],
                            ),
                          ),
                        );
                      });
                } else if (model.baseModelState == BaseModelState.loading) {
                  return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: ListView.builder(
                          itemCount: 3,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Row(
                                children: [
                                  CountryFlagContainer(
                                    flag: 'us',
                                    size: 40,
                                  ),
                                  const Gap(12),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('wallet name'),
                                      Text('USD',
                                          style: textTheme.bodyMedium
                                              ?.copyWith(color: AppColor.kblue))
                                    ],
                                  ),
                                  const Spacer(flex: 2),
                                  Text('\$0.00',
                                      style: textTheme.bodyLarge
                                          ?.copyWith(color: AppColor.kblue))
                                ],
                              ),
                            );
                          }));
                } else {
                  return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: ErrorScreen(
                          showHelp: false,
                          onRefresh: () {
                            setState(() {
                              model.fetchWallets(context);
                            });
                          },
                          exception: model.errorType));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
