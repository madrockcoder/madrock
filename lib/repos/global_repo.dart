import 'dart:convert';

import 'package:http/http.dart' as http;

import '../app/shared_widgets/http_exception.dart';
import '../models/country.dart';
import '../models/currency.dart';
import '../util/security.dart';
import 'api_path.dart';

abstract class GlobalBase {
  late List<Country> foundCountries;
  late List<Currency> foundCurrencies;
  Future<List<Country>> fetchCountries();
  Future<List<Currency>> fetchCurrencies();
}

class GlobalRepo with HMACSecurity implements GlobalBase {
  @override
  List<Country> foundCountries = [];

  @override
  List<Currency> foundCurrencies = [];

  @override
  Future<List<Country>> fetchCountries() async {
    try {
      final response = await http.get(
        Uri.parse(APIPath.fetchCountries('50')),
        headers: headers(),
      );

      final body = json.decode(response.body);
      if (body['message'] != null) {
        throw CustomHttpException(
            title: 'Something went wrong',
            message: 'An exception occurred while trying to fetch countries');
      } else {
        final countries = body['results'] as List<dynamic>;
        final fc =
            countries.map((country) => Country.fromMap(country)).toList();

        foundCountries.addAll(fc);
        return fc;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Currency>> fetchCurrencies() async {
    try {
      final response = await http.get(
        Uri.parse(APIPath.fetchCurrencies('50')),
        headers: headers(),
      );

      // if (body['message'] != null || body['error_message'] != null) {
      //   throw CustomHttpException(title: 'Error', message: body['message']);
      // } else {
      final body = json.decode(response.body)['results'] as List<dynamic>;

      final currencies =
          body.map((currency) => Currency.fromMap(currency)).toList();

      _clearCurrenciesList();
      foundCurrencies.addAll(currencies);
      return currencies;
      // final results = body['results'];

      // List<Currency> currencies = [];
      // results.forEach((currency) {
      //   currencies.add(Currency.fromMap(currency));
      // });

      // return currencies;
      // }
    } catch (e) {
      rethrow;
    }
  }

  void _clearCurrenciesList() => foundCurrencies.clear();
}
