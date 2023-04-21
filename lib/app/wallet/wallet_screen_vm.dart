import 'package:flutter/material.dart';
import 'package:geniuspay/app/home/pages/home_containter.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/app/wallet/view_individual_wallet/individual_wallet.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/models/user.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/services/wallet_services.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class WalletScreenVM extends BaseModel {
  //list of all country
  List<Wallet> _wallets = [];

  List<Wallet> get wallets => _wallets;
  Wallet? wallet;
  final WalletService _walletService = sl<WalletService>();
  final AuthenticationService _authenticationService = sl<AuthenticationService>();
  BaseModelState baseModelState = BaseModelState.loading;
  BaseModelState individualBaseModelState = BaseModelState.loading;
  String? showWalletId;

  User get user => _authenticationService.user!;

  void changeState(BaseModelState state) {
    baseModelState = state;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
  }

  Future<void> fetchWallets(BuildContext context) async {
    baseModelState = BaseModelState.loading;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
    final uid = _authenticationService.user!.id;
    final result = await _walletService.fetchWallets(uid: uid);

    result.fold((l) {
      changeState(BaseModelState.error);
    }, (r) {
      _wallets = r;
      if (showWalletId != null) {
        final index = _wallets.indexWhere((wallet) => wallet.walletID == showWalletId);
        showWalletId = null;
        IndividualWalletWidget.show(context: context, wallet: _wallets[index], disableExchange: false);
      }
      changeState(BaseModelState.success);
    });
  }

  Future<void> fetchIndividualWallet(BuildContext context, String walletId) async {
    individualBaseModelState = BaseModelState.loading;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
    final uid = _authenticationService.user!.id;
    final result = await _walletService.fetchIndividualWallet(uid: uid, walletId: walletId);

    result.fold((l) {
      individualBaseModelState = BaseModelState.error;
      notifyListeners();
    }, (r) {
      wallet = r;
      notifyListeners();
    });
  }

  Future<bool> setDefaultWallet(BuildContext context, Wallet wallet) async {
    final uid = _authenticationService.user!.id;
    final result = await _walletService.setDefaultWallet(wallet, uid);
    if (result.isLeft()) {
      result.leftMap((l) {
        Navigator.pop(context);
        PopupDialogs(context).errorMessage('Unable to set default Wallet. Try again');
      });
      return false;
    } else {
      HomeWidget.show(context, defaultPage: 0, showWalletId: wallet.walletID, showSuccessDialog: 'Default Wallet was updated');
      return true;
    }
  }

  void setWalletId(String walletId) {
    showWalletId = walletId;
    notifyListeners();
  }

  updateWalletsWebsocket() async {
    final result = await _walletService.fetchWallets(uid: _authenticationService.user!.id);
    result.fold((l) => null, (r) => _wallets = r);

    if (wallet != null) {
      final walletres = _wallets.where((element) => element.walletID == wallet!.walletID).toList();
      if (walletres.isNotEmpty) {
        wallet = walletres.first;
      }
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
  }
}
