import 'package:flutter/material.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/models/conversion.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/services/currency_exchange_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ConversionHistoryVM extends BaseModel {
  BaseModelState baseModelStateMini = BaseModelState.loading;
  BaseModelState baseModelState = BaseModelState.loading;
  final CurrencyExchangeService _exchangeService =
      sl<CurrencyExchangeService>();
  final AuthenticationService _authenticationService =
      sl<AuthenticationService>();
  List<Conversion> _conversionsMini = [];
  List<Conversion> _conversions = [];

  List<Conversion> get conversionsMini => _conversionsMini;
  List<Conversion> get conversions => _conversions;
  void changeStateMini(BaseModelState state) {
    baseModelStateMini = state;
    notifyListeners();
  }

  void changeState(BaseModelState state) {
    baseModelState = state;
    notifyListeners();
  }

  Future<void> getTransactionsMini(
    BuildContext context,
  ) async {
    baseModelStateMini = BaseModelState.loading;
    final result = await _exchangeService.getTransactions(
        uid: _authenticationService.user!.id, pages: '6');
    result.fold((l) {
      setError(l);
      changeStateMini(BaseModelState.error);
    }, (r) async {
      _conversionsMini = r;
      changeStateMini(BaseModelState.success);
    });
  }

  Future<void> getTransactions(
    BuildContext context,
  ) async {
    baseModelState = BaseModelState.loading;
    final result = await _exchangeService.getTransactions(
        uid: _authenticationService.user!.id);
    result.fold((l) {
      setError(l);
    }, (r) async {
      _conversions = r;
      changeState(BaseModelState.success);
    });
  }
}
