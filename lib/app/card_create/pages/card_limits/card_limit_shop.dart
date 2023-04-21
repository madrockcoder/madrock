import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/util/color_scheme.dart';

class CardLimitShop extends StatefulWidget {
  const CardLimitShop({Key? key}) : super(key: key);

  @override
  State<CardLimitShop> createState() => _CardLimitShopState();
}

class _CardLimitShopState extends State<CardLimitShop> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: SvgPicture.asset(
            'assets/share_with_contact/arrowback.svg',
            fit: BoxFit.scaleDown,
            height: 15,
            width: 15,
            color: Colors.black,
          ),
        ),
        title: Center(
          child: Text(
            'Shops',
            style: textTheme.titleLarge
                ?.copyWith(color: AppColor.kOnPrimaryTextColor),
          ),
        ),
        actions: [
          HelpIconButton(
            onTap: () {},
          )
        ],
      ),
      body: Padding(
          padding:
              const EdgeInsets.only(top: 38, left: 24, right: 24, bottom: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Daily cash transaction limit',
                      style: textTheme.headlineMedium
                          ?.copyWith(color: AppColor.kSecondaryColor)),
                  Container(
                    margin: const EdgeInsets.only(top: 25),
                    child: Text(
                      'Every day, you can pay with your card for shopping up to this amount:',
                      style: textTheme.bodyMedium
                          ?.copyWith(color: AppColor.kOnPrimaryTextColor),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: TextFormField(
                        initialValue: '\$50,000.00',
                        style: textTheme.headlineMedium
                            ?.copyWith(color: AppColor.kSecondaryColor),
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        )),
                  ),
                  const Divider(
                    color: AppColor.kGreyColor,
                    height: 15,
                    thickness: 1,
                  ),
                  Text('max to be set 50,000.00 USD',
                      style: textTheme.bodySmall
                          ?.copyWith(color: AppColor.kSecondaryColor)),
                  Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xff008AA7),
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffE0F7FE),
                      ),
                      padding: const EdgeInsets.only(left: 20),
                      margin: const EdgeInsets.only(top: 25),
                      child: TextFormField(
                        // controller: ,
                        onChanged: (value) {
                          setState(() {});
                        },
                        enabled: false,
                        initialValue: '50,000.00 USD',
                        style: textTheme.headlineMedium
                            ?.copyWith(color: AppColor.kSecondaryColor),
                        decoration: InputDecoration(
                          labelText: 'Today, you can still pay:',
                          counterText: '',
                          border: InputBorder.none,
                          labelStyle: textTheme.bodyMedium
                              ?.copyWith(color: AppColor.kOnPrimaryTextColor3),
                        ),
                      )),
                  Container(
                    margin: const EdgeInsets.only(top: 35),
                    child: Text(
                      'Every day you can pay with your card for shopping:',
                      style: textTheme.bodyMedium
                          ?.copyWith(color: AppColor.kOnPrimaryTextColor),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: TextFormField(
                        initialValue: '15',
                        style: textTheme.headlineMedium
                            ?.copyWith(color: AppColor.kSecondaryColor),
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        )),
                  ),
                  const Divider(
                    color: AppColor.kGreyColor,
                    height: 15,
                    thickness: 1,
                  ),
                  Text('max 10 transactions',
                      style: textTheme.bodySmall
                          ?.copyWith(color: AppColor.kSecondaryColor)),
                  Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xff008AA7),
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffE0F7FE),
                      ),
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      margin: const EdgeInsets.only(top: 25),
                      child: TextFormField(
                        // controller: ,
                        onChanged: (value) {
                          setState(() {});
                        },
                        enabled: false,
                        initialValue: ' Today, you can still withdraw 10 times',
                        style: textTheme.headlineMedium
                            ?.copyWith(color: AppColor.kSecondaryColor),
                        decoration: const InputDecoration(
                          counterText: '',
                          border: InputBorder.none,
                        ),
                      )),
                ],
              ),
              CustomElevatedButton(
                child:
                    Text('SAVE', style: Theme.of(context).textTheme.bodyLarge),
                onPressed: () {},
                color: AppColor.kGoldColor2,
                radius: 8,
              ),
            ],
          )),
    );
  }
}
