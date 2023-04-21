
import 'package:equatable/equatable.dart';

class KYCAddress extends Equatable {
  final String userId;
  final String addressLine1;
  final String? addressLine2;
  final String state;
  final String postCode;
  final String city;

  final String addressProofType;
  const KYCAddress({
    required this.userId,
    required this.addressLine1,
    this.addressLine2,
    required this.city,
    required this.state,
    required this.postCode,
    required this.addressProofType,
  });

  Map<String, dynamic> toMap(String? addressLine2) {
    if (addressLine2 != null) {
      return {
        'user': userId,
        'address_line_1': addressLine1,
        'address_line_2': addressLine2,
        'city': city,
        'state_or_province': state,
        'zip_code': postCode,
        'address_proof_type': addressProofType,
      };
    } else {
      return {
        'user': userId,
        'address_line_1': addressLine1,
        'city': city,
        'state_or_province': state,
        'zip_code': postCode,
        'address_proof_type': addressProofType,
      };
    }
  }

  factory KYCAddress.fromMap(Map<String, dynamic> map) {
    return KYCAddress(
      userId: map['user'] ?? '',
      addressLine1: map['address_line_1'] ?? '',
      city: map['city'] ?? '',
      postCode: map['zip_code'] ?? '',
      addressProofType: map['address_proof_type'] ?? '',
      state: map['state_or_province'],
    );
  }

  // String toJson() => json.encode(toMap());

  // factory KYCAddress.fromJson(String source) => KYCAddress.fromMap(json.decode(source));

  @override
  List<Object> get props {
    return [
      userId,
      addressLine1,
      city,
      state,
      postCode,
      addressProofType,
    ];
  }

  @override
  String toString() {
    return 'KYCAddress(userId: $userId, addressLine1: $addressLine1, city: $city, state: $state, postCode: $postCode, addressProofType: $addressProofType)';
  }
}
