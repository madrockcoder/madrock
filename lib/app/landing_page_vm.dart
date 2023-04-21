import 'dart:convert';
import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:geniuspay/app/Profile/profile_page_vm.dart';
import 'package:geniuspay/app/auth/pages/sign_up/permissions/notification_permission_page.dart';
import 'package:geniuspay/app/auth/view_models/otp_view_model.dart';
import 'package:geniuspay/app/home/view_models/home_view_model.dart';
import 'package:geniuspay/app/shared_widgets/error_screens/account_locked.dart';
import 'package:geniuspay/app/wallet/wallet_screen_vm.dart';
import 'package:geniuspay/core/errors/errors.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/environment_config.dart';
import 'package:geniuspay/models/country.dart';
import 'package:geniuspay/models/user.dart';
import 'package:geniuspay/models/user_profile.dart';
import 'package:geniuspay/repos/local_repo.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/services/navigation_service.dart';
import 'package:geniuspay/services/remote_config_service.dart';
import 'package:geniuspay/util/enums.dart';
import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'shared_widgets/error_screens/account_banned.dart';

@lazySingleton
class LandingPageVM extends BaseModel {
  //list of all country
  bool signedIn = false;
  User? user;
  Country? selectedCountry;
  final AuthenticationService _authenticationService =
      sl<AuthenticationService>();
  final OtpViewModel _otpViewModel = sl<OtpViewModel>();
  final ProfilePageVM _profilePageVM = sl<ProfilePageVM>();

  final _localBase = sl<LocalBase>();

  BaseModelState baseModelState = BaseModelState.loading;
  bool splashdone = false;
  bool biometricVerified = false;
  ProfileStatus userStatus = ProfileStatus.unknown;
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  void changeState(BaseModelState state) {
    baseModelState = state;
    notifyListeners();
  }

  Future<void> registerDevice() async {
    final token = await FirebaseMessaging.instance.getToken();
    if (_localBase.getFcmToken() == null) {
      final token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        final result =
            await _authenticationService.setUserDeviceInfo(user, token);
        result.fold((l) => null, (r) {
          _localBase.setFcmToken(token);
        });
      }
    }
  }

  Future<bool> biometricAuth(BuildContext context) async {
    try {
      bool isUser = await _localAuthentication.authenticate(
        localizedReason: "Verify yourself",
        useErrorDialogs: false,
        stickyAuth: true,
        biometricOnly: true,
      );
      return isUser;
    } catch (e) {
      return false;
    }
  }

  Future<void> showAppTrackingTransparencyDialogBox() async {
    final status = await AppTrackingTransparency.requestTrackingAuthorization();
  }

  connectWebSocket() async {
    String baseUrl = "${RemoteConfigService.getRemoteData.appUrl}";
    baseUrl = baseUrl.replaceAll('https', 'wss');
    final res = WebSocketChannel.connect(Uri.parse(
        '$baseUrl/ws/notification/7637cd13-ea74-400f-b321-9fd68c3af86b'));
    res.stream.listen(
      (message) {
        print(message);
        final data = jsonDecode(message);
        if (data['type'] == "account_notification" &&
            data['account']['account_status'] != null) {
          accountStatusNavigation(data['account']['account_status']);
        } else {
          //getuserwebsocket();
        }
      },
      onDone: () {},
      onError: (error) {
        debugPrint('WebSocket error: ${error.toString()}');
      },
    );
    debugPrint('WebSocket initialized');
  }

  getuserwebsocket() async {
    await _authenticationService.getUser();
    final HomeViewModel _homeViewModel = sl<HomeViewModel>();
    final WalletScreenVM _walletViewModel = sl<WalletScreenVM>();
    _homeViewModel.updateHome();
    _walletViewModel.updateWalletsWebsocket();
  }

  accountStatusNavigation(String statusString) async {
    ProfileStatus status = getProfileStatus(statusString);
    switch (status) {
      case ProfileStatus.limited:
      case ProfileStatus.banned:
      case ProfileStatus.suspended:
        if (NavigationServices.navigatorKey.currentContext != null) {
          return AccountBanned.show(
              NavigationServices.navigatorKey.currentContext!, status);
        }
        break;
      case ProfileStatus.blocked:
      case ProfileStatus.closing:
      case ProfileStatus.closed:
        if (NavigationServices.navigatorKey.currentContext != null) {
          return AccountLocked.show(
              NavigationServices.navigatorKey.currentContext!, status);
        }
        break;
      default:
    }
    Navigator.of(NavigationServices.navigatorKey.currentContext!).push(
      MaterialPageRoute(
          builder: (_) =>
              const AccountBanned(profileStatus: ProfileStatus.banned)),
    );
  }

  bool privacyAndTermsAccepted = false;
  bool jailBreak = false;
  Future<void> initialize(BuildContext context) async {
    splashdone = false;
    baseModelState = BaseModelState.loading;
    if (RemoteConfigService.getRemoteData.maintenance ?? false) {
      await Future.delayed(const Duration(seconds: 1));
      setError(const Maintenance(message: 'maintenance'));
      changeState(BaseModelState.error);
    } else {
      try {
        final token = _fetchToken();
        if (await FlutterJailbreakDetection.jailbroken &&
            EnvironmentConfig.env == Flavor.live) {
          jailBreak = true;
          changeState(BaseModelState.error);
        } else if (token == null) {
          privacyAndTermsAccepted = _localBase.getPrivacyAndTerms() ?? false;
          signedIn = false;
          await Future.delayed(const Duration(seconds: 1));
          changeState(BaseModelState.success);
        } else {
          List<Object> res = [];
          if (_localBase.getFaceID()) {
            res = await Future.wait(
                [_authenticationService.getUser(), biometricAuth(context)]);
            biometricVerified = res[1] as bool;
          } else {
            res = await Future.wait([_authenticationService.getUser()]);
          }
          final result = res[0] as Either<Failure, User>;

          user = _authenticationService.user;
          if (user == null) {
            Failure? f;
            result.leftMap((l) async {
              f = l;
              setError(l);
            });
            if (f.runtimeType == NoInternetFailure) {
              await Future.delayed(const Duration(seconds: 1));
            }
            if (f.runtimeType == SessionTimeOut) {
              await _profilePageVM.logOutFunction(
                  context: context, autologout: true);
              privacyAndTermsAccepted =
                  _localBase.getPrivacyAndTerms() ?? false;
              signedIn = false;
              await Future.delayed(const Duration(seconds: 1));
              changeState(BaseModelState.success);
            } else {
              changeState(BaseModelState.error);
            }
          } else {
            userStatus = user!.userProfile.status;
            if (user!.userProfile.status != ProfileStatus.active &&
                user!.userProfile.status != ProfileStatus.limited) {
              // setError(error);
              changeState(BaseModelState.error);
            } else {
              signedIn = true;
              connectWebSocket();
              // await _otpViewModel.updateUserCountry();
              // if (user!.userProfile.countryIso2.isEmpty) {
              //   await _otpViewModel.updateUserCountry();
              // }
              if (user?.userProfile.onboardingStatus ==
                  OnboardingStatus.onboardingRequired) {
                final result = await _authenticationService
                    .searchCountryIso(user!.userProfile.countryIso2!);
                result.fold((l) {}, (r) {
                  selectedCountry = r;
                });
              }
              changeState(BaseModelState.success);
              registerDevice();
              showAppTrackingTransparencyDialogBox();
              checkNotification(context);
            }
          }
        }
      } catch (e) {
        changeState(BaseModelState.error);
      }
    }
  }

  void checkNotification(BuildContext context) async {
    // NotificationPermision.show(context, false);
    if (Platform.isIOS) {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      NotificationSettings settings = await messaging.getNotificationSettings();
      if (settings.authorizationStatus == AuthorizationStatus.denied ||
          settings.authorizationStatus == AuthorizationStatus.notDetermined) {
        NotificationPermision.show(context, false);
      }
    }
  }

  void markSplashDone() {
    splashdone = true;
    notifyListeners();
  }

  String? _fetchToken() {
    final localBase = sl<LocalBase>();
    // localBase.deleteToken();
    return localBase.getToken();
  }
}
