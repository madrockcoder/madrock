import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/currency_exchange/widgets/exchange_flag_button.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/app/shared_widgets/profile_card_background.dart';
import 'package:geniuspay/app/wallet/wallet_screen_vm.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:shimmer/shimmer.dart';

class WalletSelectorList extends StatefulWidget {
  final bool disable;
  const WalletSelectorList({Key? key, required this.disable}) : super(key: key);

  @override
  State<WalletSelectorList> createState() => _WalletSelectorListState();
}

class _WalletSelectorListState extends State<WalletSelectorList> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * .9,
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Gap(24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.close,
                  size: 22,
                  color: AppColor.kSecondaryColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Text(
                'Select Wallet',
                style: textTheme.bodyLarge,
              ),
              const Gap(42)
            ],
          ),
          const Gap(12),
          Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * .6,
              ),
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ElevatedCardBackground(
                      padding: const EdgeInsets.all(8),
                      child: BaseView<WalletScreenVM>(
                        onModelReady: (p0) async {
                          if (p0.wallets.isEmpty) {
                            await p0.fetchWallets(context);
                            if(p0.wallets.isEmpty){
                              Navigator.pop(context);
                              Future.delayed(const Duration(milliseconds: 200));
                              PopupDialogs(context).errorMessage('No wallets found');
                            }
                          } else {
                            p0.changeState(BaseModelState.success);
                          }
                        },
                        builder: (context, model, snapshot) {
                          if (model.baseModelState == BaseModelState.success) {
                            final wallets = model.wallets;
                            return ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: model.wallets.length,
                                separatorBuilder: (context, index) {
                                  return const Gap(12);
                                },
                                itemBuilder: (context, index) {
                                  return Opacity(
                                      opacity: wallets[index]
                                                      .availableBalance
                                                      ?.value ==
                                                  0 &&
                                              widget.disable
                                          ? 0.3
                                          : 1,
                                      child: CurrencySelectorTile(
                                        title: wallets[index].friendlyName,
                                        currency: wallets[index].currency,
                                        subtitle: wallets[index].currency,
                                        trailing: wallets[index]
                                            .availableBalance
                                            ?.valueWithCurrency,
                                        onTap: wallets[index]
                                                        .availableBalance
                                                        ?.value ==
                                                    0 &&
                                                widget.disable
                                            ? () {}
                                            : () {
                                                Navigator.pop(
                                                    context, wallets[index]);
                                              },
                                      ));
                                });
                          } else if (model.baseModelState ==
                              BaseModelState.loading) {
                            return ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 5,
                                separatorBuilder: (context, index) {
                                  return const Gap(4);
                                },
                                itemBuilder: (context, index) {
                                  return Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: CurrencySelectorTile(
                                          title: 'My Wallet',
                                          currency: 'USD',
                                          loading: true,
                                          onTap: () {}));
                                });
                          } else {
                            return Center(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/splash/error_rocket_destroy.svg',
                                      height: 200,
                                    ),
                                    const Gap(24),
                                    const Text('Unable to fetch wallets'),
                                    const Gap(24),
                                    IntrinsicWidth(
                                      child: CustomElevatedButton(
                                        child: Text(
                                          'TRY AGAIN',
                                          style: textTheme.bodyLarge
                                              ?.copyWith(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            model.fetchWallets(context);
                                          });
                                        },
                                      ),
                                    )
                                  ]),
                            );
                          }
                        },
                      )))),
          const Gap(24),
        ]));
  }
}
