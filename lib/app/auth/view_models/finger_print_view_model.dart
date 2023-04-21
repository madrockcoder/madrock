import 'package:flutter/material.dart';
import 'package:geniuspay/app/auth/view_models/pin_code_view_model.dart';
import 'package:geniuspay/app/onboarding/support_pin_screen.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/repos/local_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';

@lazySingleton
class FingerPrintViewModel extends BaseModel {
  FingerPrintViewModel(this.localBase);
  final LocalBase localBase;
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  late bool _canPrint;
  bool get canPrint => _canPrint;
  final PinCodeViewModel _pincode = sl<PinCodeViewModel>();

  void checkIfPrintExist() async {
    List<BiometricType> metric =
        await _localAuthentication.getAvailableBiometrics();

    _canPrint = metric.contains(BiometricType.fingerprint) ||
        metric.contains(BiometricType.face);
  }

  Future<void> autenticate(BuildContext context) async {
    setBusy(value: true);
    if (canPrint) {
      bool isUser = await _localAuthentication.authenticate(
        localizedReason: "Verify yourself",
        useErrorDialogs: false,
        stickyAuth: true,
        biometricOnly: true,
      );
      if (isUser) {
        //set pref and move
        localBase.setFaceID(true);
        localBase.setPasscode(_pincode.pin);
        SupportPin.show(context);
      }
    } else {
      PopupDialogs(context)
          .errorMessage('This device doesn\'t have support for Fingerprint ');
    }
    setBusy(value: false);
  }
}
