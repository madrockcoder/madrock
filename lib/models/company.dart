import 'dart:convert';

import 'package:equatable/equatable.dart';

class Company extends Equatable {
  const Company({
    required this.name,
    required this.tagline,
    required this.logo,
    required this.bio,
    required this.isActive,
  });

  factory Company.fromMap(Map<String, dynamic> map) {
    return Company(
      name: map['name'] as String,
      tagline: map['tagline'] as String,
      logo: map['logo'] as String,
      bio: map['bio'] as String,
      isActive: map['is_active'] as bool,
    );
  }

  factory Company.fromJson(String source) =>
      Company.fromMap(json.decode(source) as Map<String, dynamic>);
  final String name;
  final String tagline;
  final String logo;
  final String bio;
  final bool isActive;

  @override
  List<Object> get props {
    return [
      name,
      tagline,
      logo,
      bio,
      isActive,
    ];
  }

  @override
  String toString() {
    return 'Company(name: $name, tagline: $tagline, logo: $logo, bio: $bio, isActive: $isActive)';
  }
}
