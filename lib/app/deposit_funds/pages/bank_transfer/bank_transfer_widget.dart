import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/shared_widgets/curved_background.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/custom_tab_indicator.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/models/wallet_account_details.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:share_plus/share_plus.dart';

class BankTransferWidget extends StatefulWidget {
  final Wallet wallet;
  final List<WalletAccountDetails> walletDetailsList;
  const BankTransferWidget(
      {Key? key, required this.wallet, required this.walletDetailsList})
      : super(key: key);
  static Future<void> show(BuildContext context, Wallet wallet,
      List<WalletAccountDetails> walletDetailsList) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BankTransferWidget(
          wallet: wallet,
          walletDetailsList: walletDetailsList,
        ),
      ),
    );
  }

  @override
  State<BankTransferWidget> createState() => _BankTransferWidgetState();
}

class _BankTransferWidgetState extends State<BankTransferWidget>
    with SingleTickerProviderStateMixin {
  final AuthenticationService _authenticationService =
      sl<AuthenticationService>();
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        vsync: this,
        length: widget.walletDetailsList[0].funding_accounts.length);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  Widget _customItem({required String title, required String content}) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.bodyMedium,
        ),
        Text(content,
            style:
                textTheme.titleSmall?.copyWith(color: AppColor.kSecondaryColor)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        if (widget.walletDetailsList[0].funding_accounts.length > 1)
          Container(
              height: 40,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(34),
                  border:
                      Border.all(color: AppColor.kSecondaryColor, width: 3)),
              child: TabBar(
                labelColor: Colors.white,
                controller: _tabController,
                unselectedLabelColor: AppColor.kSecondaryColor,
                indicator: WalletTabIndicator(),
                tabs: [
                  for (final fundingAccount
                      in widget.walletDetailsList[0].funding_accounts)
                    Tab(
                      text: fundingAccount.localOrInternational,
                    ),
                ],
              )),
        Expanded(
            child: TabBarView(
          controller: _tabController,
          children: [
            for (final walletDetails
                in widget.walletDetailsList[0].funding_accounts)
              SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(24),
                  Text(
                      'Make a transfer from bank account registered to "${_authenticationService.user?.firstName} ${_authenticationService.user?.lastName}". Make sure to include your unique reference number.'),
                  const Gap(24),
                  Text(
                    'Bank Details',
                    style: textTheme.bodyLarge
                        ?.copyWith(color: AppColor.kSecondaryColor),
                  ),
                  const Gap(16),
                  SizedBox(
                      height: 266,
                      child: CurvedBackground(
                          borderRadius: 20,
                          bgColor: Colors.white,
                          child: GridView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 16,
                                    mainAxisSpacing: 6,
                                    mainAxisExtent: 50),
                            children: [
                              _customItem(
                                  title: 'To',
                                  content:
                                      "${_authenticationService.user?.firstName} ${_authenticationService.user?.lastName}"),
                              _customItem(
                                  title: 'Bank',
                                  content: walletDetails.bank_name ?? ''),
                              _customItem(
                                  title: walletDetails.account_number_type,
                                  content: walletDetails.account_number),
                              _customItem(
                                  title: 'City',
                                  content: walletDetails.bank_address.city),
                              if (walletDetails.identifier_type.isNotEmpty)
                                _customItem(
                                    title: walletDetails.identifier_type
                                        .replaceAll("_", " "),
                                    content: walletDetails.identifier_value),
                              _customItem(
                                  title: 'Currency',
                                  content:
                                      widget.walletDetailsList[0].currency),
                              _customItem(
                                  title: 'Reference number',
                                  content: _authenticationService
                                          .user?.userProfile.customerNumber ??
                                      ''),
                            ],
                          ))),
                  const Gap(16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.info,
                        size: 16,
                        color: AppColor.kSecondaryColor,
                      ),
                      const Gap(8),
                      Expanded(
                          child: Text(
                        'Everything you send, spend, and receive with this Wallet will show up here.',
                        style: textTheme.titleSmall
                            ?.copyWith(color: AppColor.kSecondaryColor),
                      )),
                    ],
                  ),
                  const Gap(8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.info,
                        size: 16,
                        color: AppColor.kSecondaryColor,
                      ),
                      const Gap(8),
                      Expanded(
                          child: Text(
                        "You won't be able to withdraw this money to a crypto wallet. We don't accept cash deposits because of money laundering regulations. Share details",
                        style: textTheme.titleSmall
                            ?.copyWith(color: AppColor.kSecondaryColor),
                      )),
                    ],
                  ),
                  const Gap(32),
                  CustomElevatedButton(
                    child: Text(
                      'SHARE DETAILS',
                      style: textTheme.bodyLarge,
                    ),
                    onPressed: () {
                      Share.share(
                          'Account Holder: ${_authenticationService.user?.firstName} ${_authenticationService.user?.lastName}\n'
                          '${walletDetails.account_number_type}: ${walletDetails.account_number}\n'
                          '${walletDetails.identifier_type.replaceAll("_", " ")}: ${walletDetails.identifier_value}\n'
                          'Bank Name: ${walletDetails.bank_name}\n'
                          'City: ${walletDetails.bank_address.city}\n'
                          'Currency: ${widget.walletDetailsList[0].currency}\n'
                          'Reference number: ${_authenticationService.user?.userProfile.customerNumber}',
                          subject: 'Here is my geniuspay bank account details:');
                    },
                    color: AppColor.kGoldColor2,
                  ),
                  const Gap(16),
                ],
              ))
          ],
        )),
      ],
    );
  }
}

class DetailsWidget extends StatelessWidget {
  final WalletAccountDetails details;
  const DetailsWidget({Key? key, required this.details}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
