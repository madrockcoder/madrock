import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/home/widget/onboarding_status_widget.dart';
import 'package:geniuspay/app/shared_widgets/currency_selection_bottomsheet.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/app/wallet/create_individual_wallet/choose_currency_widget.dart';
import 'package:geniuspay/app/wallet/create_individual_wallet/create_wallet_vm.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/repos/local_repo.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/enums.dart';

class CreateWalletScreen extends StatelessWidget {
  const CreateWalletScreen({Key? key}) : super(key: key);
  static Future<void> show(BuildContext context) async {
    final LocalBase _localBase = sl<LocalBase>();
    if (_localBase.isCreateAWalletPageOpenedOnce()) {
      onCreatePressed(context);
    } else {
      _localBase.setCreateAWalletPageAsOpened();
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const CreateWalletScreen(),
        ),
      );
    }
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
      backgroundColor: AppColor.kAccentColor2,
      appBar: AppBar(
        backgroundColor: AppColor.kAccentColor2,
        centerTitle: true,
        title: const Text('Borderless Wallet'),
        actions: const [HelpIconButton()],
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const Spacer(),
        Image.asset(
          'assets/images/create_wallet_bg.png',
          width: 240,
        ),
        const Gap(32),
        Text(
          'Create a Wallet and',
          style: textTheme.displaySmall?.copyWith(color: AppColor.kSecondaryColor),
        ),
        const Gap(16),
        _listTile('Hold balances in over 70 currencies', textTheme),
        _listTile('Make secure Balance exchange', textTheme),
        _listTile('Receive payments from 190 countries', textTheme),
        const Spacer(),
        Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
            child: CustomElevatedButton(
              child: Text(
                'CREATE WALLET',
                style: textTheme.titleLarge,
              ),
              onPressed: () {
                onCreatePressed(context);
              },
              color: AppColor.kGoldColor2,
            )),
        const Gap(48),
      ]),
    );
  }
}

onCreatePressed(context) {
  final AuthenticationService _authenticationService =
      sl<AuthenticationService>();
  if (_authenticationService.user!.userProfile.onboardingStatus ==
      OnboardingStatus.onboardingCompleted) {
    final CreateWalletViewModel _walletScreenVM = sl<CreateWalletViewModel>();
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return CurrencySelectionBottomSheet(
          onAccountCurrencySelected: (wallet) {},
          onAllCurrencySelected: (currency) {
            _walletScreenVM.setCurrency = currency;
            Navigator.pop(context);
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return AddWalletName(
                    model: _walletScreenVM,
                  );
                });
          },
        );
      },
    );
  } else {
    OnboardingStatusPage.show(
        context, _authenticationService.user!.userProfile.onboardingStatus);
  }
}
