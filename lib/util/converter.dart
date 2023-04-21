import 'dart:math';

import 'package:geniuspay/models/wallet.dart';
import 'package:intl/intl.dart';

class Converter {
  String getDateFromCupertinoDatePicker(String date) {
    final formatted = DateFormat('yyyy-MM-dd').parse(date);
    final result = DateFormat('dd-MM-yyyy').format(formatted);
    return result;
  }

  String getDateFromString(String date) {
    final formatted = DateFormat('yyyy-MM-ddThh:mm:ss').parse(date);
    final result = DateFormat('yyyy.MM.dd').format(formatted);
    return result;
  }

  DateTime getDateFormatFromString(String date) {
    final result = DateFormat('yyyy-MM-ddThh:mm:ssZ').parseUtc(date);

    // final resultWithTimeZone = dateTimeToZone(zone: DateTime.now().timeZoneName, datetime: result);

    return result;
  }

  double reduceDecimals(double input, {int precision = 2}) {
    try {
      return double.parse('$input'.substring(0, '$input'.indexOf('.') + precision + 1));
    } catch (e) {
      return input;
    }
  }

  String getDateTimeFromString(String date) {
    final formatted = DateFormat('yyyy-MM-ddThh:mm:ss').parse(date);
    final result = DateFormat('yyyy.MM.dd  | hh:mm a').format(formatted);
    return result;
  }

  String getCurrency(String currency) {
    final format = NumberFormat.simpleCurrency(
      name: currency,
    );
    return format.currencySymbol;
  }

  String? formatCurrency(AvailableBalance amount) {
    final symbol = getCurrency(amount.currency);
    final format = NumberFormat.currency(symbol: symbol).format(amount.value);
    return format;
  }

  String getLocale(String currency) {
    if (currency == 'XOF') {
      return 'ie';
    }
    return (currency[0] + currency[1]).toLowerCase();
  }

  static getRadianFromDegree(int i) {
    return i * (pi / 180);
  }
}
