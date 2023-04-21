import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/home/pages/all_transactions_page.dart';
import 'package:geniuspay/app/home/view_models/account_transactions_view_model.dart';
import 'package:geniuspay/app/home/widget/transaction_detail_page.dart';
import 'package:geniuspay/app/home/widget/transactions_widget.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/models/total_amount.dart';
import 'package:geniuspay/models/transaction.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/converter.dart';
import 'package:geniuspay/util/enums.dart';
import 'package:shimmer/shimmer.dart';

class TransactionsMiniWidget extends StatefulWidget {
  final bool isVerified;
  final String? walletId;
  const TransactionsMiniWidget(
      {Key? key, required this.isVerified, this.walletId})
      : super(key: key);

  @override
  State<TransactionsMiniWidget> createState() => _TransactionsMiniWidgetState();
}

class _TransactionsMiniWidgetState extends State<TransactionsMiniWidget> {
  @override
  Widget build(BuildContext context) {
    return !widget.isVerified
        ? const Opacity(opacity: 0.3, child: EmptyTransactionsWidget())
        : BaseView<AccountTransactionsViewModel>(
            onModelReady: (p0) =>
                p0.getAccountTransactionsMini(context, widget.walletId),
            builder: (context, model, snapshot) {
              if (model.baseModelStateMini == BaseModelState.success) {
                if (model.accountTransactionsMini.isEmpty) {
                  return const EmptyTransactionsWidget();
                } else {
                  return AccountTransactionsList(
                      accountTransactions: model.miniTransactions,
                      walletId: widget.walletId);
                }
              } else if (model.baseModelStateMini == BaseModelState.loading) {
                return const LoadingListPage();
              } else {
                return Container();
              }
            },
          );
  }
}

class EmptyTransactionsWidget extends StatelessWidget {
  const EmptyTransactionsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Transactions',
          style: textTheme.titleLarge,
        ),
        const Gap(8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              border: Border.all(color: AppColor.kSecondaryColor, width: 1.5),
              borderRadius: BorderRadius.circular(8)),
          child: Column(children: [
            const Text('You haven’t made any transaction yet!'),
            const Gap(8),
            Image.asset('assets/home/empty_transactions.png')
          ]),
        ),
      ],
    );
  }
}

class AccountTransactionsList extends StatelessWidget {
  final List<Transaction> accountTransactions;
  final String? walletId;
  const AccountTransactionsList(
      {Key? key, required this.accountTransactions, this.walletId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(children: [
      Row(
        children: [
          Text(
            'Transactions',
            style: textTheme.titleLarge,
          ),
          const Spacer(),
          TextButton(
            child: Text(
              'View All',
              style: textTheme.bodyMedium?.copyWith(
                  fontSize: 12, decoration: TextDecoration.underline),
            ),
            onPressed: () {
              AccountTransactionsPage.show(context, walletId, true);
            },
          )
        ],
      ),
      const Gap(12),
      for (int index = 0;
          index <
              (accountTransactions.length > 5 ? 5 : accountTransactions.length);
          index++)
        TransactionListTile(
          onTap: () {
            TransactionDetailPage.show(context, accountTransactions[index]);
          },
          icon: accountTransactions[index].type == TransactionType.exchange
              ? 'assets/images/view_transactions.svg'
              : accountTransactions[index].direction == PaymentDirection.credit
                  ? 'assets/icons/credited_icon.svg'
                  : 'assets/icons/debited_icon.svg',
          text: accountTransactions[index].description,
          paymentDirection: accountTransactions[index].direction,
          status: accountTransactions[index].status,
          amount:
              accountTransactions[index].direction == PaymentDirection.credit
                  ? accountTransactions[index].debitedAmount
                  : accountTransactions[index].totalAmount,
          date: Converter().getDateFromString(
              accountTransactions[index].createdAt ?? '2021-05-04T22:33:44'),
        )
    ]);
  }
}

class LoadingListPage extends StatefulWidget {
  const LoadingListPage({Key? key}) : super(key: key);

  @override
  _LoadingListPageState createState() => _LoadingListPageState();
}

class _LoadingListPageState extends State<LoadingListPage> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      enabled: true,
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 2,
          itemBuilder: (builder, index) {
            return const TransactionListTile(
              icon: 'assets/images/dribble.svg',
              text: 'geniuspay gift',
              amount: TotalAmount(
                  value: 12, currency: '\$', valueWithCurrency: '\$1'),
            );
          }),
    );
  }
}
