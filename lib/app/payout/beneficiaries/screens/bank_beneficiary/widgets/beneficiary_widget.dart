import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/models/bank_beneficiary.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/converter.dart';
import 'package:geniuspay/util/essentials.dart';

class BeneficiaryWidget extends StatelessWidget {
  final BankBeneficiary beneficiary;
  final bool isSelected;
  final GestureTapCallback? onTap;

  BeneficiaryWidget(
      {Key? key,
      required this.beneficiary,
      this.isSelected = false,
      this.onTap})
      : super(key: key);
  final Converter _walletHelper = Converter();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: isSelected ? AppColor.kAccentColor2 : null,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: AppColor.kSecondaryColor)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    beneficiary.beneficiaryFirstName == null
                        ? beneficiary.companyName!
                        : "${beneficiary.beneficiaryFirstName} ${beneficiary.beneficiaryLastName}",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                  const Gap(4),
                  if (beneficiary.isdefault == true)
                    SvgPicture.asset('assets/icons/bookmark.svg',
                        width: 12, height: 18)
                ],
              ),
              const Gap(4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Text(
                    beneficiary.bankName ?? '',
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColor.kSecondaryColor),
                  )),
                  SizedBox(
                    child: Row(
                      children: [
                        CircleAvatar(
                            radius: 10,
                            backgroundImage: AssetImage(
                                'icons/flags/png/${_walletHelper.getLocale(beneficiary.currency)}.png',
                                package: 'country_icons')),
                        const Gap(4),
                        Text(
                          beneficiary.currency,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 12),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Text(
                beneficiary.accountNumber ?? beneficiary.iBan ?? '',
                style: const TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                    color: AppColor.kSecondaryColor),
              ),
              const Gap(4),
              Container(
                decoration: BoxDecoration(
                    color: AppColor.kSecondaryColor.withOpacity(0.5),
                    borderRadius: const BorderRadius.all(Radius.circular(16))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                  child: Text(
                    Essentials.capitalize(beneficiary.beneficiaryType.name),
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 10),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
