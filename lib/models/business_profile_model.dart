import 'package:flutter/material.dart';
import 'package:geniuspay/util/essentials.dart';

class BusinessProfileModel {
  BusinessProfileModel(
      {this.id,
      this.user,
      this.businessName,
      this.tradingName,
      this.registeredDate,
      this.legalEntityType,
      this.registrationNumber,
      this.registeredCountry,
      this.taxNumber,
      this.businessLicenseNumber,
      this.businessLicenseExpiry,
      this.registrationAuthority,
      this.registeredAddress,
      this.serviceAddress,
      this.website,
      this.verificationAt,
      this.verificationStatus,
      this.directors,
      this.beneficialOwners,
      this.status,
      this.legalEntityIdentifier,
      this.category,
      this.subCategory,
      this.natureOfBusiness,
      this.businessAssessment,
      this.reviewedAt,
      this.createdAt,
      this.updatedAt,
      this.structureVerification});

  factory BusinessProfileModel.fromJson(Map<String, dynamic> json) =>
      BusinessProfileModel(
          id: json['id'] as String,
          user: json['user'] as String,
          businessName: json['business_name'] as String,
          tradingName: json['trading_name'] as String,
          registeredDate: json['registered_date'] as String,
          legalEntityType: json['legal_entity_type'] != null
              ? IdName.fromJson(
                  json['legal_entity_type'] as Map<String, dynamic>)
              : null,
          registrationNumber: json['registration_number'] as String,
          registeredCountry: json['registered_country'] as String,
          taxNumber: json['tax_number'] as String,
          businessLicenseNumber: json['business_license_number'] as String,
          businessLicenseExpiry: json['business_license_expiry'] as String,
          registrationAuthority: json['registration_authority'] as String,
          registeredAddress: json['registered_address'] != null
              ? RegisteredAddress.fromJson(
                  json['registered_address'] as Map<String, dynamic>)
              : null,
          serviceAddress: json['service_address'] != null
              ? RegisteredAddress.fromJson(
                  json['service_address'] as Map<String, dynamic>)
              : null,
          website: json['website'] as String,
          verificationAt: json['verification_at'] as String,
          verificationStatus: json['verification_status'] as String,
          directors: json['directors'] != null
              ? BusinessDirectorList.fromJson(
                  json['directors'] as List<BusinessDirector>,
                ).list
              : null,
          beneficialOwners: json['beneficial_owners'] != null
              ? BusinessOwnerList.fromJson(
                      json['beneficial_owners'] as List<BusinessOwner>)
                  .list
              : null,
          status: json['status'] as String,
          legalEntityIdentifier: json['legal_entity_identifier'] as String,
          category: json['category'] != null
              ? IdName.fromJson(json['category'] as Map<String, dynamic>)
              : null,
          subCategory: json['sub_category'] != null
              ? IdName.fromJson(json['sub_category'] as Map<String, dynamic>)
              : null,
          natureOfBusiness: json['nature_of_business'] as String,
          businessAssessment: json['business_assessment'] != null
              ? BusinessAssessment.fromJson(
                  json['business_assessment'] as Map<String, dynamic>)
              : null,
          reviewedAt: json['reviewed_at'] as String,
          createdAt: json['created_at'] as String,
          updatedAt: json['updated_at'] as String,
          structureVerification: json['structure_verification'] as String);
  String? id;
  String? user;
  String? businessName;
  String? tradingName;
  String? registeredDate;
  IdName? legalEntityType;
  String? registrationNumber;
  String? registeredCountry;
  String? taxNumber;
  String? businessLicenseNumber;
  String? businessLicenseExpiry;
  String? registrationAuthority;
  RegisteredAddress? registeredAddress;
  RegisteredAddress? serviceAddress;
  String? website;
  String? verificationAt;
  String? verificationStatus;
  List<BusinessDirector>? directors;
  List<BusinessOwner>? beneficialOwners;
  String? status;
  String? legalEntityIdentifier;
  IdName? category;
  IdName? subCategory;
  String? natureOfBusiness;
  BusinessAssessment? businessAssessment;
  String? reviewedAt;
  String? createdAt;
  String? updatedAt;
  String? structureVerification;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['user'] = user;
    data['business_name'] = businessName;
    data['trading_name'] = tradingName;
    data['registered_date'] = registeredDate;
    data['legal_entity_type'] = legalEntityType;
    data['registration_number'] = registrationNumber;
    data['registered_country'] = registeredCountry;
    data['tax_number'] = taxNumber;
    data['business_license_number'] = businessLicenseNumber;
    data['business_license_expiry'] = businessLicenseExpiry;
    data['registration_authority'] = registrationAuthority;
    if (registeredAddress != null) {
      data['registered_address'] = removeNull(registeredAddress!.toJson());
    }
    if (serviceAddress != null) {
      data['service_address'] = removeNull(serviceAddress!.toJson());
    }
    data['website'] = website;
    data['verification_at'] = verificationAt;
    data['verification_status'] = verificationStatus;
    data['directors'] = directors?.map((e) => removeNull(e.toJson())).toList();
    data['beneficial_owners'] =
        beneficialOwners?.map((e) => removeNull(e.toJson())).toList();
    data['status'] = status;
    data['legal_entity_identifier'] = legalEntityIdentifier;
    data['category'] = category;
    data['sub_category'] = subCategory;
    data['nature_of_business'] = natureOfBusiness;
    if (businessAssessment != null) {
      data['business_assessment'] = businessAssessment!.toJson();
    }
    data['reviewed_at'] = reviewedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['structure_verification'] = structureVerification;
    return data;
  }

  String getRegisteredAddress() {
    return '${registeredAddress!.addressLine1!}'
        '${registeredAddress!.addressLine2 != null ? ',  '
            '${registeredAddress!.addressLine2}' : ''}, '
        '${registeredAddress!.city!}, '
        '${registeredAddress!.stateOrProvince!}, '
        '${registeredAddress!.country!} - '
        '${registeredAddress!.zipCode!}';
  }

  String getServiceAddress() {
    return '${serviceAddress!.addressLine1!}'
        '${registeredAddress!.addressLine2 != null ? ',  '
            '${registeredAddress!.addressLine2}' : ''}, '
        '${serviceAddress!.city!}, ${serviceAddress!.stateOrProvince!}, '
        '${serviceAddress!.country!} - ${serviceAddress!.zipCode!}';
  }
}

class RegisteredAddress {
  RegisteredAddress(
      {this.id,
      this.business,
      this.addressLine1,
      this.addressLine2,
      this.city,
      this.stateOrProvince,
      this.zipCode,
      this.country,
      this.status,
      this.createdAt,
      this.updatedAt});

  factory RegisteredAddress.fromJson(Map<String, dynamic> json) =>
      RegisteredAddress(
        id: json['id'] as String,
        business: json['business'] as String,
        addressLine1: json['address_line_1'] as String,
        addressLine2: json['address_line_2'] as String,
        city: json['city'] as String,
        stateOrProvince: json['state_or_province'] as String,
        zipCode: json['zip_code'] as String,
        country: json['country'] as String,
        status: json['status'] as String,
        createdAt: json['created_at'] as String,
        updatedAt: json['updated_at'] as String,
      );
  String? id;
  String? business;
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? stateOrProvince;
  String? zipCode;
  String? country;
  String? status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['business'] = business;
    data['address_line_1'] = addressLine1;
    data['address_line_2'] = addressLine2;
    data['city'] = city;
    data['state_or_province'] = stateOrProvince;
    data['zip_code'] = zipCode;
    data['country'] = country;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class BusinessAssessment {
  BusinessAssessment(
      {this.annualTurnover,
      this.countriesOfOperation,
      this.countriesOfOutgoingPayments,
      this.countriesOfIncomingPayments,
      this.sourceOfFunds,
      this.avgIncomingTransactionSize,
      this.monthlyTurnoverIncoming,
      this.monthlyFrequencyIncoming,
      this.avgOutgoingTransactionSize,
      this.monthlyTurnoverOutgoing,
      this.monthlyFrequencyOutgoing,
      this.totalEmployees,
      this.verificationStatus});

  factory BusinessAssessment.fromJson(Map<String, dynamic> json) =>
      BusinessAssessment(
          annualTurnover: json['annual_turnover'] as String,
          countriesOfOperation:
              List<String>.from(json['countries_of_operation'] as List<String>),
          countriesOfOutgoingPayments: List<String>.from(
              json['countries_of_outgoing_payments'] as List<String>),
          countriesOfIncomingPayments: List<String>.from(
              json['countries_of_incoming_payments'] as List<String>),
          sourceOfFunds: json['source_of_funds'] as String,
          avgIncomingTransactionSize:
              json['avg_incoming_transaction_size'] as String,
          monthlyTurnoverIncoming: json['monthly_turnover_incoming'] as String,
          monthlyFrequencyIncoming:
              json['monthly_frequency_incoming'] as String,
          avgOutgoingTransactionSize:
              json['avg_outgoing_transaction_size'] as String,
          monthlyTurnoverOutgoing: json['monthly_turnover_outgoing'] as String,
          monthlyFrequencyOutgoing:
              json['monthly_frequency_outgoing'] as String,
          totalEmployees: json['total_employees'] as String,
          verificationStatus: json['verification_status'] as String);
  String? annualTurnover;
  List<String>? countriesOfOperation;
  List<String>? countriesOfOutgoingPayments;
  List<String>? countriesOfIncomingPayments;
  String? sourceOfFunds;
  String? avgIncomingTransactionSize;
  String? monthlyTurnoverIncoming;
  String? monthlyFrequencyIncoming;
  String? avgOutgoingTransactionSize;
  String? monthlyTurnoverOutgoing;
  String? monthlyFrequencyOutgoing;
  String? totalEmployees;
  String? verificationStatus;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['annual_turnover'] = annualTurnover;
    data['countries_of_operation'] = countriesOfOperation;
    data['countries_of_outgoing_payments'] = countriesOfOutgoingPayments;
    data['countries_of_incoming_payments'] = countriesOfIncomingPayments;
    data['source_of_funds'] = sourceOfFunds;
    data['avg_incoming_transaction_size'] = avgIncomingTransactionSize;
    data['monthly_turnover_incoming'] = monthlyTurnoverIncoming;
    data['monthly_frequency_incoming'] = monthlyFrequencyIncoming;
    data['avg_outgoing_transaction_size'] = avgOutgoingTransactionSize;
    data['monthly_turnover_outgoing'] = monthlyTurnoverOutgoing;
    data['monthly_frequency_outgoing'] = monthlyFrequencyOutgoing;
    data['total_employees'] = totalEmployees;
    data['verification_status'] = verificationStatus;
    return data;
  }
}

class BusinessOwner {
  BusinessOwner(
      {required this.firstName,
      required this.lastName,
      required this.percentage,
      required this.dob,
      this.address});

  factory BusinessOwner.fromJson(Map<String, dynamic> json) => BusinessOwner(
        firstName: json['first_name'] as String,
        lastName: json['last_name'] as String,
        dob: json['birth_date'] as String,
        percentage: json['percentage_shares'] as double,
        address:
            RegisteredAddress.fromJson(json['address'] as Map<String, dynamic>),
      );
  final String firstName;
  TextEditingController firstNameController = TextEditingController();
  FocusNode firstNameFocusNode = FocusNode();
  final String lastName;
  TextEditingController lastNameController = TextEditingController();
  FocusNode lastNameFocusNode = FocusNode();
  final String dob;
  TextEditingController dobController = TextEditingController();
  FocusNode dobFocusNode = FocusNode();
  final double percentage;
  TextEditingController percentageController = TextEditingController();
  FocusNode percentageFocusNode = FocusNode();
  final RegisteredAddress? address;

  Map<String, Object?> toJson() => {
        'first_name': firstName,
        'last_name': lastName,
        'birth_date': dob,
        'percentage_shares': percentage,
        'address': address?.toJson()
      };
}

class BusinessOwnerList {
  BusinessOwnerList({required this.list});

  factory BusinessOwnerList.fromJson(List parsedJson) {
    final list = parsedJson.map((value) {
      return BusinessOwner.fromJson(value as Map<String, dynamic>);
    }).toList();
    return BusinessOwnerList(list: list);
  }

  final List<BusinessOwner> list;
}

class BusinessDirector {
  BusinessDirector(
      {required this.firstName,
      required this.lastName,
      this.dob,
      this.address});

  factory BusinessDirector.fromJson(Map<String, dynamic> json) =>
      BusinessDirector(
        firstName: json['first_name'] as String,
        lastName: json['last_name'] as String,
        dob: json['birth_date'] as String,
        address:
            RegisteredAddress.fromJson(json['address'] as Map<String, dynamic>),
      );
  final String firstName;
  TextEditingController firstNameController = TextEditingController();
  FocusNode firstNameFocusNode = FocusNode();
  final String lastName;
  TextEditingController lastNameController = TextEditingController();
  FocusNode lastNameFocusNode = FocusNode();
  final String? dob;
  TextEditingController dobController = TextEditingController();
  FocusNode dobFocusNode = FocusNode();

  final RegisteredAddress? address;

  Map<String, Object?> toJson() => {
        'first_name': firstName,
        'last_name': lastName,
        'birth_date': dob,
        'address': address?.toJson()
      };
}

class BusinessDirectorList {
  BusinessDirectorList({required this.list});

  factory BusinessDirectorList.fromJson(List parsedJson) {
    final list = parsedJson.map((value) {
      return BusinessDirector.fromJson(value as Map<String, dynamic>);
    }).toList();
    return BusinessDirectorList(list: list);
  }

  final List<BusinessDirector> list;
}

class IdName {
  factory IdName.fromJson(Map<String, dynamic> json) =>
      IdName(json['name'] as String, json['id'] as String);

  IdName(this.name, this.id);
  final String name;
  final String id;

  Map<String, dynamic> toJson() => {'name': name, 'id': id};
}
