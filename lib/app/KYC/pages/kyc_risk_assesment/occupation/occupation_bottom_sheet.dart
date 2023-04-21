import 'package:flutter/material.dart';
import 'package:geniuspay/app/KYC/widgets/bottom_sheet_content_list_tile.dart';
import 'package:geniuspay/app/KYC/widgets/compliance_provider.dart';
import 'package:geniuspay/app/auth/pages/sign_up/widgets/auth_provider.dart';
import 'package:geniuspay/app/shared_widgets/custom_divider.dart';
import 'package:provider/provider.dart';

import '../../../../../../util/constants.dart';
import '../../../../../../util/enums.dart';

class OccupationBottomSheetContent extends StatelessWidget {
  const OccupationBottomSheetContent(
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
          for (var occupation in Occupation.values) ...[
            BottomSheetContentListTile(
                context: context,
                title: authProvider.getOccupationText(occupation),
                onTap: () {
                  complianceProvider.updateWith(occupation: occupation);
                  Navigator.of(context).pop();
                }),
            if (occupation != Occupation.values.last)
              const CustomDivider(sizedBoxHeight: 2.0),
          ],
        ],
      ),
    );
  }
}
