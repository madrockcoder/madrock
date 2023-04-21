import 'package:flutter/material.dart';
import 'package:geniuspay/app/KYC/widgets/bottom_sheet_content_list_tile.dart';
import 'package:geniuspay/app/KYC/widgets/compliance_provider.dart';
import 'package:geniuspay/app/auth/pages/sign_up/widgets/auth_provider.dart';
import 'package:geniuspay/app/shared_widgets/custom_divider.dart';
import 'package:provider/provider.dart';

import '../../../../../../util/constants.dart';
import '../../../../../../util/enums.dart';

class EmployeeStatusBottomSheetContent extends StatelessWidget {
  const EmployeeStatusBottomSheetContent(
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
          for (var es in EmployeeStatus.values) ...[
            BottomSheetContentListTile(
                context: context,
                title: authProvider.getEmployeeStatusText(es),
                onTap: () {
                  complianceProvider.updateWith(employeeStatus: es);
                  Navigator.of(context).pop();
                }),
            if (es != EmployeeStatus.values.last)
              const CustomDivider(sizedBoxHeight: 2.0),
          ],
        ],
      ),
    );
  }
}
