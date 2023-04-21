import 'dart:convert';

import 'package:equatable/equatable.dart';

// [FOR REFERENCE]
// id = payee
// user = payer

class EmailRecipient extends Equatable {
  final String payeeId;
  final String payerId;
  final String email;
  final String? firstName;
  final String? lastName;
  final String? country;
  const EmailRecipient({
    required this.payeeId,
    required this.payerId,
    required this.email,
    this.firstName,
    this.lastName,
    this.country,
  });

  Map<String, dynamic> toMap() {
    return {
      'user': payerId,
      'id': payeeId,
      'email': email,
    };
  }

  factory EmailRecipient.fromMap(Map<String, dynamic> map) {
    return EmailRecipient(
      payeeId: map['id'] ?? '',
      firstName: map['first_name'] ?? '',
      lastName: map['last_name'] ?? '',
      payerId: map['user'] ?? '',
      email: map['email'] ?? '',
      country: map['country'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EmailRecipient.fromJson(String source) =>
      EmailRecipient.fromMap(json.decode(source));

  @override
  List<Object?> get props {
    return [
      payeeId,
      payerId,
      email,
      firstName,
      lastName,
      country,
    ];
  }
}

class EmailRecipientList {
  EmailRecipientList({required this.list});

  factory EmailRecipientList.fromJson(List parsedJson) {
    final list = parsedJson.map((value) {
      return EmailRecipient.fromMap(value);
    }).toList();
    return EmailRecipientList(list: list);
  }

  final List<EmailRecipient> list;
}
