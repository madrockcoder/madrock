import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/home/pages/transaction_page.dart';
import 'package:geniuspay/app/home/widget/transactions_widget.dart';
import 'package:geniuspay/app/shared_widgets/custom_tab_indicator.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/app/wallet/view_individual_wallet/activity/chart_data.dart';
import 'package:geniuspay/models/total_amount.dart';
import 'package:geniuspay/util/color_scheme.dart';

class WalletActivityScreen extends StatelessWidget {
  const WalletActivityScreen({Key? key}) : super(key: key);
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const WalletActivityScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColor.kAccentColor2,
      appBar: AppBar(
        backgroundColor: AppColor.kAccentColor2,
        centerTitle: true,
        title: const Text('Activity'),
        actions: const [HelpIconButton()],
      ),
      body: ListView(
        children: [
          const ActivityHeader(),
          Container(
            padding: const EdgeInsets.only(top: 16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            width: double.infinity,
            child: Column(
              children: [
                const Gap(12),
                Container(
                  width: 20,
                  height: 2,
                  decoration: BoxDecoration(
                    color: AppColor.kSecondaryColor.withOpacity(0.1),
                  ),
                ),
                const Gap(15),
                Row(
                  children: [
                    const SizedBox(
                      width: 25,
                    ),
                    _payInOutWidget(
                      textTheme,
                      'Pay-in',
                      '\$4,600.00',
                      Icons.arrow_downward,
                      const Color(0xffEFFBF4),
                    ),
                    const SizedBox(
                      width: 32,
                    ),
                    _payInOutWidget(
                      textTheme,
                      'Pay-out',
                      '\$1,600.00',
                      Icons.arrow_upward,
                      const Color(0xffFFF9F9),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                  ],
                ),
                const Gap(36),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Transactions',
                            style: textTheme.bodyLarge?.copyWith(
                              color: AppColor.kOnPrimaryTextColor2,
                            ),
                          ),
                          InkWell(
                            onTap: () => TransactionPage.show(context),
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
                      const Gap(10),
                      const TransactionListTile(
                        icon: 'assets/images/dribble.svg',
                        text: 'Dribbble',
                        amount: TotalAmount(
                            value: 12,
                            currency: '\$',
                            valueWithCurrency: '\$1'),
                      ),
                      const TransactionListTile(
                        icon: 'assets/images/spotify.svg',
                        text: 'Spotify',
                        amount: TotalAmount(
                            value: 12,
                            currency: '\$',
                            valueWithCurrency: '\$1'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _payInOutWidget(
    TextTheme textTheme,
    String label,
    String amount,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColor.kAccentColor2,
          ),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: color,
            ),
            child: Icon(icon),
          ),
          minLeadingWidth: 0,
          minVerticalPadding: 0,
          title: Text(
            label,
            style: textTheme.titleMedium,
          ),
          subtitle: Text(
            amount,
            style: textTheme.titleSmall,
          ),
        ),
      ),
    );
  }
}

class ActivityHeader extends StatefulWidget {
  const ActivityHeader({Key? key}) : super(key: key);

  @override
  State<ActivityHeader> createState() => _ActivityHeaderState();
}

class _ActivityHeaderState extends State<ActivityHeader>
    with SingleTickerProviderStateMixin {
  late TabController _durationController;
  @override
  void initState() {
    super.initState();
    _durationController =
        TabController(vsync: this, length: 4, initialIndex: 2);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        const SizedBox(
          height: 8,
        ),
        Center(
          child: Text(
            'Total spending',
            style: textTheme.bodyMedium
                ?.copyWith(color: AppColor.kSecondaryColor, fontSize: 12),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Center(
          child: Text(
            '\$3,578.00',
            style: textTheme.displayLarge?.copyWith(
              color: AppColor.kSecondaryColor,
              fontSize: 44,
            ),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        TabBar(
          controller: _durationController,
          isScrollable: true,
          labelColor: AppColor.kSecondaryColor,
          indicator: CustomTabIndicator(),
          tabs: const [
            Tab(text: 'Day'),
            Tab(text: 'Week'),
            Tab(text: 'Month'),
            Tab(text: 'Year'),
          ],
        ),
        const SizedBox(
          height: 64,
        ),
        Container(
          height: 200,
          padding: const EdgeInsets.only(left: 32, right: 32),
          child: LineChart(BeizerChartData().sampleData1),
        ),
        const SizedBox(
          height: 32,
        ),
      ],
    );
  }
}
