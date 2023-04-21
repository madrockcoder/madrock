import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/currency_exchange/view_models/conversion_history_vm.dart';
import 'package:geniuspay/app/currency_exchange/widgets/empty_exchange_transactions.dart';
import 'package:geniuspay/app/currency_exchange/widgets/conversions_list_widget.dart';
import 'package:geniuspay/app/currency_exchange/widgets/loading_exchangge_transactions.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/converter.dart';
import 'package:geniuspay/util/widgets_util.dart';

class AllExchangeTransactionsPage extends StatefulWidget {
  const AllExchangeTransactionsPage({Key? key}) : super(key: key);
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const AllExchangeTransactionsPage(),
      ),
    );
  }

  @override
  State<AllExchangeTransactionsPage> createState() =>
      _AllExchangeTransactionsPageState();
}

class _AllExchangeTransactionsPageState
    extends State<AllExchangeTransactionsPage> {
  List<String> months = [
    'All',
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  int selectedMonth = 0;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: WidgetsUtil.onBoardingAppBar(
          context,
          title: 'Conversion History',
          actions: [const HelpIconButton()],
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: BaseView<ConversionHistoryVM>(
                onModelReady: (p0) => p0.getTransactions(context),
                builder: (context, model, snapshot) {
                  if (model.baseModelState == BaseModelState.loading) {
                    return const LoadingExchangeTransactionsWidget(
                      number: 10,
                    );
                  } else if (model.baseModelState == BaseModelState.error) {
                    return const EmptyExchangeTransactions(
                      error: true,
                    );
                  } else if (model.conversions.isEmpty) {
                    return const EmptyExchangeTransactions(
                      error: false,
                    );
                  } else {
                    return SingleChildScrollView(
                        child: Column(children: [
                      SizedBox(
                          height: 30,
                          child: ListView(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            children: [
                              for (int i = 0; i < months.length; i++) ...[
                                InkWell(
                                    borderRadius: BorderRadius.circular(16),
                                    onTap: () {
                                      setState(() {
                                        selectedMonth = i;
                                      });
                                    },
                                    child: Chip(
                                      backgroundColor: selectedMonth == i
                                          ? AppColor.kSecondaryColor
                                              .withOpacity(.3)
                                          : Colors.white,
                                      label: Text(
                                        months[i],
                                        style: textTheme.titleMedium?.copyWith(
                                            color: AppColor.kSecondaryColor),
                                      ),
                                    )),
                                const Gap(4)
                              ]
                            ],
                          )),
                      const Gap(24),
                      ConversionsListWidget(
                        conversions: model.conversions.where((element) {
                          final date = Converter()
                              .getDateFormatFromString(element.conversionDate);
                          if (selectedMonth == 0) {
                            return true;
                          } else if (date.month == selectedMonth) {
                            return true;
                          }
                          return false;
                        }).toList(),
                      )
                    ]));
                  }
                })));
  }
}
