import 'package:flutter/material.dart';
import 'package:geniuspay/app/Profile/refer/refer_a_friend_homescreen.dart';
import 'package:geniuspay/app/changes/pages/changes_screen.dart';
import 'package:geniuspay/app/currency_exchange/pages/main_currency_exchange.dart';
import 'package:geniuspay/app/home/pages/more/more_item_container.dart';
import 'package:geniuspay/app/home/widget/wallet_selector.dart';
import 'package:geniuspay/app/payout/beneficiaries/screens/beneficiary_home_screen.dart';
import 'package:geniuspay/app/payout/beneficiaries/screens/borderless/borderless_recipient.dart';
import 'package:geniuspay/app/payout/international_transfer/international_transfer_main.dart';

import 'package:geniuspay/app/perks/pages/perk_page.dart';
import 'package:geniuspay/app/wallet/view_individual_wallet/details/individual_wallet_details.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/util/enums.dart';
import 'package:geniuspay/util/essentials.dart';

import '../../../shared_widgets/popup_dialogs.dart';

class MoreData {
  final BuildContext context;

  // final WalletProvider? walletProvider;
  MoreData(this.context);

  List<MoreItemContainer> get paymentItems => [
        MoreItemContainer(
          assetName: 'assets/icons/home/more/currency_exchange.svg',
          title: 'Currency Exchange',
          onTap: () {
            MainCurrencyExchangePage.show(context: context);
          },
        ),
        MoreItemContainer(
            assetName: 'assets/icons/home/more/gieno.svg',
            title: 'geniuspay Payment',
            hasColor: true,
            onTap: () => BorderlessRecipientHomeScreen.show(context)),
        MoreItemContainer(
          assetName: 'assets/icons/home/more/eu.svg',
          title: 'European Payment',
          onTap: () {
            InternationalTransferPage.show(context, true);
          },
        ),
        if (!shouldTemporaryHideForEarlyLaunch)
          MoreItemContainer(
            assetName: 'assets/icons/home/more/scan.svg',
            title: 'Scan and\nPay',
            onTap: PopupDialogs(context).comingSoonSnack,
          ),
        MoreItemContainer(
          assetName: 'assets/icons/home/more/international_payment.svg',
          title: 'International Payments',
          onTap: () {
            InternationalTransferPage.show(context, false);
          },
        ),
        if (!shouldTemporaryHideForEarlyLaunch)
          MoreItemContainer(
            assetName: 'assets/icons/home/more/multi_payments.svg',
            title: 'Multiple Payments',
            onTap: PopupDialogs(context).comingSoonSnack,
          ),
        if (!shouldTemporaryHideForEarlyLaunch)
          MoreItemContainer(
            assetName: 'assets/icons/home/more/standing_orders.svg',
            title: 'Standing Orders',
            onTap: PopupDialogs(context).comingSoonSnack,
          ),
        if (!shouldTemporaryHideForEarlyLaunch)
          MoreItemContainer(
            assetName: 'assets/icons/home/more/tax_payment.svg',
            title: 'Tax payments',
            onTap: PopupDialogs(context).comingSoonSnack,
          ),
        if (!shouldTemporaryHideForEarlyLaunch)
          MoreItemContainer(
              assetName: 'assets/icons/home/more/jar.svg',
              title: 'Jar',
              onTap: () => ChangesComingSoon.show(
                  context) //PopupDialogs(context).comingSoonSnack,
              ),
      ];

  List<MoreItemContainer> get otherOperations => [
        MoreItemContainer(
          assetName: 'assets/icons/home/more/pay_link.svg',
          title: 'Pay\nLink',
          onTap: PopupDialogs(context).comingSoonSnack,
        ),
        MoreItemContainer(
          assetName: 'assets/icons/home/more/blik_voucher.svg',
          title: 'Money Vouchers',
          onTap: PopupDialogs(context).comingSoonSnack,
        ),
        MoreItemContainer(
          image: 'assets/images/avios.png',
          title: 'Avios\nPoints',
          onTap: () => ChangesComingSoon.show(context),
        ),
        MoreItemContainer(
          assetName: 'assets/icons/home/more/mobile.svg',
          title: 'Mobile\nTop-up',
          onTap: PopupDialogs(context).comingSoonSnack,
        ),
        MoreItemContainer(
          assetName: 'assets/icons/home/more/perks.svg',
          title: 'Perks',
          onTap: () => PerkPage.show(context),
        ),
        MoreItemContainer(
          image: 'assets/icons/home/more/group-payment.png',
          title: 'Group Payment',
          onTap: PopupDialogs(context).comingSoonSnack,
        ),
        MoreItemContainer(
          assetName: 'assets/icons/home/more/beneficiaries.svg',
          title: 'Refer A Friend',
          imageWidth: 16,
          onTap: () => ReferAFriendHomeScreen.show(context),
        ),
      ];

  List<MoreItemContainer> get shortcuts => [
        MoreItemContainer(
          assetName: 'assets/icons/home/more/wallet_details.svg',
          title: 'Wallet details',
          onTap: () async {
            final result = await showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return const WalletSelectorList(
                    disable: true,
                  );
                });
            if (result is Wallet) {
              WalletDetailsScreen.show(
                  context,
                  result,
                  result.status != WalletStatus.ACTIVE,
                  result.walletAccountDetails!);
            }
          },
        ),
        if (!shouldTemporaryHideForEarlyLaunch)
          MoreItemContainer(
            assetName: 'assets/icons/home/more/tax_payments.svg',
            title: 'Wallet Analytics',
            onTap: PopupDialogs(context).comingSoonSnack,
          ),
        if (!shouldTemporaryHideForEarlyLaunch)
          MoreItemContainer(
            assetName: 'assets/icons/home/more/statements.svg',
            title: 'Statements',
            onTap: PopupDialogs(context).comingSoonSnack,
          ),
        if (!shouldTemporaryHideForEarlyLaunch)
          MoreItemContainer(
            assetName: 'assets/icons/home/wallet/linked_card.svg',
            title: 'Linked Cards',
            onTap: PopupDialogs(context).comingSoonSnack,
          ),
    if(shouldTemporaryHideForEarlyLaunch)
      MoreItemContainer(
        assetName: 'assets/icons/home/more/perks.svg',
        title: 'Perks',
        onTap: () => PerkPage.show(context),
      ),
        MoreItemContainer(
          assetName: 'assets/icons/deposit/bankIinkIcon.svg',
          title: 'Linked Accounts',
          onTap: PopupDialogs(context).comingSoonSnack,
        ),
        MoreItemContainer(
          assetName: 'assets/icons/home/more/beneficiaries.svg',
          title: 'Beneficiaries',
          onTap: () async {
            BeneficiaryHomeScreen.show(context);
          },
        ),
      ];
}
