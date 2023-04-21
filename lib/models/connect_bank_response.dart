import 'dart:convert';

import 'package:equatable/equatable.dart';

class ConnectBankResponse extends Equatable {
  final String id;
  final String reference;
  final String status;
  final String aspsp;
  final String initiateUrl;

  const ConnectBankResponse({
    required this.id,
    required this.reference,
    required this.status,
    required this.aspsp,
    required this.initiateUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'reference': reference,
      'status': status,
      'aspsp': aspsp,
      'initiate_url': initiateUrl,
    };
  }

  factory ConnectBankResponse.fromMap(Map<String, dynamic> map) {
    return ConnectBankResponse(
        id: map['id'] as String,
        reference: map['reference'] as String,
        status: map['status'] as String,
        aspsp: map['aspsp'] as String,
        initiateUrl: map['initiate_url'] as String);
  }

  factory ConnectBankResponse.fromJson(String source) =>
      ConnectBankResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [
        id,
      ];
}
