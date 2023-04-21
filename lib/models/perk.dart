import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'company.dart';

class Perk extends Equatable {
  final String id;
  final Company company;
  final String name;
  final String description;
  final String validUntil;
  final String offerUrl;
  final String coupon;
  final bool isActive;
  final int points;
  final int claimCount;
  final String terms;
  final String category;
  const Perk({
    required this.id,
    required this.company,
    required this.name,
    required this.description,
    required this.validUntil,
    required this.offerUrl,
    required this.coupon,
    required this.isActive,
    required this.points,
    required this.claimCount,
    required this.terms,
    required this.category,
  });

  factory Perk.fromMap(Map<String, dynamic> map) {
    return Perk(
        id: map['id'] ?? '',
        company: Company.fromMap(map['company']),
        name: map['name'] ?? '',
        description: map['description'] ?? '',
        validUntil: map['valid_until'] ?? '',
        offerUrl: map['offer_url'] ?? '',
        coupon: map['coupon'] ?? '',
        isActive: map['is_active'] ?? false,
        points: map['points']?.toInt() ?? 0,
        terms: map['terms'] ?? '',
        claimCount: map['claim_count']?.toInt() ?? 0,
        category: map['category']['name'] ?? '');
  }

  factory Perk.fromJson(String source) => Perk.fromMap(json.decode(source));

  @override
  List<Object> get props {
    return [
      id,
      company,
      name,
      description,
      validUntil,
      offerUrl,
      coupon,
      isActive,
      points,
      claimCount,
      terms,
    ];
  }

  @override
  String toString() {
    return 'Perk(id: $id, company: $company, name: $name, description: $description, validUntil: $validUntil, offerUrl: $offerUrl, coupon: $coupon, isActive: $isActive, points: $points, claimCount: $claimCount, terms: $terms)';
  }
}

class PerkList {
  PerkList({required this.list});

  factory PerkList.fromJson(List parsedJson) {
    final list = parsedJson.map((value) {
      return Perk.fromMap(value);
    }).toList();
    return PerkList(list: list);
  }

  final List<Perk> list;
}
