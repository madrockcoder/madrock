// ignore_for_file: prefer_const_constructors
import 'package:geniuspay/app/faq/model/app_faq_model.dart';

final allOtherQuestions = <FAQQuestion>[
  FAQQuestion(
      id: '1',
      question: 'How can I make a complaint?',
      discription:
          """We are sorry to hear that we did not meet your expectations. There are several ways to report a complaint:\n1. By initiating a chat through a mobile application or geniuspay.com\n2. By sending an email to report@geniuspay.com\n3. By sending a letter to Kemp House, 160 City Road, London, United Kingdom, EC1V 2NX While filling up a complaint, please do not forget to include as much information as possible:\n1. name of the person whose rights have been infringed / company name,\n2. attached power of attorney of the representative, if you are represented by a representative;\n3. contact details - address of residence / actual business address and other contact details;\n4. date of the complaint;\n5. the reason for submitting the complaint, i.e. the rights, contracts that have been violated and the basis for the violation, if known;\n6. attached supporting documents of such a complaint (if any). If the circumstances set out in the complaint relate to a specific contract with geniuspay, the date and/or number of the contract (if known to the customer) must be provided;\n7. preferences as to how you expect the complaint to be resolved.""",
      type: FAQType.other),
  FAQQuestion(
      id: '2',
      question: 'What fees are you charging?',
      discription:
          'A detailed overview of our fee structure can be found on our website by visiting https://geniuspay.com/fees.',
      type: FAQType.other),
  FAQQuestion(
      id: '3',
      question: 'Why do I have to verify my identity?',
      discription:
          "You need to verify your identity in order to use your geniuspay account. This policy is in line with compliance regulation commonly known as 'Know Your Customer' (KYC) or 'Customer Due Diligence' (CDD) and is the process of a business verifying the identity of its clients. It is an anti-corruption and fraud measure.",
      type: FAQType.other),
  FAQQuestion(
      id: '4',
      question: 'What to do if my device was stolen or lost?',
      discription:
          'Please contact our 24/7 customer service team to report your device stolen or lost so we can suspend your geniuspay account. When you have access to your account, review the transactions to make sure no unauthorised transactions occured.',
      type: FAQType.other),
  FAQQuestion(
      id: '5',
      question: 'Why am I unable to verify my identity?',
      discription:
          "If your verification has failed, please try again and double-check that your images are clear and all document photos are readable without any blur or glare. Make sure that you: Are using a document that isn't expired, damaged or unreadable. Take pictures that are clear, with the details of the document readable. \nIf you're experiencing issues with ID verification, here are a few things to keep in mind: \nMake sure you have the latest version of the app. To start the procedure, you can either tap on the notification you receive in the app, follow the instructions from the e-mail sent to you. If your camera isn't working and you can't take photos, please use a different device. \nThe documents have to be submitted in the app.",
      type: FAQType.other),
    FAQQuestion(
      id: '6',
      question: 'How many referrals can I have?',
      discription:
          "There is not limit to the number of friends you can refer to join the GenioXperience.",
      type: FAQType.other),
    FAQQuestion(
      id: '7',
      question: 'I cannot find my referrals and earnings.',
      discription:
          "Our system valids every new referral and add that to your account. This is not done in real time likewise the earnings. If your referral count does not change, you can contact our 24/7 customer support for assistance.",
      type: FAQType.other),
    FAQQuestion(
      id: '8',
      question: 'When can I withdraw my referral earnings?',
      discription:
          "Your referral bonus can be withdrawn at anytime as they become available. Sign up bonuses can only be withdrawn after the referred user qualitifies. Please refer to our Referral terms for more information on our referral program at https://geniuspay.com/legal/referral-terms",
      type: FAQType.other),
    FAQQuestion(
      id: '9',
      question: 'What does qualified referral mean?',
      discription:
          "Not every referral qualifies you for earnings through our referral programme. For a referral to be deemed as qualified means that the referred user must have their geniuspay account Verified active for a minimum of 60 days and have performed a transaction to the equivalent of GBP 200.",
      type: FAQType.other),
    FAQQuestion(
      id: '10',
      question: 'How can I report an error I detected?',
      discription:
          "We appreciate your vigilance and interest to report an error. It makes us better and stronger. To report an error, send an email to itdesk@geniuspay.com or use our in-app live chat.",
      type: FAQType.other),
    FAQQuestion(
      id: '11',
      question: 'Are you regulated?',
      discription:
          "Yes, geniuspay (UK) Ltd. and geniuspay Inc. Canada are licensed and regulated by the Financial Transactions and Reports Analysis Centre of Canada (FINTRAC) as a Money service business with Registration numbers M22437094 and M22313641 respectively.\ngeniuspay is in the process of applying for authorization in 20 additional countries including 23 states in the United States.\nWe are registered with the UK’s data protection regulator (The Information Commissioner’s Office or “ICO”) as a Controller of personal data under number ZB151097",
      type: FAQType.other),
    FAQQuestion(
      id: '12',
      question: 'Where is geniuspay incorporated?',
      discription:
          "geniuspay Ltd (Registration No. 12976922) is incorporated in the U.K with registered office at: Kemp House, 160 City Road, London, United Kingdom, EC1V 2NX.\ngeniuspay Inc. is a incorporated in Canada under Corporation Number 13975185 with registered office: 9 Rue Des Colibris Saint-Clet, QC, Canada J0P1S0.\ngeniuspay OÜ is incorporated in the Republic of Estonia under Registration Number 16294084 with its legal address being at Harjumaa, Tallinn linn, Sakala tn 7-2, 10141, Estonia\ngeniuspay sp. z O.O is a limited liability company incorporated in the Republic of Poland with registration number 0000966701 with its legal address: Ul. Rychtalska 11 / 71, 50-304 Wrocław\ngeniuspay (US) Inc. is incorporated in the United States with its registered address: 651 N Broad ST Suite 201, Middleton DE 19709",
      type: FAQType.other),
    FAQQuestion(
      id: '13',
      question: 'How are Genio points earned?',
      discription:
          "geniuspay gives you 1 point for every \$1 on your transaction fees*, or when you spend with the geniuspay Prepaid MasterCard. You can also earn points by completeing certain account related tasks which include completing verification or referring a friend.\nYou can earn a maximum of one thousand (1,000) Points per Qualifying Transaction and an aggregate maximum of five hundred thousand (500, 000) Points in a calendar month. \n\nAny rounding will be done to the lower whole number (for example, if you transact an amount of up to USD 0.5 you will get zero Points. If you transact an amount of USD 1.1 – USD 1.9 you will receive 1 Loyalty Point).\n\nOnly the following transactions are considered as qualified:\n1.Spending from MasterCard\n2. Performing Currency exchange\n3.International transfers (fee payable)",
      type: FAQType.other),
    FAQQuestion(
      id: '14',
      question: 'Does my points expire?',
      discription:
          "Yes points do expire. All of the Points earned in any calendar year must be redeemed by the end of the following calendar year or all of the Points earned in that year will expire at the end of the said following calendar year.",
      type: FAQType.other),
];
