import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/util/color_scheme.dart';

class AllSavingsScreen extends StatefulWidget {
  const AllSavingsScreen({Key? key}) : super(key: key);

  @override
  State<AllSavingsScreen> createState() => _AllSavingsScreenState();
}

class _AllSavingsScreenState extends State<AllSavingsScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final width = MediaQuery.of(context).size.width;
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
        centerTitle: true,
        title: Text(
          'Jar',
          style: textTheme.titleLarge?.copyWith(color: AppColor.kOnPrimaryTextColor),
        ),
        actions: [
          HelpIconButton(
            onTap: () {},
          )
        ],
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: width / 4,
                    child: Text(
                      'All Savings',
                      style: textTheme.displayMedium?.copyWith(color: AppColor.kSecondaryColor),
                    ),
                  ),
                  SizedBox(
                    width: width / 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text('Total Balance\n',
                            textAlign: TextAlign.end,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w100, color: AppColor.kSecondaryColor)),
                        Text(
                          '\$ 15,500',
                          textAlign: TextAlign.end,
                          style: textTheme.headlineMedium?.copyWith(color: AppColor.kSecondaryColor),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 15),
                child: Text(
                  'Summer trip',
                  style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: Container(
                      height: 50,
                      width: 50,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(9), color: AppColor.kAccentColor2.withOpacity(0.3)),
                      child: Image.asset(
                        'assets/jar/summer.png',
                        scale: 1.5,
                      )),
                  title: Wrap(children: [
                    Container(
                      height: 50,
                      width: 200,
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: AppColor.kAccentColor2,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9),
                              color: AppColor.kWhiteColor,
                            ),
                            child: Text(
                              '\$ 1,500',
                              style: textTheme.bodyMedium?.copyWith(color: AppColor.kSecondaryColor),
                            ),
                          )
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 15),
                child: Text(
                  'New phone',
                  style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: Container(
                      height: 50,
                      width: 50,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(9), color: AppColor.kAccentColor2.withOpacity(0.3)),
                      child: Image.asset(
                        'assets/jar/mobile.png',
                        scale: 1.5,
                      )),
                  title: Wrap(children: [
                    Container(
                      height: 50,
                      width: 240,
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: AppColor.kAccentColor2,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9),
                              color: AppColor.kWhiteColor,
                            ),
                            child: Text(
                              '\$ 3,500',
                              style: textTheme.bodyMedium?.copyWith(color: AppColor.kSecondaryColor),
                            ),
                          )
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        child: CustomElevatedButton(
            color: AppColor.kGoldColor2,
            borderColor: AppColor.kGoldColor2,
            onPressed: () {},
            child: Text(
              'NEW JAR',
              style: textTheme.bodyLarge,
            )),
      ),
    );
  }
}
