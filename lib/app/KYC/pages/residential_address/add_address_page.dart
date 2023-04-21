import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/KYC/pages/residential_address/enter_address_page.dart';
import 'package:geniuspay/app/KYC/pages/residential_address/pick_address.dart';
import 'package:geniuspay/app/home/pages/home_containter.dart';
import 'package:geniuspay/app/shared_widgets/continue_button.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/widgets_util.dart';

class AddAddressPage extends StatelessWidget {
  const AddAddressPage({Key? key}) : super(key: key);
  static Future<void> show(
    BuildContext context,
  ) async {
    await Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const AddAddressPage(),
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
          appBar: WidgetsUtil.onBoardingAppBar(context,
              backButton: IconButton(
                  onPressed: () {
                    HomeWidget.show(context);
                  },
                  icon: const Icon(Icons.close))),
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const Spacer(),
                SizedBox(
                  height: 240,
                  child: Image.asset('assets/images/add_address.png'),
                ),
                const Gap(16),
                Text(
                  'Add your address',
                  style: textTheme.bodyText1?.copyWith(
                    fontSize: 25,
                    color: AppColor.kSecondaryColor,
                  ),
                ),
                const Gap(16),
                Text(
                  'How would you like to add your address?',
                  style: textTheme.bodyText2?.copyWith(
                    fontSize: 14,
                    color: AppColor.kOnPrimaryTextColor2,
                  ),
                ),
                const Spacer(),
                ContinueButton(
                  context: context,
                  color: AppColor.kSecondaryColor,
                  textColor: Colors.white,
                  text: 'CHOOSE ON MAP',
                  onPressed: () async {
                    PickAddressPage.show(context);
                  },
                ),
                const Gap(16),
                Center(
                  child: TextButton(
                    onPressed: () {
                      EnterAddressPage.show(context);
                    },
                    child: Text(
                      'ADD ADDRESS MANUALLY ',
                      style: textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: AppColor.kSecondaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
