import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/auth/pages/sign_up/email_sign_in/email_otp_sign_in_page.dart';
import 'package:geniuspay/app/auth/pages/sign_up/not_in_country.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/models/country.dart';
import 'package:geniuspay/repos/local_repo.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SelectCountryViewModel extends BaseModel {
  //list of all country
  List<Country> _countries = [];
  List<Country> get countries => _countries;

  //list of found Countries
  List<Country> _foundCountries = [];
  List<Country> get foundCountries => _foundCountries;

  void clearCountriesList() => _foundCountries.clear();

  /// Device country getter
  Country? _deviceCountry;
  Country? get deviceCountry => _deviceCountry;

  /// Country getter and setter
  Country? _country;
  Country? get country => _country;
  set country(Country? value) {
    _country = value;
    notifyListeners();
  }

  /// residenceCountry getter and setter
  Country? _residenceCountry;
  Country? get residenceCountry => _residenceCountry;
  set residenceCountry(Country? value) {
    _residenceCountry = value;
    notifyListeners();
  }

  /// countryOfBirth getter and setter
  Country? _countryOfBirth;
  Country? get countryOfBirth => _countryOfBirth;
  set countryOfBirth(Country? value) {
    _countryOfBirth = value;
    notifyListeners();
  }

  /// otherCountry getter and setter
  Country? _otherCountry;
  Country? get otherCountry => _otherCountry;
  set otherCountry(Country? value) {
    _otherCountry = value;
    notifyListeners();
  }

  final AuthenticationService _authenticationService =
      sl<AuthenticationService>();
  final LocalBase _localBase = sl<LocalBase>();
  BaseModelState baseModelState = BaseModelState.loading;
  BaseModelState searchCountryBaseModel = BaseModelState.success;
  void changeState(BaseModelState state) {
    baseModelState = state;
    notifyListeners();
  }

  void changeSearchCountryState(BaseModelState state) {
    searchCountryBaseModel = state;
    notifyListeners();
  }

// initialise vairables
  Future<void> init(BuildContext context) async {
    // if (deviceCountry == null || countries.isEmpty) {
    getCountries(context);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setDeviceCountry(context);
    });
    // }
  }

  Future<void> resetFoundCountries(BuildContext context) async {
    if (countries.isEmpty) {
      searchCountryBaseModel = BaseModelState.loading;

      await getCountries(context);
    }
    _foundCountries = countries;
    await Future.delayed(const Duration(milliseconds: 100));
    changeSearchCountryState(BaseModelState.success);
  }

  Future<void> searchCountry({
    required String keyword,
    required BuildContext context,
  }) async {
    changeSearchCountryState(BaseModelState.loading);
    // final result = await _authenticationService.searchCountry(keyword);
    // result.fold((l) async {
    //   changeSearchCountryState(BaseModelState.success);
    // }, (r) {
    //   _foundCountries = r;
    //   changeSearchCountryState(BaseModelState.success);
    // });
    final result = countries.where((element) =>
        element.name.toLowerCase().startsWith(keyword.toLowerCase()) ||
        element.currencyISO.toLowerCase().startsWith(keyword.toLowerCase()));
    _foundCountries = result.toList();
    changeSearchCountryState(BaseModelState.success);
  }

  Future<Country> getCountryFromIso(
      BuildContext context, String countryIso) async {
    if (countries.isEmpty) {
      await getCountries(context);
    }
    final result = countries.where((element) => element.iso2 == countryIso);
    return result.toList().first;
  }

  Future<void> getCountries(BuildContext context) async {
    final data = await DefaultAssetBundle.of(context)
        .loadString('assets/countries.json');
    final jsonResult = jsonDecode(data) as List<dynamic>?;
    _countries = CountrylList.fromJson(jsonResult!).list;
    _foundCountries = _countries;
    changeState(BaseModelState.success);
    // final result = await _authenticationService.fetchCountries();
    // result.fold((l) async {
    //   setError(l);
    //   changeState(BaseModelState.error);
    // }, (r) async {
    //   _countries = r;
    //   _foundCountries = r;
    //   changeState(BaseModelState.success);
    //   changeSearchCountryState(BaseModelState.success);
    // });
  }

  // get current location for users
  Future<Position?> determinePosition() async {
    try {
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return null;
      }
      if (permission == LocationPermission.deniedForever) return null;

      final position = await Geolocator.getCurrentPosition();
      return position;
    } catch (e) {
      return null;
    }
  }

  Future<void> setDeviceCountry(BuildContext context) async {
// first get location permission dialog
    final permissionStatus = await Geolocator.checkPermission();
    final result = permissionStatus == LocationPermission.always ||
            permissionStatus == LocationPermission.whileInUse
        ? true
        : await showMyDialog(context);

    if (result != null && result == true) {
      changeState(BaseModelState.loading);
      try {
        var position = await determinePosition();
        if (position != null) {
          List<Placemark> locations = await placemarkFromCoordinates(
            position.latitude,
            position.longitude,
          );
          if (locations.isNotEmpty) {
            final str = locations[0].country ?? '';
            final result = countries.where((element) =>
                element.name.toLowerCase().startsWith(str.toLowerCase()));
            final newCountry = result.toList().first;
            _countryOfBirth = newCountry;
            _country = newCountry;
            _residenceCountry = newCountry;
            _deviceCountry = newCountry;
          }
          changeState(BaseModelState.success);

          // final countries = await _authenticationService.searchCountry(str ?? '');
          // countries.fold((l) async {}, (r) {
          //   final newCountry = r.firstWhere(
          //     (country) => country.name.toLowerCase() == str?.toLowerCase(),
          //   );
          //   _countryOfBirth = newCountry;
          //   _country = newCountry;
          //   _residenceCountry = newCountry;
          //   _deviceCountry = newCountry;
          //   changeState(BaseModelState.success);
          // });
        } else {
          changeState(BaseModelState.success);
        }
      } catch (e) {
        changeState(BaseModelState.success);
      }
    } else {
      changeState(BaseModelState.success);
    }
  }

  Future<bool?> continueButton(BuildContext context) async {
    final result =
        await _authenticationService.isPermittedCountry(residenceCountry!.iso2);
    result.fold((l) async {
      // PopupDialogs(context)
      //     .errorMessage('Unable to verify right now, please try again');
      PopupDialogs(context).errorMessage(
          'An error occured while communication with server, please try again later');
    }, (r) {
      if (r) {
        _localBase.setdeviceCountry(country!.toJson());
        _localBase.setResidenceCountry(residenceCountry!.toJson());
        _localBase.setBirthCountry(countryOfBirth!.toJson());
        EmailOTPSignInPage.show(context);
      } else {
        NotInYourCountryPage.show(context, residenceCountry!);
      }
    });
    return null;
  }

  Future<void> addWaitlistUser(
      BuildContext context, String email, Country country) async {
    final result =
        await _authenticationService.addWaitlistUser(email, country.iso2);
    result.fold((l) async {
      PopupDialogs(context)
          .errorMessage('Unable to verify right now, please try again');
    }, (r) {
      PopupDialogs(context).successMessage(
          "You're now on our waitlist. We'll notify you when ready");
    });
  }

  Future<bool?> showMyDialog(BuildContext context) async {
    final textTheme = Theme.of(context).textTheme;

    return showDialog<bool?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const CircleAvatar(
            radius: 80,
            backgroundColor: AppColor.kAccentColor2,
            child: Icon(
              Icons.location_on,
              size: 80,
              color: AppColor.kErrorBorderColor,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('LOCATION',
                    textAlign: TextAlign.center,
                    style: textTheme.bodyLarge?.copyWith(letterSpacing: 2)),
                const Gap(24),
                Text(
                    'Please enable location access so we can verify your Country of residence',
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium),
                const Gap(48),
                Row(
                  children: [
                    Expanded(
                        child: CustomElevatedButton(
                      child: const Text('DENY'),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                    )),
                    Expanded(
                        child: CustomElevatedButton(
                      child: const Text('ALLOW'),
                      color: AppColor.kGoldColor2,
                      onPressed: () async {
                        final result = await Geolocator.requestPermission();
                        if (result == LocationPermission.always ||
                            result == LocationPermission.whileInUse) {
                          Navigator.pop(context, true);
                        }
                      },
                    ))
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
