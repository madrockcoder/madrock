import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/payout/beneficiaries/screens/bank_beneficiary/bank_recipient_home.dart';
import 'package:geniuspay/app/payout/beneficiaries/screens/borderless/borderless_recipient.dart';
import 'package:geniuspay/app/shared_widgets/custom_circular_icon.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/essentials.dart';

class BeneficiaryHomeScreen extends StatefulWidget {
  const BeneficiaryHomeScreen({Key? key}) : super(key: key);

  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const BeneficiaryHomeScreen()),
    );
  }

  @override
  State<BeneficiaryHomeScreen> createState() => _BeneficiaryHomeScreenState();
}

class _BeneficiaryHomeScreenState extends State<BeneficiaryHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.kWhiteColor,
        appBar: AppBar(
          title: const Text("Beneficiary"),
          centerTitle: true,
          automaticallyImplyLeading: true,
          actions: const [
            HelpIconButton(),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(18),
            customListTile(
                'assets/icons/world-line.svg',
                'Borderless Recipient',
                'Recipients without account numbers',
                () => BorderlessRecipientHomeScreen.show(context)),
            if(!shouldTemporaryHideForEarlyLaunch)
            customListTile(
                'assets/icons/mobile-check.svg',
                'Mobile Money recipient',
                'Send money to friends through mobile money',
                () => PopupDialogs(context).comingSoonSnack()),
            customListTile('assets/icons/building-bank.svg', 'Bank Recipients',
                'Send money across the globe through bank transfers', () {
              BankRecipientHome.show(
                  context, (p0) => null, false, 'Manage Bank Accounts');
            }),
          ],
        ));
  }

  Widget customListTile(
      String icon, String title, String subtitle, GestureTapCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Row(
            children: [
              CustomCircularIcon(
                SvgPicture.asset(
                  icon,
                  width: 24,
                  height: 24,
                ),
                radius: 40,
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColor.kOnPrimaryTextColor2)),
                  SizedBox(
                    width: 217,
                    child: Text(subtitle,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: AppColor.kPinDesColor)),
                  )
                ],
              ),
              const Spacer(),
              SvgPicture.asset('assets/icons/arrow.svg')
            ],
          ),
        ),
      ),
    );
  }
}
