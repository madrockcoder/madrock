import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/payout/beneficiaries/screens/bank_beneficiary/bank_add_beneficiary.dart';
import 'package:geniuspay/app/payout/beneficiaries/view_models/bank_recipient_vm.dart';
import 'package:geniuspay/app/shared_widgets/custom_circular_icon.dart';
import 'package:geniuspay/app/shared_widgets/custom_divider.dart';
import 'package:geniuspay/models/bank_beneficiary.dart';
import 'package:geniuspay/util/color_scheme.dart';

class AddNewReceiverBottomSheet extends StatefulWidget {
  final Function(BankBeneficiary?) onselected;
  final bool isEuropean;
  const AddNewReceiverBottomSheet(
      {Key? key, required this.onselected, required this.isEuropean})
      : super(key: key);

  @override
  State<AddNewReceiverBottomSheet> createState() =>
      _AddNewReceiverBottomSheetState();
}

class _AddNewReceiverBottomSheetState extends State<AddNewReceiverBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 24.0, right: 24, bottom: 24, top: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  child: const Icon(
                    Icons.close,
                    size: 20,
                    color: AppColor.kSecondaryColor,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  }),
              const Text(
                "Add new receiver",
                style: TextStyle(
                    color: AppColor.kOnPrimaryTextColor2,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
              const Icon(
                Icons.close,
                color: Colors.transparent,
              )
            ],
          ),
          const Gap(40),
          const Text(
            "Who are you sending money to?",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColor.kSecondaryColor),
          ),
          const Gap(24),
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) =>
                  newReceiverWidget(receivers[index]),
              separatorBuilder: (context, index) => const CustomDivider(
                  sizedBoxHeight: 16,
                  color: AppColor.kSecondaryColor,
                  thickness: 0.3),
              itemCount: receivers.length)
        ],
      ),
    );
  }

  final viewModel = BankRecipientVM();
  Widget newReceiverWidget(Receiver receiver) {
    return InkWell(
        onTap: () {
          viewModel.changeSelf(receiver.isSelf);

          BankAddBeneficiaryPage.show(context, viewModel, (beneficiary) {
            Navigator.pop(
              context,
            );
            widget.onselected(beneficiary);
          }, widget.isEuropean, isSomeoneElse: receiver.isSomeoneElse);
        },
        child: Row(
          children: [
            CustomCircularIcon(receiver.isIcon
                ? receiver.leadingIcon!
                : Text(
                    receiver.leadingText!,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: AppColor.kOnPrimaryTextColor2),
                  )),
            const Gap(12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  receiver.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: AppColor.kOnPrimaryTextColor2),
                ),
                Text(
                  receiver.subtitle,
                  style: const TextStyle(
                      fontSize: 12,
                      color: AppColor.kOnPrimaryTextColor2,
                      fontWeight: FontWeight.w300),
                )
              ],
            ),
            const Spacer(),
            SvgPicture.asset('assets/icons/arrow.svg')
          ],
        ));
  }
}

class Receiver {
  final String? leadingText;
  final Widget? leadingIcon;
  final bool isIcon;
  final String title;
  final String subtitle;
  final bool isSelf;
  final bool isSomeoneElse;

  Receiver(this.title, this.subtitle,
      {this.isIcon = true,
      this.leadingIcon,
      this.leadingText,
      this.isSomeoneElse = false,
      required this.isSelf});
}

List<Receiver> receivers = [
  Receiver("Myself", "Send money to your own bank account",
      isIcon: false, leadingText: "MS", isSelf: true),
  Receiver("Someone else", "Send money to someone’s bank account",
      leadingIcon: SvgPicture.asset('assets/icons/user-multiple.svg',
          width: 24, height: 24),
      isSelf: false, isSomeoneElse: true),
  Receiver("Business", "Send money to a business",
      leadingIcon: SvgPicture.asset('assets/icons/business-bag.svg',
          width: 24, height: 24),
      isSelf: false),
];
