import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/app/wallet/wallet_screen_vm.dart';
import 'package:geniuspay/app/wallet/wallets_list_screen.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:shimmer/shimmer.dart';
import 'package:geniuspay/models/wallet.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BaseView<WalletScreenVM>(
        onModelReady: (p0) => p0.fetchWallets(context),
        builder: (context, model, snapshot) {
          return SafeArea(
              child: Scaffold(
                  backgroundColor: AppColor.kAccentColor2,
                  body: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Gap(24),
                            Row(
                              children: [
                                Text("Total Balance",
                                    style: textTheme.bodyMedium?.copyWith(
                                        color: AppColor.kSecondaryColor)),
                              ],
                            ),
                            const Gap(4),
                            Text(
                              model.user.userProfile.totalBalance
                                      ?.valueWithCurrency ??
                                  '',
                              style: textTheme.displayLarge?.copyWith(
                                color: AppColor.kSecondaryColor,
                                fontSize: 44,
                              ),
                            ),
                            const Gap(13),
                            Expanded(
                                child: model.baseModelState ==
                                        BaseModelState.success
                                    ? WalletsListScreen(
                                        wallets: model.wallets,
                                        model: model,
                                        onRefreshed: () {
                                          setState(() {
                                            model.fetchWallets(
                                              context,
                                            );
                                          });
                                        },
                                      )
                                    : model.baseModelState ==
                                            BaseModelState.loading
                                        ? Shimmer.fromColors(
                                            baseColor: Colors.grey[300]!,
                                            highlightColor: Colors.grey[100]!,
                                            enabled: true,
                                            child: WalletsListScreen(
                                              model: model,
                                              onRefreshed: () {
                                                setState(() {
                                                  model.fetchWallets(
                                                    context,
                                                  );
                                                });
                                              },
                                              wallets: const [
                                                Wallet(
                                                    user: 'user',
                                                    friendlyName: 'USD',
                                                    currency: 'USD',
                                                    isDefault: false),
                                                Wallet(
                                                    user: 'user',
                                                    friendlyName: 'EUR',
                                                    currency: 'EUR',
                                                    isDefault: false),
                                              ],
                                            ))
                                        : WalletErrorWidget(onPressed: () {
                                            setState(() {
                                              model.fetchWallets(
                                                context,
                                              );
                                            });
                                          }))
                          ]))));
        });
  }
}

class WalletErrorWidget extends StatefulWidget {
  final Function() onPressed;
  const WalletErrorWidget({Key? key, required this.onPressed})
      : super(key: key);

  @override
  State<WalletErrorWidget> createState() => _WalletErrorWidgetState();
}

class _WalletErrorWidgetState extends State<WalletErrorWidget> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
              style: textTheme.bodyLarge?.copyWith(color: Colors.white),
            ),
            onPressed: () {
              widget.onPressed();
            },
          ),
        )
      ]),
    );
  }
}
