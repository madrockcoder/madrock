import 'package:flutter/material.dart';
import 'package:geniuspay/app/currency_exchange/widgets/conversions_list_widget.dart';
import 'package:geniuspay/models/conversion.dart';
import 'package:shimmer/shimmer.dart';

class LoadingExchangeTransactionsWidget extends StatelessWidget {
  final int number;
  const LoadingExchangeTransactionsWidget({Key? key, required this.number})
      : super(key: key);
  final conversion = const Conversion(
    user: 'user',
    buyCurrency: 'USD',
    sellCurrency: 'EUR',
    amount: '100',
    reference: 'reference',
    conversionDate: '2022-06-25T12:11:43.966Z',
  );
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ConversionsListWidget(
          conversions: [for (int i = 0; i < number; i++) conversion],
        ));
  }
}
