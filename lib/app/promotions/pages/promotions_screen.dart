// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/util/color_scheme.dart';

class Promotions extends StatefulWidget {
  const Promotions({Key? key}) : super(key: key);

  @override
  State<Promotions> createState() => _PromotionsState();
}

class _PromotionsState extends State<Promotions> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: MaterialButton(
          onPressed: () {
            promotion(context);
          },
          child: const Text(
            "Promotion",
          ),
          color: Colors.blueAccent,
        ),
      ),
    ));
  }
}

//To open this just call this function and provide context inside onTap/onPressed function
promotion(context) {
  return showModalBottomSheet<String>(
    backgroundColor: Colors.transparent,
    context: context,
    isScrollControlled: true,
    builder: (BuildContext ctx) {
      double height = MediaQuery.of(context).size.height;
      double width = MediaQuery.of(context).size.width;
      final textTheme = Theme.of(context).textTheme;
      return StatefulBuilder(
        builder: (BuildContext context, setState) => Container(
            padding: const EdgeInsets.only(
              top: 40,
              left: 25,
              right: 25,
            ),
            height: height / 1.1,
            decoration: const BoxDecoration(
                color: Color(0xffFFFFFF),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))),
            child: Scaffold(
                body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width / 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.close,
                            size: 24,
                            color: Color(0xff008AA7),
                          ),
                          Text(
                            'Promotions',
                            style: textTheme.titleLarge?.copyWith(color: AppColor.kOnPrimaryTextColor),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Container(
                          width: width / 1.5,
                          margin: const EdgeInsets.only(top: 60),
                          child: Text(
                            'Add promo codes and get the best deals',
                            textAlign: TextAlign.center,
                            style: textTheme.displaySmall?.copyWith(color: AppColor.kSecondaryColor),
                          )),
                    ),
                    Container(
                      // margin: EdgeInsets.only(top: 15),
                      child: Image.asset(
                        'assets/promotions/promotion.png',
                        height: 250,
                        width: width,
                        // color: Colors.amber,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 0),
                      child: Text(
                        'We’ll send them to you by email and in-app notification',
                        style: textTheme.bodyLarge?.copyWith(color: AppColor.kOnPrimaryTextColor2),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
                Column(children: [
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: CustomElevatedButton(
                        child: Text(
                          'ADD CODE',
                          style: textTheme.bodyLarge?.copyWith(color: AppColor.kOnPrimaryTextColor),
                        ),
                        color: const Color(0xffEBD75C),
                        onPressed: () {
                          Navigator.pop(context);
                          addCode(context);
                        },
                        radius: 8),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8, bottom: 50),
                    child: CustomElevatedButton(
                      child: Text(
                        'HAVE A CODE?',
                        style: textTheme.bodyLarge?.copyWith(color: AppColor.kOnPrimaryTextColor),
                      ),
                      color: const Color(0xffFFFFFF),
                      onPressed: () {},
                    ),
                  ),
                ]),
              ],
            ))),
      );
    },
  );
}

TextEditingController promoCodeController = TextEditingController();
addCode(
  context,
) {
  return showModalBottomSheet<String>(
    backgroundColor: Colors.transparent,
    context: context,
    isScrollControlled: true,
    builder: (BuildContext ctx) {
      double height = MediaQuery.of(context).size.height;
      double width = MediaQuery.of(context).size.width;
      final textTheme = Theme.of(context).textTheme;
      return StatefulBuilder(
        builder: (BuildContext context, setState) => Container(
            padding: const EdgeInsets.only(
              top: 40,
              left: 25,
              right: 25,
            ),
            height: height / 1.1,
            decoration: const BoxDecoration(
                color: Color(0xffFFFFFF),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))),
            child: Scaffold(
                body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  SizedBox(
                    width: width / 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(
                          'assets/share_with_contact/arrowback.svg',
                          height: 16,
                          width: 16,
                        ),
                        Text(
                          'Add code',
                          style: textTheme.titleLarge?.copyWith(color: AppColor.kOnPrimaryTextColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xff008AA7),
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: promoCodeController.text.length < 12 ? Colors.transparent : Color(0xffE0F7FE),
                      ),
                      padding: EdgeInsets.only(left: 20),
                      margin: EdgeInsets.only(top: 32),
                      child: TextFormField(
                        controller: promoCodeController,
                        onChanged: (value) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          labelText: 'Enter promo code',
                          border: InputBorder.none,
                          labelStyle: textTheme.bodyMedium?.copyWith(color: AppColor.kOnPrimaryTextColor3),
                        ),
                      ))
                ]),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 50),
                      child: CustomElevatedButton(
                        child: Text(
                          'ADD CODE',
                          style: promoCodeController.text.length < 12
                              ? textTheme.bodyMedium?.copyWith(color: AppColor.kOnPrimaryTextColor3)
                              : textTheme.bodyLarge?.copyWith(color: AppColor.kOnPrimaryTextColor),
                        ),
                        color: promoCodeController.text.length < 12 ? Color(0xffE0F7FE) : Color(0xffEBD75C),
                        onPressed: () {},
                        radius: 8,
                      ),
                    ),
                  ],
                ),
              ],
            ))),
      );
    },
  );
}
