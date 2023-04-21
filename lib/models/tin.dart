import 'dart:convert';

import 'package:equatable/equatable.dart';

class TIN extends Equatable {
  final String userID;
  final String? taxNo;
  final String? reasonNoTIN;

  const TIN({
    required this.userID,
    this.taxNo,
    this.reasonNoTIN,
  });

  Map<String, dynamic> toMap() {
    return {
      'user': userID,
      "number": taxNo,
      "reason_no_tin": reasonNoTIN,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object> get props => [
        userID,
      ];
}
