import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/home/widget/transaction_detail_page.dart';
import 'package:geniuspay/app/home/widget/transactions_widget.dart';
import 'package:geniuspay/app/wallet/view_individual_wallet/transactions/transactions_all_page.dart';
import 'package:geniuspay/app/wallet/view_individual_wallet/transactions/transactions_widget_vm.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/models/total_amount.dart';
import 'package:geniuspay/models/transaction.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/models/wallet_transaction.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/converter.dart';
import 'package:geniuspay/util/enums.dart';
import 'package:shimmer/shimmer.dart';

class WalletTransactionsWidget extends StatefulWidget {
  final Wallet wallet;

  const WalletTransactionsWidget({Key? key, required this.wallet}) : super(key: key);

  @override
  State<WalletTransactionsWidget> createState() => _WalletTransactionsWidgetState();
}

class _WalletTransactionsWidgetState extends State<WalletTransactionsWidget> {
  @override
  Widget build(BuildContext context) {
    return BaseView<WalletTransactionsVM>(
      onModelReady: (p0) => p0.getWalletTransactionsMini(context, widget.wallet.walletID!),
      builder: (context, model, snapshot) {
        if (model.baseModelStateMini == BaseModelState.success) {
          if (model.walletTransactionsMini.isEmpty) {
            return _emptyTransactions(context);
          } else {
            return TransactionsList(
                walletTransactions: model.walletTransactionsMini,
                walletId: widget.wallet.walletID!,
                currency: widget.wallet.currency);
          }
        } else if (model.baseModelStateMini == BaseModelState.loading) {
          return const LoadingListPage();
        } else {
          return const ErrorWidget();
        }
      },
    );
  }

  Widget _emptyTransactions(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final cardPadding = MediaQuery.of(context).size.height * .1;
    return Column(
      children: [
        const Gap(12),
        Container(
          width: 20,
          height: 2,
          decoration: BoxDecoration(
            color: AppColor.kSecondaryColor.withOpacity(0.1),
          ),
        ),
        Gap(cardPadding),
        Row(
          children: [
            const Gap(50),
            SvgPicture.asset('assets/images/transactions.svg'),
            const Gap(8),
            Expanded(
                child: Text(
              'Everything you send, spend, and receive with this Wallet will show up here.',
              style: textTheme.bodyMedium,
            )),
            const Gap(50),
          ],
        ),
        Gap(cardPadding),
      ],
    );
  }
}

class TransactionsList extends StatelessWidget {
  final List<WalletTransaction> walletTransactions;
  final String walletId;
  final String currency;

  const TransactionsList({Key? key, required this.walletTransactions, required this.walletId, required this.currency})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: Column(children: [
          const Gap(12),
          Container(
            width: 20,
            height: 2,
            decoration: BoxDecoration(
              color: AppColor.kSecondaryColor.withOpacity(0.1),
            ),
          ),
          const Gap(12),
          Row(
            children: [
              Text(
                '$currency Transactions',
                style: textTheme.titleLarge,
              ),
              const Spacer(),
              TextButton(
                child: Text(
                  'View All',
                  style: textTheme.bodyMedium?.copyWith(fontSize: 12, decoration: TextDecoration.underline),
                ),
                onPressed: () {
                  AllWalletTransactions.show(context, walletId);
                },
              )
            ],
          ),
          const Gap(12),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (WalletTransaction transaction in walletTransactions)
                    TransactionListTile(
                      onTap: () {
                        TransactionDetailPage.show(context, transaction);
                      },
                      icon: transaction.type == TransactionType.exchange
                          ? 'assets/images/view_transactions.svg'
                          : transaction.direction == PaymentDirection.credit
                              ? 'assets/icons/credited_icon.svg'
                              : 'assets/icons/debited_icon.svg',
                      text: transaction.description,
                      paymentDirection: transaction.direction,
                      status: transaction.status,
                      amount:
                          transaction.direction == PaymentDirection.credit ? transaction.debitedAmount : transaction.totalAmount,
                      date: Converter().getDateFromString(transaction.createdAt ?? '2021-05-04T22:33:44'),
                    )
                ],
              ),
            ),
          ),
        ]));
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
          padding: const EdgeInsets.all(24),
          shrinkWrap: true,
          itemCount: 2,
          itemBuilder: (builder, index) {
            return const TransactionListTile(
              icon: 'assets/images/dribble.svg',
              text: 'geniuspay gift',
              amount: TotalAmount(value: 12, currency: '\$', valueWithCurrency: '\$1'),
            );
          }),
    );
  }
}

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final cardPadding = MediaQuery.of(context).size.height * .1;
    return Column(children: [
      const Gap(12),
      Container(
        width: 20,
        height: 2,
        decoration: BoxDecoration(
          color: AppColor.kSecondaryColor.withOpacity(0.1),
        ),
      ),
      Container(
        padding: EdgeInsets.symmetric(vertical: cardPadding, horizontal: 40),
        child: Row(
          children: [
            SvgPicture.asset('assets/images/error_icon.svg'),
            const Gap(8),
            Expanded(
                child: Text(
              'We were not able to load your transactions',
              style: textTheme.bodyMedium,
            )),
          ],
        ),
      )
    ]);
  }
}
