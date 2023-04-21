import 'dart:convert';

import 'package:equatable/equatable.dart';

class Recipient extends Equatable {
  final String? id;
  final String userID;
  final String email;
  final String? avatar;
  final String? firstName;
  final String? lastName;
  final String? country;
  const Recipient({
    this.id,
    required this.userID,
    required this.email,
    this.avatar,
    this.firstName,
    this.lastName,
    this.country,
  });

  Map<String, dynamic> toMap() {
    return {
      'user': userID,
      'email': email,
    };
  }

  factory Recipient.fromMap(Map<String, dynamic> map) {
    return Recipient(
      id: map['id'] ?? '',
      firstName: map['first_name'],
      lastName: map['last_name'],
      userID: map['user'] ?? '',
      email: map['email'] ?? '',
      avatar: map['avatar'] ?? '',
      country: map['country'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Recipient.fromJson(String source) =>
      Recipient.fromMap(json.decode(source));

  @override
  List<Object?> get props {
    return [
      id,
      userID,
      email,
      avatar,
      firstName,
      lastName,
      country,
    ];
  }

  @override
  String toString() {
    return 'Recipient(id: $id, userID: $userID, email: $email, avatar: $avatar, firstName: $firstName, lastName: $lastName, country: $country)';
  }
}
