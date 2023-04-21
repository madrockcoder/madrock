import 'dart:convert';

import 'package:equatable/equatable.dart';

class CreateUser extends Equatable {
  final String? accountType;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String country;
  final bool termsAccepted;
  final bool dataUsage;
  const CreateUser({
    required this.accountType,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.country,
    this.termsAccepted = true,
    this.dataUsage = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'account_type': accountType,
      'first_name': firstName,
      'last_name': lastName,
      'country': country,
      // 'email': email,
      // 'password': password,
      // 'termsAccepted': termsAccepted,
      // 'dataUsage': dataUsage,
    };
  }

  factory CreateUser.fromMap(Map<String, dynamic> map) {
    return CreateUser(
      accountType: map['account_type'] ?? '',
      firstName: map['first_name'] ?? '',
      lastName: map['last_name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      country: map['country'] ?? '',
      termsAccepted: map['terms_Accepted'] ?? false,
      dataUsage: map['data_usage'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateUser.fromJson(String source) =>
      CreateUser.fromMap(json.decode(source));

  @override
  List<Object?> get props {
    return [
      accountType,
      firstName,
      lastName,
      email,
      password,
      country,
      termsAccepted,
      dataUsage,
    ];
  }

  @override
  String toString() {
    return 'CreateUser(accountType: $accountType, first_name: $firstName, last_name: $lastName, email: $email, password: $password, country: $country, termsAccepted: $termsAccepted, dataUsage: $dataUsage)';
  }
}
