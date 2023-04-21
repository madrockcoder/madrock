import 'dart:convert';

import 'package:equatable/equatable.dart';

class Country extends Equatable {
  final String iso2;
  final String iso3;
  final String name;
  final String currencyISO;
  final String phoneCode;
  final bool isSupported;

  const Country({
    required this.iso2,
    required this.name,
    required this.currencyISO,
    required this.phoneCode,
    required this.iso3,
    this.isSupported = false,
  });

  @override
  List<Object> get props => [iso2, name, currencyISO];

  @override
  String toString() => 'Country(iso2: $iso2, name: $name)';

  factory Country.fromMap(Map<String, dynamic> map) {
    var phoneCode = '';
    if (map['phone_code'] != null) {
      var code = map['phone_code'].toString();
      if (!code.contains('+')) {
        phoneCode = '+$code';
      } else {
        phoneCode = code;
      }
    }

    return Country(
      iso2: map['iso2'] ?? '',
      name: map['name'] ?? '',
      currencyISO: map['currencyISO'] ?? '',
      phoneCode: phoneCode,
      iso3: map['iso3'] ?? '',
      isSupported: map['supported'] ?? false,
    );
  }

  // String toJson() => json.encode(toMap());

  factory Country.fromJson(String source) =>
      Country.fromMap(json.decode(source));

  // Map<String, dynamic> toMap() {
  //   return {
  //     'iso2': iso2,
  //     'name': name,
  //   };
  // }

  // String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'iso2': iso2,
      'name': name,
      'currencyISO': currencyISO,
    };
  }

  String toJson() => json.encode(toMap());
}

class CountrylList {
  CountrylList({required this.list});

  factory CountrylList.fromJson(List parsedJson) {
    final list = parsedJson.map((value) {
      return Country.fromMap(value);
    }).toList();
    return CountrylList(list: list);
  }

  final List<Country> list;
}
