import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/currency_exchange/pages/main_currency_exchange.dart';
import 'package:geniuspay/app/deposit_funds/pages/choose_payment_page.dart';
import 'package:geniuspay/app/payout/payout_selector.dart';
import 'package:geniuspay/app/shared_widgets/curved_background.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button_async.dart';
import 'package:geniuspay/app/shared_widgets/menu_item.dart' as menu_item;
import 'package:geniuspay/app/shared_widgets/show_draggable_scrollable_sheet.dart';
import 'package:geniuspay/app/shared_widgets/tile_selector.dart';
import 'package:geniuspay/app/wallet/create_individual_wallet/create_wallet.dart';
import 'package:geniuspay/app/wallet/view_individual_wallet/details/individual_wallet_details.dart';
import 'package:geniuspay/app/wallet/view_individual_wallet/details/more_details.dart';
import 'package:geniuspay/app/wallet/view_individual_wallet/transactions/transactions_widget.dart';
import 'package:geniuspay/app/wallet/wallet_screen_main.dart';
import 'package:geniuspay/app/wallet/wallet_screen_vm.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/converter.dart';
import 'package:geniuspay/util/enums.dart';
import 'package:shimmer/shimmer.dart';

class IndividualWalletWidget extends StatefulWidget {
  final Wallet? wallet;
  final bool disableExchange;
  final String? walletId;
  const IndividualWalletWidget(
      {Key? key, this.wallet, required this.disableExchange, this.walletId})
      : super(key: key);
  static Future<void> show(
      {required BuildContext context,
      required Wallet wallet,
      required bool disableExchange}) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => IndividualWalletWidget(
            wallet: wallet, disableExchange: disableExchange),
      ),
    );
  }

  @override
  State<IndividualWalletWidget> createState() => _IndividualWalletWidgetState();
}

class _IndividualWalletWidgetState extends State<IndividualWalletWidget> {
  Wallet? wallet;

  Future<void> initialize(WalletScreenVM p0) async {
    if (widget.walletId != null) {
      await p0.fetchIndividualWallet(context, widget.walletId!);
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        if (p0.wallet != null) {
          p0.individualBaseModelState = BaseModelState.success;
          wallet = p0.wallet;
        }
        setState(() {});
      });
    } else {
      p0.individualBaseModelState = BaseModelState.success;
      wallet = widget.wallet;
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BaseView<WalletScreenVM>(onModelReady: (p0) async {
      await initialize(p0);
    }, builder: (context, model, snapshot) {
      return Scaffold(
          backgroundColor: AppColor.kAccentColor2,
          appBar: AppBar(
            backgroundColor: AppColor.kAccentColor2,
            title: Text('${widget.wallet?.currency} Wallet'),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () async {
                  showCustomScrollableSheet(
                      context: context,
                      borderRadius: 40,
                      child: MoreOptions(
                        wallet: widget.wallet!,
                      ));
                },
                icon: const Icon(Icons.more_horiz),
                splashRadius: 20,
              )
            ],
          ),
          body: model.individualBaseModelState == BaseModelState.loading
              ? const LoadingListPage()
              : model.baseModelState == BaseModelState.error
                  ? WalletErrorWidget(onPressed: () async {
                      await initialize(model);
                    })
                  : RefreshIndicator(
                      onRefresh: () async {
                        await model.fetchIndividualWallet(
                            context, wallet!.walletID!);
                        WidgetsBinding.instance
                            ?.addPostFrameCallback((timeStamp) {
                          if (model.wallet != null) {
                            model.individualBaseModelState =
                                BaseModelState.success;
                            wallet = model.wallet;
                          }
                          setState(() {});
                        });
                      },
                      child: ListView(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height -
                                (kToolbarHeight +
                                    MediaQuery.of(context).viewPadding.top),
                            child: Column(children: [
                              Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: CurvedBackground(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Gap(13),
                                        IndividualWalletHeader(
                                          wallet: wallet!,
                                        ),
                                        const Gap(20),
                                        const Divider(
                                          color: AppColor.kSecondaryColor,
                                        ),
                                        const Gap(20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            menu_item.MenuItem(
                                              icon: 'assets/images/payout.svg',
                                              text: 'Pay Out',
                                              onTab: () {
                                                PayoutSelectorPage.show(
                                                    context: context,
                                                    wallet: wallet);
                                              },
                                              disabled: wallet?.status ==
                                                      WalletStatus
                                                          .DEACTIVATED ||
                                                  wallet?.availableBalance
                                                          ?.value ==
                                                      0.00,
                                            ),
                                            menu_item.MenuItem(
                                              icon: 'assets/images/payin.svg',
                                              text: 'Pay In',
                                              onTab: () {
                                                ChoosePaymentPage.show(
                                                    context, wallet!);
                                              },
                                            ),
                                            menu_item.MenuItem(
                                              icon:
                                                  'assets/images/exchange.svg',
                                              text: 'Exchange',
                                              disabled: wallet?.status ==
                                                      WalletStatus
                                                          .DEACTIVATED ||
                                                  wallet?.availableBalance
                                                          ?.value ==
                                                      0.00,
                                              onTab: () {
                                                MainCurrencyExchangePage.show(
                                                    context: context,
                                                    selectedWallet: wallet);
                                              },
                                            ),
                                            menu_item.MenuItem(
                                              icon:
                                                  'assets/images/bank_account.svg',
                                              text: 'Details',
                                              onTab: () =>
                                                  WalletDetailsScreen.show(
                                                      context,
                                                      widget.wallet!,
                                                      widget.wallet!.status ==
                                                          WalletStatus.INACTIVE,
                                                      widget.wallet!
                                                          .walletAccountDetails),
                                            ),
                                          ],
                                        ),
                                        const Gap(16),
                                        // Row(
                                        //   children: [
                                        //     Text(
                                        //       '${wallet.availableBalance!.currency} activity',
                                        //       style: textTheme.bodyText1?.copyWith(
                                        //         color: AppColor.kSecondaryColor,
                                        //       ),
                                        //     ),
                                        //     const Spacer(),
                                        //     RawMaterialButton(
                                        //       constraints:
                                        //           const BoxConstraints(minWidth: 30, minHeight: 30),
                                        //       onPressed: () => WalletActivityScreen.show(context),
                                        //       child: SvgPicture.asset(
                                        //         'assets/images/stats.svg',
                                        //         color: AppColor.kSecondaryColor,
                                        //       ),
                                        //       shape: const CircleBorder(),
                                        //     ),
                                        //     RawMaterialButton(
                                        //       constraints:
                                        //           const BoxConstraints(minWidth: 30, minHeight: 30),
                                        //       onPressed: () {},
                                        //       child: SvgPicture.asset(
                                        //         'assets/images/search.svg',
                                        //         color: AppColor.kSecondaryColor,
                                        //       ),
                                        //       shape: const CircleBorder(),
                                        //     ),
                                        //   ],
                                        // )
                                      ],
                                    ),
                                  )),
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
                                    wallet: wallet!,
                                  ),
                                ),
                              ),
                            ]),
                          )
                        ],
                      )));
    });
  }
}

class IndividualWalletHeader extends StatelessWidget {
  final Wallet wallet;
  IndividualWalletHeader({Key? key, required this.wallet}) : super(key: key);

  final Converter _walletHelper = Converter();
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            wallet.friendlyName,
            style: textTheme.bodyText2
                ?.copyWith(color: AppColor.kSecondaryColor, fontSize: 12),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _walletHelper.formatCurrency(wallet.availableBalance!) ??
                        '',
                    style: textTheme.headline1?.copyWith(
                      color: AppColor.kSecondaryColor,
                      fontSize: 44,
                    ),
                  ),
                ),
              ),
              const Gap(48),
              CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(
                      'icons/flags/png/${_walletHelper.getLocale(wallet.currency)}.png',
                      package: 'country_icons')),
            ],
          ),
          Row(children: [
            InkWell(
              onTap: () {
                onCreatePressed(context);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColor.kSecondaryColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      wallet.availableBalance!.currency,
                      style: textTheme.bodyText2?.copyWith(
                          color: AppColor.kSecondaryColor, fontSize: 10),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColor.kSecondaryColor,
                      size: 12,
                    ),
                  ],
                ),
              ),
            ),
            if (wallet.status == WalletStatus.DEACTIVATED) ...[
              const Gap(8),
              Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.kRedColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Deactivated',
                    style: textTheme.bodyText2
                        ?.copyWith(color: AppColor.kRedColor, fontSize: 10),
                  ))
            ],
            if (wallet.isDefault) ...[
              const Gap(8),
              Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.kSecondaryColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Default',
                    style: textTheme.bodyText2?.copyWith(
                        color: AppColor.kSecondaryColor, fontSize: 10),
                  ))
            ],
          ]),
        ]));
  }
}

class MoreOptions extends StatelessWidget {
  final Wallet wallet;
  const MoreOptions({Key? key, required this.wallet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // const TileSelector(
            //     svgAsset: 'assets/images/request.svg', title: 'Request'),
            if (!wallet.isDefault)
              TileSelector(
                svgAsset: 'assets/images/set_as_default.svg',
                title: 'Set as default',
                onPressed: () {
                  Navigator.pop(context);
                  _setAsDeafult(context);
                },
              ),
            // TileSelector(
            //   svgAsset: 'assets/images/statements.svg',
            //   title: 'Statements',
            //   onPressed: () {
            //     Navigator.pop(context);
            //     ChooseStatements.show(context);
            //   },
            // ),
            TileSelector(
              svgAsset: 'assets/images/wallet_details.svg',
              title: 'Wallet details',
              onPressed: () {
                Navigator.pop(context);
                WalletDetailsScreen.show(
                    context,
                    wallet,
                    wallet.status == WalletStatus.INACTIVE,
                    wallet.walletAccountDetails);
              },
            ),
            if (wallet.availableBalance?.value == 0)
              TileSelector(
                svgAsset: 'assets/images/close_account.svg',
                title: 'Close account',
                onPressed: () {
                  Navigator.pop(context);
                  MoreDetails().closeWallet(context, wallet);
                },
              ),
            TileSelector(
              svgAsset: 'assets/images/add.svg',
              title: 'Add new Wallet',
              onPressed: () {
                Navigator.pop(context);
                CreateWalletScreen.show(context);
              },
            ),
          ],
        ));
  }

  void _setAsDeafult(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Stack(alignment: AlignmentDirectional.bottomCenter, children: [
            Container(
                margin: const EdgeInsets.only(top: 50),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                padding: EdgeInsets.only(
                    top: 26,
                    left: 26,
                    right: 26,
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Gap(30),
                    Text(
                      'Default Account',
                      textAlign: TextAlign.center,
                      style: textTheme.headline4?.copyWith(fontSize: 20),
                    ),
                    const Gap(17),
                    Text(
                      '${wallet.currency} Wallet will be pre-selected when you make future payments. You’ll still be able to selet another account during payment creation if needed.\n\n'
                      'Any fees owed, for  instance , card order fees and plan fees, will be changed to your default account.\n\n'
                      'Set any of your accounts as your default on the Account detail page.',
                      textAlign: TextAlign.justify,
                      style: textTheme.bodyText2,
                    ),
                    const Gap(30),
                    CustomElevatedButtonAsync(
                        color: AppColor.kGoldColor2,
                        onPressed: () async {
                          await WalletScreenVM()
                              .setDefaultWallet(context, wallet);
                        },
                        child:
                            Text('SET AS DEFAULT', style: textTheme.headline6)),
                    const Gap(10),
                    CustomElevatedButton(
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('CANCEL', style: textTheme.headline6)),
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
                      backgroundColor: AppColor.kSecondaryColor,
                      child: SvgPicture.asset(
                        'assets/wallets/default_wallet.svg',
                        width: 32,
                        height: 32,
                        color: Colors.white,
                      )),
                )),
          ]);
        });
  }
}

class LoadingListPage extends StatefulWidget {
  const LoadingListPage({Key? key}) : super(key: key);

  @override
  _LoadingListPageState createState() => _LoadingListPageState();
}

class _LoadingListPageState extends State<LoadingListPage> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      enabled: true,
      child: Column(children: [
        Padding(
            padding: const EdgeInsets.all(20.0),
            child: CurvedBackground(
                child: Container(
              height: 250,
            )))
      ]),
    );
  }
}
