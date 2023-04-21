import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/home/view_models/account_transactions_view_model.dart';
import 'package:geniuspay/app/home/widget/transaction_detail_page.dart';
import 'package:geniuspay/app/home/widget/transaction_filters.dart';
import 'package:geniuspay/app/home/widget/transactions_widget.dart';
import 'package:geniuspay/app/shared_widgets/error_screens/error_screen_selector.dart';
import 'package:geniuspay/app/wallet/view_individual_wallet/transactions/transactions_widget.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/models/transaction.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/converter.dart';
import 'package:geniuspay/util/enums.dart';
import 'package:intl/intl.dart';

class AccountTransactionsPage extends StatefulWidget {
  final String? walletId;
  final bool addLeading;

  const AccountTransactionsPage(
      {Key? key, this.walletId, required this.addLeading})
      : super(key: key);

  static Future<void> show(
      BuildContext context, String? walletId, bool addLeading) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AccountTransactionsPage(
          walletId: walletId,
          addLeading: addLeading,
        ),
      ),
    );
  }

  @override
  State<AccountTransactionsPage> createState() =>
      _AccountTransactionsPageState();
}

class _AccountTransactionsPageState extends State<AccountTransactionsPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BaseView<AccountTransactionsViewModel>(
        onModelReady: (p0) =>
            p0.getAccountTransactions(context, widget.walletId),
        builder: (context, model, snapshot) {
          final datedTransactionList = model.allTransactionsFiltered;
          return Scaffold(
              appBar: AppBar(
                leading: widget.addLeading
                    ? IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back))
                    : null,
                centerTitle: true,
                title: Text(
                  'Transaction History',
                  style: textTheme.displayLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () async {
                      // Navigator.pop(context);
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TransactionFilters(
                                    model: model,
                                  )));
                      setState(() {});
                    },
                    icon: Stack(
                      alignment: Alignment.center,
                      children: [
                        SvgPicture.asset('assets/images/filter.svg'),
                        if (model.getFilterNumber() != 0)
                          Align(
                              alignment: Alignment.bottomRight,
                              child: CircleAvatar(
                                radius: 7,
                                backgroundColor: AppColor.kred,
                                child: Text(
                                  '${model.getFilterNumber()}',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 8),
                                ),
                              ))
                      ],
                    ),
                  ),
                ],
              ),
              body: model.baseModelState == BaseModelState.success
                  ? model.allTransactionsFiltered.isEmpty
                      ? const EmptyTransactions()
                      : RefreshIndicator(
                          color: AppColor.kSecondaryColor,
                          onRefresh: () async {
                            setState(() {
                              model.getAccountTransactions(
                                  context, widget.walletId);
                            });
                          },
                          child: ListView.builder(
                              itemCount: datedTransactionList.length,
                              padding: const EdgeInsets.all(24),
                              itemBuilder: (context, index) {
                                if (model.selectedTransactionTypes.isNotEmpty &&
                                    !model.selectedTransactionTypes.any(
                                        (element) => datedTransactionList[index]
                                            .transactions
                                            .any((element2) =>
                                                element2.type == element))) {
                                  return Container();
                                }
                                if (model.selectedWalletTypes.isNotEmpty &&
                                    !model.selectedWalletTypes.any((element) =>
                                        datedTransactionList[index]
                                            .transactions
                                            .any((element2) =>
                                                element2
                                                    .debitedAmount.currency ==
                                                element.currency))) {
                                  return Container();
                                }
                                if (model.startDate != null &&
                                    model.startDate!.isAfter(
                                        DateFormat('yyyy-MM-dd').parse(
                                            datedTransactionList[index]
                                                .createdDate))) {
                                  return Container();
                                }
                                if (model.startDate != null &&
                                    model.endDate!.isBefore(
                                        DateFormat('yyyy-MM-dd').parse(
                                            datedTransactionList[index]
                                                .createdDate))) {
                                  return Container();
                                }
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      DateFormat('dd MMMM, yyyy').format(
                                          DateFormat('yyyy-MM-dd').parse(
                                              datedTransactionList[index]
                                                  .createdDate)),
                                      style: textTheme.bodyLarge?.copyWith(
                                          color: AppColor.kSecondaryColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const Gap(17),
                                    _TransactionsList(
                                      transactions: datedTransactionList[index]
                                          .transactions,
                                      model: model,
                                    ),
                                    if (index ==
                                        datedTransactionList.length - 1)
                                      SizedBox(
                                        height: 100,
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CircleAvatar(
                                                radius: 16,
                                                backgroundColor:
                                                    AppColor.kAccentColor2,
                                                child: Center(
                                                    child: SvgPicture.asset(
                                                  'assets/images/search.svg',
                                                  width: 16,
                                                  color:
                                                      AppColor.kSecondaryColor,
                                                )),
                                              ),
                                              const Gap(10),
                                              Text(
                                                'No more transactions,\nbut looking for something?',
                                                textAlign: TextAlign.center,
                                                style: textTheme.bodyMedium
                                                    ?.copyWith(
                                                  fontSize: 10,
                                                  color: AppColor.kOnPrimaryTextColor3
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                  ],
                                );
                              }))
                  : model.baseModelState == BaseModelState.loading
                      ? const LoadingListPage()
                      : ErrorScreen(
                          showHelp: false,
                          onRefresh: () {
                            setState(() {
                              model.getAccountTransactions(
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
  final List<Transaction> transactions;
  final AccountTransactionsViewModel model;

  const _TransactionsList(
      {Key? key, required this.transactions, required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactions.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        // if (model.selectedWalletTypes.isNotEmpty &&
        //     model.selectedWalletTypes.any((element) {
        //       print('1:${element.currency}');
        //       print('2:${transactions[index].debitedAmount.currency}');
        //       return element.currency !=
        //           transactions[index].debitedAmount.currency;
        //     })) {
        //   return Container();
        // }
        if (model.selectedTransactionTypes.isNotEmpty &&
            !model.selectedTransactionTypes
                .any((element) => element == transactions[index].type)) {
          return Container();
        }
        if (model.selectedWalletTypes.isNotEmpty &&
            !model.selectedWalletTypes.any((element) =>
                element.currency ==
                transactions[index].debitedAmount.currency)) {
          return Container();
        }

        return TransactionListTile(
          onTap: () {
            TransactionDetailPage.show(context, transactions[index]);
          },
          icon: transactions[index].type == TransactionType.exchange
              ? 'assets/images/view_transactions.svg'
              : transactions[index].direction == PaymentDirection.credit
                  ? 'assets/icons/credited_icon.svg'
                  : 'assets/icons/debited_icon.svg',
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

// final formatted2 = DateFormat('dd-MM-yyyy').parse(endDate); // error if empty
// final formattedEndDate = DateFormat('yyyy-MM-dd').format(formatted2);

// var endingDate = allTransactions.completedAt!.split('T');
// if (endingDate[0] == formattedEndDate) {
//   transaction = allTransactions;
//   // filteredDatedTransactions.add(transaction);
// } else
