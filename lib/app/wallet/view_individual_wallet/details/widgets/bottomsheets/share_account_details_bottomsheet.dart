import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/shared_widgets/custom_circular_icon.dart';
import 'package:geniuspay/app/shared_widgets/custom_yellow_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/models/wallet_account_details.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:share_plus/share_plus.dart';

class ShareAccountDetailsBottomSheet extends StatefulWidget {
  final WalletAccountDetails walletDetailsList;
  final FundingAccounts fundingAccount;

  const ShareAccountDetailsBottomSheet(
      {Key? key, required this.walletDetailsList, required this.fundingAccount})
      : super(key: key);

  @override
  State<ShareAccountDetailsBottomSheet> createState() =>
      _ShareAccountDetailsBottomSheetState();
}

class _ShareAccountDetailsBottomSheetState
    extends State<ShareAccountDetailsBottomSheet> {
  final AuthenticationService _authenticationService =
      sl<AuthenticationService>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(33),
        Column(
          children: [
            const Text(
              "Share account details",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
            const Gap(24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    CustomCircularIcon(
                        Image.asset(
                          "assets/icons/share_via.png",
                          width: 40.72,
                          height: 40,
                        ), onTap: () {
                      String accountHolderName =
                          "${_authenticationService.user?.firstName} ${_authenticationService.user?.lastName}";
                      FundingAccounts fundingAccount = widget.fundingAccount;
                      String text =
                          "Hi There!\n\nHere are my geniuspay bank account details:\n\n";
                      text += "Account Name: $accountHolderName\n";
                      if (fundingAccount.account_number.isNotEmpty) {
                        text +=
                            "${fundingAccount.account_number_type}: ${fundingAccount.account_number}\n";
                      }
                      if (fundingAccount.identifier_value.isNotEmpty) {
                        text +=
                            "${fundingAccount.identifier_type.replaceAll('_', ' ')}:${fundingAccount.identifier_value}\n";
                      }
                      text +=
                          "Bank / Payment institution: ${fundingAccount.bank_name}\n";
                      text +=
                          "Bank address: ${fundingAccount.bank_address.addressLine1}, ${fundingAccount.bank_address.addressLine2}, ${fundingAccount.bank_address.city}, ${fundingAccount.bank_address.state}";
                      Share.share(text,
                          subject:
                              "Here are my bank details for my geniuspay accoubt");
                    }, radius: 80),
                    const Gap(8),
                    const Text(
                      "Share via...",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: AppColor.kOnPrimaryTextColor2),
                    )
                  ],
                ),
                const Gap(48),
                Column(
                  children: [
                    CustomCircularIcon(
                        Image.asset(
                          "assets/icons/export_pdf.png",
                          width: 40.72,
                          height: 40,
                        ), onTap: () {
                      PopupDialogs(context).comingSoonSnack();
                      // Essentials.showBottomSheet(
                      //     const ExportPDFBottomSheet(), context,
                      //     showFullScreen: true,
                      //     bgColor: const Color(0xFFE0F7FE).withOpacity(0.3));
                    }, radius: 80),
                    const Gap(8),
                    const Text(
                      "Export PDF",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: AppColor.kOnPrimaryTextColor2),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
        const Gap(31),
        CustomYellowElevatedButton(
          text: "CANCEL",
          transparentBackground: true,
          onTap: () {
            Navigator.pop(context);
          },
        ),
        const Gap(12),
      ],
    );
  }
}
