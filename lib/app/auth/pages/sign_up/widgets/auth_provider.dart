import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:geniuspay/models/country.dart';
import 'package:geniuspay/models/create_user.dart';
import 'package:geniuspay/models/notification_option.dart';
import 'package:geniuspay/models/reason.dart';
import 'package:geniuspay/repos/auth.dart';
import 'package:geniuspay/util/constants.dart';
import 'package:geniuspay/util/enum_converter.dart';
import 'package:geniuspay/util/enums.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class AuthProvider with ChangeNotifier, EnumConverter {
  String firstName;
  String lastName;
  Country? userCountry;
  String email;
  String password;
  String otp;
  String token;
  String pin;
  String changePin;
  String confirmPin;
  bool pinVerified;
  String uid;
  Position? devicePosition;
  Country? deviceCountry;
  NotificationOption? notificationOption;
  NotificationOption? fetchedNotifOption;
  ReasonForClosure? reasonForClosure;
  String mobileNumber;
  Country? addressCountry;
  UserType userType;
  BusinessType businessType;
  File? userAvatar;
  Country? country;
  Country? residenceCountry;
  Country? countryOfBirth;
  Country? otherCountry;
  String? phoneCode;
  final AuthBase auth;
  AuthType? authType;

  AuthProvider({
    this.firstName = '',
    this.lastName = '',
    this.userCountry,
    this.email = '',
    this.password = '',
    this.otp = '',
    this.token = '',
    this.pin = '',
    this.changePin = '',
    this.confirmPin = '',
    this.pinVerified = false,
    this.uid = '',
    this.devicePosition,
    this.deviceCountry,
    this.notificationOption,
    this.fetchedNotifOption,
    this.reasonForClosure,
    this.mobileNumber = '',
    this.userType = UserType.personal,
    this.businessType = BusinessType.company,
    this.userAvatar,
    this.country,
    this.residenceCountry,
    this.countryOfBirth,
    this.otherCountry,
    this.phoneCode = '',
    required this.auth,
    this.authType = AuthType.logIn,
  }) {
    setDeviceCountry();
  }

  var isLoading = false;
  var canContinue = false;

  final _countries = <Country>[];
  List<Country> get countries => _countries;

  final _reasons = <Reason>[];
  List<Reason> get reasons => _reasons;

  bool get isUserVerified =>
      auth.user!.userProfile.verificationStatus == VerificationStatus.verified;

  void setCanContinue(bool cont) {
    canContinue = cont;
    notifyListeners();
  }

  // int getVerificationPercentage() {
  //   final user = auth.user!;
  //   final status = user.userProfile.verificationStatus;
  //   final onboardStatus = user.userProfile.onboardingStatus;
  //   if (onboardStatus == OnboardingStatus.assessmentRequired) {
  //     return 20;
  //   } else if (onboardStatus == OnboardingStatus.taxDeclarationRequired) {
  //     return 40;
  //   } else if (onboardStatus == OnboardingStatus.taxDeclarationSubmitted) {
  //     return 60;
  //   } else if (onboardStatus == OnboardingStatus.addressRequired) {
  //     return 80;
  //   } else if (status == VerificationStatus.pending) {
  //     return 90;
  //   } else if (status == VerificationStatus.verified) {
  //     return 100;
  //   } else {
  //     return 5;
  //   }
  // }

  Future<String?> convertToBase64(File? file) async {
    if (file == null) return null;
    var imageBytes = await file.readAsBytes();
    var base64string = base64.encode(imageBytes);

    return base64string;
  }

  String getUserAddress() {
    final address = auth.user!.userProfile.addresses;
    var finalAddress = '';
    if (address!.addressLine1.isNotEmpty) {
      finalAddress =
          '${address.addressLine1}, ${address.city} ${address.state}, ${address.zipCode}, ${address.countryIso2}';
    }
    return finalAddress;
  }

  Future<String> emailOTPSignIn() async {
    try {
      isLoading = true;
      notifyListeners();
      final response = await auth.emailOTPSignIn(email);

      isLoading = false;
      notifyListeners();
      return response;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<String> verifyOTP() async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await auth.verifyOTP(email: email, otp: otp);

      isLoading = false;
      notifyListeners();
      return response;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<bool> closeAccountCheck() async {
    try {
      isLoading = true;
      notifyListeners();
      final res = await auth.closeAccountCheck();

      isLoading = false;
      notifyListeners();
      return res;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  bool validatePIN() {
    final found =
        commonlyUsedPins.firstWhere((e) => pin == e, orElse: () => 'null');
    return found == 'null';
  }

  Future<void> setPIN() async {
    try {
      isLoading = true;
      notifyListeners();
      await getUserId();
      await auth.setPIN(uid: uid, pin: confirmPin);

      isLoading = false;
      notifyListeners();
      // return response;

    } catch (e) {
      isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> updatePIN() async {
    try {
      await auth.updatePIN(oldPIN: pin, newPIN: changePin);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> verifyUserPin() async {
    return await auth.verifyUserPin(pin);
  }

  void lockUserAcc() {
    auth.lockUserAcc();
  }

  Future<void> setNotificationOption() async {
    try {
      isLoading = true;
      notifyListeners();
      await auth.setNotificationOption(notificationOption!);
      await fetchNotificationOption();
      isLoading = false;
      notifyListeners();
      // return response;

    } catch (e) {
      isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> fetchNotificationOption() async {
    try {
      // final options = await auth.fetchNotificationOption();
      // updateWith(fetchedNotifOption: options);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setAvatar() async {
    try {
      isLoading = true;
      notifyListeners();
      await auth.setAvatar((await convertToBase64(userAvatar))!);
      await getUserId();

      isLoading = false;
      notifyListeners();
      // return response;

    } catch (e) {
      isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> postMobileNumber() async {
    try {
      await auth.postMobileNumber(mobileNumber);
      await getUserId();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> confirmMobileNumber() async {
    // try {
    //   await auth.confirmMobileNumber(token);
    //   await getUserId();
    // } catch (e) {
    //   rethrow;
    // }
  }

  Future<void> getUserId() async {
    try {
      isLoading = true;
      notifyListeners();
      final user = await auth.getUser();
      updateWith(uid: user.id);

      isLoading = false;
      notifyListeners();
      // return response;

    } catch (e) {
      isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> getCountries(String searchTerm) async {
    try {
      clearCountriesList();
      isLoading = true;
      notifyListeners();
      final foundCountries = await auth.fetchCountries(searchTerm);
      clearCountriesList();
      _countries.addAll(foundCountries);
      notifyListeners();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Country getCountryFromIso2(String iso2) =>
      countries.firstWhere((country) => country.iso2 == iso2);

  void clearCountriesList() => _countries.clear();

  void addReason(Reason reason) {
    if (!_reasons
        .contains(_reasons.firstWhereOrNull((element) => element == reason))) {
      _reasons.add(reason);
      notifyListeners();
    } else {
      _reasons.remove(reason);
      notifyListeners();
    }
  }

  bool isSelected(Reason reason) {
    return _reasons.contains(reason);
  }

  String encryptedEmail() {
    if (email.isNotEmpty) {
      final splitted = email.split('@');
      final mail = splitted[0];
      var encryptEmail = '';
      for (var i = 0; i < mail.length; i++) {
        encryptEmail += '*';
      }
      return '$encryptEmail@${splitted.last}';
    } else {
      return '*******@mail.com';
    }
  }

  String encryptedNumber() {
    updateWith(mobileNumber: auth.user!.userProfile.mobileNumber!.number);

    if (mobileNumber.isNotEmpty) {
      final splitted = mobileNumber.split(phoneCode ?? '+');
      final number = splitted[1];
      var encryptNumber = '';
      encryptNumber += phoneCode ?? '+';
      for (var i = 0; i < number.length - 3; i++) {
        encryptNumber += '*';
      }
      encryptNumber += number[number.length - 3];
      encryptNumber += number[number.length - 2];
      encryptNumber += number[number.length - 1];
      return encryptNumber;
    } else {
      return '********';
    }
  }

  Future<void> updateUser() async {
    try {
      isLoading = true;
      notifyListeners();
      final user = CreateUser(
          accountType: userType == UserType.business ? 'BUSINESS' : 'PERSONAL',
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
          country: country!.iso2);
      final response = await auth.updateUser(user);
      isLoading = false;
      notifyListeners();
      return response;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> reasonForUsingApp() async {
    try {
      isLoading = true;
      notifyListeners();
      await auth.reasonForUsingApp(_reasons);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<bool> checkEmailExists() async {
    try {
      isLoading = true;
      notifyListeners();

      await auth.checkEmailExists(email);
      isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> closeAccount() async {
    try {
      isLoading = true;
      await auth.closeAccount(getReasonForClosureRequestText(reasonForClosure));
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      isLoading = true;
      await auth.logout();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> determinePosition() async {
    if (devicePosition != null) return;
    try {
      LocationPermission permission;
      // serviceEnabled = await Geolocator.isLocationServiceEnabled();

      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return;
      }

      if (permission == LocationPermission.deniedForever) return;

      final position = await Geolocator.getCurrentPosition();
      updateWith(devicePosition: position);
    } catch (e) {
      return;
    }
  }

  Future<void> setDeviceCountry() async {
    try {
      await determinePosition();
      if (devicePosition == null) return;
      List<Placemark> locations = await placemarkFromCoordinates(
        devicePosition!.latitude,
        devicePosition!.longitude,
      );

      final str = locations[0].country;

      final countries = await auth.fetchCountries(str ?? '');
      final country = countries.firstWhere(
        (country) => country.name.toLowerCase() == str?.toLowerCase(),
      );
      updateWith(country: country);
      updateWith(residenceCountry: country);
      updateWith(deviceCountry: country);
      notifyListeners();
    } catch (e) {
      return;
    }
  }

  List<String> toggleAuthPageText() {
    if (authType == AuthType.signUp) {
      return ['Already have an account', '  Login'];
    } else {
      return ['Don\'t have an account yet', '  Register'];
    }
  }

  void updateWith({
    String? uid,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? mobileNumber,
    Country? userCountry,
    File? userAvatar,
    Country? country,
    Country? residenceCountry,
    Country? countryOfBirth,
    Country? otherCountry,
    UserType? userType,
    BusinessType? businessType,
    String? otp,
    String? token,
    String? confirmPin,
    String? pin,
    String? changePin,
    String? phoneCode,
    Position? devicePosition,
    bool? pinVerified,
    Country? deviceCountry,
    Country? addressCountry,
    ReasonForClosure? reasonForClosure,
    String? kycURL,
    NotificationOption? notificationOption,
    NotificationOption? fetchedNotifOption,
    AuthType? authType,
  }) {
    this.uid = uid ?? this.uid;
    this.firstName = firstName ?? this.firstName;
    this.lastName = lastName ?? this.lastName;
    this.otp = otp ?? this.otp;
    this.confirmPin = confirmPin ?? this.confirmPin;
    this.mobileNumber = mobileNumber ?? this.mobileNumber;
    this.userAvatar = userAvatar ?? this.userAvatar;
    this.userType = userType ?? this.userType;
    this.token = token ?? this.token;
    this.pin = pin ?? this.pin;
    this.changePin = changePin ?? this.changePin;
    this.pinVerified = pinVerified ?? this.pinVerified;
    this.userCountry = userCountry ?? this.userCountry;
    this.phoneCode = phoneCode ?? this.phoneCode;
    this.reasonForClosure = reasonForClosure ?? this.reasonForClosure;
    this.email = email ?? this.email;
    this.notificationOption = notificationOption ?? this.notificationOption;
    this.fetchedNotifOption = fetchedNotifOption ?? this.fetchedNotifOption;
    this.devicePosition = devicePosition ?? this.devicePosition;
    this.deviceCountry = deviceCountry ?? this.deviceCountry;
    this.password = password ?? this.password;
    this.country = country ?? this.country;
    this.countryOfBirth = countryOfBirth ?? this.countryOfBirth;
    this.otherCountry = otherCountry ?? this.otherCountry;
    this.residenceCountry = residenceCountry ?? this.residenceCountry;
    this.authType = authType ?? this.authType;
    this.businessType = businessType ?? this.businessType;
    this.addressCountry = addressCountry ?? this.addressCountry;
    // notifyListeners();
  }

  @override
  String toString() {
    return 'AuthProvider(firstName: $firstName, lastName: $lastName, email: $email, password: $password, otp: $otp, token: $token, pin: $pin, confirmPin: $confirmPin, uid: $uid, reasonForClosure: $reasonForClosure, mobileNumber: $mobileNumber, userType: $userType, userAvatar: $userAvatar, country: $country, phoneCode: $phoneCode, auth: $auth, authType: $authType)';
  }
}
