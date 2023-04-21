import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geniuspay/app/auth/pages/passcode/pin_code_page.dart';
import 'package:geniuspay/app/auth/pages/sign_up/mobile_number/mobile_number_page.dart';
import 'package:geniuspay/app/auth/view_models/mobile_number_view_model.dart';
import 'package:geniuspay/app/auth/view_models/select_country_view_model.dart';
import 'package:geniuspay/app/auth/view_models/signup_email_view_model.dart';
import 'package:geniuspay/app/landing_page.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/models/user.dart';
import 'package:geniuspay/repos/local_repo.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class OtpViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      sl<AuthenticationService>();
  final SignupEmailViewModel _emailViewModel = sl<SignupEmailViewModel>();
  final LocalBase _localBase = sl<LocalBase>();
  final MobileNumberViewModel _mobileNumberViewModel =
      sl<MobileNumberViewModel>();
  final SelectCountryViewModel _selectCountryViewModel =
      sl<SelectCountryViewModel>();

  String? get mobileNumber => _mobileNumberViewModel.mobileNumber;

  String get email => _emailViewModel.email!;
  User? get user => _authenticationService.user;

  Future<void> verifyOtp(
      {required BuildContext context,
      required String otp,
      required bool isMobile,
      required bool isLogin,
      String? mobNo}) async {
    setBusy(value: true);
    if (isMobile) {
      final result = await _authenticationService.confirmMobileNumberOtp(
          mobileNumber: mobNo!,
          otp: otp,
          accountId: _authenticationService.user!.id);
      result.fold((l) async {
        PopupDialogs(context).errorMessage('Incorrect OTP / Unable to verify');
        setBusy(value: false);
      }, (r) {
        if (isLogin) {
          setBusy(value: false);
          LandingPage.show(context);
        } else {
          PINCodeSettingPage.show(context: context, onVerified: (context) {});
        }
        setBusy(value: false);
      });
    } else {
      final result = await _authenticationService.verifyOTP(
        email: email,
        otp: otp,
      );
      result.fold((l) async {
        PopupDialogs(context).errorMessage('Incorrect OTP / Unable to verify');
        setBusy(value: false);
      }, (r) {
        if (isLogin) {
          setBusy(value: false);
          LandingPage.show(context);
        } else {
          // updateUserCountry();
          registerDevice();
          MobileNumberVerification.show(
              context, _selectCountryViewModel.residenceCountry!, false);
        }
        setBusy(value: false);
      });
    }
  }

  Future<void> registerDevice() async {
    User? currentUser;
    final result = await _authenticationService.getUser();
    if (result.isLeft()) {
    } else {
      result.foldRight(User, (r, previous) {
        currentUser = r;
      });
      final token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        final result =
            await _authenticationService.setUserDeviceInfo(currentUser, token);
        result.fold((l) => null, (r) {
          _localBase.setFcmToken(token);
        });
      }
    }
  }

  // Future<void> updateUserCountry() async {
  //   final nationality = _selectCountryViewModel.country?.iso2 ??
  //       _localBase.getdeviceCountry()?.iso2 ??
  //       _authenticationService.user?.userProfile.countryIso2;
  //   final residenceCountry = _selectCountryViewModel.country?.iso2 ??
  //       _localBase.getResidenceCountry()?.iso2 ??
  //       nationality;
  //   final birthCountry = _selectCountryViewModel.country?.iso2 ??
  //       _localBase.getBirthCountry()?.iso2 ??
  //       nationality;
  //   if (nationality != null && nationality.isNotEmpty) {
  //     await _authenticationService.updateUserCountry(
  //       nationality,
  //       residenceCountry!,
  //       birthCountry!,
  //     );
  //   }
  // }

  Future<void> resendMobileOtp(
      BuildContext context, String mobileNumber) async {
    final result = await _authenticationService.sendMobileNumberOtp(
        accountId: _authenticationService.user!.id, mobileNumber: mobileNumber);
    result.fold((l) async {
      PopupDialogs(context)
          .errorMessage('Unable to resend code. Please try again');
    }, (r) {
      PopupDialogs(context).successMessage('OTP has been sent');
    });
  }

  Future<void> resendCode(BuildContext context) async {
    final result = await _authenticationService.emailOTPSignIn(
        email: email,
        country: _selectCountryViewModel.country!.iso2,
        citizenship: _selectCountryViewModel.residenceCountry!.iso2,
        birthCountry: _selectCountryViewModel.countryOfBirth!.iso2,
        invitationCode: _emailViewModel.referralCode);
    result.fold((l) async {
      PopupDialogs(context)
          .errorMessage('Unable to resend code. Please try again');
    }, (r) {
      PopupDialogs(context).successMessage('OTP has been sent');
    });
  }
}
