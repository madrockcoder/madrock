import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/app/wallet/view_individual_wallet/details/get_account_details.dart';
import 'package:geniuspay/app/wallet/view_individual_wallet/details/wallet_details_widget_v2.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/models/wallet_account_details.dart';
import 'package:geniuspay/util/color_scheme.dart';

import 'package:shimmer/shimmer.dart';

class WalletDetailsScreen extends StatefulWidget {
  final Wallet wallet;
  final bool getAccount;
  final WalletAccountDetails? walletAccountDetails;
  const WalletDetailsScreen(
      {Key? key,
      required this.wallet,
      required this.getAccount,
      required this.walletAccountDetails})
      : super(key: key);

  static Future<void> show(BuildContext context, Wallet wallet, bool getAccount,
      WalletAccountDetails? walletAccountDetails) async {
    if (getAccount) {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => GetAccountDetails(
            wallet: wallet,
          ),
        ),
      );
    } else {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => WalletDetailsScreen(
            wallet: wallet,
            getAccount: getAccount,
            walletAccountDetails: walletAccountDetails,
          ),
        ),
      );
    }
  }

  @override
  State<WalletDetailsScreen> createState() => _WalletDetailsScreenState();
}

class _WalletDetailsScreenState extends State<WalletDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final wallet = widget.wallet;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: widget.getAccount
              ? const Text('Account details')
              : Text('${wallet.currency} Wallet details'),
          actions: const [HelpIconButton()],
          backgroundColor: widget.getAccount ? null : AppColor.kAccentColor2,
        ),
        backgroundColor: widget.getAccount ? null : AppColor.kAccentColor2,
        body: WalletDetailsWidgetV2(
            wallet: wallet,
            walletDetailsList: widget.walletAccountDetails == null
                ? []
                : [widget.walletAccountDetails!]));
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        enabled: true,
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  color: Colors.grey,
                ),
              ),
              const Gap(20),
              Container(
                height: 50,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  color: Colors.grey,
                ),
              ),
              const Gap(10),
              Container(
                height: 50,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  color: Colors.grey,
                ),
              ),
            ])));
  }
}
