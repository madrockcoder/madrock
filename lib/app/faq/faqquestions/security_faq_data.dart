// ignore_for_file: prefer_const_constructors
import 'package:geniuspay/app/faq/model/app_faq_model.dart';

final allSecurityQuestions = <FAQQuestion>[
  FAQQuestion(
      id: '1',
      question: 'How to protect my account?',
      discription:
          'Here are some tips for keeping your account safe and secure. Never share your app Passcode and support PIN with anyone. We recommend you use only an email address that only you have access to. Do not use a shared email address when you sign up for a geniuspay account. Do not share with anyone details of your card',
      type: FAQType.security),
  FAQQuestion(
      id: '2',
      question: 'What happens if I have exceeded all my Passcode attempts?',
      discription:
          'After 3 wrong attempts, your account will be locked to protect your account from unauthorised access. You can unblock your account by contacting customer support. Before contacting customer service, please make sure you have all your personal details handy to authenticate yourself',
      type: FAQType.security),
  FAQQuestion(
      id: '3',
      question: 'How do I change my Passcode?',
      discription:
          'Due to security reasons and to protect your account, we do not allow direct Passcode change. To change this, contact our 24/7 customer support team and after authenticating yourself by providing the support PIN, the customer service team will generate a secret PIN which you will then use to change the Passcode from the app',
      type: FAQType.security),
  FAQQuestion(
      id: '4',
      question: 'Can I change my Support PIN?',
      discription:
          'The support like your Passcode cannot be changed directly. Contact our 24/7 customer support and a new support PIN will be generated for you. The newly generated support PIN will appear on the mobile app for 15 seconds. ',
      type: FAQType.security),
  FAQQuestion(
      id: '5',
      question: 'How can I set a Password for my app?',
      discription:
          'Using geniuspay does not require a password for both app and web. You have one less worry of having to remember a password each time you access your app.',
      type: FAQType.security),
];
