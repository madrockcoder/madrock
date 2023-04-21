import 'package:flutter/material.dart';
import 'package:geniuspay/app/home/pages/profile_points/profile_points_screen.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/models/points_stat.dart';

class PointsHistoryPage extends StatelessWidget {
  final List<PointStat> pointsList;
  const PointsHistoryPage({Key? key, required this.pointsList})
      : super(key: key);
  static Future<void> show(
      BuildContext context, List<PointStat> pointsList) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
          builder: (_) => PointsHistoryPage(pointsList: pointsList)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Points history'),
          centerTitle: true,
          actions: const [HelpIconButton()],
        ),
        body: ListView.builder(
            itemCount: pointsList.length,
            padding: const EdgeInsets.all(24),
            itemBuilder: (context, index) {
              return PointsTile(point: pointsList[index]);
            }));
  }
}
