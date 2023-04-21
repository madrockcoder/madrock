import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:geniuspay/models/wallet_account_details.dart';
import 'package:geniuspay/util/enums.dart';

import '../util/widgets_util.dart';

class Wallet extends Equatable {
  final String? walletID;
  final String user;
  final String friendlyName;
  final String currency;
  final bool isDefault;
  final AvailableBalance? availableBalance;
  final LedgerBalance? ledgerBalance;
  final PendingBalance? pendingBalance;
  final BlockedBalance? blockedBalance;
  final TotalIncoming? totalIncoming;
  final TotalOutgoing? totalOutgoing;
  final String? createdAt;
  final String? internalAccountId;
  final WalletStatus? status;
  final bool hasAccountDetails;
  final WalletAccountDetails? walletAccountDetails;
  final WalletType? walletType;

  const Wallet(
      {this.walletID,
      required this.user,
      required this.friendlyName,
      required this.currency,
      required this.isDefault,
      this.availableBalance,
      this.ledgerBalance,
      this.pendingBalance,
      this.blockedBalance,
      this.totalIncoming,
      this.totalOutgoing,
      this.createdAt,
      this.internalAccountId,
      this.status,
      this.walletAccountDetails,
      this.walletType,
      this.hasAccountDetails = false});

  @override
  List<Object> get props {
    return [
      user,
      friendlyName,
      currency,
      isDefault,
    ];
  }

  Map<String, dynamic> toMap(String friendlyName) {
    if (friendlyName.isEmpty) {
      return {
        'user': user,
        'default': isDefault,
        'currency': currency,
      };
    } else {
      return {
        // 'walletId': walletId,
        'user': user,
        'friendly_name': friendlyName,
        'default': isDefault,
        'currency': currency,
      };
    }
  }

  // String toJson() => json.encode(toMap());

  factory Wallet.fromMap(Map<String, dynamic> map) {
    return Wallet(
        walletID: map['id'] ?? '',
        user: map['user'] ?? '',
        friendlyName: map['friendly_name'] ?? '',
        currency: map['currency'] ?? '',
        isDefault: map['default'] ?? false,
        createdAt: map['created_at'] ?? '',
        internalAccountId: map['internal_account_id'] ?? '',
        availableBalance: AvailableBalance.fromMap(map['available_balance']),
        ledgerBalance: LedgerBalance.fromMap(map['ledger_balance']),
        pendingBalance: PendingBalance.fromMap(map['pending_balance']),
        blockedBalance: BlockedBalance.fromMap(map['blocked_balance']),
        totalIncoming: TotalIncoming.fromMap(map['total_incoming']),
        totalOutgoing: TotalOutgoing.fromMap(map['total_outgoing']),
        walletType: map['wallet_type'] == null
            ? null
            : WalletType.fromMap(map['wallet_type']),
        walletAccountDetails: map['account_details'] == null
            ? null
            : WalletAccountDetails.fromMap(map['account_details']),
        hasAccountDetails: map['has_account_details'],
        status: map['status'] == 'ACTIVE'
            ? WalletStatus.ACTIVE
            : map['status'] == 'DEACTIVATED'
                ? WalletStatus.DEACTIVATED
                : WalletStatus.INACTIVE);
  }

  factory Wallet.fromJson(String source) => Wallet.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Wallet(walletID: $walletID, user: $user, friendlyName: $friendlyName, currency: $currency, isDefault: $isDefault, availableBalance: $availableBalance, ledgerBalance: $ledgerBalance, pendingBalance: $pendingBalance, blockedBalance: $blockedBalance, totalIncoming: $totalIncoming, totalOutgoing: $totalOutgoing, createdAt: $createdAt, internalAccountId: $internalAccountId)';
  }
}

class WalletType extends Equatable {
  final String? maintenanceFee;
  final String? initialDeposit;
  final String? feeMargin;
  final String? interestRate;
  final bool? autoCreate;
  final String? minBalance;
  final String? maxDeposit;
  final String? minDeposit;
  final String? maxWithdrawal;
  final String? minWithdrawal;

  const WalletType({
    this.maintenanceFee,
    this.initialDeposit,
    this.feeMargin,
    this.interestRate,
    this.autoCreate,
    this.minBalance,
    this.maxDeposit,
    this.minDeposit,
    this.maxWithdrawal,
    this.minWithdrawal,
  });

  factory WalletType.fromMap(Map<String, dynamic> map) {
    return WalletType(
      maintenanceFee: map['maintenance_fee'],
      initialDeposit: map['initial_deposit'],
      feeMargin: map['fee_margin'],
      interestRate: map['interest_rate'],
      autoCreate: map['auto_create'],
      minBalance: map['min_balance'],
      maxDeposit: map['max_deposit'],
      minDeposit: map['min_deposit'],
      maxWithdrawal: map['max_withdrawal'],
      minWithdrawal: map['min_withdrawal'],
    );
  }

  factory WalletType.fromJson(String source) =>
      WalletType.fromMap(json.decode(source));

  @override
  List<Object> get props => [];

  // @override
  // String toString() => 'WalletType(value: $value, currency: $currency)';
}

class AvailableBalance extends Equatable {
  final double value;
  final String currency;
  final String? valueWithCurrency;

  const AvailableBalance({
    required this.value,
    required this.currency,
    required this.valueWithCurrency,
  });

  factory AvailableBalance.fromMap(Map<String, dynamic>? map) {
    final valArr = (map?['value'] ?? 0.0).toStringAsFixed(2).split('-');
    final val = double.tryParse(valArr.last ?? '0.00');
    final valueWithCurrency =
        '${WidgetsUtil.getCurrency(map?['currency'])}${val?.toStringAsFixed(2)}';

    return AvailableBalance(
      value: val!,
      currency: map?['currency'] ?? '',
      valueWithCurrency: valueWithCurrency,
    );
  }

  factory AvailableBalance.fromJson(String source) =>
      AvailableBalance.fromMap(json.decode(source));

  @override
  List<Object> get props => [value, currency];

  @override
  String toString() => 'AvailableBalance(value: $value, currency: $currency)';
}

class LedgerBalance extends Equatable {
  final double value;
  final String currency;
  final String? valueWithCurrency;

  const LedgerBalance({
    required this.value,
    required this.currency,
    this.valueWithCurrency,
  });

  factory LedgerBalance.fromMap(Map<String, dynamic>? map) {
    final valArr = (map?['value'] ?? 0.0).toStringAsFixed(2).split('-');
    final val = double.tryParse(valArr.last ?? '0.00');
    final valueWithCurrency =
        '${WidgetsUtil.getCurrency(map?['currency'])}${val?.toStringAsFixed(2)}';

    return LedgerBalance(
      value: val!,
      currency: map?['currency'] ?? '',
      valueWithCurrency: valueWithCurrency,
    );
  }

  factory LedgerBalance.fromJson(String source) =>
      LedgerBalance.fromMap(json.decode(source));

  @override
  List<Object> get props => [value, currency];

  @override
  String toString() => 'LedgerBalance(value: $value, currency: $currency)';
}

class PendingBalance extends Equatable {
  final double value;
  final String currency;
  final String? valueWithCurrency;

  const PendingBalance({
    required this.value,
    required this.currency,
    required this.valueWithCurrency,
  });

  factory PendingBalance.fromMap(Map<String, dynamic>? map) {
    final valArr = (map?['value'] ?? 0.0).toStringAsFixed(2).split('-');
    final val = double.tryParse(valArr.last ?? '0.00');
    final valueWithCurrency =
        '${WidgetsUtil.getCurrency(map?['currency'])}${val?.toStringAsFixed(2)}';

    return PendingBalance(
      value: val!,
      currency: map?['currency'] ?? '',
      valueWithCurrency: valueWithCurrency,
    );
  }

  factory PendingBalance.fromJson(String source) =>
      PendingBalance.fromMap(json.decode(source));

  @override
  List<Object> get props => [value, currency];

  @override
  String toString() => 'PendingBalance(value: $value, currency: $currency)';
}

class BlockedBalance extends Equatable {
  final double value;
  final String currency;
  final String? valueWithCurrency;

  const BlockedBalance({
    required this.value,
    required this.currency,
    this.valueWithCurrency,
  });

  factory BlockedBalance.fromMap(Map<String, dynamic>? map) {
    final valArr = (map?['value'] ?? 0.0).toStringAsFixed(2).split('-');
    final val = double.tryParse(valArr.last ?? '0.00');
    final valueWithCurrency =
        '${WidgetsUtil.getCurrency(map?['currency'])}${val?.toStringAsFixed(2)}';

    return BlockedBalance(
      value: val!,
      currency: map?['currency'] ?? '',
      valueWithCurrency: valueWithCurrency,
    );
  }

  factory BlockedBalance.fromJson(String source) =>
      BlockedBalance.fromMap(json.decode(source));

  @override
  List<Object> get props => [value, currency];

  @override
  String toString() => 'BlockedBalance(value: $value, currency: $currency)';
}

class TotalIncoming extends Equatable {
  final double value;
  final String currency;
  final String? valueWithCurrency;

  const TotalIncoming({
    required this.value,
    required this.currency,
    this.valueWithCurrency,
  });

  factory TotalIncoming.fromMap(Map<String, dynamic>? map) {
    final valArr = (map?['value'] ?? 0.0).toStringAsFixed(2).split('-');
    final val = double.tryParse(valArr.last ?? '0.00');
    final valueWithCurrency =
        '${WidgetsUtil.getCurrency(map?['currency'])}${val?.toStringAsFixed(2)}';

    return TotalIncoming(
      value: val!,
      currency: map?['currency'] ?? '',
      valueWithCurrency: valueWithCurrency,
    );
  }

  factory TotalIncoming.fromJson(String source) =>
      TotalIncoming.fromMap(json.decode(source));

  @override
  List<Object> get props => [value, currency];

  @override
  String toString() => 'TotalIncoming(value: $value, currency: $currency)';
}

class TotalOutgoing extends Equatable {
  final double value;
  final String currency;
  final String? valueWithCurrency;

  const TotalOutgoing({
    required this.value,
    required this.currency,
    this.valueWithCurrency,
  });

  factory TotalOutgoing.fromMap(Map<String, dynamic>? map) {
    final valArr = (map?['value'] ?? 0.0).toStringAsFixed(2).split('-');
    final val = double.tryParse(valArr.last ?? '0.00');
    final valueWithCurrency =
        '${WidgetsUtil.getCurrency(map?['currency'])}${val?.toStringAsFixed(2)}';

    return TotalOutgoing(
      value: val!,
      currency: map?['currency'] ?? '',
      valueWithCurrency: valueWithCurrency,
    );
  }

  factory TotalOutgoing.fromJson(String source) =>
      TotalOutgoing.fromMap(json.decode(source));

  @override
  List<Object> get props => [value, currency];

  @override
  String toString() => 'TotalOutgoing(value: $value, currency: $currency)';
}

class WalletList {
  WalletList({required this.list});

  factory WalletList.fromJson(List parsedJson) {
    final list = parsedJson.map((value) {
      return Wallet.fromMap(value);
    }).toList();
    return WalletList(list: list);
  }

  final List<Wallet> list;
}
