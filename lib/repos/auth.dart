import 'dart:convert';
import 'dart:io';

import 'package:geniuspay/models/notification_option.dart';
import 'package:geniuspay/services/mixpanel_service.dart';
import 'package:geniuspay/util/security.dart';
import 'package:http/http.dart' as http;
import 'package:sentry/sentry.dart';

import '../app/shared_widgets/http_exception.dart';
import '../models/country.dart';
import '../models/create_user.dart';
import '../models/reason.dart';
import '../models/user.dart';
// import '../util/security.dart';
import '../util/essentials.dart';
import 'api_path.dart';
import 'local_repo.dart';

abstract class AuthBase {
  // late final String  token;
  String? get token;
  late User? user;
  Future<User> get currentUser;
  // Future<String> signup(CreateUser user);
  Future<String> emailOTPSignIn(String email);
  Future<void> postMobileNumber(String mobileNumber);
  Future<void> confirmMobileNumber(String numberId);
  Future<User> getUser();
  Future<bool> closeAccountCheck();
  Future<void> closeAccount(String reason);
  Future<void> updateUser(CreateUser user);
  Future<String> verifyOTP({required String email, required String otp});
  Future<void> setPIN({required String uid, required String pin});
  Future<void> updatePIN({required String oldPIN, required String newPIN});
  Future<void> reasonForUsingApp(List<Reason> reasons);
  // Future<String> login(LoginUser user);
  Future<void> logout();
  Future<bool> checkEmailExists(String email);
  void setToken(String token);
  Future<List<Country>> fetchCountries(String searchTerm);
  Future<void> lockUserAcc();
  Future<String> setAvatar(String image);
  Future<bool> verifyUserPin(String pin);
  Future<void> setUserDeviceInfo();
  Future<void> setNotificationOption(NotificationOption option);
  // Future<NotificationOption> fetchNotificationOption();
  // Future<void> setTaxResidence(TaxCountry country);
}

class Auth with HMACSecurity implements AuthBase {
  final LocalBase localBase;
  Auth({required this.localBase});

  @override
  String? token;

  @override
  User? user;

  @override
  Future<User> get currentUser async {
    if (user == null) {
      try {
        final foundUser = await getUser();
        return foundUser;
      } catch (exception, stackTrace) {
        await Sentry.captureException(
          exception,
          stackTrace: stackTrace,
        );
        rethrow;
      }
    } else {
      return user!;
    }
  }

  @override
  Future<String> setAvatar(String image) async {
    try {
      final response = await http.post(
        Uri.parse(APIPath.setAvatar(user!.id)),
        headers: headers(
          token: token,
          hmac: generateHMACSignature(
            path: APIPath.setAvatar(user!.id),
            method: 'POST',
            payload: {'avatar': image},
          ),
        ),
        body: json.encode({'avatar': image}),
      );
      final body = json.decode(response.body);

      if (body['avatar'] != null) {
        await getUser();
        return body['avatar'];
      } else if (body['message'] != null) {
        throw CustomHttpException(title: 'An error occurred', message: body['message']);
      } else {
        throw CustomHttpException(title: 'An error occurred', message: 'Something went wrong');
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<bool> verifyUserPin(String pin) async {
    try {
      debugPrint('TOKen is $token');
      final response = await http.post(
        Uri.parse(APIPath.verifyUserPin(user!.id)),
        headers: headers(
          token: token,
          hmac: generateHMACSignature(
            path: APIPath.verifyUserPin(user!.id),
            method: 'POST',
            payload: {'security_pin': pin},
          ),
        ),
        body: json.encode({'security_pin': pin}),
      );

      final body = json.decode(response.body);

      if (body.runtimeType == bool) {
        return body;
      } else {
        if (body['message'] != null) {
          throw CustomHttpException(title: 'Oops!', message: body['message'] ?? '');
        }
        return body;
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<void> lockUserAcc() async {
    try {
      final response = await http.post(
        Uri.parse(APIPath.lockUserAcc(user!.id)),
        headers: headers(
          token: token,
          hmac: generateHMACSignature(
            path: APIPath.lockUserAcc(user!.id),
            method: 'POST',
            payload: {'account_id': user!.id},
          ),
        ),
        body: jsonEncode({'account_id': user!.id}),
      );

      json.decode(response.body);

      localBase.deleteToken();

      // if(body.runtimeType == bool){
      //   return body;
      // }else {
      //
      //   if (body['message'] != null) {
      //     throw CustomHttpException(
      //         title: 'Oops!',
      //         message: body['message'] ?? '');
      //   }
      //   return body;
      // }

    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<String> emailOTPSignIn(String email) async {
    try {
      final response = await http.post(
        Uri.parse(APIPath.emailOTPSignIn),
        headers: headers(
          // token: token,
          hmac: generateHMACSignature(
            path: APIPath.emailOTPSignIn,
            method: 'POST',
            payload: {'email': email},
          ),
        ),
        body: json.encode({'email': email}),
      );

      final body = json.decode(response.body);
      if (body['errors'] != null) {
        throw CustomHttpException(
            title: 'Couldn\'t Complete Request', message: body['errors'][0]['message'] ?? 'Something went wrong');
      } else if (body['error_message'] != null) {
        throw CustomHttpException(title: 'Couldn\'t Complete Request', message: body['error_message'] ?? 'Something went wrong');
      }
      return body['detail'];
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<String> verifyOTP({required String email, required String otp}) async {
    try {
      final response = await http.post(
        Uri.parse(APIPath.verifyOTP),
        headers: headers(
          hmac: generateHMACSignature(
            path: APIPath.verifyOTP,
            method: 'POST',
            payload: {'email': email, 'token': otp},
          ),
        ),
        body: json.encode({'email': email, 'token': otp}),
      );
      final body = json.decode(response.body);
      if (body['errors'] != null) {
        throw CustomHttpException(
            title: 'Couldn\'t Complete Request', message: body['errors'][0]['message'] ?? 'Something went wrong');
      } else if (body['error_message'] != null) {
        throw CustomHttpException(title: 'Couldn\'t Complete Request', message: body['error_message'] ?? 'Something went wrong');
      }
      updateWith(token: body['token']);

      localBase.setToken(body['token']);

      return body['token'];
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<void> setUserDeviceInfo() async {
    String device = Platform.isIOS ? 'ios' : 'android';
    // String? deviceId = await sl<FirebaseServices>().getUserToken();

    Map<String, dynamic> data = {
      "name": user!.name,
      "registration_id": "deviceId",
      "device_id": user!.id,
      "active": true,
      "type": device
    };

    // try {
    //   await http.post(
    //     Uri.parse(APIPath.setUserDeviceInfo),
    //     headers: headers(
    //       token: token,
    //       hmac: generateHMACSignature(
    //         path: APIPath.setUserDeviceInfo,
    //         method: 'POST',
    //         payload: data,
    //       ),
    //     ),
    //     body: json.encode(data),
    //   );
    // } catch (exception, stackTrace) {
    //   await Sentry.captureException(
    //     exception,
    //     stackTrace: stackTrace,
    //   );
    //   rethrow;
    // }
  }

  @override
  Future<bool> checkEmailExists(String email) async {
    try {
      final response = await http.get(
        Uri.parse(APIPath.checkEmailExists(email)),
        headers: headers(),
      );
      final body = json.decode(response.body);
      if (body['status_code'] == 401) {
        throw CustomHttpException(
          title: 'An error occurred',
          message: body['message'],
        );
      }
      return body['status'];
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      final response = await http.get(
        Uri.parse(APIPath.logout),
        headers: headers(token: token),
      );
      if (response.statusCode == 200) {
        updateWith(token: null, user: null);

        localBase.deleteToken();
      } else {
        throw CustomHttpException(
          title: 'An error occurred',
          message: 'Couldn\'t log you out. Try again later',
        );
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<void> updateUser(CreateUser createUser) async {
    // try {
    //   final response = await http.post(
    //     Uri.parse(APIPath.updateUser(user!.id)),
    //     headers: headers(
    //       token: token,
    //       hmac: generateHMACSignature(
    //         path: APIPath.updateUser(user!.id),
    //         method: 'POST',
    //         payload: createUser.toMap(),
    //       ),
    //     ),
    //     body: createUser.toJson(),
    //   );
    //   final body = json.decode(response.body);

    //   if (body['errors'] != null) {
    //     throw CustomHttpException(
    //         title: 'Couldn\'t Complete Request',
    //         message: body['errors'][0]['message'] ?? 'Something went wrong');
    //   } else if (body['error_message'] != null) {
    //     throw CustomHttpException(
    //         title: 'Couldn\'t Complete Request',
    //         message: body['error_message'] ?? 'Something went wrong');
    //   } else if (response.statusCode != 200) {
    //     throw CustomHttpException(
    //         title: 'Couldn\'t Complete Request',
    //         message: body['message'] ?? 'Something went wrong');
    //   }

    //   return body['key'];
    // } catch (exception, stackTrace) {
    //   await Sentry.captureException(
    //     exception,
    //     stackTrace: stackTrace,
    //   );
    //   rethrow;
    // }
  }

  @override
  Future<void> reasonForUsingApp(List<Reason> reasons) async {
    // try {
    //   final response = await http.post(
    //     Uri.parse(APIPath.reasonForUsingApp),
    //     headers: headers(
    //       token: token,
    //       hmac: generateHMACSignature(
    //         path: APIPath.reasonForUsingApp,
    //         method: 'POST',
    //         payload: {
    //           'reason_using_app': [...reasons.map((e) => e.reason).toList()]
    //         },
    //       ),
    //     ),
    //     body: json.encode({
    //       'reason_using_app': [...reasons.map((e) => e.reason).toList()],
    //     }),
    //   );
    //   final body = json.decode(response.body);

    //   if (body['errors'] != null) {
    //     throw CustomHttpException(
    //         title: 'Couldn\'t Complete Request',
    //         message: body['errors'][0]['message'] ?? 'Something went wrong');
    //   } else if (body['error_message'] != null) {
    //     throw CustomHttpException(
    //         title: 'Couldn\'t Complete Request',
    //         message: body['error_message'] ?? 'Something went wrong');
    //   }
    // } catch (exception, stackTrace) {
    //   await Sentry.captureException(
    //     exception,
    //     stackTrace: stackTrace,
    //   );
    //   rethrow;
    // }
  }

  @override
  Future<List<Country>> fetchCountries(String searchTerm) async {
    try {
      final response = await http.get(
        Uri.parse(APIPath.searchCountries(searchTerm)),
        headers: headers(),
      );

      final body = json.decode(response.body)['results'] as List<dynamic>;

      return body.map((country) => Country.fromMap(country)).toList();
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<void> setPIN({required String uid, required String pin}) async {
    try {
      final response = await http.post(
        Uri.parse(APIPath.setPIN),
        headers: headers(
          token: token,
          hmac: generateHMACSignature(
            path: APIPath.setPIN,
            method: 'POST',
            payload: {'security_pin': pin},
          ),
        ),
        body: json.encode({'security_pin': pin}),
      );
      final body = json.decode(response.body);

      if (body['errors'] != null) {
        throw CustomHttpException(
            title: 'Couldn\'t Complete Request', message: body['errors'][0]['message'] ?? 'Something went wrong');
      } else if (body['error_message'] != null) {
        throw CustomHttpException(title: 'Couldn\'t Complete Request', message: body['error_message'] ?? 'Something went wrong');
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<void> updatePIN({required String oldPIN, required String newPIN}) async {
    final payload = {'old_security_pin': oldPIN, 'security_pin': newPIN};
    try {
      final response = await http.post(
        Uri.parse(APIPath.updatePIN(user!.id)),
        headers: headers(
          token: token,
          hmac: generateHMACSignature(
            path: APIPath.updatePIN(user!.id),
            method: 'POST',
            payload: payload,
          ),
        ),
        body: json.encode(payload),
      );
      final body = json.decode(response.body);

      if (body['errors'] != null) {
        throw CustomHttpException(
            title: 'Couldn\'t Complete Request', message: body['errors'][0]['message'] ?? 'Something went wrong');
      } else if (body['error_message'] != null) {
        throw CustomHttpException(title: 'Couldn\'t Complete Request', message: body['error_message'] ?? 'Something went wrong');
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<void> postMobileNumber(String mobileNumber) async {
    try {
      final response = await http.post(
        Uri.parse(APIPath.postMobileNumber),
        headers: headers(
          token: token,
          hmac: generateHMACSignature(
            path: APIPath.postMobileNumber,
            method: 'POST',
            payload: {'user': user!.id, 'number': mobileNumber},
          ),
        ),
        body: json.encode({'user': user!.id, 'number': mobileNumber}),
      );
      final body = json.decode(response.body);

      // await getUser();

      if (body['errors'] != null) {
        throw CustomHttpException(
            title: 'Couldn\'t Complete Request', message: body['errors'][0]['message'] ?? 'Something went wrong');
      } else if (body['error_message'] != null) {
        throw CustomHttpException(title: 'Couldn\'t Complete Request', message: body['error_message'] ?? 'Something went wrong');
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<void> confirmMobileNumber(String token) async {
    try {
      final response = await http.post(
        Uri.parse(APIPath.confirmMobileNumber(user!.userProfile.mobileNumber!.id)),
        headers: headers(
          token: token,
          hmac: generateHMACSignature(
            path: APIPath.confirmMobileNumber(user!.userProfile.mobileNumber!.id),
            method: 'POST',
            payload: {'token': token},
          ),
        ),
        body: json.encode({'token': token}),
      );
      final body = json.decode(response.body);
      if (body['status_code'] == 401) {
        throw CustomHttpException(title: 'Couldn\'t Complete Request', message: body['message'] ?? 'Something went wrong');
      } else if (body['errors'] != null) {
        throw CustomHttpException(
            title: 'Couldn\'t Complete Request', message: body['errors'][0]['message'] ?? 'Something went wrong');
      } else if (body['error_message'] != null) {
        throw CustomHttpException(title: 'Couldn\'t Complete Request', message: body['error_message'] ?? 'Something went wrong');
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<User> getUser() async {
    try {
      final response = await http.get(
        Uri.parse(APIPath.getUser),
        headers: headers(token: token),
      );
      final body = json.decode(response.body);

      if (body['errors'] != null) {
        throw CustomHttpException(
            title: 'Couldn\'t Complete Request', message: body['errors'][0]['message'] ?? 'Something went wrong');
      } else if (body['error_message'] != null) {
        throw CustomHttpException(title: 'Couldn\'t Complete Request', message: body['error_message'] ?? 'Something went wrong');
      }
      final foundUser = User.fromMap(json.decode(response.body));
      updateWith(user: foundUser);
      setUserDeviceInfo();
      MixPanelService.setUserIdentifier(foundUser.id); // set user id
      MixPanelService.setOnceProperty({
        'name': foundUser.name,
        'email': foundUser.email,
      }); // set once property
      MixPanelService.updateUserActivity('LoggedIn'); // logged user  time of sign in
      return foundUser;
      // return body['id'];
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<void> setNotificationOption(NotificationOption option) async {
    // try {
    //   final response = await http.patch(
    //     Uri.parse(APIPath.notificationOption(user!.id)),
    //     headers: headers(
    //       token: token,
    //       hmac: generateHMACSignature(
    //         method: 'PATCH',
    //         path: APIPath.notificationOption(user!.id),
    //         payload: option.toMap(),
    //       ),
    //     ),
    //     body: option.toJson(),
    //   );
    //   final body = json.decode(response.body);
    //   if (body['status_code'] == 401) {
    //     throw CustomHttpException(
    //         title: 'An error occurred', message: body['message']);
    //   }
    //   // return NotificationOption.fromJson(body);
    // } catch (exception, stackTrace) {
    //   await Sentry.captureException(
    //     exception,
    //     stackTrace: stackTrace,
    //   );
    //   rethrow;
    // }
  }

  // @override
  // Future<NotificationOption> fetchNotificationOption() async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse(APIPath.notificationOption(user!.id)),
  //       headers: headers(token: token),
  //     );
  //     return NotificationOption.fromJson(response.body);
  //   } catch (exception, stackTrace) {
  //     await Sentry.captureException(
  //       exception,
  //       stackTrace: stackTrace,
  //     );
  //     rethrow;
  //   }
  // }

  @override
  Future<bool> closeAccountCheck() async {
    try {
      final response = await http.get(
        Uri.parse(APIPath.closeAccountCheck(user!.id)),
        headers: headers(token: token),
      );
      final body = json.decode(response.body);
      if (body['can_close'] != null) {
        if (body['can_close']) {
          return body['can_close'];
        } else {
          throw CustomHttpException(title: 'Error', message: body['message']);
        }
      } else {
        return false;
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<void> closeAccount(String reason) async {
    try {
      final response = await http.post(
        Uri.parse(APIPath.closeAccount(user!.id)),
        headers: headers(
          token: token,
          hmac: generateHMACSignature(
            path: APIPath.closeAccount(user!.id),
            method: 'POST',
            payload: {'reason_for_closure': reason},
          ),
        ),
        body: json.encode({'reason_for_closure': reason}),
      );

      final body = json.decode(response.body);

      if (body['errors'] != null) {
        throw CustomHttpException(
            title: 'Couldn\'t Complete Request', message: body['errors'][0]['message'] ?? 'Something went wrong');
      } else if (body['error_message'] != null) {
        throw CustomHttpException(title: 'Couldn\'t Complete Request', message: body['error_message'] ?? 'Something went wrong');
      }
      updateWith(token: null, user: null);
      localBase.deleteToken();
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  // @override
  // Future<void> setTaxResidence(TaxCountry country) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse(APIPath.taxResidence),
  //       headers: {
  //         'content-type': 'application/json; charset=utf-8',
  //         'Accept': 'application/json',
  //         'X-Auth-Client': authClient,
  //         'Authorization': 'Token $token',
  //         'X-HMAC-SIGNATURE': generateHMACSignature(
  //           path: APIPath.taxResidence,
  //           method: 'POST',
  //           payload: country.toMap(),
  //         ),
  //       },
  //       body: country.toJson(),
  //     );

  //     final body = json.decode(response.body);

  //     if (body['errors'] != null) {
  //       throw CustomHttpException(
  //           title: 'Couldn\'t Complete Request',
  //           message: body['errors'][0]['message'] ?? 'Something went wrong');
  //     } else if (body['error_message'] != null) {
  //       throw CustomHttpException(
  //           title: 'Couldn\'t Complete Request',
  //           message: body['error_message'] ?? 'Something went wrong');
  //     }
  //   } catch (exception, stackTrace) {
  //     await Sentry.captureException(
  //       exception,
  //       stackTrace: stackTrace,
  //     );
  //     rethrow;
  //   }
  // }

  @override
  void setToken(String token) {
    updateWith(token: token);
  }

  void updateWith({String? token, User? user}) {
    this.token = token ?? this.token;
    this.user = user ?? this.user;
  }
}
