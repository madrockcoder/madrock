import 'package:flutter/material.dart';
import 'package:geniuspay/app/KYC/model/account_item_model.dart';
import 'package:geniuspay/app/KYC/pages/kyc_risk_assesment/employee_status/employee_status_page.dart';
import 'package:geniuspay/app/KYC/pages/kyc_risk_assesment/expected_funds/expected_funds_page.dart';
import 'package:geniuspay/app/KYC/view_models.dart/kyc_view_model.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/constants.dart';
import 'package:geniuspay/util/widgets_util.dart';

class OccupationPage extends StatefulWidget {
  const OccupationPage({
    Key? key,
  }) : super(key: key);

  static Future<void> show(
    BuildContext context,
  ) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const OccupationPage(),
      ),
    );
  }

  @override
  State<OccupationPage> createState() => _EmployeeStatusPageState();
}

class _EmployeeStatusPageState extends State<OccupationPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BaseView<KycViewModel>(builder: (context, model, snapshot) {
      return Scaffold(
        appBar: WidgetsUtil.onBoardingAppBar(
          context,
          title: 'Occupation',
        ),
        body: Padding(
          padding: commonPadding,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'What is your occupation?',
                  style: textTheme.bodyMedium
                      ?.copyWith(fontSize: 14, color: AppColor.kPinDesColor),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var es in AccountItemList.occupationList)
                      StatusWidget(
                        text: es.name,
                        icon: es.icon,
                        onTap: () {
                          model.occupation = es.name;
                          ExpectedFundsPage.show(
                            context,
                          );
                        },
                      )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
