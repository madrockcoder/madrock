import 'dart:convert';
import 'dart:developer';

import 'package:crypto/crypto.dart';
import 'package:geniuspay/services/remote_config_service.dart';

String secretKey = RemoteConfigService.getRemoteData.secretKey!;
String apiKey = RemoteConfigService.getRemoteData.apiKey!;
//

String authClient = RemoteConfigService.getRemoteData.apiKey!;
//

typedef Payload = Map<String, dynamic>;
typedef GenioHeaders = Map<String, String>;

mixin HMACSecurity {
  String generateHMACSignature({required String path, required String method, required Payload? payload}) {
    var hmacSha256 = Hmac(sha256, utf8.encode(secretKey));
    bool cond = path.endsWith('/onboarding/') || path.endsWith('/create-by-LEI') ? true : false;
    var bytes = utf8.encode(
        "['${_generateHMACPath(path)}', '$method', ${_generateHMACPayload(payload, overrideCondition: cond)}, '$secretKey']");

    var digest = hmacSha256.convert(bytes);
    log("['${_generateHMACPath(path)}', '$method', ${_generateHMACPayload(payload, overrideCondition: cond)}, '$secretKey']");
    return digest.toString();
  }

  String _generateHMACPath(String path) {
    return '/${RemoteConfigService.getRemoteData.apiVersion}${path.split('${RemoteConfigService.getRemoteData.apiVersion}').last}';
  }

  Payload _generateHMACPayload(Map<String, dynamic>? pLoad, {bool overrideCondition = false}) {
    final Payload payload = {};
    if (pLoad != null) {
      pLoad.forEach((key, value) {
        var val = value;
        if (value == true) {
          val = 'True';
        } else if (value == false) {
          val = 'False';
        }
        if (value is List) {
          if (!overrideCondition) {
            payload["'$key'"] = [
              ...value.map<String>((e) {
                return "'$e'";
              }).toList()
            ];
          } else {
            payload["'$key'"] = [
              ...value.map<String>((e) {
                return jsonEncode(e).replaceAll(',"', ', "').replaceAll('"', "'").replaceAll(':', ': ');
              }).toList()
            ];
          }
        } else if (value is Map) {
          payload["'$key'"] = jsonEncode(val).replaceAll("\"", "'").replaceAll(",", ", ").replaceAll("':", "': ");
        } else {
          payload["'$key'"] = val == 'True' ? val : (val == 'False' ? val : "'$val'");
        }
      });
    }
    return payload;
  }

  GenioHeaders headers({String? hmac, String? token, String? uuid}) {
    return {
      'content-type': 'application/json; charset=utf-8',
      'Accept': 'application/json',
      'Accept-language': 'en',
      'X-CHANNEL-CODE': 'MOBILE',
      'X-TENANT-CODE': 'GP',
      'X-Auth-Client': apiKey,
      if (token != null) 'Authorization': 'Token $token',
      if (hmac != null) 'X-HMAC-SIGNATURE': hmac,
      if (uuid != null) 'X-IDEMPOTENCY-KEY': uuid,
    };
  }
}
