import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:geniuspay/core/errors/error.dart';
import 'package:geniuspay/core/network/http_requester.dart';
import 'package:geniuspay/core/network/network_info.dart';
import 'package:geniuspay/models/business_category.dart';
import 'package:geniuspay/models/business_profile_model.dart';
import 'package:geniuspay/models/company_type.dart';
import 'package:geniuspay/repos/api_path.dart';
import 'package:geniuspay/util/essentials.dart';
import 'package:geniuspay/util/security.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

abstract class BusinessProfileDataSource {
  Future<BusinessProfileModel> getBusinessDetails(String companyNumber);

  Future<List<CompanyType>> getCompanyTypes(String countryIso);

  Future<List<BusinessCategory>> getBusinessCategories();

  Future<BusinessProfileModel> openBusinessAccount(
      BusinessProfileModel businessProfileModel,
      String accountId,
      bool isAutomaticLEI,
      bool isAutomaticCompanyCode);

  Future<BusinessProfileModel> validateLEI(String leiCode);

  Future<BusinessProfileModel> validateCompanyCode(
      String companyCode, String countryIso);
}

@LazySingleton(as: BusinessProfileDataSource)
class BusinessProfileDataSourceImpl
    with HMACSecurity
    implements BusinessProfileDataSource {
  BusinessProfileDataSourceImpl(
      {required this.networkInfo, required this.dio, required this.httpClient});

  final NetworkInfo networkInfo;
  final Dio dio;
  final HttpServiceRequester httpClient;

  @override
  Future<BusinessProfileModel> getBusinessDetails(String companyNumber) async {
    if (await networkInfo.isConnected) {
      final result = await httpClient.getRequest(
          endpoint: APIPath.getBusinessDetails(companyNumber));
      final body = result.data;
      return BusinessProfileModel.fromJson(body);
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<List<CompanyType>> getCompanyTypes(String countryIso) async {
    if (await networkInfo.isConnected) {
      final result = await httpClient.getRequest(
          endpoint: APIPath.getCompanyTypes(countryIso));
      final types = result.data['results'];
      return CompanyTypeList.fromJson(types).list;
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<List<BusinessCategory>> getBusinessCategories() async {
    if (await networkInfo.isConnected) {
      final result =
          await httpClient.getRequest(endpoint: APIPath.getBusinessCategories);
      final types = result.data['results'];
      return BusinessCategoryList.fromJson(types).list;
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<BusinessProfileModel> openBusinessAccount(
      BusinessProfileModel businessProfileModel,
      String accountId,
      bool isAutomaticLEI,
      bool isAutomaticCompanyCode) async {
    businessProfileModel.user = accountId;
    businessProfileModel.serviceAddress ??=
        businessProfileModel.registeredAddress;
    Map<String, dynamic> businessProfileModelMap =
        businessProfileModel.toJson();
    businessProfileModelMap['directors'] =
        businessProfileModelMap['directors'].map((e) => removeNull(e)).toList();
    businessProfileModelMap = businessProfileModelMap.map((key, value) {
      if (value.runtimeType == IdName) {
        return MapEntry(key, (value as IdName).id);
      } else {
        return MapEntry(key, value);
      }
    });
    if (isAutomaticLEI) {
      List<String> requiredFields = [
        'user',
        'legal_entity_identifier',
        'legal_entity_type',
        'nature_of_business',
        'tax_number',
        'category',
        'sub_category',
        'website',
        'directors',
        'beneficial_owners',
        'business_assessment'
      ];
      businessProfileModelMap
          .removeWhere((key, value) => !requiredFields.contains(key));
    } else if (isAutomaticCompanyCode) {
      // List<String> requiredFields = [ // change here
      //   'user',
      //   'legal_entity_identifier',
      //   'legal_entity_type',
      //   'nature_of_business',
      //   'tax_number',
      //   'category',
      //   'sub_category',
      //   'website',
      //   'directors',
      //   'beneficial_owners',
      //   'business_assessment'
      // ];
      // businessProfileModelMap
      //     .removeWhere((key, value) => !requiredFields.contains(key));
    } else {
      businessProfileModelMap['legal_entity_identifier'] = "";
    }
    businessProfileModelMap = removeNull(businessProfileModelMap);
    log(jsonEncode(businessProfileModelMap));
    if (await networkInfo.isConnected) {
      var uuid = const Uuid().v4();
      final result = await httpClient.post(
          endpoint: isAutomaticLEI
              ? APIPath.openBusinessAccountUsingLei(accountId)
              : APIPath.openBusinessAccount(accountId),
          uuid: uuid,
          body: businessProfileModelMap);
      return businessProfileModel;
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<BusinessProfileModel> validateLEI(String leiCode) async {
    if (await networkInfo.isConnected) {
      var body = <String, dynamic>{};
      final result =
          await httpClient.getRequest(endpoint: APIPath.validateLEI(leiCode));
      body = result.data as Map<String, dynamic>;
      body['category'] = null;
      body['business_name'] = body['company_name'];
      body['legal_entity_identifier'] = body['LEI'];
      body['registered_country'] = body['jurisdiction'];
      log(jsonEncode(body));
      return BusinessProfileModel.fromJson(body);
    } else {
      throw NoInternetException();
    }
  }

  @override
  Future<BusinessProfileModel> validateCompanyCode(
      String companyCode, String countryIso) async {
    if (await networkInfo.isConnected) {
      final result = await httpClient.getRequest(
          endpoint: APIPath.validateCompanyCode(companyCode, countryIso));
      final body = result.data;
      body['category'] = null;
      body['business_name'] = body['company_name'];
      body['legal_entity_identifier'] = body['LEI'];
      body['registered_country'] = body['jurisdiction'];
      log(jsonEncode(body));
      return BusinessProfileModel.fromJson(body);
    } else {
      throw NoInternetException();
    }
  }
}
