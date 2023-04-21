import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/KYC/model/account_item_model.dart';
import 'package:geniuspay/app/KYC/pages/kyc_risk_assesment/occupation/occupation_page.dart';
import 'package:geniuspay/app/KYC/view_models.dart/kyc_view_model.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/constants.dart';
import 'package:geniuspay/util/widgets_util.dart';

class EmployeeStatusPage extends StatefulWidget {
  const EmployeeStatusPage({
    Key? key,
  }) : super(key: key);

  static Future<void> show(
    BuildContext context,
  ) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const EmployeeStatusPage(),
      ),
    );
  }

  @override
  State<EmployeeStatusPage> createState() => _EmployeeStatusPageState();
}

class _EmployeeStatusPageState extends State<EmployeeStatusPage> {
  @override
  Widget build(BuildContext context) {
    return BaseView<KycViewModel>(builder: (context, model, snapshot) {
      return Scaffold(
        appBar: WidgetsUtil.onBoardingAppBar(context, title: 'Employee Status'),
        body: Padding(
          padding: commonPadding,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var status in AccountItemList.employeeStatus)
                      StatusWidget(
                        text: status.name,
                        icon: status.icon,
                        onTap: () {
                          model.employeeStatus = status.requestText;
                          OccupationPage.show(
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

class StatusWidget extends StatelessWidget {
  const StatusWidget({
    Key? key,
    required this.onTap,
    required this.text,
    this.isLast = false,
    this.icon,
  }) : super(key: key);

  final String text;
  final VoidCallback onTap;
  final bool isLast;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 0,
              vertical: 20,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColor.kAccentColor2,
                  radius: icon != null ? 20 : 5,
                  child: icon != null
                      ? Center(
                          child: SvgPicture.asset(icon!),
                        )
                      : const SizedBox(),
                ),
                const Gap(12),
                Expanded(
                  child: Text(
                    text,
                    style: textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
