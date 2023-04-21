import 'package:flutter/cupertino.dart';
import 'package:geniuspay/app/home/pages/notifications/notifications_vm.dart';
import 'package:geniuspay/app/home/view_models/account_transactions_view_model.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/models/country.dart';
import 'package:geniuspay/models/user.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/services/remote_config_service.dart';
import 'package:geniuspay/util/enums.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class HomeViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      sl<AuthenticationService>();
  User? get user => _authenticationService.user;
  bool get isVerifed =>
      user!.userProfile.verificationStatus == VerificationStatus.verified;
  final List _transactions = [];
  List get transations => _transactions;
  bool showBalance = true;
  final NotificationsVM _notificationsVM = sl<NotificationsVM>();
  final AccountTransactionsViewModel accountTransactionsViewModel =
      sl<AccountTransactionsViewModel>();
  bool get haveAnyTransactions =>
      accountTransactionsViewModel.miniTransactions.isNotEmpty;
  int get unreadNotifs => _notificationsVM.unreadNotifications;
  Country? residentialCountry;
  bool countrySupported = false;

  Future<void> getUser() async {
    await _authenticationService.getUser();
    notifyListeners();
  }

  void changeShowBalance() {
    showBalance = !showBalance;
    notifyListeners();
  }

  bool isCountrySupported() {
    if (RemoteConfigService.getRemoteData.supportedCountries
        .contains(_authenticationService.user!.userProfile.countryIso2)) {
      countrySupported = true;
    } else {
      countrySupported = false;
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
    return countrySupported;
  }

  Future<void> getAccountTransactionsMini(BuildContext context) async {
    await accountTransactionsViewModel.getAccountTransactionsMini(
        context, null);
    notifyListeners();
  }

  updateHome() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
  }
}
