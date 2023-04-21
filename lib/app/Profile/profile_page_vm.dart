import 'package:flutter/material.dart';
import 'package:geniuspay/app/landing_page.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/main_dev.dart';
import 'package:geniuspay/models/user.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button_async.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

@lazySingleton
class ProfilePageVM extends BaseModel {
  final AuthenticationService _authenticationService =
      sl<AuthenticationService>();
  User get user => _authenticationService.user!;
  Future<void> logOutFunction(
      {required BuildContext context, required bool autologout}) async {
    await GetIt.instance.reset();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    if (autologout) {
      PopupDialogs(context)
          .informationMessage('Session timed out. Logging you out');
    } else {
      PopupDialogs(context).successMessage('Successfully logged out');
    }

    await configureDependecies();
    await preloader();
    prefs.setBool('privacyandterms', true);
    if (!autologout) {
      LandingPage.show(context);
    }
  }

  void logout(BuildContext context) {
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
                      'Are you sure you want to\nlogout?',
                      textAlign: TextAlign.center,
                      style: textTheme.headlineMedium?.copyWith(fontSize: 20),
                    ),
                    const Gap(17),
                    Text(
                      'Come back soon before we start missing you!',
                      textAlign: TextAlign.center,
                      style: textTheme.bodyMedium,
                    ),
                    const Gap(30),
                    CustomElevatedButtonAsync(
                        color: AppColor.kGoldColor2,
                        onPressed: () async {
                          await logOutFunction(
                              context: context, autologout: false);
                        },
                        child: Text(
                          'YES, LOG ME OUT',
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
                        'assets/icons/profile/logout.svg',
                        width: 32,
                        height: 32,
                        color: Colors.white,
                      )),
                )),
          ]);
        });
  }

  Future<void> uploadAvatar(BuildContext context, String base64) async {
    final result = await _authenticationService.uploadAvatar(
        _authenticationService.user!.id, base64);
    result.fold((l) {
      PopupDialogs(context)
          .errorMessage('Unable to upload avatar. Please try again later');
    }, (r) async {
      await _authenticationService.getUser();
      notifyListeners();
    });
  }
}
