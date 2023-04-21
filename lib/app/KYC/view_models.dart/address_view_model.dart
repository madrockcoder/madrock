import 'package:flutter/material.dart';
import 'package:geniuspay/app/auth/pages/sign_up/widgets/validators.dart';
import 'package:geniuspay/app/auth/view_models/select_country_view_model.dart';
import 'package:geniuspay/app/home/pages/home_containter.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/models/country.dart';
import 'package:geniuspay/models/kyc_address.dart';
import 'package:geniuspay/repos/local_repo.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/services/kyc_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AddressViewModel extends BaseModel with AddressValidators {
  final SelectCountryViewModel _selectCountryViewModel =
      sl<SelectCountryViewModel>();
  final AuthenticationService _authenticationService =
      sl<AuthenticationService>();
  final Kycservice _kycService = sl<Kycservice>();
  final LocalBase _localBase = sl<LocalBase>();

  //Country getter and setter
  Country? _country;
  Country? get country => _country;
  set setCountry(Country selectedCountry) {
    _country = selectedCountry;
    notifyListeners();
  }

  //Postal Code getter and setter
  String? _postalCode;
  String? get postalCode => _postalCode;
  set setPostalCode(String val) {
    _postalCode = val;
    notifyListeners();
  }

  //State getter and setter
  String? _state;
  String? get state => _state;
  set setState(String val) {
    _state = val;
    notifyListeners();
  }

  //City getter and setter
  String? _city;
  String? get city => _city;
  set setCity(String val) {
    _city = val;
    notifyListeners();
  }

  //Street getter and setter
  String? _street;
  String? get street => _street;
  set setStreet(String val) {
    _street = val;
    notifyListeners();
  }

  //House No getter and setter
  String? _houseNo;
  String? get houseNo => _houseNo;
  set setHouseNo(String val) {
    _houseNo = val;
    notifyListeners();
  }

  //Apartment No getter and setter
  String? _aptNo;
  String? get aptNo => _aptNo;
  set setAptNo(String val) {
    _aptNo = val;
    notifyListeners();
  }

  KYCAddress? _address;
  KYCAddress? get address => _address;

  //Init Function
  void init(BuildContext context) async {
    await _selectCountryViewModel.init(context);
    setBusy(value: false);
  }

  bool disableButton() {
    if ((country!.name.isNotEmpty) &&
        (addressValidator.isValidAlphabetText(city ?? "")) &&
        (postalCode!.isNotEmpty &&
            RegExp(r'[a-z]').hasMatch(postalCode ?? "")) &&
        (addressValidator.isValidAlphabetText(state ?? "")) &&
        (houseNo!.isNotEmpty) &&
        (street!.isNotEmpty)) {
      return true;
    } else {
      return false;
    }
  }

  //Set Address
  setAddress() {
    _address = KYCAddress(
        userId: _authenticationService.user!.id,
        addressLine1: (aptNo == null || aptNo!.isEmpty)
            ? "$street $houseNo"
            : "$street $houseNo/$aptNo",
        city: city!,
        state: state!.isEmpty ? country!.name : state!,
        postCode: postalCode!,
        addressProofType: 'bank_statement');
    notifyListeners();
  }

  //Set AddressLine 2
  void setAddressLine2(String addressLine2) {
    _address = KYCAddress(
        userId: _authenticationService.user!.id,
        addressLine1: _address!.addressLine1,
        addressLine2: addressLine2,
        city: _address!.city,
        state: _address!.state,
        postCode: _address!.postCode,
        addressProofType: 'bank_statement');
    notifyListeners();
  }

  //Search Country
  Future<void> searchCountry(BuildContext context) async {
    if (_authenticationService.user?.userProfile.countryIso2 == null ||
        _authenticationService.user!.userProfile.countryIso2!.isEmpty) {
      final result = _localBase.getResidenceCountry();
      if (result != null) {
        _country = result;
        notifyListeners();
      }
    } else {
      final result = await _selectCountryViewModel.getCountryFromIso(
          context, _authenticationService.user!.userProfile.countryIso2!);
      _country = result;
      notifyListeners();
    }
  }

  //Get name
  String getName() {
    String? firstName = _authenticationService.user?.firstName;
    String? lastName = _authenticationService.user?.lastName;
    String? name = _authenticationService.user?.name;
    if (name != null) {
      return name;
    } else {
      return "$firstName $lastName";
    }
  }

  //Verify Address
  Future<void> verifyAddress(BuildContext context) async {
    final result = await _kycService.kycAddressVerification(address!);
    result.fold((l) async {
      PopupDialogs(context)
          .errorMessage("Unable to set address. Please try again");
    }, (r) {
      HomeWidget.show(context,
          showSuccessDialog: 'Updated address successfully');
    });
  }
}
