import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button_async.dart';
import 'package:geniuspay/app/wallet/view_individual_wallet/details/individual_wallet_details_vm.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/util/color_scheme.dart';

class DeactivateBottomSheet extends StatefulWidget {
  final Wallet wallet;

  const DeactivateBottomSheet({Key? key, required this.wallet})
      : super(key: key);

  @override
  State<DeactivateBottomSheet> createState() => _DeactivateBottomSheetState();
}

class _DeactivateBottomSheetState extends State<DeactivateBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(22),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Gap(52),
          RichText(
            text: TextSpan(
                text: "Are you sure you want to\ndeactivate your ",
                style: textTheme.headlineMedium?.copyWith(fontSize: 20),
                children: [
                  TextSpan(
                      text: widget.wallet.friendlyName,
                      style: textTheme.headlineMedium?.copyWith(
                          fontSize: 20, color: AppColor.kSecondaryColor))
                ]),
            textAlign: TextAlign.center,
          ),
          const Gap(16),
          Text(
            'You may want to temporarly deactivate an account if you want to prevent spending funds on this account when paying with geniuspay card. However, incoming payments into this account will still be processed as usual. You will be able to reactivate this account at any time.',
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium,
          ),
          const Gap(30),
          CustomElevatedButtonAsync(
              color: AppColor.kGoldColor2,
              onPressed: () async {
                await WalletDetailsVM().closeWallet(context, widget.wallet);
              },
              child: Text(
                'YES, DELETE MY ACCOUNT',
                style: textTheme.titleLarge,
              )),
          const Gap(10),
          CustomElevatedButton(
              color: AppColor.kWhiteColor,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('CANCEL', style: textTheme.titleLarge)),
        ],
      ),
    );
  }
}
