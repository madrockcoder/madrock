import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/deposit_funds/widgets/round_tag_button.dart';
import 'package:geniuspay/app/payout/international_transfer/international_transfer_main.dart';

import '../../../util/color_scheme.dart';
import '../../../util/iconPath.dart';

class ChoosePaymentCard extends StatelessWidget {
  const ChoosePaymentCard({
    Key? key,
    required this.leadingIcon,
    this.logoList,
    required this.cardTitle,
    required this.limitValue,
    required this.feeValue,
    required this.onTapCard,
    required this.onTapInfo,
    required this.feeDuration,
    required this.paymentMethod,
  }) : super(key: key);

  final Widget leadingIcon;
  final List<String>? logoList;
  final String limitValue;
  final String feeValue;
  final String cardTitle;
  final String feeDuration;
  final VoidCallback onTapCard;
  final VoidCallback onTapInfo;
  final PaymentMethod paymentMethod;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {
        onTapCard();
      },
      child: Container(
        width: double.infinity,
        height: 130,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColor.kWhiteColor,
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              color: Color.fromRGBO(7, 5, 26, 0.07),
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: AppColor.kAccentColor2,
                        borderRadius: BorderRadius.circular(100)),
                    child: leadingIcon,
                  ),
                  const Gap(10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            cardTitle,
                            style: textTheme.headlineSmall?.copyWith(fontSize: 12),
                          ),
                        ),
                        const Gap(10),
                        logoList != null
                            ? Column(
                                children: [
                                  SizedBox(
                                    height: 15,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: logoList!.length,
                                      itemBuilder: (context, index) {
                                        return Image.asset(logoList![index],
                                            width: 30, height: 15);
                                      },
                                    ),
                                  ),
                                  const Gap(10),
                                ],
                              )
                            : Container(),
                        Text(
                          limitValue,
                          style: textTheme.titleSmall
                              ?.copyWith(color: AppColor.kSecondaryColor),
                        ),
                        const Gap(5),
                        Row(
                          children: [
                            RoundTag(label: feeValue),
                            const Gap(10),
                            RoundTag(label: feeDuration)
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 30,
              child: InkWell(
                  onTap: () {
                    onTapInfo();
                  },
                  child: SvgPicture.asset(SvgPath.infoCircleIconSvg)),
            )
          ],
        ),
      ),
    );
  }
}
