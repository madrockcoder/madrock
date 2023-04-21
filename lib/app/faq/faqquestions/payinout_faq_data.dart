// ignore_for_file: prefer_const_constructors

import 'package:geniuspay/app/faq/model/app_faq_model.dart';

final allPayInOutQuestions = <FAQQuestion>[
  FAQQuestion(
      id: '1',
      question: 'How can I add funds to my Wallet?',
      discription:
          'Currently you can only add money or top-up your Wallet through the Debit/Credit Card, Bank transfer, iDeal, Stitch and Trustly. Trustly and Stitch allows you make a direct debit from your bank account. We continue to add more funding options and you will be notified as they become available.',
      type: FAQType.payinout),
  FAQQuestion(
      id: '2',
      question: 'What is the limit on withdrawal?',
      discription:
          'Withdrawal limits varies depending on the method of withdrawal. The minimum withdrawal is USD 5. You can also send up to 3,000,000 USD by Bank transfer and up to 250,000 USD in Currency exchange.',
      type: FAQType.payinout),
  FAQQuestion(
      id: '3',
      question: 'What is the limit for deposit?',
      discription:
          'Depending on the type of payment method you use a minimum and maximum will be indicated on the transaction page. The minimum to deposit is USD 5.',
      type: FAQType.payinout),
  FAQQuestion(
      id: '4',
      question: 'My deposit has a status of Awaiting Funds. What does that mean?',
      discription:
          'Awaiting funds as a transaction status means that the payment processor or the settlement institution has not transferred the payment to geniuspay and as such you account will not be credited with the funds until we have received the funds.',
      type: FAQType.payinout)
];
