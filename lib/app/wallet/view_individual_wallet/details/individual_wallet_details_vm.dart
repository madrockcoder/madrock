import 'package:flutter/material.dart';
import 'package:geniuspay/app/home/pages/home_containter.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/models/wallet_account_details.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:injectable/injectable.dart';
import 'package:geniuspay/services/wallet_services.dart';

@lazySingleton
class WalletDetailsVM extends BaseModel {
  //list of all country
  List<WalletAccountDetails> _walletDetails = [];
  List<WalletAccountDetails> get walletDetails => _walletDetails;
  final WalletService _walletService = sl<WalletService>();
  final AuthenticationService _authenticationService =
      sl<AuthenticationService>();
  BaseModelState baseModelState = BaseModelState.loading;
  void changeState(BaseModelState state) {
    baseModelState = state;
    notifyListeners();
  }

  Future<void> fetchWalletAccountDetails(
      BuildContext context, String walletId) async {
    baseModelState = BaseModelState.loading;
    final uid = _authenticationService.user!.id;
    final result =
        await _walletService.fetchWalletAccountDetails(walletId, uid);
    result.fold((l) async {
      setError(l);
      changeState(BaseModelState.error);
    }, (r) {
      if (r.isEmpty) {
        changeState(BaseModelState.error);
      } else {
        _walletDetails = r;
        changeState(BaseModelState.success);
      }
    });
  }

  Future<bool> renameWallet(
      BuildContext context, String walletId, String friendlyName) async {
    final uid = _authenticationService.user!.id;
    final result =
        await _walletService.updateFriendlyName(walletId, friendlyName, uid);
    if (result.isLeft()) {
      result.leftMap((l) async {
        PopupDialogs(context)
            .errorMessage('Unable to rename wallet. Please try again');
      });
      return false;
    } else {
      HomeWidget.show(context,
          defaultPage: 0,
          showWalletId: walletId,
          showSuccessDialog: "Successfully renamed wallet");
      return true;
    }
  }

  Future<bool> closeWallet(BuildContext context, Wallet wallet) async {
    final uid = _authenticationService.user!.id;
    final result = await _walletService.closeWallet(wallet, uid);
    if (result.isLeft()) {
      result.leftMap((l) async {
        PopupDialogs(context).errorMessage(l.props[0] == null
            ? 'Unable to close wallet'
            : l.props[0].toString());
      });
      return false;
    } else {
      HomeWidget.show(context,
          defaultPage: 0, showSuccessDialog: "Successfully deleted wallet");
      return true;
    }
  }

  Future<bool> changeWalletStatus(
      BuildContext context, Wallet wallet, String status) async {
    final uid = _authenticationService.user!.id;
    final result = await _walletService.changeWalletStatus(wallet, uid, status);
    if (result.isLeft()) {
      result.leftMap((l) async {
        PopupDialogs(context)
            .errorMessage('Unable to deactivate wallet. Please try again');
      });
      return false;
    } else {
      HomeWidget.show(context,
          defaultPage: 0,
          showWalletId: wallet.walletID,
          showSuccessDialog: "Successfully ${status.toLowerCase()}d wallet");
      return true;
    }
  }
}
