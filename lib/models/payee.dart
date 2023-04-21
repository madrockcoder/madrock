import 'dart:convert';

import 'package:equatable/equatable.dart';

enum AccountStatus { active, closing }

class Payee extends Equatable {
  final String payeeID;
  final AccountStatus userStatus;
  const Payee({
    required this.payeeID,
    required this.userStatus,
  });

  factory Payee.fromMap(Map<String, dynamic> map) {
    return Payee(
      payeeID: map['account_id'] ?? '',
      userStatus: getAccountStatus(map['user_status']),
    );
  }

  factory Payee.fromJson(String source) => Payee.fromMap(json.decode(source));

  @override
  List<Object> get props => [payeeID, userStatus];

  @override
  String toString() => 'Payee(payeeID: $payeeID, userStatus: $userStatus)';
}

AccountStatus getAccountStatus(String? status) {
  switch (status) {
    case 'ACTIVE':
      return AccountStatus.active;
    case 'CLOSING':
      return AccountStatus.closing;
    default:
      return AccountStatus.closing;
  }
}
