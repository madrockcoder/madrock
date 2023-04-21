import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sentry_flutter/sentry_flutter.dart';

import '../app/shared_widgets/http_exception.dart';
import '../models/compliance.dart';
import '../models/country.dart';
import '../models/tin.dart';
import '../util/security.dart';
import 'api_path.dart';

abstract class ComplianceBase {
  Future<void> setComplianceAssessment(Compliance compliance);
  Future<void> setTin(TIN tin);
  Future<List<Country>> fetchCountries(String searchTerm);
}

class ComplianceRepo with HMACSecurity implements ComplianceBase {
  ComplianceRepo({required this.token});
  final String token;

  @override
  Future<void> setComplianceAssessment(Compliance compliance) async {
    // try {
    //   final response = await http.post(
    //     Uri.parse(APIPath.complianceAssessment),
    //     headers: headers(
    //       token: token,
    //       hmac: generateHMACSignature(
    //         path: APIPath.complianceAssessment,
    //         method: 'POST',
    //         payload: compliance.toMap(),
    //       ),
    //     ),
    //     body: compliance.toJson(),
    //   );

    //   final body = json.decode(response.body);
    //   if (body['errors'] != null) {
    //     throw CustomHttpException(
    //         title: 'Oops!',
    //         message: body['errors'][0]['message'] ?? 'Something went wrong');
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
  Future<void> setTin(TIN tin) async {
    try {
      final response = await http.post(
        Uri.parse(APIPath.taxResidence),
        headers: headers(
          token: token,
          hmac: generateHMACSignature(
            path: APIPath.taxResidence,
            method: 'POST',
            payload: tin.toMap(),
          ),
        ),
        body: tin.toJson(),
      );

      final body = json.decode(response.body);

      if (body['errors'] != null) {
        throw CustomHttpException(
            title: 'Couldn\'t Complete Request', message: body['errors'][0]['message'] ?? 'Something went wrong');
      } else if (body['error_message'] != null) {
        throw CustomHttpException(title: 'Couldn\'t Complete Request', message: body['error_message'] ?? 'Something went wrong');
      } else if (body['status_code'] == 401) {
        throw CustomHttpException(title: 'Couldn\'t Complete Request', message: body['message'] ?? 'Something went wrong');
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
}
