import 'package:flutter/cupertino.dart';
import 'package:geniuspay/app/wallet/wallet_screen_vm.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/models/transaction.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/services/transactions_services.dart';
import 'package:geniuspay/util/enums.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AccountTransactionsViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      sl<AuthenticationService>();
  final AccountTransactionsService _accountTransactionsService =
      sl<AccountTransactionsService>();
  final WalletScreenVM _walletScreenVM = sl<WalletScreenVM>();
  List<Wallet> get wallets => _walletScreenVM.wallets;
  List<DatedTransaction> _accountTransactionsMini = [];
  List<DatedTransaction> _allTransactions = [];
  List<DatedTransaction> allTransactionsFiltered = [];
  List<DatedTransaction> get accountTransactionsMini =>
      _accountTransactionsMini;
  BaseModelState baseModelStateMini = BaseModelState.loading;
  BaseModelState baseModelState = BaseModelState.loading;

  List<Transaction> miniTransactions = [];

  //filters
  List<TransactionType> selectedTransactionTypes = [];
  List<Wallet> selectedWalletTypes = [];
  DateTime? startDate;
  DateTime? endDate;
  void changeMiniState(BaseModelState state) {
    baseModelStateMini = state;
    notifyListeners();
  }

  void changeState(BaseModelState state) {
    baseModelState = state;
    notifyListeners();
  }

  Future<void> getAccountTransactionsMini(
      BuildContext context, String? walletId) async {
    baseModelStateMini = BaseModelState.loading;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
    // if (_accountTransactionsMini.isEmpty) {
    final result = await _accountTransactionsService.fetchAccountTransactions(
        _authenticationService.user!.id, '5', walletId);
    result.fold((l) => null, (r) {
      _accountTransactionsMini = r;
      if (accountTransactionsMini.isNotEmpty) {
        List<Transaction> transactions =
            accountTransactionsMini[0].transactions;

        for (int i = 0; i < 4; i++) {
          if (transactions.length > 5) {
            break;
          }
          if (transactions.length < 5 &&
              accountTransactionsMini.length > i + 1) {
            transactions.addAll(accountTransactionsMini[i + 1].transactions);
          }
        }
        miniTransactions = transactions;
      }

      changeMiniState(BaseModelState.success);
    });
    // } else {
    //   changeMiniState(BaseModelState.success);
    // }
  }

  Future<void> getAccountTransactions(
      BuildContext context, String? walletId) async {
    baseModelState = BaseModelState.loading;
    final result = await _accountTransactionsService.fetchAccountTransactions(
        _authenticationService.user!.id, null, walletId);
    result.fold((l) => null, (r) {
      _allTransactions = r;
      allTransactionsFiltered = r;
      changeState(BaseModelState.success);
    });
    getWallets(context);
  }

  void getWallets(BuildContext context) async {
    if (wallets.isEmpty) {
      _walletScreenVM.fetchWallets(context);
      notifyListeners();
    }
  }

  int getFilterNumber() {
    int filters = 0;
    filters += selectedTransactionTypes.length;
    filters += selectedWalletTypes.length;
    if (startDate != null || endDate != null) {
      filters++;
    }

    return filters;
  }

  void filterTransactions(
      {required BuildContext context,
      required List<TransactionType> transactionTypes,
      required List<Wallet> selectedWallets,
      required DateTime? start,
      required DateTime? end}) async {
    selectedTransactionTypes = transactionTypes;
    selectedWalletTypes = selectedWallets;
    startDate = start;
    endDate = end;
    Navigator.pop(context);
    notifyListeners();
  }
}
