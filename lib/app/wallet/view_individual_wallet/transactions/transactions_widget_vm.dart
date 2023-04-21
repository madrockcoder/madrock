import 'package:flutter/material.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/models/wallet_transaction.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/services/wallet_services.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class WalletTransactionsVM extends BaseModel {
  //list of all country
  List<WalletTransaction> _walletTransactionsMini = [];
  List<WalletTransaction> _walletTransactions = [];
  List<WalletTransaction> get walletTransactionsMini => _walletTransactionsMini;
  List<WalletTransaction> get walletTransactions => _walletTransactions;
  final WalletService _walletService = sl<WalletService>();
  final AuthenticationService _authenticationService =
      sl<AuthenticationService>();
  BaseModelState baseModelStateMini = BaseModelState.loading;
  BaseModelState baseModelState = BaseModelState.loading;
  void changeStateMini(BaseModelState state) {
    baseModelStateMini = state;
    notifyListeners();
  }

  void changeState(BaseModelState state) {
    baseModelState = state;
    notifyListeners();
  }

  Future<void> getWalletTransactionsMini(
      BuildContext context, String walletId) async {
    baseModelStateMini = BaseModelState.loading;

    final uid = _authenticationService.user!.id;
    final result =
        await _walletService.getWalletTransactions(walletId, uid, '5');
    result.fold((l) {
      changeStateMini(BaseModelState.error);
    }, (r) async {
      _walletTransactionsMini = r;
      changeStateMini(BaseModelState.success);
    });
  }

  Future<void> getWalletTransactions(
      BuildContext context, String walletId) async {
    baseModelState = BaseModelState.loading;
    final uid = _authenticationService.user!.id;
    final result =
        await _walletService.getWalletTransactions(walletId, uid, null);
    result.fold((l) {
      changeState(BaseModelState.error);
    }, (r) async {
      _walletTransactions = r;
      changeState(BaseModelState.success);
    });
  }
}
