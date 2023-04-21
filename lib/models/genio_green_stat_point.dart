import 'dart:convert';

import 'package:equatable/equatable.dart';

class GenioGreenStatPoints extends Equatable {
  final String id;
  final int points;
  final int position;
  final int level;
  const GenioGreenStatPoints({
    required this.id,
    required this.points,
    required this.position,
    required this.level,
  });

  factory GenioGreenStatPoints.fromMap(Map<String, dynamic> map) {
    return GenioGreenStatPoints(
      id: map['id'] ?? '',
      points: map['points']?.toInt() ?? 0,
      position: map['position']?.toInt() ?? 0,
      level: map['level']?.toInt() ?? 0,
    );
  }

  factory GenioGreenStatPoints.fromJson(String source) =>
      GenioGreenStatPoints.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GenioGreenStatPoints(id: $id, points: $points, position: $position, level: $level)';
  }

  @override
  List<Object> get props => [id, points, position, level];
}
