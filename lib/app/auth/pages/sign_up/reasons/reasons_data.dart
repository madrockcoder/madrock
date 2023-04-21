import 'package:geniuspay/models/reason.dart';

class ReasonsData {
  static const List<Reason> _data = [
    Reason(
      id: '1',
      iconImage: 'assets/images/tabler_chart-pie.svg',
      title: 'Spend or save daily',
      reason: 'SPEND_SAVE_DAILY',
    ),
    Reason(
      id: '2',
      iconImage: 'assets/images/tabler_bolt.svg',
      title: 'Make fast transactions',
      reason: 'FASTER_TRANSACTION',
    ),
    Reason(
      id: '3',
      iconImage: 'assets/images/tabler_businessplan.svg',
      title: 'Payments to friends',
      reason: 'PAYMENT_TO_FRIENDS',
    ),
    Reason(
      id: '4',
      iconImage: 'assets/images/tabler_credit-card.svg',
      title: 'Online payments',
      reason: 'ONLINE_PAYMENT',
    ),
    Reason(
      id: '5',
      iconImage: 'assets/images/tabler_beach.svg',
      title: 'Spend while travelling',
      reason: 'SPEND_TRAVEL',
    ),
    Reason(
      id: '6',
      iconImage: 'assets/images/Group.svg',
      title: 'Your financial assets',
      reason: 'FINANCIAL_ASSET',
    ),
  ];

  List<Reason> get data => _data;
}
