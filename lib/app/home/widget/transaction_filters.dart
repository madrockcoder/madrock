import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/home/view_models/account_transactions_view_model.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/models/wallet.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/enum_converter.dart';
import 'package:geniuspay/util/enums.dart';
import 'package:intl/intl.dart';

class TransactionFilters extends StatefulWidget {
  final AccountTransactionsViewModel model;
  const TransactionFilters({Key? key, required this.model}) : super(key: key);

  @override
  State<TransactionFilters> createState() => _TransactionFiltersState();
}

class _TransactionFiltersState extends State<TransactionFilters>
    with EnumConverter {
  List<TransactionType> allTransactionTypes = [
    TransactionType.balanceTransfer,
    TransactionType.wireTransfer,
    TransactionType.walletRefund,
    TransactionType.currencyExchange,
  ];
  List<TransactionType> selectedTransactionTypes = [];
  List<Wallet> selectedWallets = [];
  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    selectedTransactionTypes = widget.model.selectedTransactionTypes;
    selectedWallets = widget.model.selectedWalletTypes;
    startDate = widget.model.startDate;
    endDate = widget.model.endDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
          centerTitle: true,
          title: Text(
            'Filter',
            style: textTheme.displayLarge?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              CustomElevatedButton(
                  color: AppColor.kGoldColor2,
                  onPressed: () {
                    widget.model.filterTransactions(
                        context: context,
                        transactionTypes: selectedTransactionTypes,
                        selectedWallets: selectedWallets,
                        start: startDate,
                        end: endDate);
                  },
                  child: Text(
                    'APPLY FILTER',
                    style: textTheme.bodyLarge,
                  )),
              CustomElevatedButton(
                  color: AppColor.kWhiteColor,
                  onPressed: () {
                    selectedTransactionTypes.clear();
                    selectedWallets.clear();
                    startDate = null;
                    endDate = null;
                    widget.model.filterTransactions(
                        context: context,
                        transactionTypes: selectedTransactionTypes,
                        selectedWallets: selectedWallets,
                        start: startDate,
                        end: endDate);
                  },
                  child: Text(
                    'RESET FILTER',
                    style: textTheme.bodyLarge,
                  )),
            ])),
        body: Padding(
            padding:
                const EdgeInsets.only(left: 24, right: 24, bottom: 15, top: 16),
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(
                    'Types of transaction',
                    style: textTheme.bodyMedium?.copyWith(
                        color: AppColor.kSecondaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                  const Gap(8),
                  Wrap(spacing: 8.0, runSpacing: -6, children: [
                    InputChip(
                      selectedColor: AppColor.kAccentColor2,
                      backgroundColor: selectedTransactionTypes.isEmpty
                          ? AppColor.kAccentColor2
                          : Colors.transparent,
                      selected: false,
                      showCheckmark: false,
                      pressElevation: 0,
                      padding: const EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                              color: selectedTransactionTypes.isEmpty
                                  ? AppColor.kAccentColor2
                                  : AppColor.kSecondaryColor)),
                      label: Text(
                        'All',
                        style: textTheme.bodyMedium,
                      ),
                      onPressed: () {
                        setState(() {
                          selectedTransactionTypes.clear();
                        });
                      },
                    ),
                    for (int index = 0;
                        index < allTransactionTypes.length;
                        index++) ...[
                      InputChip(
                        selectedColor: AppColor.kAccentColor2,
                        backgroundColor: selectedTransactionTypes
                                .contains((allTransactionTypes[index]))
                            ? AppColor.kAccentColor2
                            : Colors.transparent,
                        selected: false,
                        showCheckmark: false,
                        pressElevation: 0,
                        padding: const EdgeInsets.all(8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(
                                color: selectedTransactionTypes
                                        .contains((allTransactionTypes[index]))
                                    ? AppColor.kAccentColor2
                                    : AppColor.kSecondaryColor)),
                        label: Text(
                          getTransactionTypeString(allTransactionTypes[index]),
                          style: textTheme.bodyMedium,
                        ),
                        onPressed: () {
                          setState(() {
                            if (selectedTransactionTypes
                                .contains((allTransactionTypes[index]))) {
                              selectedTransactionTypes
                                  .remove(allTransactionTypes[index]);
                            } else {
                              selectedTransactionTypes
                                  .add(allTransactionTypes[index]);
                            }
                          });
                        },
                      ),
                    ]
                  ]),
                  const Gap(16),
                  Text(
                    'Wallet Currency',
                    style: textTheme.bodyMedium?.copyWith(
                        color: AppColor.kSecondaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                  const Gap(8),
                  Wrap(spacing: 8.0, runSpacing: -6, children: [
                    InputChip(
                      selectedColor: AppColor.kAccentColor2,
                      backgroundColor: selectedWallets.isEmpty
                          ? AppColor.kAccentColor2
                          : Colors.transparent,
                      selected: false,
                      showCheckmark: false,
                      pressElevation: 0,
                      padding: const EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                              color: selectedWallets.isEmpty
                                  ? AppColor.kAccentColor2
                                  : AppColor.kSecondaryColor)),
                      label: Text(
                        'All',
                        style: textTheme.bodyMedium,
                      ),
                      onPressed: () {
                        setState(() {
                          selectedWallets.clear();
                        });
                      },
                    ),
                    for (int index = 0;
                        index < widget.model.wallets.length;
                        index++) ...[
                      InputChip(
                        selectedColor: AppColor.kAccentColor2,
                        backgroundColor: selectedWallets
                                .contains((widget.model.wallets[index]))
                            ? AppColor.kAccentColor2
                            : Colors.transparent,
                        selected: false,
                        showCheckmark: false,
                        pressElevation: 0,
                        padding: const EdgeInsets.all(8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(
                                color: selectedWallets
                                        .contains((widget.model.wallets[index]))
                                    ? AppColor.kAccentColor2
                                    : AppColor.kSecondaryColor)),
                        label: Text(
                          widget.model.wallets[index].currency,
                          style: textTheme.bodyMedium,
                        ),
                        onPressed: () {
                          setState(() {
                            if (selectedWallets
                                .contains((widget.model.wallets[index]))) {
                              selectedWallets
                                  .remove(widget.model.wallets[index]);
                            } else {
                              selectedWallets.add(widget.model.wallets[index]);
                            }
                          });
                        },
                      ),
                    ]
                  ]),
                  const Gap(16),
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
                          onPressed: () async {
                            final result = await _selectDate(
                                context: context, initialDate: startDate);
                            if (result != null) {
                              setState(() {
                                startDate = result;
                              });
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: const BorderSide(
                                  color: AppColor.kSecondaryColor)),
                          label: Container(
                            width: 100,
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            alignment: Alignment.center,
                            child: Text(
                              startDate == null
                                  ? 'DD MM YYYY'
                                  : DateFormat('dd-MM-yyyy').format(startDate!),
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
                          onPressed: () async {
                            final result = await _selectDate(
                                context: context, initialDate: endDate);
                            if (result != null) {
                              setState(() {
                                endDate = result;
                              });
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: const BorderSide(
                                  color: AppColor.kSecondaryColor)),
                          label: Container(
                            width: 100,
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            alignment: Alignment.center,
                            child: Text(
                              endDate == null
                                  ? 'DD MM YYYY'
                                  : DateFormat('dd-MM-yyyy').format(endDate!),
                              style: textTheme.bodyMedium,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ]))));
  }

  Future<DateTime?> _selectDate(
      {required BuildContext context, required DateTime? initialDate}) async {
    final DateTime? picked = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: AppColor.kSecondaryColor, // header background color
                onPrimary: Colors.white, // header text color
                onSurface: Colors.black, // body text color
              ),
            ),
            child: child!,
          );
        },
        context: context,
        initialDate: initialDate ?? DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != initialDate) {
      // Navigator.pop(context, picked);
      return picked;
    }
    return null;
  }
}
