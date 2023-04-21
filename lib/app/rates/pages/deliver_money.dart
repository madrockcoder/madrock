// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:geniuspay/app/rates/pages/deliver_amount.dart';
import 'package:geniuspay/app/shared_widgets/icon_container.dart';
import 'package:geniuspay/util/color_scheme.dart';

class DeliverMoneyToRecipient extends StatefulWidget {
  const DeliverMoneyToRecipient({Key? key}) : super(key: key);

  @override
  State<DeliverMoneyToRecipient> createState() => _DeliverMoneyToRecipientState();
}

class _DeliverMoneyToRecipientState extends State<DeliverMoneyToRecipient> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [AppColor.kAccentColor2, AppColor.kWhiteColor])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.close)),
        ),
        body: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Select the country to send money from',
                  style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 25),
                height: height / 4,
                width: width,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColor.kWhiteColor, boxShadow: [
                  BoxShadow(
                    color: AppColor.kAccentColor2,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  )
                ]),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                        leading: IconContainer(
                          color: AppColor.kAccentColor2,
                          icon: Image.asset("assets/rates/bank-account.png"),
                        ),
                        title: Text(
                          'To bank account',
                          style: textTheme.titleMedium?.copyWith(fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 30, right: 24, left: 24, bottom: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Limit',
                                  style: textTheme.titleSmall?.copyWith(color: AppColor.kSecondaryColor, fontSize: 14),
                                ),
                                Text(
                                  '10,000.00 USD',
                                  style: textTheme.titleSmall?.copyWith(color: Colors.grey, fontSize: 14),
                                )
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5, bottom: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Fee',
                                      style: textTheme.titleSmall?.copyWith(color: AppColor.kSecondaryColor, fontSize: 14)),
                                  Text(
                                    '0.00 USD',
                                    style: textTheme.titleSmall?.copyWith(color: Colors.grey, fontSize: 14),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Should arrive',
                                    style: textTheme.titleSmall?.copyWith(color: AppColor.kSecondaryColor, fontSize: 14)),
                                Text(
                                  'Up to 3 business days',
                                  style: textTheme.titleSmall?.copyWith(color: Colors.grey, fontSize: 14),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DeliverAmount()));
                },
                child: Container(
                  margin: EdgeInsets.only(top: 25),
                  height: height / 4,
                  width: width,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColor.kWhiteColor, boxShadow: [
                    BoxShadow(
                      color: AppColor.kAccentColor2,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    )
                  ]),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListTile(
                          leading: IconContainer(
                            color: AppColor.kAccentColor2,
                            icon: Image.asset("assets/rates/digital_wallet.png"),
                          ),
                          title: Text(
                            'To digital wallet',
                            style: textTheme.titleMedium?.copyWith(fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 30, right: 24, left: 24, bottom: 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Limit',
                                    style: textTheme.titleSmall?.copyWith(color: AppColor.kSecondaryColor, fontSize: 14),
                                  ),
                                  Text(
                                    '10,000.00 USD',
                                    style: textTheme.titleSmall?.copyWith(color: Colors.grey, fontSize: 14),
                                  )
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5, bottom: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Fee',
                                        style: textTheme.titleSmall?.copyWith(color: AppColor.kSecondaryColor, fontSize: 14)),
                                    Text(
                                      '0.00 USD',
                                      style: textTheme.titleSmall?.copyWith(color: Colors.grey, fontSize: 14),
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Should arrive',
                                      style: textTheme.titleSmall?.copyWith(color: AppColor.kSecondaryColor, fontSize: 14)),
                                  Text(
                                    'In a few minutes',
                                    style: textTheme.titleSmall?.copyWith(color: Colors.grey, fontSize: 14),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
