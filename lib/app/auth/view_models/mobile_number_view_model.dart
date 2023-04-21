import 'package:flutter/material.dart';
import 'package:geniuspay/app/auth/pages/sign_up/widgets/verify_sent_page.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/models/country.dart';
import 'package:geniuspay/models/user.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class MobileNumberViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      sl<AuthenticationService>();

  Country? residenceCountry;
  String? _mobileNumber;
  String? get mobileNumber => _mobileNumber;
  bool mobileNumberExists = false;

  User? get user => _authenticationService.user;
  Future<void> checkMobileNumberExists(
      {required BuildContext context,
      required String mobileNumber,
      required bool isLogin}) async {
    final result = await _authenticationService.checkMobileNumberExists(
        mobileNumber: mobileNumber);
    if (result.isLeft()) {
      PopupDialogs(context).errorMessage(
          'An error occured while communication with server, please try again later');
      // PopupDialogs(context).errorMessage('Unable to process, try again later');
    } else {
      result.foldRight(bool, (r, previous) => mobileNumberExists = r);
      if (!mobileNumberExists) {
        await sendMobileNumberOtp(
            context: context, text: mobileNumber, isLogin: isLogin);
      } else {
        PopupDialogs(context).errorMessage("Mobile number already exists");
      }
    }
  }

  Future<void> updateUserCountry() async {
    await _authenticationService.getUser();
    //    final result = _localBase.getdeviceCountry();
    // if (result != null) {
    //   Country deviceCountry = Country.fromJson(result);
    //    await _authenticationService.updateUserCountry(
    //   deviceCountry.iso2,
    //  deviceCountry.iso2,
    //   deviceCountry.iso2,
    // );
    // }
  }

  Future<void> sendMobileNumberOtp(
      {required BuildContext context,
      required String text,
      required bool isLogin}) async {
    _mobileNumber = text;
    setBusy(value: true);
    final result = await _authenticationService.sendMobileNumberOtp(
        mobileNumber: text, accountId: _authenticationService.user!.id);

    result.fold((l) async {
      PopupDialogs(context).errorMessage(
        'Unable to add Mobile number. Please try again',
      );
      setBusy(value: false);
    }, (r) {
      setBusy(value: false);
      _mobileNumber = mobileNumber;
      VerificationSentPage.show(context,
          isMobile: true, isLogin: isLogin, mobileNumber: mobileNumber);
    });

    setBusy(value: false);
  }
}
