// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/home/widget/transaction_detail_page.dart';
import 'package:geniuspay/app/home/widget/transactions_widget.dart';
import 'package:geniuspay/app/shared_widgets/error_screens/error_screen_selector.dart';
import 'package:geniuspay/app/wallet/view_individual_wallet/transactions/transactions_widget.dart';
import 'package:geniuspay/app/wallet/view_individual_wallet/transactions/transactions_widget_vm.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/models/transaction.dart';
import 'package:geniuspay/models/wallet_transaction.dart';
import 'package:geniuspay/util/converter.dart';
import 'package:geniuspay/util/enums.dart';
import 'package:geniuspay/util/widgets_util.dart';

class AllWalletTransactions extends StatefulWidget {
  final String walletId;
  const AllWalletTransactions({Key? key, required this.walletId})
      : super(key: key);
  static Future<void> show(BuildContext context, String walletId) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AllWalletTransactions(
          walletId: walletId,
        ),
      ),
    );
  }

  @override
  State<AllWalletTransactions> createState() => _AllWalletTransactionsState();
}

class _AllWalletTransactionsState extends State<AllWalletTransactions> {
  @override
  Widget build(BuildContext context) {
    return BaseView<WalletTransactionsVM>(
        onModelReady: (p0) =>
            p0.getWalletTransactions(context, widget.walletId),
        builder: (context, model, snapshot) {
          return Scaffold(
              appBar: WidgetsUtil.onBoardingAppBar(
                context,
                title: 'Transaction History',
                // actions: [
                //   IconButton(
                //     onPressed: () {},
                //     icon: SvgPicture.asset('assets/images/filter.svg'),
                //   ),
                // ],
              ),
              body: model.baseModelState == BaseModelState.success
                  ? model.walletTransactionsMini.isEmpty
                      ? const EmptyTransactions()
                      : _TransactionsList(
                          transactions: model.walletTransactions,
                        )
                  : model.baseModelState == BaseModelState.loading
                      ? const LoadingListPage()
                      : ErrorScreen(
                          showHelp: false,
                          onRefresh: () {
                            setState(() {
                              model.getWalletTransactions(
                                  context, widget.walletId);
                            });
                          },
                          exception: model.errorType));
        });
  }
}

class EmptyTransactions extends StatelessWidget {
  const EmptyTransactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListView(
      children: [
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
      ],
    );
  }
}

class _TransactionsList extends StatelessWidget {
  final List<WalletTransaction> transactions;
  const _TransactionsList({Key? key, required this.transactions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        return TransactionListTile(
          onTap: () {
            TransactionDetailPage.show(context, transactions[index]);
          },
          icon: transactions[index].type == TransactionType.exchange
              ? 'assets/images/view_transactions.svg'
              : transactions[index].direction == PaymentDirection.credit
                  ? 'assets/icons/arrow_down.svg'
                  : 'assets/icons/arrow_up.svg',
          text: transactions[index].description,
          paymentDirection: transactions[index].direction,
          status: transactions[index].status,
          amount: transactions[index].debitedAmount,
          date: Converter().getDateFromString(
              transactions[index].createdAt ?? '2021-05-04T22:33:44'),
        );
      },
    );
  }
}
