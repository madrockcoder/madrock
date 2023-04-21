import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/widgets_util.dart';

class EquivalentPage extends StatelessWidget {
  const EquivalentPage({
    Key? key,
    required this.firstSubText,
    required this.firstText,
    required this.secondSubText,
    required this.secondText,
    required this.title,
  }) : super(key: key);
  final String title;
  final String firstText;
  final String firstSubText;
  final String secondText;
  final String secondSubText;

  static Future<void> show({
    required BuildContext context,
    required String title,
    required String firstText,
    required String firstSubText,
    required String secondText,
    required String secondSubText,
  }) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => EquivalentPage(
          firstSubText: firstSubText,
          firstText: firstText,
          secondSubText: secondSubText,
          secondText: secondText,
          title: title,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColor.kAccentColor2,
      appBar: WidgetsUtil.onBoardingAppBar(
        context,
        title: title,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              firstText,
              style: textTheme.bodyLarge?.copyWith(
                fontSize: 16,
              ),
            ),
            const Gap(12),
            Text(
              firstSubText,
              style: textTheme.bodyMedium,
            ),
            const Gap(32),
            Text(
              secondText,
              style: textTheme.bodyLarge?.copyWith(
                fontSize: 16,
              ),
            ),
            const Gap(12),
            Text(
              secondSubText,
              style: textTheme.bodyMedium,
            ),
          ],
        ),
      )),
    );
  }
}
