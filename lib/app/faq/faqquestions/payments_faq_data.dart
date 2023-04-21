// ignore_for_file: prefer_const_constructors

import 'package:geniuspay/app/faq/model/app_faq_model.dart';

final allPaymentQuestions = <FAQQuestion>[
  FAQQuestion(
      id: '1',
      question: 'What is SEPA?',
      discription:
          'SEPA stands for Single Euro Payments Area. It was launched by the European banking and payment industry as a means of establishing a set of tools and standards that make cross-border payments in euros as easy as national payments. SEPA is composed of all EU member states, along with the four members of the European Free Trade Association (Iceland, Liechtenstein, Norway and Switzerland), and Andorra, Monaco, San Marino, United Kingdom, Vatican City State, Mayotte, Saint-Pierre-et Miquelon, Guernsey, Jersey and Isle of Man. \nThe SEPA Credit Transfer scheme was established in 2013 and is designed to improve the efficiency of cross-border payments across Europe and is for euro payments only. The advantages of SEPA credit transfers are that payments can be processed and settled the same day, with the maximum execution time set at one working day. In addition, there are no transaction limits.',
      type: FAQType.payments),
  FAQQuestion(
      id: '2',
      question: 'What is CHAPS?',
      discription:
          'CHAPS stands for Clearing House Automated Payment System. It is composed of more than 30 direct participants and over 5000 financial institutions, and is ideally suited to those needing to make large real-time gross settlement sterling payments in the UK. \nThe CHAPS service runs from 6am to 6pm, Monday to Friday – apart from bank or public holidays in England and Wales – and, if payment instructions are received by 2pm on a working day, the CHAPS system guarantees same-day payment and there is no limit to the amount of money that can be sent. It is typically used for making high-value transactions that require same-day guaranteed payment (such as businesses paying suppliers). \nFor banks, financial institutions and businesses that need to make large, urgent payments, CHAPS presents a perfect solution.',
      type: FAQType.payments),
  FAQQuestion(
      id: '3',
      question: 'What is Faster Payments?',
      discription:
          'The Faster Payments Service (FPS) is a UK banking initiative that was launched in 2008. It was established with the aim of reducing payment times between different banks’ customer accounts. The service enables UK sterling payments to be made via mobile, internet, telephone and standing order 24/7. If all parties involved in the transaction are part of FPS, accounts are typically credited within seconds, but it may take longer if one of the accounts is a non-participant of the scheme. \nThe Faster Payments transaction limit is £250,000, although individual banks and financial institutions often set their own limits for personal and corporate customers.',
      type: FAQType.payments),
  FAQQuestion(
      id: '4',
      question: 'What is SWIFT',
      discription:
          'SWIFT stands for the Society for Worldwide Interbank Financial Telecommunication, which was established in 1973 to create common processes and standards for financial transactions. SWIFT is the primary communications network between banks and boasts high levels of security and reliability. The SWIFT network does not transfer funds – it sends payment orders between different bank accounts using SWIFT codes. \nSWIFT standardised both IBANs and BIC codes, and the network owns the BIC system. Because of this, it can identify a bank very quickly and send payment information securely. SWIFT makes international payments simple and straightforward, and helps businesses become more efficient.',
      type: FAQType.payments),
  FAQQuestion(
      id: '5',
      question: 'What is an IBAN?',
      discription:
          'IBAN stands for International Bank Account Number. It is an internationally agreed code that uniquely identifies a bank account. IBANs are composed of up to 34 alphanumeric characters, depending on the country in which the account is held. They help banks process transfers around the world. \nNot all countries require an IBAN, but the system is used throughout Europe and is recognised in many other areas around the world. Because every IBAN follows a set structure, it is possible for individuals to generate their own IBAN if they do not know it. Your IBAN will usually appear on bank statements, but there are a range of tools online that enable you to validate or find an IBAN.',
      type: FAQType.payments),
  FAQQuestion(
      id: '6',
      question: 'How can I see my transfer limit?',
      discription:
          'You can access your transaction limits from your profile by clicking on My limits',
      type: FAQType.payments),
    FAQQuestion(
      id: '7',
      question: 'How long does payments take?',
      discription:
          'In general, SEPA transfers can be instant or take up to two business days. We offer diffrent payment schemes which include instant, urgent and regular. Kindly note that geniuspay has no way of speeding up SWIFT transactions issued from geniuspay or a personal bank. Mobile money payments are completed instantly or between 5 - 30 minutes depending on the destination country.',
      type: FAQType.payments),
    FAQQuestion(
      id: '8',
      question: 'What happens if an international payment is sent to a wrong recipient?',
      discription:
          'When an international payment is sent to a wrong recipient, you can contact our customer support team for assistance. Depending on the status of the payment we will make all possible attempts to retrieve. In some cases, international payments sent to a wrong recipient cannot be reversed.\nIt is important to double-check to make sure beneficiary information is accurate.',
      type: FAQType.payments),
    FAQQuestion(
      id: '9',
      question: 'How can I increase my transfer limits?',
      discription:
          'In some cases, depending on the type of account you have, transfer limits can be increased. Contact our 24/7 customer support team should you wish to increase your transfer limits',
      type: FAQType.payments),
    FAQQuestion(
      id: '10',
      question: 'Why I cannot make a Currency exchange?',
      discription:
          'Together with many other functions, geniuspay is offering, clients will also be able to exchange their balance into different various currencies - from American dollars to Japanese Yen. On the other hand, due to restrictions, currency exchange will not be able to complete and is restricted for following currencies: Indian Rupee (INR), Indonesian Rupiah, Malaysian Ringgit and Philippine Peso.',
      type: FAQType.payments),
];
