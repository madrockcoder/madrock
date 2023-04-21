import 'package:geniuspay/util/enums.dart';
import 'package:intl/intl.dart';

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

class FormatDate {
  static String getDate(String dateTime, [String? format]) {
    // final today = DateTime.now();
    final date = DateTime.tryParse(dateTime);
    if (date == null) {
      return '';
    } else {
      return DateFormat(format ?? 'd MMM, y').format(date);

      // if (date.year == today.year &&
      //     date.month == today.month &&
      //     date.day == today.day) {
      //   return DateFormat(format ?? 'H:m').format(time.toDate()).toString() +
      //       period;
      // } else if (date.year == today.year) {
      //   return DateFormat(format ?? 'd MMM').format(time.toDate()).toString();
      // } else {
      //   return DateFormat(format ?? 'd MMM y').format(time.toDate()).toString();
      // }
    }
  }

  static String getPeriod(String dateTime) {
    final date = DateTime.tryParse(dateTime);
    if (date == null) return '';
    return date.hour < 12 ? 'am' : 'pm';
  }

  static DayPeriod dayPeriod(DateTime dateTime) {
    if (dateTime.hour > 0 && dateTime.hour < 12) {
      return DayPeriod.morning;
    } else if (dateTime.hour > 12 && dateTime.hour < 15) {
      return DayPeriod.afternoon;
    } else {
      return DayPeriod.evening;
    }
  }

  static bool compareDate(String? baseDateTime, String? compareDateTime) {
    if (baseDateTime == null || compareDateTime == null) return false;
    final parsedBaseDateTime = DateTime.tryParse(baseDateTime);
    final parsedCompareDateTime = DateTime.tryParse(compareDateTime);

    return parsedBaseDateTime!.isSameDate(parsedCompareDateTime!);
  }

  ///[formatType] Eg dd-MM-yyyy or MM-DD-YYY
  ///[dateTime] actual date to format
  String format({required String formatType, required DateTime dateTime}) {
    return DateFormat(formatType).format(dateTime);
  }
}
