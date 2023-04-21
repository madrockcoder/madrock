import 'dart:convert';

import 'package:equatable/equatable.dart';

enum DocumentType { residentPermit, idCard, passport, driversLicense }

class KYC extends Equatable {
  final String uid;
  final String documentIssuingCountry;
  final DocumentType documentType;
  const KYC({
    required this.uid,
    required this.documentIssuingCountry,
    required this.documentType,
  });

  Map<String, dynamic> toMap() {
    return {
      'user': uid,
      'document_issuing_country': documentIssuingCountry,
      'document_type': getDocumentType(documentType),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object> get props => [uid, documentIssuingCountry, documentType];

  @override
  String toString() =>
      'KYC(uid: $uid, documentIssuingCountry: $documentIssuingCountry, documentType: $documentType)';
}

String getDocumentType(DocumentType documentType) {
  switch (documentType) {
    case DocumentType.residentPermit:
      return 'RESIDENCE_PERMIT';
    case DocumentType.idCard:
      return 'ID_CARD';
    case DocumentType.passport:
      return 'PASSPORT';
    case DocumentType.driversLicense:
      return 'DRIVERS_LICENSE';
  }
}
