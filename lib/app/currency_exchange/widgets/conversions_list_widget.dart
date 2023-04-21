import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/models/conversion.dart';
import 'package:geniuspay/util/converter.dart';

import '../../../util/color_scheme.dart';
import '../../../util/iconPath.dart';

class ConversionsListWidget extends StatefulWidget {
  final List<Conversion> conversions;
  const ConversionsListWidget({Key? key, required this.conversions})
      : super(key: key);

  @override
  State<ConversionsListWidget> createState() => _ConversionsListWidgetState();
}

class _ConversionsListWidgetState extends State<ConversionsListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.conversions.length,
      // separatorBuilder: (context, index) {
      //   final date = DateFormat('yyyy-MM-ddThh:mm:ss')
      //       .parse(conversions[index + 1].conversionDate);
      //   final formattedDate = DateFormat('yyyyMMdd').format(date);
      //   final nextDate = index + 2 == conversions.length
      //       ? date
      //       : DateFormat('yyyy-MM-ddThh:mm:ss')
      //           .parse(conversions[index + 2].conversionDate);
      //   final formattedNextDate = DateFormat('yyyyMMdd').format(nextDate);
      //   if (formattedDate != formattedNextDate) {
      //     return Text(_getDateText(date));
      //   } else {
      //     return Container();
      //   }
      // },
      itemBuilder: (context, index) {
        return ConversionTile(conversion: widget.conversions[index]);
      },
    );
  }
}

class ConversionTitle extends StatelessWidget {
  final List<Conversion> conversions;
  const ConversionTitle({Key? key, required this.conversions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ConversionTile extends StatelessWidget {
  final Conversion conversion;
  const ConversionTile({Key? key, required this.conversion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 30,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: AppColor.kSecondaryColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      conversion.buyCurrency,
                      style: textTheme.titleSmall
                          ?.copyWith(color: AppColor.kSecondaryColor),
                    ),
                    const Gap(5),
                    SvgPicture.asset(
                      SvgPath.exchangeHorizontalSvg,
                      color: AppColor.kOnPrimaryTextColor3,
                      width: 8.57,
                      height: 8.57,
                    ),
                    const Gap(5),
                    Text(
                      conversion.sellCurrency,
                      style: textTheme.titleSmall
                          ?.copyWith(color: AppColor.kSecondaryColor),
                    ),
                  ],
                ),
              ),
              const Gap(16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ID: ${conversion.reference}',
                    style: textTheme.bodyMedium?.copyWith(fontSize: 13),
                  ),
                  Text(
                    Converter()
                        .getDateTimeFromString(conversion.conversionDate),
                    style: textTheme.bodyMedium
                        ?.copyWith(fontSize: 11, color: AppColor.kGreyColor),
                  )
                ],
              ),
            ],
          ),
          Text(
            "${Converter().getCurrency(conversion.buyCurrency)}"
            "${conversion.buyAmount ?? conversion.amount}",
            style: textTheme.titleSmall
                ?.copyWith(color: AppColor.kSecondaryColor, fontSize: 13),
          )
        ],
      ),
    );
  }
}
