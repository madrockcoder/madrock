import 'package:geniuspay/app/auth/pages/sign_up/subscribtion/models/subscription_model.dart';

class SubscriptionList {
  static final personal = [
    SubscriptionModal(
      name: 'Basic',
      offers: [
        'Free account',
        'Free payments between\ngeniuspay acoounts ',
        'Free virtual MasterCard'
      ],
    ),
    SubscriptionModal(
      name: 'Smart',
      fee: 'EUR 4.99 / month',
      best: 'BEST CHOICE',
      offers: [
        'Free account',
        'Free payments between\ngeniuspay acoounts ',
        'Free withdrawals up to EUR 200 / month'
      ],
    ),
    SubscriptionModal(
      name: 'Genius',
      fee: 'EUR 4.99 / month',
      offers: [
        'Free account',
        'Free payments between\ngeniuspay acoounts ',
        'Free withdrawals up to EUR 200 / month'
      ],
    ),
  ];
  static final business = [
    SubscriptionModal(
      name: 'Small',
      fee: 'EUR 4.99 / month',
      offers: [
        'Monthly account turnover up to\nEUR 50,000',
      ],
    ),
    SubscriptionModal(
      name: 'Medium',
      fee: 'EUR 9.99 / month',
      offers: [
        'Monthly account turnover up to\nEUR 250,000',
      ],
    ),
    SubscriptionModal(
      name: 'Enterprise',
      fee: 'EUR 24.99 / month',
      best: 'MOST POPULAR',
      offers: [
        'Monthly account turnover up to\nEUR 5000,000',
      ],
    ),
    SubscriptionModal(
      name: 'Enterprise +',
      fee: 'EUR 119.99 / month',
      offers: [
        'Custom monthly account turnover ',
      ],
    ),
  ];
}
