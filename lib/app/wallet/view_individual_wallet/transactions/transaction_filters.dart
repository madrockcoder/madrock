import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/app/wallet/wallet_screen_vm.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/converter.dart';

class FilteredTransactionList extends StatefulWidget {
  final String? walletId;
  final bool addLeading;
  const FilteredTransactionList(
      {Key? key, required this.walletId, required this.addLeading})
      : super(key: key);

  @override
  State<FilteredTransactionList> createState() =>
      _FilteredTransactionListState();
}

// List<bool> isTypeSelected = List<bool>.filled(typesOfTransactions.length, false);
List isTypeSelected = [];
List isWalletSelected = [];
List isCurrencySelected = [];
List<String> isStatusSelected = [];
List<String> typesOfTransactions = [
  'All',
  "Balance Exchange",
  "Transfer",
  "Topup",
  "Refund",
  "Wire Transfer"
  // "Deposit",
  // "Remittance",
  // "Wire Transfer",
  // "Internal Transfer",
  // "Exchange",
  // " Balance Transfer",
  // "Internet Purchase",
  // " Payout Withdrawal",
  // "Wallet FundTransfer",
  // "Wallet Refund",
  // "Voucher Deposit",
  // "Invoice Settlement",
  // "Fee Debit"
  //     "Fee Reversal",
  // "Fee Waiver",
  // "Other"
];

List<String> statuses = [
  'All',
  'Completed',
  'Pending',
  'Failed',
  'Refunded',
  'On-Hold'
];
List wallets = [
  const Wallet(
      user: '',
      friendlyName: 'All',
      currency: '',
      isDefault: false,
      internalAccountId: 'All'),
];
List<String> currencies = ['All'];
String startDate = '';
String endDate = '';

class _FilteredTransactionListState extends State<FilteredTransactionList> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BaseView<WalletScreenVM>(
        onModelReady: (p0) => p0.fetchWallets(context),
        builder: (context, model, snapshot) {
          for (var element in model.wallets) {
            if (!currencies.contains(element.currency)) {
              currencies.add(element.currency);
            }
            if (!wallets.contains(element)) {
              wallets.addAll(model.wallets);
            }
          }

          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    isTypeSelected = [];
                    isWalletSelected = [];
                    isCurrencySelected = [];
                    isStatusSelected = [];
                    startDate = '';
                    endDate = '';

                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back)),
              title: Text(
                'Filter',
                style: textTheme.displayLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  CustomElevatedButton(
                      color: AppColor.kGoldColor2,
                      onPressed: () {
                        Navigator.pop(context);
                        if (widget.addLeading) {
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'APPLY FILTER',
                        style: textTheme.bodyLarge,
                      )),
                  CustomElevatedButton(
                      color: AppColor.kWhiteColor,
                      onPressed: () {
                        setState(() {
                          isTypeSelected = [];
                          isWalletSelected = [];
                          isCurrencySelected = [];
                          isStatusSelected = [];
                          startDate = '';
                          endDate = '';
                        });
                      },
                      child: Text(
                        'RESET FILTER',
                        style: textTheme.bodyLarge,
                      )),
                ])),
            body: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 15),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          'Types of transaction',
                          style: textTheme.bodyMedium?.copyWith(
                              color: AppColor.kSecondaryColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Wrap(spacing: 8.0, runSpacing: -6, children: [
                        for (int index = 0;
                            index < typesOfTransactions.length;
                            index++) ...[
                          InputChip(
                            selectedColor: AppColor.kAccentColor2,
                            backgroundColor: Colors.transparent,
                            selected: isTypeSelected.contains(
                                        typesOfTransactions[index]
                                            .replaceAll(' ', '')
                                            .toLowerCase()) ||
                                    (index == 0 && isTypeSelected.isEmpty)
                                ? true
                                : false,
                            showCheckmark: false,
                            pressElevation: 0,
                            padding: const EdgeInsets.all(8),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(
                                    color: isTypeSelected.contains(
                                                typesOfTransactions[index]
                                                    .replaceAll(' ', '')
                                                    .toLowerCase()) ||
                                            (index == 0 &&
                                                isTypeSelected.isEmpty)
                                        ? Colors.transparent
                                        : AppColor.kSecondaryColor)),
                            label: Text(
                              typesOfTransactions[index],
                              style: textTheme.bodyMedium,
                            ),
                            onPressed: () {
                              setState(() {
                                if (typesOfTransactions[index] == 'All') {
                                  isTypeSelected.clear();
                                } else {
                                  isTypeSelected.remove('all');
                                  isTypeSelected.contains(
                                          typesOfTransactions[index]
                                              .replaceAll(' ', '')
                                              .toLowerCase())
                                      ? isTypeSelected.remove(
                                          typesOfTransactions[index]
                                              .replaceAll(' ', '')
                                              .toLowerCase())
                                      : isTypeSelected.add(
                                          typesOfTransactions[index]
                                              .replaceAll(' ', '')
                                              .toLowerCase());
                                }
                              });
                            },
                          ),
                        ]
                      ]),
                      Container(
                        margin: const EdgeInsets.only(top: 15),
                        child: Text(
                          'Wallet Currency',
                          style: textTheme.titleMedium
                              ?.copyWith(color: AppColor.kSecondaryColor),
                        ),
                      ),
                      Wrap(spacing: 8.0, runSpacing: -10, children: [
                        for (int index = 0;
                            index < currencies.length;
                            index++) ...[
                          InputChip(
                            selectedColor: AppColor.kAccentColor2,
                            backgroundColor: Colors.transparent,
                            selected: isCurrencySelected
                                        .contains(currencies[index]) ||
                                    (index == 0 && isCurrencySelected.isEmpty)
                                ? true
                                : false,
                            showCheckmark: false,
                            pressElevation: 0,
                            padding: const EdgeInsets.all(8),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(
                                    color: isCurrencySelected
                                                .contains(currencies[index]) ||
                                            (index == 0 &&
                                                isCurrencySelected.isEmpty)
                                        ? Colors.transparent
                                        : AppColor.kSecondaryColor)),
                            label: Text(currencies[index],
                                style: textTheme.bodyMedium),
                            onPressed: () {
                              setState(() {
                                if (currencies[index] == 'All') {
                                  isCurrencySelected.clear();
                                } else {
                                  isCurrencySelected.remove('All');
                                  isCurrencySelected.contains(currencies[index])
                                      ? isCurrencySelected
                                          .remove(currencies[index])
                                      : isCurrencySelected
                                          .add(currencies[index]);
                                }
                              });
                            },
                          ),
                        ]
                      ]),
                      Container(
                        margin: const EdgeInsets.only(top: 15),
                        child: Text(
                          'Period',
                          style: textTheme.titleMedium
                              ?.copyWith(color: AppColor.kSecondaryColor),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InputChip(
                              selectedColor: AppColor.kAccentColor2,
                              backgroundColor: Colors.transparent,
                              showCheckmark: false,
                              pressElevation: 0,
                              onPressed: () {
                                buildCupertinoDatePicker(
                                    context, setState, 'Start');
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  side: const BorderSide(
                                      color: AppColor.kSecondaryColor)),
                              label: Container(
                                width: 100,
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                alignment: Alignment.center,
                                child: Text(
                                  startDate == '' ? 'DD MM YYYY' : startDate,
                                  style: textTheme.bodyMedium,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            InputChip(
                              selectedColor: AppColor.kAccentColor2,
                              backgroundColor: Colors.transparent,
                              showCheckmark: false,
                              pressElevation: 0,
                              onPressed: () {
                                buildCupertinoDatePicker(
                                    context, setState, 'End');
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  side: const BorderSide(
                                      color: AppColor.kSecondaryColor)),
                              label: Container(
                                width: 100,
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                alignment: Alignment.center,
                                child: Text(
                                  endDate == '' ? 'DD MM YYYY' : endDate,
                                  style: textTheme.bodyMedium,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Text(
                          'Status',
                          style: textTheme.titleMedium
                              ?.copyWith(color: AppColor.kSecondaryColor),
                        ),
                      ),
                      Wrap(spacing: 8.0, runSpacing: -10, children: [
                        for (int index = 0;
                            index < statuses.length;
                            index++) ...[
                          InputChip(
                            selectedColor: AppColor.kAccentColor2,
                            backgroundColor: Colors.transparent,
                            selected: isStatusSelected.contains(
                                        statuses[index].toLowerCase()) ||
                                    (index == 0 && isStatusSelected.isEmpty)
                                ? true
                                : false,
                            showCheckmark: false,
                            pressElevation: 0,
                            padding: const EdgeInsets.all(8),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(
                                    color: isStatusSelected.contains(
                                                statuses[index]
                                                    .toLowerCase()) ||
                                            (index == 0 &&
                                                isStatusSelected.isEmpty)
                                        ? Colors.transparent
                                        : AppColor.kSecondaryColor)),
                            label: Text(
                              statuses[index],
                              style: textTheme.titleMedium,
                            ),
                            onPressed: () {
                              setState(() {
                                if (statuses[index] == 'All') {
                                  isStatusSelected.clear();
                                } else {
                                  isStatusSelected.remove('All');
                                  isStatusSelected.contains(
                                          statuses[index].toLowerCase())
                                      ? isStatusSelected
                                          .remove(statuses[index].toLowerCase())
                                      : isStatusSelected
                                          .add(statuses[index].toLowerCase());
                                }
                              });
                            },
                          ),
                        ]
                      ]),
                      const Gap(120)
                    ]),
              ),
            ),
          );
        });
  }
}

buildCupertinoDatePicker(BuildContext context, setState, String date) {
  List arr = startDate.split('-');
  String initDate =
      startDate != '' ? '${arr[2]}-${arr[1]}-${arr[0]} 00:00:00' : '';
  // String formattedstartDate
  List arr2 = endDate.split('-');
  String initDate2 =
      endDate != '' ? '${arr2[2]}-${arr2[1]}-${arr2[0]} 00:00:00' : '';
  showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      context: context,
      builder: (BuildContext builder) {
        return SizedBox(
          height: MediaQuery.of(context).copyWith().size.height / 2.5,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (picked) {
              if (picked != DateTime.now()) {
                setState(() {
                  date == 'Start'
                      ? startDate = Converter()
                          .getDateFromCupertinoDatePicker(picked.toString())
                      : endDate = Converter()
                          .getDateFromCupertinoDatePicker(picked.toString());
                });
              }
            },
            dateOrder: DatePickerDateOrder.dmy,
            initialDateTime: date == 'Start' && startDate != ''
                ? DateTime.parse(initDate)
                : date == 'End' && endDate != ''
                    ? DateTime.parse(initDate2)
                    : DateTime.now(),
            minimumYear: 2000,
            maximumYear: DateTime.now().year,
            maximumDate: DateTime.now(),
          ),
        );
      });
}
