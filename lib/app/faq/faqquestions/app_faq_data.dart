// ignore_for_file: prefer_const_constructors

import 'package:geniuspay/app/faq/model/app_faq_model.dart';
import 'package:geniuspay/util/essentials.dart';

final allAppQuestions = <FAQQuestion>[
  FAQQuestion(
      id: '1',
      question: 'How do I contact the customer support on the App?',
      discription:
          'At the top right on every screen you can contact our customer support team by live chat or through email at support@geniuspay.com. We also speak your language.',
      type: FAQType.app),
  FAQQuestion(
      id: '2',
      question: 'Why can’t I log into my app?',
      discription:
          'Contact our 24/7 customer service if you are unable to log into the app. Your account may have been disabled or blocked due to unsuccessful attempts of Passcode.',
      type: FAQType.app),
  FAQQuestion(
      id: '3',
      question: 'Can I run the app on iPad or Tablet?',
      discription:
          "We try to support as many devices as possible, but as with many other apps, some may not be compatible, especially if they are getting a little old. You are likely to have issues with our app if your device can't run either the most recent operating system (iOS 14 for iPhones and iPads, Android 11 for Android Phones and Tablets) or the two before that (iOS 13 and iOS 12 for iPhone/iPad, Android 10 and Android 9 Pie for Android Phones and Tablets).",
      type: FAQType.app),
  if(!shouldTemporaryHideForEarlyLaunch)
    FAQQuestion(
        id: '4',
        question: 'What does beta version mean?',
        discription:
        "Beta apps are newer and more experimental versions of apps that are already released. What this means is that we are still at the testing phase of the app.\nAt beta stage, the software still undergoes cycles of bug fixing.",
        type: FAQType.app),
    FAQQuestion(
      id: '5',
      question: 'I am unable to verify my Mobile number',
      discription:
          "To prevent spam we have limited access to mobile verification to 3 failed attempts. If you are unable to add a phone number to your account, please kindly contact our 24/7 customer support team for assistance.\nPlease make sure the number you want to add is valid or does not belong to another person.",
      type: FAQType.app),
];
