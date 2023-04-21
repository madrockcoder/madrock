import 'dart:convert';

import 'package:equatable/equatable.dart';

class MobileNetwork extends Equatable {
  final String id;
  final String destination;
  final String networkName;

  const MobileNetwork(
      {required this.id, required this.destination, required this.networkName});

  @override
  List<Object> get props => [id, destination, networkName];

  @override
  String toString() => 'Country(id: $id, name: $networkName, destination: $destination)';

  factory MobileNetwork.fromMap(Map<String, dynamic> map) {
    return MobileNetwork(
      id: map['id'],
      destination: map['destination'],
      networkName: map['network_name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MobileNetwork.fromJson(String source) =>
      MobileNetwork.fromMap(json.decode(source));

  // Map<String, dynamic> toMap() {
  //   return {
  //     'iso2': iso2,
  //     'name': name,
  //   };
  // }

  // String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'destination': destination,
      'network_name': networkName,
    };
  }
}

class MobileNetworkList {
  MobileNetworkList({required this.list});

  factory MobileNetworkList.fromJson(List parsedJson) {
    final list = parsedJson.map((value) {
      return MobileNetwork.fromMap(value);
    }).toList();
    return MobileNetworkList(list: list);
  }

  final List<MobileNetwork> list;
}
