import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/KYC/pages/kyc_risk_assesment/us_person_page.dart';
import 'package:geniuspay/app/home/pages/home_containter.dart';
import 'package:geniuspay/app/shared_widgets/continue_button.dart';
import 'package:geniuspay/util/color_scheme.dart';

class KYCRiskStartingPage extends StatelessWidget {
  const KYCRiskStartingPage({
    Key? key,
  }) : super(key: key);

  static Future<void> show(
    BuildContext context,
  ) async {
    await Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const KYCRiskStartingPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return WillPopScope(
        onWillPop: () async {
          HomeWidget.show(context);
          return false;
        },
        child: Scaffold(
          backgroundColor: AppColor.kAccentColor2,
          body: Padding(
            padding: const EdgeInsets.all(44.0),
            child: Column(
              children: [
                const Spacer(),
                SizedBox(
                  height: 137,
                  child: Image.asset('assets/images/personal_details.png'),
                ),
                const Gap(10),
                Text(
                  'Personal details',
                  style: textTheme.displayLarge?.copyWith(
                    color: AppColor.kSecondaryColor,
                    fontSize: 30,
                  ),
                ),
                const Gap(10),
                Text(
                  'To complete the onboarding, we just need a\nfew more details about you',
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColor.kSecondaryColor,
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                Text(
                  'This should take less than few minutes',
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColor.kSecondaryColor,
                    fontSize: 14,
                  ),
                ),
                const Gap(23),
                ContinueButton(
                  context: context,
                  color: AppColor.kGoldColor2,
                  textColor: Colors.black,
                  onPressed: () async {
                    UsPersonScreen.show(context);
                    // try {
                    //   final localBase = sl<LocalBase>();
                    //   final response = await http.get(
                    //     Uri.parse(APIPath.getVeriffSession(
                    //         '40e94499-9fdf-457a-a48c-8e3eabbc1be5')),
                    //     headers: {
                    //       'content-type': 'application/json; charset=utf-8',
                    //       'Accept': 'application/json',
                    //       'Accept-language': 'en',
                    //       'X-CHANNEL-CODE': 'MOBILE',
                    //       'X-TENANT-CODE': 'GP',
                    //       'X-Auth-Client':
                    //           'z1lDAkW1.YYw8U39hZMjXBQY8GEGHXEGcDHkZcsCI',
                    //       'Authorization': 'Token ${localBase.getToken()}',
                    //     },
                    //   );
                    // } catch (e) {
                    // }
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
