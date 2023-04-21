import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:geniuspay/util/converter.dart';


class PointStat extends Equatable {
  final String reason;
  final int points;
  final DateTime date;
  const PointStat({
    required this.reason,
    required this.points,
    required this.date,
  });

  factory PointStat.fromMap(Map<String, dynamic> map) {
    return PointStat(
      reason: map['reason'] ?? '',
      points: map['points'] ?? 0,
      date: Converter().getDateFormatFromString(map['timestamp']),
    );
  }

  factory PointStat.fromJson(String source) =>
      PointStat.fromMap(json.decode(source));

  @override
  List<Object> get props {
    return [reason, points, date];
  }
}

class PointsList {
  PointsList({required this.list});

  factory PointsList.fromJson(List parsedJson) {
    final list = parsedJson.map((value) {
      return PointStat.fromMap(value);
    }).toList();
    return PointsList(list: list);
  }

  final List<PointStat> list;
}
