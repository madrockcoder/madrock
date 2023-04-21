import 'dart:convert';

import 'package:equatable/equatable.dart';

// [FOR REFERENCE]
// id = payee
// user = payer

class MobileRecipient extends Equatable {
  final String payeeId;
  final String payerId;
  final String? firstName;
  final String? lastName;
  final String? country;
  final String mobileNumber;
  final String? mobileNetwork;

  // final ParsedMobileNumber? parsedMobileNumber;
  final String? sendingReason;
  final String? relationshipWithReciever;

  const MobileRecipient(
      {required this.payeeId,
      required this.payerId,
      this.firstName,
      this.lastName,
      this.country,
      required this.mobileNumber,
      // this.parsedMobileNumber,
      this.sendingReason,
      this.mobileNetwork,
      this.relationshipWithReciever});

  Map<String, dynamic> toMap() {
    return {
      'user': payerId,
      'id': payeeId,
      'first_name': firstName,
      'last_name': lastName,
      'country': country,
      'mobile_number': mobileNumber,
      'sending_reason': sendingReason,
      'relationship_with_receiver': relationshipWithReciever,
      'network': mobileNetwork
      // 'parsed_mobile_number': parsedMobileNumber?.toJson()
    };
  }

  factory MobileRecipient.fromMap(Map<String, dynamic> map) {
    return MobileRecipient(
        payeeId: map['id'] ?? '',
        mobileNetwork: map['network'] ?? '',
        firstName: map['first_name'] ?? '',
        lastName: map['last_name'] ?? '',
        payerId: map['user'] ?? '',
        country: map['country'] ?? '',
        mobileNumber: map['mobile_number'] ?? '',
        sendingReason: map['sending_reason'] ?? '',
        // parsedMobileNumber: map['parsed_mobile_number'],
        relationshipWithReciever: map['relationship_with_receiver'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory MobileRecipient.fromJson(String source) =>
      MobileRecipient.fromMap(json.decode(source));

  @override
  List<Object?> get props {
    return [
      payerId,
      firstName,
      lastName,
      country,
      mobileNumber,
      relationshipWithReciever,
      sendingReason,
      mobileNetwork
    ];
  }
}

class MobileRecipientList {
  MobileRecipientList({required this.list});

  factory MobileRecipientList.fromJson(List parsedJson) {
    final list = parsedJson.map((value) {
      return MobileRecipient.fromMap(value);
    }).toList();
    return MobileRecipientList(list: list);
  }

  final List<MobileRecipient> list;
}
