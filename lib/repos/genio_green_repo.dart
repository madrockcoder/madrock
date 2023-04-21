import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sentry_flutter/sentry_flutter.dart';

import '../util/security.dart';
import 'api_path.dart';

abstract class GenioGreenBase {
  Future<int> getUserStatPoint();
}

class GenioGreenRepo with HMACSecurity implements GenioGreenBase {
  GenioGreenRepo({
    required this.token,
    required this.uid,
  });
  final String token;
  final String uid;

  @override
  Future<int> getUserStatPoint() async {
    try {
      final response = await http.get(
        Uri.parse(APIPath.getUserPoints),
        headers: headers(token: token),
      );

      final body = json.decode(response.body);
      return body['points'];
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
