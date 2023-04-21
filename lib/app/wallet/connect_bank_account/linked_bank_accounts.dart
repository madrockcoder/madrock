import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/shared_widgets/custom_circular_icon.dart';
import 'package:geniuspay/app/shared_widgets/size_config.dart';
import 'package:flutter/material.dart';
import 'package:geniuspay/app/wallet/connect_bank_account/select_bank_page.dart';
import 'package:geniuspay/models/nordigen_bank.dart';
import 'package:geniuspay/util/color_scheme.dart';

class LinkedBankAccounts extends StatefulWidget {
  const LinkedBankAccounts({Key? key}) : super(key: key);

  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const LinkedBankAccounts()),
    );
  }

  @override
  State<LinkedBankAccounts> createState() => _LinkedBankAccountsState();
}

class _LinkedBankAccountsState extends State<LinkedBankAccounts> {
  late List<NordigenBank> linkedBanks;

  @override
  void initState() {
    getLinkedBanks();
    super.initState();
  }

  getLinkedBanks() {
    linkedBanks = [
      // BankAccount(
      //     bankName: "Santander Bank Polski",
      //     accountNumber: "12345 6789 0123 4567",
      //     countryModel:
      //         CountryModel("assets/icons/flags-3.png", "GBP", "£", Country.UK)),
      // BankAccount(
      //     bankName: "Santander Bank Polski",
      //     accountNumber: "12345 6789 0123 4567",
      //     countryModel:
      //         CountryModel("assets/icons/flags-3.png", "GBP", "£", Country.UK)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: AppColor.kWhiteColor,
      appBar: AppBar(
        title: const Text("Linked Bank Accounts"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Gap(12),
              ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: LinkedBankWidget(
                          bankAccount: linkedBanks[index],
                          onTap: () {
                            // do something with linkedBanks[index]
                          },
                        ),
                      ),
                  itemCount: linkedBanks.length),
              const Gap(24),
              CustomCircularIcon(const Icon(Icons.add), radius: 40, onTap: () {
                SelectBankPage.show(context);
              }),
              const Gap(8),
              const Text(
                "Link more accounts",
                style: TextStyle(
                    color: AppColor.kOnPrimaryTextColor2,
                    fontWeight: FontWeight.w300,
                    fontSize: 14),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LinkedBankWidget extends StatelessWidget {
  final NordigenBank bankAccount;
  final GestureTapCallback onTap;

  const LinkedBankWidget(
      {Key? key, required this.bankAccount, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: Ink(
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: AppColor.kSecondaryColor)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomCircularIcon(
                SvgPicture.asset(
                  "assets/icons/building-bank-link.svg",
                  width: 18,
                  height: 18,
                  color: Colors.white,
                ),
                radius: 24,
                color: AppColor.kSecondaryColor,
              ),
              const Gap(8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bankAccount.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: AppColor.kSecondaryColor),
                  ),
                  const Gap(8),
                  const Text(
                    "Account number",
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 12,
                        color: AppColor.kSecondaryColor),
                  ),
                  const Gap(4),
                  const Text(
                    'bankAccount.getHiddenAccountNumber()',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: AppColor.kSecondaryColor),
                  ),
                  const Gap(4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        child: Row(
                          children: const [
                            // CustomCircularImage(
                            //   bankAccount.countryModel.flagAsset,
                            //   radius: 12,
                            // ),
                            Gap(4),
                            // Text(
                            //   bankAccount.countryModel.shortName,
                            //   style: const TextStyle(
                            //       fontWeight: FontWeight.w500, fontSize: 12),
                            // )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
