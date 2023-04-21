import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:geniuspay/util/color_scheme.dart';

class BeizerChartData {
  bool dotPar(FlSpot spot, LineChartBarData data) {
    if (spot.x == 4) {
      return true;
    } else {
      return false;
    }
  }

  String _bottomTitles(double value) {
    if (value == 1.0) {
      return 'JAN';
    } else if (value == 2.0) {
      return 'FEB';
    } else if (value == 3.0) {
      return 'MAR';
    } else if (value == 4.0) {
      return 'APR';
    } else if (value == 5.0) {
      return 'MAY';
    } else if (value == 6.0) {
      return 'JUN';
    } else if (value == 7.0) {
      return 'JUL';
    } else if (value == 8.0) {
      return 'AUG';
    } else if (value == 9.0) {
      return 'SEP';
    } else if (value == 10.0) {
      return 'OCT';
    } else if (value == 11.0) {
      return 'NOV';
    } else if (value == 12.0) {
      return 'DEC';
    } else {
      return '';
    }
  }

  TextStyle _titleTextStyle(BuildContext context, double value) {
    if (value == 4.0) {
      return TextStyle(
        color: AppColor.kSecondaryColor,
        background: Paint()
          ..color = AppColor.kSecondaryColor.withOpacity(.3)
          ..strokeWidth = 20
          ..strokeJoin = StrokeJoin.round
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke,
      );
    } else {
      return const TextStyle(
        color: AppColor.kSecondaryColor,
      );
    }
  }

  LineChartData get sampleData1 => LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
            bottomTitles: SideTitles(
                showTitles: true,
                getTitles: _bottomTitles,
                margin: 40,
                getTextStyles: _titleTextStyle),
            leftTitles: SideTitles(showTitles: false),
            rightTitles: SideTitles(showTitles: false),
            topTitles: SideTitles(showTitles: false)),
        borderData: FlBorderData(
          show: false,
        ),
        lineBarsData: [
          lineChartBarData1_1,
        ],
        minX: 1,
        maxX: 8,
        maxY: 4,
        minY: 0,
      );
  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        gradientFrom: const Offset(0, 0),
        gradientTo: const Offset(1, 1),
        colors: [
          const Color(0xff008AA7).withOpacity(.26),
          const Color(0xff008AA7)
        ],
        isCurved: true,
        barWidth: 6,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: true,
          checkToShowDot: dotPar,
          getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
              radius: 8,
              color: AppColor.kSecondaryColor,
              strokeWidth: 5,
              strokeColor: Colors.white),
        ),
        spots: const [
          FlSpot(0, 1.2),
          FlSpot(1, 1),
          FlSpot(2, 0),
          FlSpot(3, 1.2),
          FlSpot(4, 5),
          FlSpot(5, 1.2),
          FlSpot(6, 2.2),
          FlSpot(7, 1.2),
          FlSpot(8, 1),
          FlSpot(9, 3),
        ],
      );
}
