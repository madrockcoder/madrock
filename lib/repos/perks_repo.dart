import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sentry_flutter/sentry_flutter.dart';

import '../app/shared_widgets/http_exception.dart';
import '../models/perk.dart';
import '../util/security.dart';
import 'api_path.dart';

abstract class PerksBase {
  Future<List<Perk>> fetchPerks();
  Future<void> claimPerk(String perkId);
}

class PerksRepo with HMACSecurity implements PerksBase {
  PerksRepo({required this.token, required this.uid});
  final String token;
  final String uid;

  @override
  Future<List<Perk>> fetchPerks() async {
    try {
      final response = await http.get(
        Uri.parse(APIPath.perks),
        headers: headers(token: token),
      );

      final body = json.decode(response.body)['results'] as List<dynamic>;

      return body.map((perk) => Perk.fromMap(perk)).toList();
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<void> claimPerk(String perkId) async {
    try {
      final response = await http.post(
        Uri.parse(APIPath.claimPerk),
        headers: headers(
          token: token,
          hmac: generateHMACSignature(
            path: APIPath.claimPerk,
            method: 'POST',
            payload: {'user': uid, 'perk': perkId},
          ),
        ),
        body: json.encode({'user': uid, 'perk': perkId}),
      );

      final body = json.decode(response.body);

      if (body['errors'] != null) {
        throw CustomHttpException(
            title: 'Insufficient Points',
            message: body['errors'][0]['message']);
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
