import 'package:flutter/material.dart';
import 'package:geniuspay/app/auth/pages/sign_up/email_sign_in/email_exist_page.dart';
import 'package:geniuspay/app/auth/pages/sign_up/widgets/shared_functions.dart';
import 'package:geniuspay/app/auth/pages/sign_up/widgets/validators.dart';
import 'package:geniuspay/app/auth/pages/sign_up/widgets/verify_sent_page.dart';
import 'package:geniuspay/app/auth/view_models/select_country_view_model.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SignupEmailViewModel extends BaseModel
    with SignInValidators, SharedFunctions {
  final AuthenticationService _authenticationService =
      sl<AuthenticationService>();
  final SelectCountryViewModel _selectCountryViewModel =
      sl<SelectCountryViewModel>();

  //Email getters and setters
  String? _email;
  String? get email => _email;
  set setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  //Email exist declaration
  bool emailExists = false;

  //DisableButton getter
  bool _disableButton = true;
  bool get disableButton => _disableButton;

  //ReferralCode getters and setters
  String? _referralCode;
  String? get referralCode => _referralCode;
  set setReferralCode(String value) {
    _referralCode = value;
    notifyListeners();

    setReferralIsValid = value;
  }

  //isEmail getters and setters
  bool _referralIsValid = false;
  bool get referralIsValid => _referralIsValid;
  set setReferralIsValid(String value) {
    _referralIsValid = emailValidator.isValidReferralCode(value);
    notifyListeners();
  }

  //isEmail getters and setters
  bool _isEmail = true;
  bool get isEmail => _isEmail;

  //Terms getters and setters
  bool _terms = false;
  bool get terms => _terms;
  set setTerms(bool value) {
    _terms = value;
    notifyListeners();
  }

  //AML Terms getters and setters
  bool _amlTerms = false;
  bool get amlTerms => _amlTerms;
  set setAmlTerms(bool value) {
    _amlTerms = value;
    notifyListeners();
  }

  //News getters and setters
  bool _news = false;
  bool get news => _news;
  set setNews(bool value) {
    _news = value;
    notifyListeners();
  }

  //Function to disable button
  void setDisableButton(String text) {
    if (text.isEmpty ||
        !emailValidator.isValidEmail(text) ||
        !referralIsValid) {
      _isEmail = false;
      _disableButton = true;
    } else {
      _isEmail = true;
      _email = text;
    }
    if (_isEmail && _amlTerms && _terms) {
      _disableButton = false;
    } else {
      _disableButton = true;
    }
    notifyListeners();
  }

  //CanContinue function to validate email signup
  Future<void> canContinue(BuildContext context) async {
    setBusy(value: true);
    final isExists = await _authenticationService.checkEmailExists(email!);
    if (isExists.isLeft()) {
      PopupDialogs(context)
          .warningMessage('Unable to connect to server. Please try again');
    } else {
      isExists.foldRight(bool, (r, previous) => emailExists = r);
      if (emailExists) {
        EmailAlreadyExistPage.show(context, email!);
        setBusy(value: false);
      } else {
        final result = await _authenticationService.emailOTPSignIn(
            email: email!,
            country: _selectCountryViewModel.residenceCountry!.iso2,
            citizenship: _selectCountryViewModel.country!.iso2,
            birthCountry: _selectCountryViewModel.countryOfBirth!.iso2,
            invitationCode: referralCode);
        result.fold((l) {
          PopupDialogs(context)
              .errorMessage('Unable to sign in. Please try again');
          setBusy(value: false);
        }, (r) async {
          VerificationSentPage.show(context);
          setBusy(value: false);
          // OtpCodePage.show(context);
        });
      }
    }
  }
}
