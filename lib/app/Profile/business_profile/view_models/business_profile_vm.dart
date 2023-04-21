import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:geniuspay/app/Profile/business_profile/screens/registration_completed.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/core/errors/errors.dart';
import 'package:geniuspay/core/injections/injections.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/models/business_category.dart';
import 'package:geniuspay/models/business_profile_model.dart';
import 'package:geniuspay/models/company_type.dart';
import 'package:geniuspay/models/country.dart';
import 'package:geniuspay/repos/business_profile_repo.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class BusinessProfileVM extends BaseModel {
  final BusinessProfileRepository _businessProfileRepository =
      sl<BusinessProfileRepository>();

  BusinessProfileModel? businessProfile;
  List<CompanyType> companyTypes = [];
  List<BusinessCategory> businessCategories = [];

  BaseModelState baseModelState = BaseModelState.loading;

  void changeState(BaseModelState state) {
    baseModelState = state;
    notifyListeners();
  }

  Future<void> getBusinessDetails(String companyNumber) async {
    baseModelState = BaseModelState.loading;
    final result =
        await _businessProfileRepository.getBusinessDetails(companyNumber);
    result.fold((l) {
      changeState(BaseModelState.error);
    }, (r) {
      businessProfile = r;
      changeState(BaseModelState.success);
    });
  }

  Future<void> getCompanyTypesAndBusinessCategories(String countryIso) async {
    baseModelState = BaseModelState.loading;
    List<Either<Failure, List<dynamic>>> results = await Future.wait([
      _businessProfileRepository.getCompanyTypes(countryIso),
      _businessProfileRepository.getBusinessCategories()
    ]);
    if (results.map((e) => e.isRight()).toList().contains(false)) {
      changeState(BaseModelState.error);
    } else {
      results[0].fold((l) {}, (r) => companyTypes = r as List<CompanyType>);
      results[1].fold(
          (l) {}, (r) => businessCategories = r as List<BusinessCategory>);
      changeState(BaseModelState.success);
    }
  }

  Future<void> openBusinessAccount(BusinessProfileModel _businessProfile,
      String accountId, BuildContext context,
      {bool isAutomaticLEI = false,
      bool isAutomaticCompanyCode = false}) async {
    baseModelState = BaseModelState.loading;
    final result = await _businessProfileRepository.openBusinessAccount(
        _businessProfile, accountId, isAutomaticLEI, isAutomaticCompanyCode);
    await result.fold((l) {
      PopupDialogs(context)
          .errorMessage('Unable to set create Profile. Try again');
      changeState(BaseModelState.error);
    }, (r) async {
      businessProfile = r;
      final auth = sl<AuthenticationService>();
      await auth.getUser();
      await RegistrationCompleted.show(context);
      changeState(BaseModelState.success);
    });
  }

  Future<void> validateLEI(
    String leiCode,
    BuildContext context,
    Country country,
  ) async {
    baseModelState = BaseModelState.loading;
    final result = await _businessProfileRepository.validateLEI(leiCode);
    result.fold((l) {
      PopupDialogs(context).errorMessage('Invalid code entered');
      changeState(BaseModelState.error);
    }, (r) {
      if (r.registeredCountry == country.iso2) {
        businessProfile = r;
        changeState(BaseModelState.success);
      } else {
        PopupDialogs(context).errorMessage('Invalid LEI country');
        changeState(BaseModelState.error);
      }
    });
  }

  Future<void> validateCompanyCode(
    String companyCode,
    String countryIso,
    BuildContext context,
  ) async {
    baseModelState = BaseModelState.loading;
    final result = await _businessProfileRepository.validateCompanyCode(
        companyCode, countryIso);
    result.fold((l) {
      PopupDialogs(context).errorMessage('Invalid company code');
      changeState(BaseModelState.error);
    }, (r) {
      businessProfile = r;
      changeState(BaseModelState.success);
    });
  }
}
