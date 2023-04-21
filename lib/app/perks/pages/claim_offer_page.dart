import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/models/perk.dart';
import 'package:geniuspay/models/user.dart';
import 'package:geniuspay/util/color_scheme.dart';

class ClaimOfferPage extends StatelessWidget {
  final Perk perk;
  final User user;
  const ClaimOfferPage({Key? key, required this.perk, required this.user})
      : super(key: key);
  static Future<void> show(BuildContext context, Perk perk, User user) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ClaimOfferPage(
          perk: perk,
          user: user,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColor.kAccentColor2,
      appBar: AppBar(
        backgroundColor: AppColor.kAccentColor2,
      ),
      body: ListView(padding: const EdgeInsets.all(24), children: [
        Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/perks_banner.png',
              width: 230,
            )),
        const Gap(16),
        Text(
          'Claimed',
          textAlign: TextAlign.center,
          style: textTheme.displayMedium?.copyWith(color: AppColor.kSecondaryColor),
        ),
        const Gap(8),
        if (perk.coupon.isNotEmpty) ...[
          const Text(
            'Your voucher code is:',
            textAlign: TextAlign.center,
          ),
          const Gap(16),
          Text(
            perk.coupon,
            textAlign: TextAlign.center,
            style:
                textTheme.headlineSmall?.copyWith(color: AppColor.kSecondaryColor),
          ),
        ],

        const Gap(16),
        Align(
            alignment: Alignment.center,
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColor.kGoldColor2)),
                child: Text(
                  'Go to ${perk.company.name}',
                  style: textTheme.bodyLarge
                      ?.copyWith(color: AppColor.kSecondaryColor),
                ))),
        const Gap(16),
        const Text(
          'Your voucher has also been sent to',
          textAlign: TextAlign.center,
        ),
        Text(
          user.email,
          textAlign: TextAlign.center,
          style: textTheme.bodyLarge?.copyWith(color: AppColor.kSecondaryColor),
        ),
        const Gap(8),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColor.kSecondaryColor)),
          child: Column(children: [
            const Gap(16),
            SizedBox(
                width: 75,
                height: 75,
                child: Image.network(
                  perk.company.logo,
                  fit: BoxFit.fitHeight,
                )),
            const Gap(8),
            Text(
              '10% discount on your next flight',
              style: textTheme.bodyLarge,
            ),
            const Gap(16),
          ]),
        ),
        const Gap(16),
        Text(
          'How to use your voucher\n',
          style: textTheme.bodyLarge
              ?.copyWith(color: AppColor.kSecondaryColor, fontSize: 16),
        ),
        const Text(
            '• If you don’t receive an email from us, please check your spam folder or resend the email\n'
            '• Copy the voucher code above and go to the website\n'
            '•Follow the instructions in the email'),
        const Gap(16),
        // Text(
        //   'Terms and conditions\n',
        //   style: textTheme.bodyText1
        //       ?.copyWith(color: AppColor.kSecondaryColor, fontSize: 16),
        // ),
        // const Text(
        //     '• Get 15% of your next balance exchange transaction by claiming perks with 200 points Get 15% of your next balance exchange transaction\n'
        //     '• Get 15% of your next balance exchange transaction by claiming perks with 200 points\n'
        //     '• Get 15% of your next balance exchange transaction by claiming perks with 200 points '),
      ]),
    );
  }
}
