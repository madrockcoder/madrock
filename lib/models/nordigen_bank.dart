import 'dart:convert';

import 'package:equatable/equatable.dart';

class NordigenBank extends Equatable {
  final String id;
  final String bic;
  final String name;
  final String logo;
  const NordigenBank({
    required this.id,
    required this.bic,
    required this.name,
    required this.logo,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'bic': bic,
      'name': name,
      'logo': logo,
    };
  }

  factory NordigenBank.fromMap(Map<String, dynamic> map) {
    return NordigenBank(
      id: map['id'] ?? '',
      bic: map['bic'] ?? '',
      name: map['name'] ?? '',
      logo: map['logo'] ?? '',
    );
  }

  factory NordigenBank.fromJson(String source) =>
      NordigenBank.fromMap(json.decode(source));

  @override
  List<Object?> get props => [id, bic, name, logo];
}

class NordigenBankList {
  NordigenBankList({required this.list});

  factory NordigenBankList.fromJson(List parsedJson) {
    final list = parsedJson.map((value) {
      return NordigenBank.fromMap(value);
    }).toList();
    return NordigenBankList(list: list);
  }

  final List<NordigenBank> list;
}
