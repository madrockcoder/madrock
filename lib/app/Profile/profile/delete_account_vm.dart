import 'package:flutter/material.dart';
import 'package:geniuspay/app/Profile/profile_page_vm.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/repos/local_repo.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button_async.dart';
import 'package:geniuspay/util/color_scheme.dart';

@lazySingleton
class DeleteAccountVM extends BaseModel {
  final LocalBase _localBase = sl<LocalBase>();
  final AuthenticationService _authenticationService =
      sl<AuthenticationService>();
  String? get passcode => _localBase.getPasscode();
  Future<bool> canCloseAccount(BuildContext context) async {
    final result = await _authenticationService
        .closeAccountCheck(_authenticationService.user!.id);
    if (result.isLeft()) {
      return false;
    } else {
      bool canClose = false;
      result.fold((l) => null, (r) {
        canClose = r;
      });
      return canClose;
    }
  }

  Future<bool> verifyPassCode(BuildContext context, String passCode) async {
    final result = await _authenticationService.verifyPin(pin: passCode);
    if (result.isLeft()) {
      PopupDialogs(context).errorMessage(
          "You do not have permission to close this account. Contact support");
      return false;
    } else {
      bool canClose = false;
      result.fold((l) => null, (r) {
        canClose = r;
      });
      return canClose;
    }
  }

  Future<void> closeAccount(BuildContext context, String reason) async {
    final textTheme = Theme.of(context).textTheme;
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Stack(alignment: AlignmentDirectional.bottomCenter, children: [
            Container(
                margin: const EdgeInsets.only(top: 50),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                padding: EdgeInsets.only(
                    top: 26,
                    left: 26,
                    right: 26,
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Gap(30),
                    Text(
                      'Are you sure you want to\ndelete this account?',
                      textAlign: TextAlign.center,
                      style: textTheme.headlineMedium?.copyWith(fontSize: 20),
                    ),
                    const Gap(17),
                    Text(
                      'This action is irreversible!',
                      textAlign: TextAlign.center,
                      style: textTheme.bodyMedium,
                    ),
                    const Gap(30),
                    CustomElevatedButtonAsync(
                        color: AppColor.kGoldColor2,
                        onPressed: () async {
                          final result =
                              await _authenticationService.closeAccount(
                                  _authenticationService.user!.id, reason);
                          if (result.isLeft()) {
                            PopupDialogs(context)
                                .errorMessage("Unable to delete account");
                          } else {
                            ProfilePageVM().logOutFunction(
                                context: context, autologout: false);
                          }
                        },
                        child: Text(
                          'YES, DELETE MY ACCOUNT',
                          style: textTheme.titleLarge,
                        )),
                    const Gap(10),
                    CustomElevatedButton(
                        color: AppColor.kWhiteColor,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('CANCEL', style: textTheme.titleLarge)),
                    const Gap(32),
                  ],
                )),
            Positioned(
                top: 0,
                child: Container(
                  height: 100,
                  width: 100,
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: CircleAvatar(
                      backgroundColor: AppColor.kGoldColor2,
                      child: SvgPicture.asset(
                        'assets/images/heart_break.svg',
                        width: 32,
                        height: 32,
                        color: Colors.white,
                      )),
                )),
          ]);
        });
  }
}
