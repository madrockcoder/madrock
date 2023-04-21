import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/Profile/refer/refer_a_friend_homescreen.dart';
import 'package:geniuspay/app/home/widget/transactions_widget.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/curved_background.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/models/earnings_model.dart';
import 'package:geniuspay/models/transaction.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/converter.dart';
import 'package:ionicons/ionicons.dart';

class BonusWalletWidget extends StatefulWidget {
  const BonusWalletWidget({Key? key}) : super(key: key);
  static Future<void> show({
    required BuildContext context,
  }) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const BonusWalletWidget(),
      ),
    );
  }

  @override
  State<BonusWalletWidget> createState() => _BonusWalletWidgetState();
}

class _BonusWalletWidgetState extends State<BonusWalletWidget> {
  final AuthenticationService _authenticationService =
      sl<AuthenticationService>();
  EarningsModel get earningsModel =>
      _authenticationService.user!.userProfile.earnings!;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: AppColor.kAccentColor2,
        appBar: AppBar(
          backgroundColor: AppColor.kAccentColor2,
          title: const Text('Bonus Wallet'),
          centerTitle: true,
        ),
        body: ListView(physics: const BouncingScrollPhysics(), children: [
          Padding(
              padding: const EdgeInsets.all(20.0),
              child: CurvedBackground(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(13),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                earningsModel
                                        .availableBalance.valueWithCurrency ??
                                    '',
                                style: textTheme.displayLarge?.copyWith(
                                  color: AppColor.kSecondaryColor,
                                  fontSize: 44,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Text("Pending Balance ",
                                    style: textTheme.bodyMedium?.copyWith(
                                        color: AppColor.kSecondaryColor,
                                        fontSize: 10)),
                                Text(
                                  earningsModel
                                          .pendingBalance.valueWithCurrency ??
                                      '',
                                  style: textTheme.displayLarge?.copyWith(
                                    color: AppColor.kSecondaryColor,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                            ...[
                              const Gap(12),
                              InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 5,
                                    horizontal: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        earningsModel.availableBalance.value > 0
                                            ? AppColor.kSecondaryColor
                                                .withOpacity(0.3)
                                            : Colors.grey.withOpacity(.3),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Ionicons.download_outline,
                                        color: earningsModel
                                                    .availableBalance.value >
                                                0
                                            ? AppColor.kSecondaryColor
                                            : Colors.grey,
                                        size: 12,
                                      ),
                                      Text(
                                        ' Withdraw',
                                        style: textTheme.bodyMedium?.copyWith(
                                            color: earningsModel
                                                        .availableBalance
                                                        .value >
                                                    0
                                                ? AppColor.kSecondaryColor
                                                : Colors.grey,
                                            fontSize: 10),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ],
                        )),
                        const Icon(Icons.star_rounded,
                            color: AppColor.korange, size: 100),
                      ],
                    ),
                    const Gap(20),
                  ],
                ),
              )),
          Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.22),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
              child: SingleChildScrollView(
                  child: Container(
                      constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height / 1.6),
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          const Gap(12),
                          Container(
                            width: 20,
                            height: 2,
                            decoration: BoxDecoration(
                              color: AppColor.kSecondaryColor.withOpacity(0.1),
                            ),
                          ),
                          const Gap(12),
                          if (earningsModel.transactions.isEmpty) ...[
                            Gap(height / 11),
                            Image.asset(
                                'assets/wallets/bonus_wallet_empty.png'),
                            const Gap(16),
                            Text(
                              'You have no bonuses yet',
                              style: textTheme.bodyLarge?.copyWith(
                                  color: AppColor.kSecondaryColor,
                                  fontSize: 16),
                            ),
                            Gap(height / 11),
                            CustomElevatedButton(
                                onPressed: () {
                                  ReferAFriendHomeScreen.show(context);
                                },
                                child: Text(
                                  'START EARNING',
                                  style: textTheme.bodyLarge
                                      ?.copyWith(color: Colors.white),
                                ))
                          ] else ...[
                            Row(
                              children: [
                                Text(
                                  'Earnings History',
                                  style: textTheme.titleLarge,
                                ),
                                const Spacer(),
                              ],
                            ),
                            const Gap(16),
                            ListView.builder(
                                itemCount: earningsModel.transactions.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final transaction =
                                      earningsModel.transactions[index];
                                  return TransactionListTile(
                                    onTap: () {},
                                    icon: 'assets/images/star.svg',
                                    showStatus: false,
                                    text: transaction.description,
                                    customIconWidget: const Icon(
                                      Icons.star_rounded,
                                      color: AppColor.korange,
                                    ),
                                    paymentDirection: PaymentDirection.credit,
                                    amount: transaction.amount,
                                    date: Converter().getDateFromString(
                                        transaction.createdAt),
                                  );
                                })
                          ],
                          const Gap(32),
                        ],
                      )))),
        ]));
  }
}
