import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/KYC/model/account_item_model.dart';
import 'package:geniuspay/app/KYC/pages/kyc_risk_assesment/account_purpose_page.dart';
import 'package:geniuspay/app/KYC/pages/kyc_risk_assesment/overseas_transaction.dart';
import 'package:geniuspay/app/KYC/view_models.dart/kyc_view_model.dart';
import 'package:geniuspay/app/shared_widgets/continue_button.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/widgets_util.dart';

class SourceOfFundsPage extends StatefulWidget {
  const SourceOfFundsPage({
    Key? key,
  }) : super(key: key);

  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const SourceOfFundsPage(),
      ),
    );
  }

  @override
  State<SourceOfFundsPage> createState() => _SourceOfFundsPageState();
}

class _SourceOfFundsPageState extends State<SourceOfFundsPage> {
  final selected = <int>[];
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BaseView<KycViewModel>(builder: (context, model, snapshot) {
      return Scaffold(
        appBar: WidgetsUtil.onBoardingAppBar(context, title: 'Source of funds'),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(24),
          child: ContinueButton(
            context: context,
            color: AppColor.kGoldColor2,
            textColor: Colors.black,
            disabledColor: AppColor.kAccentColor3,
            disable: selected.isEmpty,
            onPressed: () async {
              model.sourceOfFunds = selected;
              await OverseaTransactionPage.show(context);
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'What will be the source of these funds? (You can select multiple options)',
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
                        itemCount: AccountItemList.sourceOfFunds.length,
                        itemBuilder: (_, i) => AccountSelectionWidget(
                          isSelected: selected.contains(i),
                          item: AccountItemList.sourceOfFunds[i],
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
        ),
      );
    });
  }
}
