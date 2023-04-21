import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/deposit_funds/widgets/round_tag_button.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/app/shared_widgets/information_tile.dart';
import 'package:geniuspay/models/transaction.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/converter.dart';
import 'package:geniuspay/util/enum_converter.dart';
import 'package:geniuspay/util/essentials.dart';
import 'package:geniuspay/util/iconPath.dart';
import 'package:intl/intl.dart';

class TransactionDetailPage extends StatefulWidget {
  final Transaction transaction;

  const TransactionDetailPage({Key? key, required this.transaction})
      : super(key: key);

  static Future<void> show(
      BuildContext context, Transaction transaction) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => TransactionDetailPage(
          transaction: transaction,
        ),
      ),
    );
  }

  @override
  State<TransactionDetailPage> createState() => _TransactionDetailPageState();
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

class _TransactionDetailPageState extends State<TransactionDetailPage>
    with EnumConverter {
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

  Widget _customButton(
      {required String title, required Function() onTap, required Icon icon}) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
              decoration: BoxDecoration(
                  color: AppColor.kAccentColor2,
                  borderRadius: BorderRadius.circular(12)),
              width: 60,
              height: 60,
              child: icon),
        ),
        const Gap(4),
        Text(
          title,
          style: textTheme.bodyMedium?.copyWith(color: AppColor.kSecondaryColor),
        )
      ],
    );
  }

  String getDate(String? date) {
    if (date != null && date.isNotEmpty) {
      final result = Converter().getDateFormatFromString(date);
      return DateFormat('dd MMM, yyyy').format(result);
    }
    return '';
  }

  String getTime(String? date) {
    if (date != null && date.isNotEmpty) {
      final result = Converter().getDateFormatFromString(date);
      return DateFormat('hh:mma').format(result);
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    final transaction = widget.transaction;
    final textTheme = Theme.of(context).textTheme;
    final amount = transaction.direction == PaymentDirection.credit
        ? transaction.debitedAmount.valueWithCurrency ?? ''
        : transaction.totalAmount.valueWithCurrency ?? '';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction details'),
        centerTitle: true,
        actions: const [HelpIconButton()],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                transaction.completedAt == null
                    ? getDate(transaction.createdAt)
                    : getDate(transaction.completedAt),
                style: textTheme.titleSmall
                    ?.copyWith(color: AppColor.kSecondaryColor.withOpacity(.5)),
              ),
              const Gap(16),
              Text(
                transaction.completedAt == null
                    ? getTime(transaction.createdAt)
                    : getTime(transaction.completedAt),
                style: textTheme.titleSmall
                    ?.copyWith(color: AppColor.kSecondaryColor.withOpacity(.5)),
              )
            ],
          ),
          const Gap(16),
          Text(
            transaction.status.name.capitalize(),
            style: textTheme.titleLarge
                ?.copyWith(color: getStatusColor(transaction.status)),
            textAlign: TextAlign.center,
          ),
          const Gap(10),
          Text(amount,
              textAlign: TextAlign.center,
              style: textTheme.displayLarge
                  ?.copyWith(color: AppColor.kSecondaryColor)),
          const Gap(12),
          if (false)
            Align(
                alignment: Alignment.center,
                child: RoundTag(
                  label: 'International Transfer',
                  textStyle: textTheme.bodyLarge
                      ?.copyWith(color: AppColor.kSecondaryColor, fontSize: 10),
                )),
          const Gap(16),
          const Divider(
            color: AppColor.kSecondaryColor,
            indent: 38,
            endIndent: 38,
          ),
          const Gap(16),
          // Text(
          //   'Details',
          //   style: textTheme.bodyText1,
          // ),
          // const Gap(16),
          InformationTile(
            leadingTitle: 'Reference number',
            trailingText: transaction.reference,
            padding: 10,
          ),
          InformationTile(
            leadingTitle: 'Amount received',
            trailingText: amount,
            padding: 10,
          ),
          if (transaction.sourceWalletRef.isNotEmpty)
            InformationTile(
              leadingTitle: 'Wallet',
              trailingText: transaction.sourceWalletRef,
              padding: 10,
            ),
          InformationTile(
            leadingTitle: 'Currency',
            trailingText: transaction.totalAmount.currency,
            padding: 10,
          ),
          if(transaction.paymentMethod == 'CARD')
          InformationTile(
            leadingTitle: 'Payment method',
            trailingWidget: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if(transaction.paymentMetaData?.brand! == 'visa')
                  Image.asset(IconPath.visaPNG, width: 16,),
                if(transaction.paymentMetaData?.brand! == 'mastercard')
                  Image.asset(IconPath.visaPNG, width: 16,),
                const Gap(4),
                Text(
                  transaction.paymentMetaData != null
                      ? Essentials.capitalize(transaction.paymentMetaData!.brand!) +
                      ' x-' +
                      transaction.paymentMetaData!.last4!
                      : transaction.paymentMethod,
                  textAlign: TextAlign.right,
                  style: textTheme.bodyMedium
                      ?.copyWith(fontSize: 12, color: AppColor.kGreyColor),
                )
              ],
            ),
            padding: 10,
          ),
          if(transaction.paymentMethod != 'CARD')
          InformationTile(
            leadingTitle: 'Payment method',
            trailingText: transaction.paymentMethod,
            padding: 10,
          ),
          const Divider(
            color: AppColor.kAccentColor2,
            indent: 10,
            endIndent: 10,
          ),
          const Gap(16),
          InformationTile(
            leadingTitle: 'Note',
            trailingText: transaction.description,
            padding: 10,
          ),
          InformationTile(
            leadingTitle: 'Transaction type',
            trailingText: getTransactionTypeString(transaction.type),
            padding: 10,
          ),
          if (!shouldTemporaryHideForEarlyLaunch) ...[
            const Gap(32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _customButton(
                    title: 'Repeat',
                    onTap: () {},
                    icon: const Icon(
                      Icons.refresh,
                      color: AppColor.kSecondaryColor,
                    )),
                const Gap(40),
                _customButton(
                    title: 'Download',
                    onTap: () {},
                    icon: const Icon(Icons.cloud_download,
                        color: AppColor.kSecondaryColor)),
                // const Gap(40),
                // _customButton(
                //     title: 'Repeat',
                //     onTap: () {},
                //     icon:
                //         const Icon(Icons.close, color: AppColor.kSecondaryColor))
              ],
            )
          ]
        ],
      ),
    );
  }
}
