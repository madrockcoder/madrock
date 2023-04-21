import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class EmptyExchangeTransactions extends StatelessWidget {
  final bool error;
  const EmptyExchangeTransactions({Key? key, required this.error})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final cardPadding = MediaQuery.of(context).size.height * .1;
    return Column(
      children: [
        Gap(cardPadding),
        Row(
          children: [
            const Gap(50),
            SvgPicture.asset('assets/images/transactions.svg'),
            const Gap(8),
            Expanded(
                child: Text(
              error
                  ? 'Unable to load recent exchange transactions'
                  : 'Everything you send, spend, and receive with this Wallet will show up here.',
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
