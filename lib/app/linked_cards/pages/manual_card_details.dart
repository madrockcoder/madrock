// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/textfield_decoration.dart';
import 'package:geniuspay/util/color_scheme.dart';

addCardManually(context) {
  return showModalBottomSheet<String>(
    backgroundColor: Colors.transparent,
    context: context,
    isScrollControlled: true,
    builder: (BuildContext ctx) {
      double height = MediaQuery.of(context).size.height;
      double width = MediaQuery.of(context).size.width;
      final textTheme = Theme.of(context).textTheme;
      final _creditCardNumberFocus = FocusNode();
      TextEditingController creditCardNumberController = TextEditingController();
      final _expiryDateFocus = FocusNode();
      TextEditingController expiryDateController = TextEditingController();
      final _cvvNumberFocus = FocusNode();
      TextEditingController cvvNumberController = TextEditingController();
      return StatefulBuilder(
        builder: (BuildContext context, setState) => Container(
            padding: const EdgeInsets.only(
              top: 15,
            ),
            height: height / 1.2,
            decoration: const BoxDecoration(
                color: Color(0xffFFFFFF),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBar(
                      backgroundColor: Colors.transparent,
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
                        'Add card',
                        style: textTheme.headlineSmall?.copyWith(color: AppColor.kOnPrimaryTextColor),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 30),
                      child: Text(
                        ' We store your card details securely.',
                        style: textTheme.titleMedium,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20, left: 15, right: 15),
                      height: height / 3,
                      width: width,
                      child: Card(
                          shadowColor: Color(0xffF1F1F2),
                          elevation: 4,
                          // color: const Color(0xffFFFFFF),
                          // color: Colors.amber,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Container(
                            padding: EdgeInsets.only(left: 24, right: 24, top: 16),
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: creditCardNumberController,
                                  decoration: TextFieldDecoration(
                                    prefix: Image.asset(
                                      'assets/linked_cards/card.png',
                                    ),
                                    context: context,
                                    focusNode: _creditCardNumberFocus,
                                    hintText: 'Credit card number',
                                    onClearTap: () {
                                      setState(() {
                                        creditCardNumberController.clear();
                                      });
                                    },
                                    controller: creditCardNumberController,
                                  ).inputDecoration(),
                                  onChanged: (val) {
                                    setState(() {});
                                  },
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: width / 1.8,
                                        child: TextFormField(
                                          controller: expiryDateController,
                                          decoration: TextFieldDecoration(
                                            removeClear: true,
                                            context: context,
                                            focusNode: _expiryDateFocus,
                                            hintText: 'Expiry date',
                                            onClearTap: () {
                                              setState(() {
                                                expiryDateController.clear();
                                              });
                                            },
                                            controller: expiryDateController,
                                          ).inputDecoration(),
                                          onChanged: (val) {
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Flexible(
                                        child: TextFormField(
                                          controller: cvvNumberController,
                                          keyboardType: TextInputType.number,
                                          decoration: TextFieldDecoration(
                                            removeClear: true,
                                            context: context,
                                            focusNode: _cvvNumberFocus,
                                            hintText: 'CVV',
                                            onClearTap: () {
                                              setState(() {
                                                creditCardNumberController.clear();
                                              });
                                            },
                                            controller: cvvNumberController,
                                          ).inputDecoration(),
                                          onChanged: (val) {
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 25),
                                  child: Text(
                                    'We accept Visa or Mastercard debit cards',
                                    style: textTheme.titleSmall,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/linked_cards/visa.png'),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Image.asset('assets/linked_cards/mastercard.png')
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(25),
                  child: CustomElevatedButton(
                      color: AppColor.kGoldColor2,
                      borderColor: AppColor.kGoldColor2,
                      onPressed: () {},
                      child: Text(
                        'ADD CARD',
                        style: textTheme.bodyLarge,
                      )),
                )
              ],
            )),
      );
    },
  );
}
