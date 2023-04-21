import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/models/total_amount.dart';
import 'package:geniuspay/models/transaction.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/converter.dart';
import 'package:geniuspay/util/essentials.dart';

class TransactionListTile extends StatelessWidget {
  const TransactionListTile(
      {Key? key,
      required this.icon,
      required this.text,
      this.paymentDirection = PaymentDirection.credit,
      this.date = '2021-05-04',
      this.status = TransactionStatus.completed,
      required this.amount,
      this.showStatus = true,
      this.customIconWidget,
      this.onTap})
      : super(key: key);

  final String icon;
  final String text;
  final PaymentDirection paymentDirection;
  final String date;
  final TransactionStatus status;
  final TotalAmount amount;
  final VoidCallback? onTap;
  final bool showStatus;
  final Widget? customIconWidget;
  String _getSign(PaymentDirection direction) {
    switch (direction) {
      case PaymentDirection.credit:
        return '+';
      case PaymentDirection.debit:
        return '-';
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: AppColor.kAccentColor2,
                child: Center(
                    child: customIconWidget ??
                        SvgPicture.asset(
                          icon,
                          color: getStatusColor(status),
                        )),
              ),
              const Gap(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: textTheme.bodyMedium?.copyWith(
                        fontSize: 13,
                        color: AppColor.kOnPrimaryTextColor2,
                      ),
                    ),
                    Text(
                      date,
                      style: textTheme.bodyMedium?.copyWith(
                        fontSize: 10,
                        color: AppColor.kGreyColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${_getSign(paymentDirection)} ${Converter().getCurrency(amount.currency)}${amount.value}',
                    style: textTheme.bodyMedium?.copyWith(
                      fontSize: 13,
                      color: AppColor.kOnPrimaryTextColor2,
                    ),
                  ),
                  if (showStatus)
                    Text(
                      Essentials.capitalize(status.name),
                      style: textTheme.bodyMedium?.copyWith(
                        fontSize: 10,
                        color: getStatusColor(status),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ));
  }

  Color getStatusColor(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.completed:
        return AppColor.greenbg;
      case TransactionStatus.pending:
        return AppColor.kGoldColor2;
      default:
        return AppColor.kRedColor;
    }
  }
}
