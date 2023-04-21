import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/deposit_funds/pages/choose_payment_page.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/app/shared_widgets/show_draggable_scrollable_sheet.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/util/color_scheme.dart';

class GetAccountDetails extends StatelessWidget {
  final Wallet wallet;
  const GetAccountDetails({Key? key, required this.wallet}) : super(key: key);
  static Future<void> show(BuildContext context, Wallet wallet) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => GetAccountDetails(
          wallet: wallet,
        ),
      ),
    );
  }

  Widget _listTile(String text, TextTheme textTheme) {
    return Padding(
        padding: const EdgeInsets.only(left: 40, bottom: 10),
        child: Row(
          children: [
            const Icon(
              Icons.check_circle,
              color: AppColor.kSecondaryColor,
            ),
            const Gap(12),
            Text(
              text,
              style: textTheme.bodyMedium?.copyWith(fontSize: 16),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          actions: const [HelpIconButton()],
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const Spacer(),
          Image.asset(
            'assets/wallets/get_account_details.png',
            width: 240,
          ),
          const Gap(32),
          Text(
            'Get account details',
            style:
                textTheme.displaySmall?.copyWith(color: AppColor.kSecondaryColor),
          ),
          const Gap(16),
          _listTile('Hold balance in over 70 currencies', textTheme),
          _listTile('Receive transfers, salary or pension', textTheme),
          _listTile('Pay bills via Direct Debit', textTheme),
          const Spacer(),
          Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
              child: CustomElevatedButton(
                child: Text(
                  'CONTINUE',
                  style: textTheme.titleLarge,
                ),
                onPressed: () {
                  showCustomScrollableSheet(
                      context: context,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(Icons.close)),
                              const Gap(24),
                              Text(
                                'Get your ${wallet.currency} account details',
                                style: textTheme.headlineMedium?.copyWith(
                                    color: AppColor.kSecondaryColor,
                                    fontSize: 20),
                              ),
                              const Gap(16),
                              Text(
                                'You can give your new Wallet a new name or we give it a default name.',
                                style: textTheme.bodyMedium,
                              ),
                              const Gap(32),
                              Text(
                                'STEP TO COMPLETE',
                                style: textTheme.titleSmall
                                    ?.copyWith(color: AppColor.kSecondaryColor),
                              ),
                              const Gap(8),
                              const Divider(
                                color: AppColor.kSecondaryColor,
                                height: 5,
                              ),
                              const Gap(16),
                              ListTile(
                                leading: CircleAvatar(
                                    backgroundColor: AppColor.kAccentColor2,
                                    child: SvgPicture.asset(
                                        'assets/wallets/get_account_deposit.svg')),
                                title: Text(
                                    'Deposit at least ${wallet.walletType?.initialDeposit} ${wallet.currency}'),
                                subtitle: const Text(
                                    'You only need to do this for your first set of details. You can use this money later.'),
                              ),
                              const Gap(24),
                              Text(
                                'COMPLETED',
                                style: textTheme.titleSmall
                                    ?.copyWith(color: AppColor.kSecondaryColor),
                              ),
                              const Gap(8),
                              const Divider(
                                color: AppColor.kSecondaryColor,
                                height: 5,
                              ),
                              const Gap(16),
                              ListTile(
                                leading: CircleAvatar(
                                    backgroundColor: AppColor.kGoldColor2,
                                    child: SvgPicture.asset(
                                        'assets/wallets/get_account_verify_id.svg')),
                                title: const Text('Verify your identity'),
                                subtitle: const Text(
                                    'We\'ll need to check your ID. It\'s one of the ways we keep your money safe.'),
                              ),
                              const Spacer(),
                              CustomElevatedButton(
                                  color: AppColor.kGoldColor2,
                                  onPressed: () {
                                    ChoosePaymentPage.show(context, wallet);
                                  },
                                  child: Text(
                                    'MAKE A DEPOSIT',
                                    style: textTheme.bodyLarge,
                                  ))
                            ],
                          )));
                },
                color: AppColor.kGoldColor2,
              )),
        ]));
  }
}
