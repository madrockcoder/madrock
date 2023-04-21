// ignore_for_file: prefer_const_constructors

import 'package:geniuspay/app/faq/model/app_faq_model.dart';

final allAccountQuestions = <FAQQuestion>[
  FAQQuestion(
      id: '1',
      question: 'How can I close my account?',
      discription:
          'To close your account go to your profile information and click on Delete my account.\nYou can find your Profile information by clicking on Personal profile.\nIt is important to note that you can only close an account with a zero balance. If you are unable to close your account, kindly contact our 24/7 customer service team.',
      type: FAQType.account),
  FAQQuestion(
      id: '2',
      question: 'Can I upgrade my plan?',
      discription:
          'Yes you can always upgrade or downgrade your subscription plan by visiting your account profile or subscription plan details.',
      type: FAQType.account),
  FAQQuestion(
      id: '3',
      question: 'I cannot see my account details',
      discription:
          'The account details associated with your borderless Wallet is available after you have funded your Wallet with the requirement activation amount. The amount you fund your Wallet is still available for use upon activation.\nContact our customer service Team if you cannot see your account details after funding your account.',
      type: FAQType.account),
  FAQQuestion(
      id: '4',
      question: 'How can I change my name?',
      discription:
          'You can only change your name by contacting our customer service team. You are unable to change your name and other verified details on the app.\nTo be able to change your name, you have to provide us with legal documents covering the change of name and your new photo ID. Your account will be restricted until you have completed the KYC ID verification.',
      type: FAQType.account),
  FAQQuestion(
      id: '5',
      question: 'How can I download my account statement?',
      discription:
          'You can download your account statement by visiting the Wallet details of the designated Wallet you wish to download the statement.\nYou can also find statements from the Profile menu at the right corner of the foot of the app.',
      type: FAQType.account),
  FAQQuestion(
      id: '6',
      question: 'Can I create multiple account?',
      discription:
          'At the moment you cannot operate a multiple account.',
      type: FAQType.account),
  FAQQuestion(
      id: '7',
      question: 'How can I verify my account?',
      discription:
          'Account verification involve real-time photo ID verification that is done by a trusted third-party.\nTo complete identity verification simply follow the instructions on the geniuspay app. You will need to take a picture of your valid government-issued ID as well as a selfie. Should we require additional information, our Compliance team will contact you.',
      type: FAQType.account),
  FAQQuestion(
      id: '8',
      question: 'My account access is restricted, How can I resolve that?',
      discription:
          'Your account access can be restricted for different reasons. When you see a notice of account restriction, follow the instructions on the screen to resolve the issue.',
      type: FAQType.account),
    FAQQuestion(
      id: '9',
      question: 'How can I change my country of residence?',
      discription:
          'Due to regulatory and legal requirements we have to adhere to as a Financial instutition, you cannot change your country of residence from the app.\nTo change your country of residence you have to contact our compliance team by email: kyc@geniuspay.com or in-app live chat.\nBefore your country of residence can be change, you will be required to provide us proof of your residency in the new country.',
      type: FAQType.account),
    FAQQuestion(
      id: '10',
      question: 'My account has been locked',
      discription:
          "Your account maybe locked due to a number of reasons. The common reason maybe a failed attempt to enter correct Passcode or you tried logging in from another device simultaneously which is not allowed.",
      type: FAQType.app),
    FAQQuestion(
      id: '11',
      question: 'My account is still not verified after an hour.',
      discription:
          "90% of accounts are verified between 5 - 30 seconds and sometimes it can take more than 60 minutes. To prevent this from happy make sure your ID is still valid and clear images are taken. It will take a little bit of waiting time if the documents you have provided does not match our requirements.\nContact our customer service if your account is still not verified after 60 minutes.",
      type: FAQType.app),
];
