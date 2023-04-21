import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/home/widget/wallet_selector.dart';
import 'package:geniuspay/app/payout/geniuspay_to_geniuspay/enter_amount_page.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/util/color_scheme.dart';
// import 'package:geniuspay/constants/color_scheme.dart';
// import 'package:geniuspay/constants/style_constants.dart';
// import 'package:geniuspay/widgets/custom_elevated_button.dart';

class AddSuccessPopup extends StatelessWidget {
  final dynamic recipient;
  final Wallet? wallet;
  const AddSuccessPopup(
      {Key? key, required this.recipient, this.wallet})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      title: const CircleAvatar(
          backgroundColor: AppColor.kScaffoldBackgroundColor,
          radius: 40,
          child: Icon(
            Icons.check_rounded,
            size: 35,
            color: Colors.white,
          )),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Recipient added succesfully',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(
            height: 25,
          ),
          CustomElevatedButton(
            color: AppColor.kGoldColor2,
            width: null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black),
                  child: const Icon(
                    Icons.chevron_right_sharp,
                    color: AppColor.kGoldColor2,
                  ),
                ),
                const Gap(16),
                Text('SEND MONEY',
                    style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
            onPressed: () async {
              if(wallet != null){
                EnterTransferAmountPage.show(context, wallet!, recipient);
              }else{
                final result = await showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return const WalletSelectorList(
                        disable: true,
                      );
                    });
                if(result != null){
                  EnterTransferAmountPage.show(context, result, recipient);
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
