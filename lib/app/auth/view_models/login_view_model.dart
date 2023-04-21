import 'package:flutter/material.dart';
import 'package:geniuspay/app/auth/pages/sign_up/widgets/shared_functions.dart';
import 'package:geniuspay/app/auth/pages/sign_up/widgets/validators.dart';
import 'package:geniuspay/app/auth/pages/sign_up/widgets/verify_sent_page.dart';
import 'package:geniuspay/app/auth/view_models/signup_email_view_model.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LoginEmailViewModel extends BaseModel
    with SignInValidators, SharedFunctions {
  final AuthenticationService _authenticationService =
      sl<AuthenticationService>();
  final SignupEmailViewModel _emailViewModel = sl<SignupEmailViewModel>();

  final bool _isEmail = true;
  bool _isEmailExist = true;
  final bool _disableButton = true;
  bool get isEmail => _isEmail;
  bool get isEmailExist => _isEmailExist;
  bool get disableButton => _disableButton;

  void setDisableButton(String text) async {
    // setBusy(value: true);
    // if (text.isEmpty || !emailValidator.isValidEmail(text)) {
    //   _isEmail = false;
    //   _disableButton = true;
    // } else {
    //   final result = await _authenticationService.checkEmailExists(text);
    //   result.fold((l) {
    //     _isEmailExist = false;
    //     setBusy(value: false);
    //   }, (r) {
    //     _isEmailExist = r;
    //     if (_isEmailExist) {
    //       _disableButton = false;
    //     } else {
    //       _disableButton = true;
    //     }
    //     setBusy(value: false);
    //   });
    //   _isEmail = true;
    //   setBusy(value: false);
    // }
  }
  void resetEmailExist() {
    _isEmailExist = true;
  }

  Future<void> emailExists(String email) async {
    notifyListeners();
    final result = await _authenticationService.checkEmailExists(email);
    result.fold((l) {
      _isEmailExist = false;
      notifyListeners();
    }, (r) {
      _isEmailExist = r;
      notifyListeners();
    });
  }

  Future<void> login({
    required BuildContext context,
    required String email,
  }) async {
    setBusy(value: true);
    final result = await _authenticationService.emailOTPLogin(
      email: email,
    );
    result.fold((l) {
      PopupDialogs(context).errorMessage('Unable to login. Please try again');
      setBusy(value: false);
    }, (r) async {
      _emailViewModel.setEmail = email;
      VerificationSentPage.show(context, isLogin: true);
      setBusy(value: false);
      // OtpCodePage.show(context);
    });
  }
}
