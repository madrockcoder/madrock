import 'package:geniuspay/models/onboarding_model.dart';
import 'package:geniuspay/util/essentials.dart';

class OnboardingData {
  static final List<Onboard> _data = [
    const Onboard(
        image: 'assets/images/onboard1.png',
        title: 'Send, receive & Save\non transfers worldwide',
        subTitle: ''),
    Onboard(
        image: 'assets/images/onboard2.png',
        title: 'Buy and Sell in \n70+ currencies',
        subTitle: shouldTemporaryHideForEarlyLaunch ? '' : 'Check our rates'),
    if (!shouldTemporaryHideForEarlyLaunch)
      const Onboard(
          image: 'assets/images/onboard3.png',
          title: 'Get prepaid & Virtual \nMulti-Currency Cards',
          subTitle:
              'Get cards to use for your ATM, POS and\nonline transactions.'),
    const Onboard(
        image: 'assets/images/onboard4.png',
        title: 'Hybrid Wallet - Fiat and \nCrypto Wallets',
        subTitle: 'Send, receive & convert in over \n70 currencies.'),
    const Onboard(
        image: 'assets/images/onboard5.png',
        title: 'Connect your customers\nto your business',
        subTitle:
            'Take control of your finances as a \nbusiness by leveraging on payment \ntools to send and recive payments from \nclients. '),
    const Onboard(
        image: 'assets/images/onboard6.png',
        title: 'Track and Offset \nyour CO2 emissions ',
        subTitle: 'Change the Climate Change with one \nsimple click.'),
  ];

  List<Onboard> get data => _data;
}
