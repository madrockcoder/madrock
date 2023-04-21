import 'package:flutter/material.dart';
import 'package:geniuspay/app/Profile/profile_page_vm.dart';
import 'package:geniuspay/app/shared_widgets/circle_border_icon.dart';
import 'package:geniuspay/app/shared_widgets/custom_yellow_elevated_button.dart';
import 'package:geniuspay/util/color_scheme.dart';

class PlanUpgrade extends StatefulWidget {
  static Future<void> show(
      BuildContext context,
      ) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const PlanUpgrade(),
      ),
    );
  }

  const PlanUpgrade({Key? key})
      : super(key: key);

  @override
  State<PlanUpgrade> createState() => _PlanUpgradeState();
}

class _PlanUpgradeState extends State<PlanUpgrade> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.close, color: AppColor.kSecondaryColor,),
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                          'Your plan doesn’t include this feature',
                          style: textTheme.headlineMedium
                              ?.copyWith(color: AppColor.kSecondaryColor),
                          textAlign: TextAlign.center)),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: CircleBorderIcon(
                      gradientStart: const Color(0xff7ed8fc).withOpacity(.2),
                      gradientEnd: AppColor.kWhiteColor,
                      gapColor: Colors.white,
                      bgColor: AppColor.kAccentColor2,
                      size: 180,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/account/lock.png',
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'Upgrade your plan to unlock a range of features to scale your business.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppColor.kOnPrimaryTextColor2),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          CustomYellowElevatedButton(
            onTap: () {
              ProfilePageVM().logout(context);
            },
            text: "LOG OUT",
          ),
        ],
      ),
    );
  }
}
