import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/wallet/view_individual_wallet/details/widgets/add_copy_trailing_widget.dart';
import 'package:geniuspay/models/wallet_account_details.dart';

extension StringExtension on String {
  String capitalize() {
    try {
      return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
    } catch (e) {
      return '';
    }
  }
}

class AccountDetailsListTiles extends StatelessWidget {
  final FundingAccounts fundingAccount;
  final String accountName;
  final String reference;

  const AccountDetailsListTiles({
    Key? key,
    required this.fundingAccount,
    required this.accountName,
    required this.reference,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AddCopyTrailingWidget(
          title: "Account Name",
          subtitle: accountName,
          onTap: () {},
        ),
        const Gap(16),
        AddCopyTrailingWidget(
          title: fundingAccount.account_number_type,
          subtitle: fundingAccount.account_number,
          onTap: () {},
        ),
        const Gap(16),
        if (fundingAccount.identifier_type.isNotEmpty) ...[
          AddCopyTrailingWidget(
            title: fundingAccount.identifier_type
                .replaceAll('_', ' ')
                .capitalize(),
            subtitle: fundingAccount.identifier_value,
            onTap: () {},
          ),
          const Gap(16)
        ],
        AddCopyTrailingWidget(
          title: 'Bank name',
          subtitle: fundingAccount.bank_name ?? '',
          onTap: () {},
        ),
        const Gap(16),
        AddCopyTrailingWidget(
          title: 'Reference',
          subtitle: reference,
          onTap: () {},
        ),
      ],
    );
  }
}
