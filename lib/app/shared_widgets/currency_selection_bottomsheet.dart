import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:geniuspay/app/shared_widgets/profile_card_background.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/models/currency.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/services/wallet_services.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/cupertino.dart';
import 'package:geniuspay/app/currency_exchange/widgets/exchange_flag_button.dart';
import 'package:geniuspay/app/shared_widgets/textfield_decoration.dart';
import 'package:geniuspay/util/color_scheme.dart';

class CurrencySelectionBottomSheet extends StatefulWidget {
  final Function(Wallet wallet)? onAccountCurrencySelected;
  final Function(Currency currency)? onAllCurrencySelected;
  final bool? canBuy;
  final bool? canSell;
  const CurrencySelectionBottomSheet(
      {Key? key,
      this.onAccountCurrencySelected,
      this.onAllCurrencySelected,
      this.canBuy = false,
      this.canSell = false})
      : super(key: key);

  @override
  State<CurrencySelectionBottomSheet> createState() =>
      _CurrencySelectionBottomSheetState();
}

class _CurrencySelectionBottomSheetState
    extends State<CurrencySelectionBottomSheet> {
  final _searchFocus = FocusNode();
  final _searchController = TextEditingController();
  bool show = false;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BaseView<CurrencySelectionViewModel>(onModelReady: (p0) {
      p0.resetWallets();
      p0.resetCurrencies();
      p0.getCurrencies(
        context,
      );

      if (widget.onAccountCurrencySelected != null) {
        p0.getWallets(
          context,
        );
      }
    }, builder: (context, model, snapshot) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Gap(33),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.close)),
                  const Spacer(),
                  Text('Select currency',
                      style: textTheme.displayLarge?.copyWith(
                          fontSize: 16, fontWeight: FontWeight.w700)),
                  const Spacer(),
                ],
              )),
          const Gap(16),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                  height: 50,
                  child: TextFormField(
                    controller: _searchController,
                    decoration: TextFieldDecoration(
                      focusNode: _searchFocus,
                      context: context,
                      hintText: 'Search',
                      clearSize: 8,
                      prefix: const Icon(
                        CupertinoIcons.search,
                        color: AppColor.kSecondaryColor,
                        size: 18,
                      ),
                      onClearTap: () {
                        _searchController.clear();
                        model.resetCurrencies();
                        model.resetWallets();
                      },
                      controller: _searchController,
                    ).inputDecoration(),
                    focusNode: _searchFocus,
                    keyboardType: TextInputType.name,
                    onTap: () {
                      setState(() {});
                    },
                    onChanged: (searchTerm) {
                      if (_searchController.text.isNotEmpty) {
                        if (widget.onAllCurrencySelected != null) {}
                        model.searchCurrencies(
                            context, _searchController.text.trim(),
                            checkWithWallet:
                                widget.onAccountCurrencySelected != null);
                        if (widget.onAccountCurrencySelected != null) {
                          model.searchWallets(
                            context,
                            _searchController.text.trim(),
                          );
                        }
                      } else {
                        model.resetCurrencies();
                        model.resetWallets();
                      }
                    },
                  ))),
          const Gap(16),
          Container(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * .9 - 150),
              child: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.onAccountCurrencySelected != null &&
                      model.searchedWallets.isNotEmpty) ...[
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 38),
                        child: Text(
                          'CURRENCIES YOU HOLD',
                          style: textTheme.bodyLarge
                              ?.copyWith(fontSize: 12, letterSpacing: 1.2),
                        )),
                    const Gap(12),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: ElevatedCardBackground(
                            padding: const EdgeInsets.all(8),
                            child: ListView.separated(
                                itemCount: model.searchedWallets.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                separatorBuilder: (context, index) {
                                  final wallet = model.searchedWallets[index];
                                  if (widget.canBuy == true &&
                                      (model.allCurrencies.any((element) =>
                                              !element.canBuy &&
                                              element.code ==
                                                  wallet.currency) ||
                                          !model.allCurrencies.any((element) =>
                                              element.code ==
                                              wallet.currency))) {
                                    return Container();
                                  }
                                  if (widget.canSell == true &&
                                      (model.allCurrencies.any((element) =>
                                              !element.canSell &&
                                              element.code ==
                                                  wallet.currency) ||
                                          !model.allCurrencies.any((element) =>
                                              element.code ==
                                              wallet.currency))) {
                                    return Container();
                                  }
                                  return const Gap(12);
                                },
                                itemBuilder: (context, index) {
                                  final wallet = model.searchedWallets[index];
                                  if (widget.canBuy == true &&
                                      (model.allCurrencies.any((element) =>
                                              !element.canBuy &&
                                              element.code ==
                                                  wallet.currency) ||
                                          !model.allCurrencies.any((element) =>
                                              element.code ==
                                              wallet.currency))) {
                                    return Container();
                                  }
                                  if (widget.canSell == true &&
                                      (model.allCurrencies.any((element) =>
                                              !element.canSell &&
                                              element.code ==
                                                  wallet.currency) ||
                                          !model.allCurrencies.any((element) =>
                                              element.code ==
                                              wallet.currency))) {
                                    return Container();
                                  }
                                  return CurrencySelectorTile(
                                      selected: false,
                                      title: wallet.friendlyName,
                                      currency: wallet.currency,
                                      subtitle: wallet.currency,
                                      trailing: wallet
                                          .availableBalance!.valueWithCurrency,
                                      onTap: () {
                                        widget.onAccountCurrencySelected!(
                                            model.searchedWallets[index]);
                                      });
                                })))
                  ],
                  const Gap(16),
                  if (widget.onAllCurrencySelected != null &&
                      model.searchedCurrencies.isNotEmpty) ...[
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 38),
                        child: Text(
                          widget.onAccountCurrencySelected != null
                              ? "CURRENCIES YOU DON'T HOLD"
                              : "CURRENCIES",
                          style: textTheme.bodyLarge
                              ?.copyWith(fontSize: 12, letterSpacing: 1.2),
                        )),
                    const Gap(12),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: ElevatedCardBackground(
                            padding: const EdgeInsets.all(4),
                            child: ListView.separated(
                                itemCount: model.searchedCurrencies.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                separatorBuilder: (context, index) {
                                  print(
                                      "111: ${model.allCurrencies.where((element) => element.code == 'TRY')}");
                                  if (widget.onAccountCurrencySelected !=
                                          null &&
                                      model.checkCurrencyExists(model
                                          .searchedCurrencies[index].code)) {
                                    return Container();
                                  }
                                  if (widget.canBuy == true &&
                                      model.searchedCurrencies[index].canBuy !=
                                          true) {
                                    return Container();
                                  }
                                  if (widget.canSell == true &&
                                      model.searchedCurrencies[index].canSell !=
                                          true) {
                                    return Container();
                                  }
                                  return const Gap(12);
                                },
                                itemBuilder: (context, index) {
                                  final currencies = model.searchedCurrencies;
                                  if (widget.onAccountCurrencySelected !=
                                          null &&
                                      model.checkCurrencyExists(
                                          currencies[index].code)) {
                                    return Container();
                                  }
                                  if (widget.canBuy == true &&
                                      model.searchedCurrencies[index].canBuy !=
                                          true) {
                                    return Container();
                                  }
                                  if (widget.canSell == true &&
                                      model.searchedCurrencies[index].canSell !=
                                          true) {
                                    return Container();
                                  }
                                  return CurrencySelectorTile(
                                    title: currencies[index].name,
                                    currency: currencies[index].code,
                                    subtitle: currencies[index].code,
                                    onTap: () {
                                      widget.onAllCurrencySelected!(
                                          currencies[index]);
                                    },
                                  );
                                }))),
                    const Gap(24),
                  ],
                  Gap(MediaQuery.of(context).viewInsets.bottom)
                ],
              ))),
        ],
      );
    });
  }
}

@lazySingleton
class CurrencySelectionViewModel extends BaseModel {
  List<Wallet> allWallets = [];
  List<Wallet> searchedWallets = [];

  List<Currency> allCurrencies = [];
  List<Currency> searchedCurrencies = [];
  final WalletService _walletService = sl<WalletService>();
  final AuthenticationService _authenticationService =
      sl<AuthenticationService>();
  getWallets(
    BuildContext context,
  ) async {
    final result =
        await _walletService.fetchWallets(uid: _authenticationService.user!.id);
    result.fold((l) => null, (r) async {
      allWallets = r;
      searchedWallets = r;
    });
    notifyListeners();
  }

  bool checkCurrencyExists(String currency) =>
      allWallets.any((wallet) => wallet.currency == currency);

  Future<void> getCurrencies(
    BuildContext context,
  ) async {
    final result = await _walletService.fetchCurrencies();
    result.fold((l) {
      setError(l);
    }, (r) async {
      allCurrencies = r;
      searchedCurrencies = r;
    });
    notifyListeners();
  }

  void resetCurrencies() {
    searchedCurrencies = allCurrencies;
    notifyListeners();
  }

  void resetWallets() {
    searchedWallets = allWallets;
    notifyListeners();
  }

  Future<void> searchCurrencies(BuildContext context, String searchTerm,
      {bool checkWithWallet = true}) async {
    if (checkWithWallet) {
      searchedCurrencies = allCurrencies
          .where((element) =>
              (element.name.toLowerCase().contains(searchTerm) ||
                  element.code.toLowerCase().contains(searchTerm)) &&
              !checkCurrencyExists(element.code))
          .toList();
    } else {
      searchedCurrencies = allCurrencies
          .where((element) =>
              element.name.toLowerCase().contains(searchTerm) ||
              element.code.toLowerCase().contains(searchTerm))
          .toList();
    }
    notifyListeners();
  }

  Future<void> searchWallets(BuildContext context, String searchTerm) async {
    searchedWallets = allWallets
        .where((element) => element.currency.toLowerCase().contains(searchTerm))
        .toList();
    notifyListeners();
  }
}
