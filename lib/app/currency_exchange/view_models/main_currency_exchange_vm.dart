import 'package:flutter/material.dart';
import 'package:geniuspay/app/currency_exchange/pages/confirm_transaction.dart';
import 'package:geniuspay/app/shared_widgets/currency_selection_bottomsheet.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/app/wallet/wallet_screen_vm.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/models/currency.dart';
import 'package:geniuspay/models/exchange_rate.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/services/currency_exchange_service.dart';
import 'package:geniuspay/services/wallet_services.dart';
import 'package:geniuspay/util/converter.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CurrencyExchangeViewModel extends BaseModel {
  List<Wallet> _wallets = [];
  Wallet? _sellingWallet;
  Currency? sellingCurrency;

  Wallet? _buyingWallet;
  String _fixedSide = 'buy';
  ExchangeRate? _exchangeRate;
  String _amount = '100';
  double? _exactRate;
  String? _roundedRate;
  double? _minimumAmount;

// variables getters
  List<Wallet> get wallets => _wallets;
  Wallet? get sellingWallet => _sellingWallet;
  Wallet? get buyingWallet => _buyingWallet;
  String get fixedSide => _fixedSide;
  ExchangeRate? get exchangeRate => _exchangeRate;
  String get amount => _amount;
  double? get exactRate => _exactRate;
  String? get roundedRate => _roundedRate;
  double? get minimumAmount => _minimumAmount;
  bool error = false;

  final WalletService _walletService = sl<WalletService>();
  final CurrencyExchangeService _exchangeService =
      sl<CurrencyExchangeService>();
  final AuthenticationService _authenticationService =
      sl<AuthenticationService>();
  final WalletScreenVM _walletScreenVM = sl<WalletScreenVM>();

  BaseModelState baseModelState = BaseModelState.loading;
  void changeState(BaseModelState state) {
    baseModelState = state;
    notifyListeners();
  }

  Future<void> init(BuildContext context, Wallet? selectedWallet) async {
    _fixedSide = 'buy';
    await getWallets(context, selectedWallet);
  }

  Future<void> getExchangeRate(
      {required BuildContext context,
      String sellAmount = '100',
      bool nextStage = false}) async {
    _amount = sellAmount; //sellAmt >= 10 ? sellAmount : '100';
    // _amount = '100';
    if (_buyingWallet != null &&
        _sellingWallet != null &&
        _buyingWallet!.currency != _sellingWallet!.currency) {
      final result = await _exchangeService.fetchExchangeRate(
          buyingWallet!.currency, sellingWallet!.currency, fixedSide, amount);
      result.fold((l) {
        if (nextStage) {
          PopupDialogs(context).errorMessage('Unable to create this exchange');
        } else {
          changeState(BaseModelState.error);
          // changeState(BaseModelState.success);
          notifyListeners();
        }
      }, (r) {
        _exchangeRate = r;
        _exactRate = getRate();
        changeState(BaseModelState.success);
        notifyListeners();
        if (nextStage) {
          ConfirmTransationPage.show(
              context, exchangeRate!, buyingWallet!, sellingWallet!);
        }
      });
    } else {
      _exactRate = 1.00;
      _roundedRate = '1.00';
      changeState(BaseModelState.success);
    }
    // try {
    //   final result = await _exchangeService.fetchExchangeRate(
    //       'GBP', buyingWallet!.currency, 'buy', '100');
    //   result.fold((l) {
    //     notifyListeners();
    //   }, (r) {
    //     _minimumAmount = double.parse(r.sellAmount);
    //     notifyListeners();
    //   });
    // } catch (e) {}
  }

  final _converter = Converter();
  double getRate() {
    String currencyPair = exchangeRate!.currencyPair;
    String buyCurrency = buyingWallet!.currency;
    double rate = double.parse(exchangeRate!.rate);
    if ("${currencyPair[0]}${currencyPair[1]}${currencyPair[2]}" ==
        buyCurrency) {
      try {
        _roundedRate = _converter.reduceDecimals(rate, precision: 3).toString();
      } catch (e) {
        _roundedRate = rate.toString();
      }

      return rate;
    } else {
      final newRate = 1 / rate;
      try {
        _roundedRate =
            _converter.reduceDecimals(newRate, precision: 3).toString();
      } catch (e) {
        _roundedRate = newRate.toString();
      }
      return newRate;
    }
  }

  Future<void> getWallets(BuildContext context, Wallet? selectedWallet) async {
    baseModelState = BaseModelState.loading;
    if (_walletScreenVM.wallets.isEmpty) {
      final result = await _walletService.fetchWallets(
          uid: _authenticationService.user!.id);
      result.fold((l) {
        // setError(l);
        // changeState(BaseModelState.error);
      }, (r) async {
        _wallets = r;
      });
    } else {
      _wallets = _walletScreenVM.wallets;
    }
    _buyingWallet = selectedWallet ?? wallets[0];
    if (wallets.length > 1) {
      _sellingWallet = wallets
          .where((wallet) => wallet.currency != buyingWallet!.currency)
          .first;
      setSellingWallet(context, _sellingWallet!);
    } else {
      _sellingWallet = buyingWallet;
      setSellingWallet(context, _sellingWallet!);
    }

    notifyListeners();
    await getExchangeRate(context: context);
  }

  Future<void> createWallet(BuildContext context, String currencyCode) async {
    changeState(BaseModelState.loading);
    final AuthenticationService _authenticationService =
        sl<AuthenticationService>();
    final wallet = Wallet(
        friendlyName: '',
        user: _authenticationService.user!.id,
        isDefault: false,
        currency: currencyCode);
    final createWalletResult = await _walletService.createWallet(wallet);
    if (createWalletResult.isLeft()) {
      Navigator.pop(context);
      createWalletResult.leftMap((l) async {
        PopupDialogs(context).errorMessage("Oops! couldn't create your wallet");
      });
    } else {
      Navigator.pop(context);
      PopupDialogs(context).successMessage("Successfully created a new wallet");
      createWalletResult.foldRight(Wallet, (createdWallet, previous) async {
        final result = await _walletService.fetchWallets(
            uid: _authenticationService.user!.id);
        if (result.isRight()) {
          result.foldRight(Wallet, (r, previous) async {
            _wallets = r;
            _sellingWallet = createdWallet;
            _buyingWallet = wallets
                .where((wallet) => wallet.currency != sellingWallet!.currency)
                .first;
            setSellingWallet(context, _sellingWallet!);
            notifyListeners();
            await getExchangeRate(context: context);
          });
        }
      });
    }
  }

  Future<void> setSellingWallet(BuildContext context, Wallet value) async {
    final CurrencySelectionViewModel _currencySelectionVM =
        sl<CurrencySelectionViewModel>();
    _sellingWallet = value;

    notifyListeners();
    await getExchangeRate(context: context);
    if (_currencySelectionVM.allCurrencies.isEmpty) {
      await _currencySelectionVM.getCurrencies(
        context,
      );
    }
    final temp = _currencySelectionVM.allCurrencies
        .where((element) => element.code == value.currency)
        .toList();
    if (temp.isNotEmpty) {
      sellingCurrency = temp[0];
    }
    notifyListeners();
  }

  Future<void> setBuyingWallet(BuildContext context, Wallet value) async {
    _buyingWallet = value;
    notifyListeners();
    await getExchangeRate(context: context);
  }

  void swapSellingBuyingCurrency(BuildContext context) {
    final temp = sellingWallet;
    _sellingWallet = buyingWallet;
    setSellingWallet(context, _sellingWallet!);
    _buyingWallet = temp!;
    if (fixedSide == 'buy') {
      _fixedSide = 'sell';
    } else {
      _fixedSide = 'buy';
    }
    _exactRate = getRate();
    notifyListeners();
    getExchangeRate(context: context);
  }
}
