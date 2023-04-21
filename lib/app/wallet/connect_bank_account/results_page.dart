import 'package:flutter/material.dart';
import 'package:geniuspay/app/home/pages/home_containter.dart';
import 'package:geniuspay/models/nordigen_bank.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/shared_widgets/circle_border_icon.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/util/color_scheme.dart';

class ResultsPage extends StatelessWidget {
  final String resultsText;
  final NordigenBank bank;
  const ResultsPage({Key? key, required this.resultsText, required this.bank})
      : super(key: key);
  static Future<void> show(
      BuildContext context, String resultsText, NordigenBank bank) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ResultsPage(
          resultsText: resultsText,
          bank: bank,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const Spacer(),
                  CircleBorderIcon(
                    gradientStart: const Color(0xff008AA7).withOpacity(.2),
                    gradientEnd: AppColor.kAccentColor2,
                    gapColor: AppColor.kAccentColor2,
                    bgColor: Colors.white,
                    child: Image.network(
                      bank.logo,
                      width: 40,
                      errorBuilder: (_, __, ___) {
                        return const Icon(Icons.add);
                      },
                    ),
                  ),
                  const Gap(32),
                  Text(
                    resultsText,
                    textAlign: TextAlign.center,
                    style: textTheme.bodyLarge?.copyWith(
                        fontSize: 20, color: AppColor.kSecondaryColor),
                  ),
                  const Spacer(),
                  CustomElevatedButton(
                      color: AppColor.kSecondaryColor,
                      onPressed: () {
                        HomeWidget.show(context, resetUser: true);
                      },
                      child: Text(
                        'CONTINUE',
                        style:
                            textTheme.bodyLarge?.copyWith(color: Colors.white),
                      )),
                  const Gap(24),
                ],
              )),
        ));
  }
}
