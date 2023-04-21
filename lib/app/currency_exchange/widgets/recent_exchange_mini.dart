import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/currency_exchange/pages/all_transactions.dart';
import 'package:geniuspay/app/currency_exchange/view_models/conversion_history_vm.dart';
import 'package:geniuspay/app/currency_exchange/widgets/empty_exchange_transactions.dart';
import 'package:geniuspay/app/currency_exchange/widgets/loading_exchangge_transactions.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/models/conversion.dart';

import '../../../util/color_scheme.dart';
import 'conversions_list_widget.dart';

class ExchangeHistories extends StatefulWidget {
  const ExchangeHistories({Key? key}) : super(key: key);

  @override
  State<ExchangeHistories> createState() => _ExchangeHistoriesState();
}

class _ExchangeHistoriesState extends State<ExchangeHistories> {
  @override
  Widget build(BuildContext context) {
    return BaseView<ConversionHistoryVM>(
        onModelReady: (p0) => p0.getTransactionsMini(context),
        builder: (context, model, snapshot) {
          if (model.baseModelStateMini == BaseModelState.loading) {
            return const LoadingExchangeTransactionsWidget(
              number: 2,
            );
          } else if (model.baseModelStateMini == BaseModelState.error) {
            return const EmptyExchangeTransactions(
              error: true,
            );
          } else {
            return ExchangeHistoryWidget(
              conversions: model.conversionsMini,
            );
          }
        });
  }
}

class ExchangeHistoryWidget extends StatelessWidget {
  final List<Conversion> conversions;
  const ExchangeHistoryWidget({Key? key, required this.conversions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(conversions.isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent exchanges',
                style: textTheme.bodyLarge,
              ),
              InkWell(
                onTap: () async {
                  AllExchangeTransactionsPage.show(context);
                },
                child: Text(
                  'View All',
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColor.kPinDesColor,
                    fontSize: 12,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        const Gap(20),
        ConversionsListWidget(
          conversions: conversions,
        ),
        if (conversions.isEmpty)
          const EmptyExchangeTransactions(
            error: false,
          )
      ],
    );
  }
}
