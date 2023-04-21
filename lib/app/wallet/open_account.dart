import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/jar/pages/jar_screen.dart';
import 'package:geniuspay/app/wallet/connect_bank_account/link_a_bank_page.dart';
import 'package:geniuspay/app/wallet/create_individual_wallet/create_wallet.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/essentials.dart';

class OpenAccount extends StatefulWidget {
  const OpenAccount({Key? key}) : super(key: key);
  static Future<void> show({required BuildContext context, e}) async {
    await Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const OpenAccount()));
  }

  @override
  State<OpenAccount> createState() => _OpenAccountState();
}

class _OpenAccountState extends State<OpenAccount> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        backgroundColor: AppColor.kAccentColor2,
        appBar: AppBar(
          backgroundColor: AppColor.kAccentColor2,
        ),
        body: ListView(padding: const EdgeInsets.all(20), children: [
          Text(
            'Set up\nyour wallet',
            style:
                textTheme.displayLarge?.copyWith(color: AppColor.kSecondaryColor),
          ),
          const Gap(16),
          Text(
            'geniuspay supports multiple currencies\nand is always adding support for more.',
            style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const Gap(40),
          GridView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 16,
              childAspectRatio: MediaQuery.of(context).size.width / 500,
            ),
            children: [
              ItemContainer(
                borderColor: AppColor.kSecondaryColor,
                title: 'Create fiat Wallet',
                svgPath: 'assets/wallets/create_fiat_icon.svg',
                onPressed: () => CreateWalletScreen.show(context),
              ),
              ItemContainer(
                borderColor: AppColor.korange,
                title: 'Add account from another bank',
                svgPath: 'assets/wallets/create_external_bank_icon.svg',
                onPressed: () => LinkABankPage.show(context),
              ),
              if (!shouldTemporaryHideForEarlyLaunch)
                ItemContainer(
                  borderColor: AppColor.kGoldColor2,
                  title: 'Create a jar',
                  svgPath: 'assets/wallets/create_jar_icon.svg',
                  onPressed: () => CreateJarPage.show(context),
                )
            ],
          )
        ]));
  }
}

class ItemContainer extends StatelessWidget {
  final Color borderColor;
  final String title;
  final String svgPath;
  final Function() onPressed;
  const ItemContainer({
    Key? key,
    required this.borderColor,
    required this.title,
    required this.svgPath,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: 2),
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[AppColor.kWhiteColor, AppColor.kAccentColor2],
            ),
          ),
          child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundColor: borderColor,
                      child: SvgPicture.asset(svgPath),
                    ),
                    Text(
                      title,
                      style: textTheme.bodyMedium?.copyWith(
                          color: borderColor, fontWeight: FontWeight.w600),
                    )
                  ])),
        ));
  }
}
