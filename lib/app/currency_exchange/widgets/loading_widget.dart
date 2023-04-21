import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/currency_exchange/widgets/exchange_flag_button.dart';
import 'package:geniuspay/app/currency_exchange/widgets/round_button.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/iconPath.dart';
import 'package:shimmer/shimmer.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);
  Widget defaultMoneyWidget(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ExchangeFlagButton(
              defaultCurrencyWallet: const Wallet(
                user: 'user',
                friendlyName: 'EUR WALLET',
                currency: 'EUR',
                isDefault: true,
              ),
              showOtherCurrencies: false,
              wallets: const [],
              onCreateWallet: (val) {},
              voidCallback: (Wallet wallet) {},
            ),
            const Gap(20),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [Text('1 EUR = 1.05 USD'), Text('100.00')],
            ))
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 37,
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                blurRadius: 50,
                color: Color.fromRGBO(7, 5, 26, 0.07),
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Column(
                children: [
                  defaultMoneyWidget(context),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: AppColor.kAccentColor2,
                        ),
                      ),
                      const Gap(5),
                      InkWell(
                        onTap: () {},
                        child: SvgPicture.asset(SvgPath.exchangeSvg),
                      ),
                      const Gap(5),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: AppColor.kAccentColor2,
                        ),
                      ),
                    ],
                  ),
                  defaultMoneyWidget(context),
                  const Gap(20),
                  Container(
                    height: 1,
                    color: AppColor.kAccentColor2,
                  ),
                  const Gap(30),
                  RoundButton(
                    backgroundColor: AppColor.kSecondaryColor,
                    label: 'EXCHANGE AMOUNT',
                    height: 46,
                    margin: 0,
                    voidCallback: () {},
                  )
                ],
              )),
        ),
        const Gap(15),
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 27.5,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 50,
                  color: Color.fromRGBO(7, 5, 26, 0.07),
                  offset: Offset(0, 8),
                ),
              ],
            ),
          ),
        ),
        const Gap(15),
      ],
    );
  }
}
