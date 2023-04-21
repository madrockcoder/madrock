
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/currency_exchange/pages/main_currency_exchange.dart';
import 'package:geniuspay/app/deposit_funds/pages/choose_payment_page.dart';
import 'package:geniuspay/app/home/view_models/account_transactions_view_model.dart';
import 'package:geniuspay/app/home/view_models/home_view_model.dart';
import 'package:geniuspay/app/home/widget/budget_widget.dart';
import 'package:geniuspay/app/home/widget/country_not_supported.dart';
import 'package:geniuspay/app/home/widget/exchange_rates_widget.dart';
import 'package:geniuspay/app/home/widget/home_app_bar.dart';
import 'package:geniuspay/app/home/widget/home_refer_widget.dart';
import 'package:geniuspay/app/home/widget/home_wallet_widget.dart';
import 'package:geniuspay/app/home/widget/jars_widget.dart';
import 'package:geniuspay/app/home/widget/onboarding_status_widget.dart';
import 'package:geniuspay/app/home/widget/spending_widget.dart';
import 'package:geniuspay/app/home/widget/transactions_mini.dart';
import 'package:geniuspay/app/home/widget/wallet_selector.dart';
import 'package:geniuspay/app/payout/payout_selector.dart';
import 'package:geniuspay/app/shared_widgets/curved_background.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/draggable_home_sheet.dart';
import 'package:geniuspay/app/shared_widgets/menu_item.dart' as menu_item;
import 'package:geniuspay/app/home/pages/more/more_bottom_sheet_content.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/repos/local_repo.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/enums.dart';

class HomeScreen extends StatefulWidget {
  final PageController pageController;

  const HomeScreen({Key? key, required this.pageController}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<int> reorderableList = [0, 1, 2, 3, 4, 5];

  Widget getWidget(int index, HomeViewModel model) {
    if (index == 0) {
      // return HorizontalCardListWidget();
      return Container();
    } else if (index == 1) {
      return TransactionsMiniWidget(
        isVerified: model.isVerifed, //1
      );
    } else if (index == 2 && !model.haveAnyTransactions) {
      return const SpendingWidget();
    } else if (index == 3) {
      return const BudgetWidget();
    } else if (index == 4) {
      return const JarsWidget();
    } else {
      return const ExchangeRatesWidget();
    }
  }

  @override
  void initState() {
    final LocalBase _localBase = sl<LocalBase>();
    reorderableList = _localBase.getHomeWidgetOrder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BaseView<HomeViewModel>(
      onModelReady: (p0) {
        p0.isCountrySupported();
        p0.getUser();
        p0.getAccountTransactionsMini(context);
      },
      builder: (context, model, snapshot) {
        return Scaffold(
            backgroundColor:
                !model.isVerifed ? Colors.white : AppColor.kAccentColor2,
            body: SafeArea(
                child: RefreshIndicator(
                    onRefresh: () async {
                      final AccountTransactionsViewModel
                          _accountTransactionsViewModel =
                          sl<AccountTransactionsViewModel>();
                      await Future.wait([
                        model.getUser(),
                        _accountTransactionsViewModel
                            .getAccountTransactionsMini(context, null)
                      ]);
                    },
                    child: Stack(children: [
                      ListView(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16),
                        children: [
                          HomeAppBar(
                            user: model.user,
                            pageController: widget.pageController,
                          ),
                          const Gap(34),
                          CurvedBackground(
                              bgColor: !model.isVerifed
                                  ? Colors.white
                                  : AppColor.kAccentColor2,
                              child: Column(children: [
                                if (!model.isVerifed ||
                                    model.user?.userProfile.totalBalance ==
                                        null)
                                  const NoWalletCreated()
                                else
                                  HomeWalletWidget(
                                    totalAmount:
                                        model.user?.userProfile.totalBalance,
                                    model: model,
                                  ),
                                const Gap(24),
                                const Divider(
                                  color: AppColor.kSecondaryColor,
                                ),
                                const Gap(16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    menu_item.MenuItem(
                                        icon: 'assets/images/payout.svg',
                                        text: 'Pay Out',
                                        disabledColor: AppColor.kAccentColor2,
                                        buttonColor: AppColor.kSecondaryColor,
                                        onTab: () async {
                                          final result =
                                              await showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  context: context,
                                                  builder: (context) {
                                                    return const WalletSelectorList(
                                                      disable: true,
                                                    );
                                                  });
                                          if (result.runtimeType == Wallet) {
                                            PayoutSelectorPage.show(
                                                context: context,
                                                wallet: result);
                                          }
                                        },
                                        disabled: !model.isVerifed),
                                    menu_item.MenuItem(
                                        icon: 'assets/images/payin.svg',
                                        disabledColor: AppColor.kAccentColor2,
                                        text: 'Pay In',
                                        onTab: () async {
                                          final result =
                                              await showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  context: context,
                                                  builder: (context) {
                                                    return const WalletSelectorList(
                                                      disable: false,
                                                    );
                                                  });
                                          if (result.runtimeType == Wallet) {
                                            ChoosePaymentPage.show(
                                                context, result);
                                          }
                                        },
                                        disabled: !model.isVerifed),
                                    menu_item.MenuItem(
                                        icon: 'assets/images/exchange.svg',
                                        text: 'Exchange',
                                        disabledColor: AppColor.kAccentColor2,
                                        onTab: () {
                                          MainCurrencyExchangePage.show(
                                              context: context);
                                        },
                                        disabled: !model.isVerifed),
                                    menu_item.MenuItem(
                                      icon: 'assets/images/more.svg',
                                      text: 'More',
                                      disabledColor: AppColor.kAccentColor2,
                                      disabled: !model.isVerifed,
                                      onTab: () async {
                                        await showModalBottomSheet(
                                            isScrollControlled: true,
                                            constraints: BoxConstraints(
                                                maxHeight:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        .95),
                                            context: context,
                                            builder: (context) {
                                              return const MoreBottomSheetContent();
                                            });
                                      },
                                    ),
                                  ],
                                )
                              ]))
                        ],
                      ),
                      DraggableHomeSheet(
                          initialChildSize:
                              MediaQuery.of(context).size.height < 750
                                  ? 0.3
                                  : 0.42,
                          minChildSize: MediaQuery.of(context).size.height < 750
                              ? 0.2
                              : 0.4,
                          onlyTopRadius: true,
                          noBottomMargin: true,
                          child: Column(children: [
                            const Gap(16),
                            Column(children: [
                              if (model.user?.userProfile.onboardingStatus !=
                                  OnboardingStatus.onboardingCompleted) ...[
                                if (!model.isVerifed)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24),
                                    child:
                                        HomeReferWidget(textTheme: textTheme),
                                  ),
                                const Gap(12),
                                if (model.countrySupported ||
                                    model.user?.userProfile.optForBeta == true)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24),
                                    child: OnboardingStatusWidget(
                                        status: model.user?.userProfile
                                                .onboardingStatus ??
                                            OnboardingStatus.unknown),
                                  )
                                else
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 24),
                                    child: CountryNotSupportedWidget(),
                                  ),
                                const Gap(16),
                              ],
                              for (int i in reorderableList) ...[
                                Padding(
                                  padding: i != 0
                                      ? const EdgeInsets.symmetric(
                                          horizontal: 24)
                                      : const EdgeInsets.all(0),
                                  child: getWidget(i, model),
                                ),
                                const Gap(16),
                              ],
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                child: IntrinsicWidth(
                                    child: CustomElevatedButton(
                                        onPressed: () async {
                                          final list =
                                              await showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  constraints: BoxConstraints(
                                                      maxHeight:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              .95),
                                                  context: context,
                                                  builder: (context) {
                                                    return ReorderListSheet(
                                                      currentList:
                                                          reorderableList,
                                                    );
                                                  });
                                          if (list != null) {
                                            setState(() {
                                              reorderableList = list;
                                            });
                                          }
                                        },
                                        height: 42,
                                        color: AppColor.kGoldColor2,
                                        child: Row(children: [
                                          Text('CUSTOMIZE',
                                              style: textTheme.bodyLarge),
                                          const Gap(8),
                                          SvgPicture.asset(
                                              'assets/icons/customize_icon.svg')
                                        ]))),
                              ),
                              const Gap(64),
                            ]),
                          ]))
                    ]))));
      },
    );
  }
}

class ReorderListSheet extends StatefulWidget {
  final List<int> currentList;

  const ReorderListSheet({Key? key, required this.currentList})
      : super(key: key);

  @override
  State<ReorderListSheet> createState() => _ReorderListSheetState();
}

class _ReorderListSheetState extends State<ReorderListSheet> {
  late List<int> _items;

  String getText(int index) {
    switch (index) {
      case 0:
        return 'Spending';
      case 1:
        return 'Budget';
      case 2:
        return 'Saving jars';
      case 3:
        return 'Exchange rates';
      default:
        return '';
    }
  }

  @override
  void initState() {
    _items = widget.currentList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    padding: const EdgeInsets.only(top: 10),
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.close,
                          color: AppColor.kSecondaryColor,
                        ))),
                const Gap(16),
                Text(
                  'Customize your homescreen',
                  textAlign: TextAlign.center,
                  style: textTheme.displaySmall
                      ?.copyWith(color: AppColor.kSecondaryColor, fontSize: 22),
                ),
                const Gap(8),
                const Text(
                  'Add and remove insights, or drag to\nreorder them',
                  textAlign: TextAlign.center,
                ),
                const Gap(32),
                ListTile(
                  title: const Text('Show total savings on Home screen'),
                  subtitle: const Text(
                      'See the total amount in all of your savings pots next to your balance'),
                  trailing: CupertinoSwitch(
                    activeColor: AppColor.kSecondaryColor,
                    onChanged: (val) {},
                    value: true,
                  ),
                ),
                const Gap(32),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'ACTIVE',
                      style: textTheme.bodyLarge
                          ?.copyWith(color: AppColor.kSecondaryColor),
                    )),
                const Gap(16),
                ListTile(
                  leading: SvgPicture.asset(
                    'assets/images/minus_circle.svg',
                    width: 22,
                    height: 22,
                    color: AppColor.kGreyColor,
                  ),
                  minLeadingWidth: 0,
                  trailing: const Icon(
                    Icons.menu,
                    color: AppColor.kGreyColor,
                  ),
                  title: const Text('Transactions'),
                ),
                ReorderableListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    for (int index = 0; index < _items.length; index += 1)
                      ListTile(
                        leading: SvgPicture.asset(
                          'assets/images/minus_circle.svg',
                          width: 22,
                          height: 22,
                        ),
                        minLeadingWidth: 0,
                        key: Key('$index'),
                        trailing: const Icon(
                          Icons.menu,
                          color: AppColor.kSecondaryColor,
                        ),
                        title: Text(getText(_items[index])),
                      ),
                  ],
                  onReorder: (int oldIndex, int newIndex) {
                    if (oldIndex != 0) {
                      setState(() {
                        if (oldIndex < newIndex) {
                          newIndex -= 1;
                        }
                        final int item = _items.removeAt(oldIndex);
                        _items.insert(newIndex, item);
                      });
                    }
                  },
                ),
                const Gap(32),
                CustomElevatedButton(
                    color: AppColor.kGoldColor2,
                    onPressed: () {
                      final LocalBase _localBase = sl<LocalBase>();
                      _localBase.setHomeWidgetOrder(_items);
                      Navigator.pop(context, _items);
                    },
                    child: Text(
                      'CONFIRM',
                      style: textTheme.bodyLarge,
                    )),
                const Gap(32),
              ],
            )));
  }
}

class NoWalletCreated extends StatefulWidget {
  const NoWalletCreated({Key? key}) : super(key: key);

  @override
  State<NoWalletCreated> createState() => _NoWalletCreatedState();
}

class _NoWalletCreatedState extends State<NoWalletCreated> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        SvgPicture.asset(
          'assets/images/no_wallet.svg',
        ),
        const Gap(12),
        Text(
          'Automagically Awesome',
          style: textTheme.bodyLarge?.copyWith(
            color: AppColor.kSecondaryColor,
            fontSize: 16,
          ),
        ),
        const Gap(16),
        Text(
          'We’re wrapping things up to bring you\nthe Next-Gen Banking',
          textAlign: TextAlign.center,
          style: textTheme.bodyMedium?.copyWith(
            color: AppColor.kSecondaryColor,
            fontSize: 10,
          ),
        )
      ],
    );
  }
}

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final String icon;
  final Color color;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: InkWell(
          onTap: () {
            onPressed();
          },
          child: Container(
            width: 150,
            height: 119,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 87,
                  height: 80,
                  child: Image.asset(icon),
                ),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium?.copyWith(
                    fontSize: 8,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          )),
    );
  }
}
