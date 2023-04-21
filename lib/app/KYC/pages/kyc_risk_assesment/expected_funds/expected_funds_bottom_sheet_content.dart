import 'package:flutter/material.dart';
import 'package:geniuspay/app/KYC/widgets/bottom_sheet_content_list_tile.dart';
import 'package:geniuspay/app/KYC/widgets/compliance_provider.dart';
import 'package:geniuspay/app/auth/pages/sign_up/widgets/auth_provider.dart';
import 'package:geniuspay/app/shared_widgets/custom_divider.dart';
import 'package:provider/provider.dart';

import '../../../../../../util/constants.dart';
import '../../../../../../util/enums.dart';

class ExpectedFundsBottomSheetContent extends StatelessWidget {
  const ExpectedFundsBottomSheetContent(
      {Key? key, required this.complianceProvider})
      : super(key: key);
  final ComplianceProvider complianceProvider;

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    return Padding(
      padding: commonPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var ef in ExpectedFunds.values) ...[
            BottomSheetContentListTile(
                context: context,
                title: authProvider.getExpectedFundsText(ef),
                onTap: () {
                  complianceProvider.updateWith(expectedFunds: ef);
                  Navigator.of(context).pop();
                }),
            if (ef != ExpectedFunds.values.last)
              const CustomDivider(sizedBoxHeight: 2.0),
          ],
        ],
      ),
    );
  }
}
