import 'package:flutter/material.dart';
import 'package:geniuspay/app/shared_widgets/transfer_result_screen.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/models/exchange_rate.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/services/currency_exchange_service.dart';
import 'package:geniuspay/util/converter.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

@lazySingleton
class CurrencyExchangeViewModel extends BaseModel {
  BaseModelState baseModelState = BaseModelState.loading;
  final CurrencyExchangeService _exchangeService =
      sl<CurrencyExchangeService>();
  final AuthenticationService _authenticationService =
      sl<AuthenticationService>();
  void changeState(BaseModelState state) {
    baseModelState = state;
    notifyListeners();
  }

  Future<void> createConversion(BuildContext context, ExchangeRate exchangeRate,
      String buyingWalletId, String sellingWalletId) async {
    baseModelState = BaseModelState.loading;
    final result = await _exchangeService.createConversion(exchangeRate,
        _authenticationService.user!.id, buyingWalletId, sellingWalletId);
    result.fold((l) {
      setError(l);
      TransferResultScreen.show(
          context: context,
          status: 2,
          title: 'Exchange Failed',
          from: exchangeRate.buyCurrency + ' Wallet',
          to: exchangeRate.sellCurrency + ' Wallet',
          description: "Please try again later",
          points: '',
          date: DateFormat('dd MMM yyyy').format(DateTime.now()),
          amount:
              '${Converter().getCurrency(exchangeRate.buyCurrency)} ${exchangeRate.buyAmount}',
          redirectWallet: buyingWalletId);
    }, (r) async {
      final points = (r.pointsEarned == '0' || r.pointsEarned == null)
          ? ''
          : r.pointsEarned!;
      switch (r.status) {
        case 'AWAITING_FUNDS':
        case 'FUNDS_SENT':
          TransferResultScreen.show(
              context: context,
              referenceNumber: r.reference,
              status: 3,
              title: 'Exchange success',
              points: points,
              from: exchangeRate.buyCurrency + ' Wallet',
              to: exchangeRate.sellCurrency + ' Wallet',
              description: "you exchanged",
              date: DateFormat('dd MMM yyyy').format(DateTime.now()),
              amount:
                  '${Converter().getCurrency(exchangeRate.buyCurrency)} ${exchangeRate.buyAmount}',
              redirectWallet: buyingWalletId);
          break;
        case 'FUNDS_ARRIVED':
          TransferResultScreen.show(
              context: context,
              referenceNumber: r.reference,
              status: 1,
              title: 'Exchange success',
              points: points,
              from: exchangeRate.buyCurrency + ' Wallet',
              to: exchangeRate.sellCurrency + ' Wallet',
              description: "you exchanged",
              date: DateFormat('dd MMM yyyy').format(DateTime.now()),
              amount:
                  '${Converter().getCurrency(exchangeRate.buyCurrency)} ${exchangeRate.buyAmount}',
              redirectWallet: buyingWalletId);
          break;
        default:
          TransferResultScreen.show(
              context: context,
              referenceNumber: r.reference,
              status: 2,
              title: 'Exchange Failed',
              from: exchangeRate.buyCurrency + ' Wallet',
              to: exchangeRate.sellCurrency + ' Wallet',
              description: "Please try again later",
              points: points,
              date: DateFormat('dd MMM yyyy').format(DateTime.now()),
              amount:
                  '${Converter().getCurrency(exchangeRate.buyCurrency)} ${exchangeRate.buyAmount}',
              redirectWallet: buyingWalletId);
      }
    });
  }
}
