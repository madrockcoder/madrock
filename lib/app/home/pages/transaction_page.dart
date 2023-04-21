import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/home/widget/transactions_widget.dart';
import 'package:geniuspay/models/total_amount.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/widgets_util.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({Key? key}) : super(key: key);
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const TransactionPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: WidgetsUtil.onBoardingAppBar(
        context,
        title: 'Transaction History',
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('assets/images/filter.svg'),
          ),
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '29 Dec, 2022',
                style: textTheme.bodyLarge?.copyWith(
                  color: AppColor.kSecondaryColor,
                ),
              ),
              const Gap(20),
              const TransactionListTile(
                icon: 'assets/images/dribble.svg',
                text: 'Dribbble',
                amount: TotalAmount(
                    value: 12, currency: '\$', valueWithCurrency: '\$1'),
              ),
              const TransactionListTile(
                icon: 'assets/images/spotify.svg',
                text: 'Spotify',
                amount: TotalAmount(
                    value: 12, currency: '\$', valueWithCurrency: '\$1'),
              ),
              Text(
                '29 Dec, 2022',
                style: textTheme.bodyLarge?.copyWith(
                  color: AppColor.kSecondaryColor,
                ),
              ),
              const Gap(20),
              const TransactionListTile(
                icon: 'assets/images/dribble.svg',
                text: 'Dribbble',
                amount: TotalAmount(
                    value: 12, currency: '\$', valueWithCurrency: '\$1'),
              ),
              const TransactionListTile(
                icon: 'assets/images/spotify.svg',
                text: 'Spotify',
                amount: TotalAmount(
                    value: 12, currency: '\$', valueWithCurrency: '\$1'),
              ),
              Text(
                '29 Dec, 2022',
                style: textTheme.bodyLarge?.copyWith(
                  color: AppColor.kSecondaryColor,
                ),
              ),
              const Gap(20),
              const TransactionListTile(
                icon: 'assets/images/dribble.svg',
                text: 'Dribbble',
                amount: TotalAmount(
                    value: 12, currency: '\$', valueWithCurrency: '\$1'),
              ),
              const TransactionListTile(
                icon: 'assets/images/spotify.svg',
                text: 'Spotify',
                amount: TotalAmount(
                    value: 12, currency: '\$', valueWithCurrency: '\$1'),
              ),
              Text(
                '29 Dec, 2022',
                style: textTheme.bodyLarge?.copyWith(
                  color: AppColor.kSecondaryColor,
                ),
              ),
              const Gap(20),
              const TransactionListTile(
                icon: 'assets/images/dribble.svg',
                text: 'Dribbble',
                amount: TotalAmount(
                    value: 12, currency: '\$', valueWithCurrency: '\$1'),
              ),
              const TransactionListTile(
                icon: 'assets/images/spotify.svg',
                text: 'Spotify',
                amount: TotalAmount(
                    value: 12, currency: '\$', valueWithCurrency: '\$1'),
              ),
              Text(
                '29 Dec, 2022',
                style: textTheme.bodyLarge?.copyWith(
                  color: AppColor.kSecondaryColor,
                ),
              ),
              const Gap(20),
              const TransactionListTile(
                icon: 'assets/images/dribble.svg',
                text: 'Dribbble',
                amount: TotalAmount(
                    value: 12, currency: '\$', valueWithCurrency: '\$1'),
              ),
              const TransactionListTile(
                icon: 'assets/images/spotify.svg',
                text: 'Spotify',
                amount: TotalAmount(
                    value: 12, currency: '\$', valueWithCurrency: '\$1'),
              ),
              Text(
                '29 Dec, 2022',
                style: textTheme.bodyLarge?.copyWith(
                  color: AppColor.kSecondaryColor,
                ),
              ),
              const Gap(20),
              const TransactionListTile(
                icon: 'assets/images/dribble.svg',
                text: 'Dribbble',
                amount: TotalAmount(
                    value: 12, currency: '\$', valueWithCurrency: '\$1'),
              ),
              const TransactionListTile(
                icon: 'assets/images/spotify.svg',
                text: 'Spotify',
                amount: TotalAmount(
                    value: 12, currency: '\$', valueWithCurrency: '\$1'),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
