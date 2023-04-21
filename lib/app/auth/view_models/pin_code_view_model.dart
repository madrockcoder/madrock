import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geniuspay/app/auth/pages/passcode/blocked_account.dart';
import 'package:geniuspay/app/auth/pages/sign_up/biometrics/finger_print/finger_print_page.dart';
import 'package:geniuspay/app/onboarding/support_pin_screen.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/repos/local_repo.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/util/constants.dart';
import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';

@lazySingleton
class PinCodeViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      sl<AuthenticationService>();
  final LocalBase _localBase = sl<LocalBase>();
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  bool get fingerPrint => _localBase.getFaceID();
  final List<int> _pins = [];
  List<int> get pins => _pins;
  String? get passcode => _localBase.getPasscode();
  bool _isConfirm = false;
  bool get isConfirm => _isConfirm;
  int _attempt = 3;
  int get attempt => _attempt;

  String _pin = '';
  String get pin => _pin;
  String _confirmPin = '';
  String get confirmPin => _confirmPin;

  int _activeField = 0;
  int get activeField => _activeField;

  void reset() {
    _pins.clear();
    _activeField = 0;

    notifyListeners();
  }

  void initialize() {
    _attempt = 3;
    _pins.clear();
    _activeField = 0;
    if (_timer != null && _timer?.isActive == true) {
      _timer?.cancel();
    }
    selected = false;
    notifyListeners();
  }

  int zeroKeyPressed(int i) {
    if (i == 10) {
      return 0;
    } else {
      return i + 1;
    }
  }

  void biometricAuth(
      BuildContext context, Function(BuildContext) onVerified) async {
    bool isUser = await _localAuthentication.authenticate(
      localizedReason: "Verify yourself",
      useErrorDialogs: false,
      stickyAuth: true,
      biometricOnly: true,
    );
    if (isUser) {
      startPasscodeLoading();
      // HomeWidget.show(context);
      await onVerified(context);
      _timer?.cancel();
      selected = false;
      setBusy(value: false);
    }
  }

  void keysPressed({
    required int i,
    required bool isLogin,
    required BuildContext context,
    required Function(BuildContext) onVerified,
  }) async {
    if (i == 11) {
      if (_pins.isNotEmpty) {
        _pins.removeLast();
      }
    } else {
      if (_pins.length < 6) {
        _pins.add(zeroKeyPressed(i));
      }
      if (_pins.length == 6) {
        var otp = '';

        for (var pin in _pins) {
          otp += pin.toString();
        }
        if (isLogin) {
          _pin = otp;
          await verifyUserPin(context, onVerified);
        } else if (_isConfirm) {
          _confirmPin = otp;
          await setPin(context);
        } else {
          _pin = '';
          _pin = otp;
          verifyPin(context);
        }

        otp = '';
      }
    }
    notifyListeners();
  }

  bool selected = false;
  Timer? _timer;
  void startPasscodeLoading() {
    selected = !selected;
    notifyListeners();
    _timer = Timer.periodic(const Duration(milliseconds: 800), (timer) {
      selected = !selected;
      notifyListeners();
    });
  }

  Future<void> setPin(BuildContext context) async {
    if (_pin == _confirmPin) {
      setBusy(value: true);
      startPasscodeLoading();
      final result = await _authenticationService.setPIN(pin: pin);
      result.fold((l) async {
        _timer?.cancel();
        selected = false;
        PopupDialogs(context)
            .errorMessage('Unable to set PIN. Please try again');
        _timer?.cancel();
        _isConfirm = false;
        selected = false;
        reset();
        setBusy(value: false);
      }, (r) async {
        if (await _localAuthentication.isDeviceSupported()) {
          FingerPrintPage.show(context);
        } else {
          SupportPin.show(context);
        }
        reset();
        _timer?.cancel();
        selected = false;
        setBusy(value: false);
      });
    } else {
      _timer?.cancel();
      selected = false;
      PopupDialogs(context).errorMessage("Oops! that's a PIN mismatch");
    }
  }

  Future<void> verifyUserPin(
      BuildContext context, Function(BuildContext) onVerified,
      {String? token}) async {
    setBusy(value: true);
    startPasscodeLoading();
    // unawaited(AppLoadingPopup(context: context).show());
    final result = await _authenticationService.verifyPin(pin: token ?? pin);
    result.fold((l) async {
      PopupDialogs(context)
          .errorMessage("Couldn't verify PIN. Please try again");
      _timer?.cancel();
      selected = false;
      reset();
      setBusy(value: false);
    }, (r) async {
      selected = false;
      if (r) {
        // HomeWidget.show(context);
        await onVerified(context);
        _timer?.cancel();
      } else {
        _timer?.cancel();
        reset();
        _attempt = _attempt - 1;
        if (_attempt <= 0) {
          await _authenticationService.lockUserAccount();
          BlockedAccount.show(context);
        }
      }

      setBusy(value: false);
    });
  }

  bool validatePIN() {
    final found =
        commonlyUsedPins.firstWhere((e) => _pin == e, orElse: () => 'null');
    return found == 'null';
  }

  void verifyPin(BuildContext context) async {
    if (validatePIN()) {
      _isConfirm = true;
      reset();
    } else {
      PopupDialogs(context).warningMessage(
          'PIN is too common and easily guessed. Be more creative 😃');
      reset();
    }
  }
}
