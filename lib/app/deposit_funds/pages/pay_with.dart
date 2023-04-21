import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/deposit_funds/pages/stitch/stitch_payment.dart';
import 'package:geniuspay/app/deposit_funds/pages/trustly/trustly_payment.dart';
import 'package:geniuspay/app/deposit_funds/widgets/round_tag_button.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/util/iconPath.dart';

import '../../../util/color_scheme.dart';

class PayWithPage extends StatefulWidget {
  final Wallet wallet;
  const PayWithPage({Key? key, required this.wallet}) : super(key: key);

  static Future<void> show(BuildContext context, Wallet wallet) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PayWithPage(
          wallet: wallet,
        ),
      ),
    );
  }

  @override
  State<PayWithPage> createState() => _PayWithPageState();
}

class _PayWithPageState extends State<PayWithPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColor.kWhiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.kWhiteColor,
        centerTitle: true,
        title: Text('Pay with',
            style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
        actions: const [HelpIconButton()],
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColor.kWhiteColor,
          boxShadow: const [
            BoxShadow(
              blurRadius: 30,
              color: Color.fromARGB(25, 56, 56, 56),
              offset: Offset(5, 10),
            ),
          ],
        ),
        margin: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              PayWithTile(
                  title: 'Trustly',
                  iconPath: IconPath.trustlyLogoPNG,
                  subtitle: const RoundTag(label: 'Fee 1-2%'),
                  onTap: () => PayWithTrustlyPage.show(context, widget.wallet)),
              if (widget.wallet.currency == 'ZAR')
                PayWithTile(
                    title: 'Stitch Payments',
                    iconPath: IconPath.stitchLogo,
                    subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  'Available in South Africa and Nigeria',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(fontSize: 10))),
                          const Gap(3),
                          const RoundTag(label: 'Fee 1.5%')
                        ]),
                    onTap: () =>
                        PayWithStitchPage.show(context, widget.wallet)),
            ],
          ),
        ),
      ),
    );
  }

  Widget rapidItem() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          SizedBox(
            height: 24,
            width: 72,
            child: Image.asset(
              IconPath.rapidLogoPNG,
            ),
          ),
          const Gap(35),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Instant bank transfer',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontSize: 14, color: AppColor.kGreyColor)),
              const Gap(5),
              Stack(
                children: [
                  Container(
                    height: 5,
                    width: 145,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: AppColor.kSecondaryColor,
                    ),
                  ),
                  Container(
                    height: 5,
                    width: 5,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(25)),
                  ),
                ],
              ),
              const Gap(3),
              SizedBox(
                width: 145,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('\$0.00 used',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 9, color: AppColor.kSecondaryColor)),
                    Text('\$2,000.00 left',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 9, color: AppColor.kSecondaryColor)),
                  ],
                ),
              ),
              const Gap(3),
              const RoundTag(label: 'Fee 1%')
            ],
          )
        ],
      ),
    );
  }

  Widget voucherItem() {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          SizedBox(
            height: 37.8,
            width: 72,
            child: Image.asset(IconPath.voucherPNG),
          ),
          const Gap(35),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('geniuspay Voucher',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontSize: 14)),
              const Gap(3),
              const RoundTag(label: 'Free')
            ],
          )
        ],
      ),
    );
  }

  Widget divider() {
    return Container(
      color: AppColor.kAccentColor2,
      height: 1,
    );
  }
}

class PayWithTile extends StatelessWidget {
  final String title;
  final Widget subtitle;
  final Function() onTap;
  final String iconPath;
  const PayWithTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.iconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 0,
        margin: EdgeInsets.zero,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
            child: Row(
              children: [
                SizedBox(
                  height: 24,
                  width: 72,
                  child: Image.asset(iconPath),
                ),
                const Gap(35),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(fontSize: 14)),
                    const Gap(4),
                    subtitle
                  ],
                ))
              ],
            ),
          ),
        ));
  }
}
