import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/KYC/model/account_item_model.dart';
import 'package:geniuspay/app/KYC/pages/kyc_risk_assesment/employee_status/employee_status_page.dart';
import 'package:geniuspay/app/KYC/view_models.dart/kyc_view_model.dart';
import 'package:geniuspay/app/shared_widgets/continue_button.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/widgets_util.dart';

class AccountPurposePage extends StatefulWidget {
  const AccountPurposePage({Key? key}) : super(key: key);
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const AccountPurposePage(),
      ),
    );
  }

  @override
  State<AccountPurposePage> createState() => _AccountPurposePageState();
}

class _AccountPurposePageState extends State<AccountPurposePage> {
  final selected = <int>[];
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BaseView<KycViewModel>(
      builder: (context, model, snapshot) {
        return Scaffold(
          appBar: WidgetsUtil.onBoardingAppBar(
            context,
            title: 'Account Purpose',
          ),
          floatingActionButton: Padding(
              padding: const EdgeInsets.all(24),
              child: ContinueButton(
                context: context,
                color: AppColor.kGoldColor2,
                textColor: Colors.black,
                disabledColor: AppColor.kAccentColor3,
                disable: selected.isEmpty,
                onPressed: () async {
                  model.accountPurpose = selected;
                  await EmployeeStatusPage.show(context);
                },
              )),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'We need to know this for regulatory reasons. And also we\'re curious! You can select more than one reason',
                    style: textTheme.bodyMedium
                        ?.copyWith(fontSize: 14, color: AppColor.kPinDesColor),
                  ),
                  const Gap(20),
                  Column(
                    children: [
                      GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 13.5,
                          mainAxisSpacing: 13.5,
                          childAspectRatio: 1.5,
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: AccountItemList.accountPurposeList.length,
                        itemBuilder: (_, i) => AccountSelectionWidget(
                          isSelected: selected.contains(i),
                          item: AccountItemList.accountPurposeList[i],
                          onTap: () {
                            if (selected.contains(i)) {
                              selected.remove(i);
                            } else {
                              selected.add(i);
                            }
                            setState(() {});
                          },
                        ),
                      )
                    ],
                  ),
                  const Gap(160),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class AccountSelectionWidget extends StatelessWidget {
  const AccountSelectionWidget({
    Key? key,
    required this.isSelected,
    required this.item,
    required this.onTap,
  }) : super(key: key);

  final bool isSelected;
  final VoidCallback onTap;
  final AccountItemModel item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColor.kAccentColor2),
            color: isSelected ? AppColor.kAccentColor2 : Colors.transparent,
          ),
          child: Stack(alignment: Alignment.center, children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColor.kAccentColor2,
                  child: Center(
                    child: SvgPicture.asset(item.icon),
                  ),
                ),
                const Gap(12),
                SizedBox(
                  width: 122,
                  child: Text(item.name,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        letterSpacing: 0.3,
                      )),
                )
              ],
            ),
            if (isSelected)
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                    padding: const EdgeInsets.only(right: 16, top: 12),
                    child: SvgPicture.asset('assets/icons/thick_done.svg')),
              )
          ]),
        ),
      ),
    );
  }
}
