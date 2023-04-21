import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:geniuspay/core/errors/error.dart';
import 'package:geniuspay/core/network/network_info.dart';
import 'package:geniuspay/repos/local_repo.dart';
import 'package:geniuspay/util/essentials.dart';
import 'package:geniuspay/util/security.dart';
import 'package:injectable/injectable.dart';
import 'package:retry/retry.dart';

@lazySingleton
class HttpServiceRequester with HMACSecurity {
  HttpServiceRequester({
    required this.dio,
    required this.networkInfo,
    required this.localBase,
  });

  final Dio dio;

  final NetworkInfo networkInfo;
  final LocalBase localBase;
  Future<Response> post({
    required String endpoint,
    required String uuid,
    String? token,
    Map<String, dynamic>? body,
    Map? queryParam,
    // Map<String, dynamic>? headers,
  }) async {
    if (await networkInfo.isConnected) {
      final header = headers(
        token: localBase.getToken(),
        uuid: uuid,
        hmac: generateHMACSignature(
          path: endpoint,
          method: 'POST',
          payload: body,
        ),
      );

      dio.options.headers = header;
      debugPrint("HEADERS: $header");
      debugPrint("------------------");
      debugPrint("Token from parameter: $token");
      debugPrint("------------------");
      debugPrint("Token from shared pref: ${localBase.getToken()}");
      // final response = await retry(
      //   () => dio
      //       .post<dynamic>(
      //         endpoint,
      //         data: json.encode(body),
      //         queryParameters: queryParam as Map<String, dynamic>?,
      //         options: Options(
      //           headers: header,
      //         ),
      //       )
      //       .timeout(const Duration(seconds: 7)),
      //   // Retry on SocketException or TimeoutException
      //   retryIf: (e) =>
      //       e is SocketException ||
      //       e is ServerException ||
      //       e is TimeoutException ||
      //       (e is DioError &&
      //           (e.type == DioErrorType.connectTimeout ||
      //               e.type == DioErrorType.sendTimeout ||
      //               e.type == DioErrorType.receiveTimeout)),
      // );
      debugPrint('URL: $endpoint');
      debugPrint('METHOD: POST');
      debugPrint('X-HMAC-SIGNATURE: ${generateHMACSignature(
        path: endpoint,
        method: 'POST',
        payload: body,
      )}');

      if (body != null) {
        debugPrint('BODY: ${jsonEncode(body)}');
      }
      if (queryParam != null) {
        debugPrint('QUERY PARAMS: ${jsonEncode(queryParam)}');
      }
      debugPrint('HEADERS: ${jsonEncode(header)}');
      final response = dio.post(
        endpoint,
        data: json.encode(body),
        queryParameters: queryParam as Map<String, dynamic>?,
        options: Options(
          headers: header,
        ),
      );
      return response;
    } else {
      throw NoInternetException();
    }
  }

  Future<Response> putRequest({
    required String endpoint,
    required String uuid,
    String? token,
    Map<String, dynamic>? body,
    Map? queryParam,
    // Map<String, dynamic>? headers,
  }) async {
    if (await networkInfo.isConnected) {
      final header = headers(
        token: localBase.getToken(),
        uuid: uuid,
        hmac: generateHMACSignature(
          path: endpoint,
          method: 'PUT',
          payload: body,
        ),
      );

      dio.options.headers = header;

      debugPrint('URL: $endpoint');
      debugPrint('METHOD: PUT');
      if (body != null) {
        debugPrint('BODY: ${jsonEncode(body)}');
      }
      if (queryParam != null) {
        debugPrint('QUERY PARAMS: ${jsonEncode(queryParam)}');
      }
      // debugPrint('HEADERS: ${jsonEncode(header)}');

      final response = await dio.put<dynamic>(
        endpoint,
        data: body,
        queryParameters: queryParam as Map<String, dynamic>?,
        options: Options(
          headers: header,
        ),
      );
      return response;
    } else {
      throw NoInternetException();
    }
  }

  Future<Response> getRequest({
    required String endpoint,
    bool removeToken = false,
    Map<String, dynamic>? queryParam,
    bool cacheRequest = false,
    Duration cacheDuration = const Duration(
      hours: 24,
    ),
  }) async {
    final header = headers(token: removeToken ? null : localBase.getToken());
    debugPrint('URL: $endpoint');
    debugPrint('METHOD: GET');
    if (queryParam != null) {
      debugPrint('QUERY PARAMS: ${jsonEncode(queryParam)}');
    }
    debugPrint('HEADERS: ${jsonEncode(header)}');
    final response = await retry(
      () => dio
          .get<dynamic>(
            endpoint,
            options: Options(
              headers: header,
            ),
            queryParameters: queryParam,
          )
          .timeout(
            const Duration(
              seconds: 7,
            ),
          ),
      // Retry on SocketException or TimeoutException
      retryIf: (e) =>
          e is SocketException ||
          e is TimeoutException ||
          (e is DioError &&
              (e.type == DioErrorType.connectTimeout ||
                  e.type == DioErrorType.sendTimeout ||
                  e.type == DioErrorType.receiveTimeout)),
    );
    return response;
  }

  Future<Response> deleteRequest({
    required String endpoint,
    required String uuid,
    String? token,
    Map<String, dynamic>? body,
    Map? queryParam,
    // Map<String, dynamic>? headers,
  }) async {
    if (await networkInfo.isConnected) {
      final header = headers(
        uuid: uuid,
        token: localBase.getToken(),
        hmac: generateHMACSignature(
          path: endpoint,
          method: 'DELETE',
          payload: body,
        ),
      );

      dio.options.headers = header;
      debugPrint('URL: $endpoint');
      debugPrint('METHOD: DELETE');
      if (body != null) {
        debugPrint('BODY: ${jsonEncode(body)}');
      }
      if (queryParam != null) {
        debugPrint('QUERY PARAMS: ${jsonEncode(queryParam)}');
      }
      // debugPrint('HEADERS: ${jsonEncode(header)}');
      final response = await dio.delete<dynamic>(
        endpoint,
        data: body,
        queryParameters: queryParam as Map<String, dynamic>?,
        options: Options(
          headers: header,
        ),
      );

      return response;
    } else {
      throw NoInternetException();
    }
  }
}
