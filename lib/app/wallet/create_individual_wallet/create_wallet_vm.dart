import 'package:flutter/material.dart';
import 'package:geniuspay/app/home/pages/home_containter.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/app/wallet/view_individual_wallet/individual_wallet.dart';
import 'package:geniuspay/app/wallet/wallet_screen_vm.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/models/currency.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/services/wallet_services.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CreateWalletViewModel extends BaseModel {
  //list of all country
  List<Currency> _currencies = [];

  List<Currency> get currencies => _currencies;
  List<Currency> allCurrencies = [];

  List<Wallet> _wallets = [];

  List<Wallet> get wallets => _wallets;
  List<Wallet> allWallets = [];

// variables getters
  Currency? _currency;
  String? _friendly_name;
  bool _defaultWallet = false;

  Currency? get currency => _currency;

  String? get friendly_name => _friendly_name;

  bool get defaultWallet => _defaultWallet;
  final WalletService _walletService = sl<WalletService>();
  final WalletScreenVM _walletScreenVM = sl<WalletScreenVM>();
  BaseModelState baseModelState = BaseModelState.loading;

  void changeState(BaseModelState state) {
    baseModelState = state;
    notifyListeners();
  }

  getWallets(BuildContext context) async {
    await _walletScreenVM.fetchWallets(context);
    _wallets = _walletScreenVM.wallets;
    allWallets = _walletScreenVM.wallets;
    notifyListeners();
  }

  bool checkCurrencyExists(String currency) => allWallets.any((wallet) => wallet.currency == currency);

  Future<bool> createWallet(BuildContext context) async {
    final AuthenticationService _authenticationService = sl<AuthenticationService>();
    final wallet = Wallet(
        friendlyName: friendly_name ?? '',
        user: _authenticationService.user!.id,
        isDefault: defaultWallet,
        currency: _currency!.code);
    final result = await _walletService.createWallet(wallet);
    if (result.isLeft()) {
      Navigator.pop(context);
      Navigator.pop(context);
      result.leftMap((l) async {
        PopupDialogs(context).errorMessage("Oops! couldn't create your wallet");
      });
      return false;
    } else {
      result.foldRight(Wallet, (r, previous) {
        // final walletScreenVM = sl<WalletScreenVM>();
        // await walletScreenVM.fetchWallets(context);
        Navigator.push(
            context,
            NoAnimationPageRoute(
                builder: (BuildContext context) =>
                    const HomeWidget(defaultPage: 0, showSuccessDialog: "Successfully created a new wallet")));
        Navigator.push(
            context,
            NoAnimationPageRoute(
                builder: (BuildContext context) => IndividualWalletWidget(
                      disableExchange: false,
                      wallet: r,
                      walletId: r.walletID,
                    )));
      });

      return true;
    }
  }

  Future<void> getCurrencies(BuildContext context) async {
    baseModelState = BaseModelState.loading;
    final result = await _walletService.fetchCurrencies();
    result.fold((l) {
      setError(l);
      changeState(BaseModelState.error);
    }, (r) {
      _currencies = r;
      allCurrencies = r;
      changeState(BaseModelState.success);
    });
  }

  void resetCurrencies() {
    _currencies = allCurrencies;
    notifyListeners();
  }

  void resetWallets() {
    _wallets = allWallets;
    notifyListeners();
  }

  Future<void> searchCurrencies(BuildContext context, String searchTerm, {bool checkWithWallet = true}) async {
    if (checkWithWallet) {
      _currencies = allCurrencies
          .where((element) =>
              (element.name.toLowerCase().contains(searchTerm) || element.code.toLowerCase().contains(searchTerm)) &&
              !checkCurrencyExists(element.code))
          .toList();
    } else {
      _currencies = allCurrencies
          .where((element) => element.name.toLowerCase().contains(searchTerm) || element.code.toLowerCase().contains(searchTerm))
          .toList();
    }
    notifyListeners();
  }

  Future<void> searchWallets(BuildContext context, String searchTerm) async {
    _wallets = allWallets.where((element) => element.currency.toLowerCase().contains(searchTerm)).toList();
    notifyListeners();
  }

  set setCurrency(Currency value) {
    _currency = value;
    notifyListeners();
  }

  set setFriendlyName(String value) {
    _friendly_name = value;
    notifyListeners();
  }

  set setDefaultWallet(bool value) {
    _defaultWallet = value;
    notifyListeners();
  }
}

class NoAnimationPageRoute<T> extends MaterialPageRoute<T> {
  NoAnimationPageRoute({required WidgetBuilder builder}) : super(builder: builder);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
}
