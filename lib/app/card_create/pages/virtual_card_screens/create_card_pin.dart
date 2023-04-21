// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/card_create/pages/virtual_card_screens/your_cards_screen.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/custom_keyboard.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/app/shared_widgets/pin_text_field.dart';
import 'package:geniuspay/util/color_scheme.dart';

List pinCode = [];
String pinCodeString = '';

class CreateCardPin extends StatefulWidget {
  const CreateCardPin({Key? key}) : super(key: key);
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => CreateCardPin()),
    );
  }

  @override
  State<CreateCardPin> createState() => _CreateCardPinState();
}

class _CreateCardPinState extends State<CreateCardPin> {
  bool selectedValue = false;
  bool _disableButton = true;
  final _pins = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.kWhiteColor,
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
            'Create card PIN',
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 13, right: 24, left: 24),
            child: Text(
                'Create a 4 digit pin that will be used to complete transactions with this card.',
                style:
                    textTheme.bodyMedium?.copyWith(color: AppColor.kGreyColor)),
          ),
          const Gap(16),
          Container(
            width: width / 1.4,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (var pin in _pins)
                  PINTextField(
                    obscureText: true,
                    controller: pin,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 28.0,
                        ),
                  ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 24, left: 24),
            child: CustomElevatedButton(
              onPressed: _disableButton
                  ? null
                  : () {
                      YourCardScreen.show(context);
                      pinCodeString = pinCode.join("");
                      pinCode.clear();
                    },
              radius: 8,
              color: AppColor.kGoldColor2,
              // : AppColor.kGoldColor2,
              child: Text('CONTINUE', style: textTheme.bodyLarge),
            ),
          ),
          CustomKeyboard(onKeypressed: (i) {
            keysPressed(i);
            if (_pins.last.text.isEmpty) {
              setState(() => _disableButton = true);
            } else {
              setState(() => _disableButton = false);
            }
          }),
          const Gap(30),
        ],
      ),
    );
  }

  var activeField = 0;

  int zeroKeyPressed(int i) {
    if (i == 10) {
      return 0;
    } else {
      return i + 1;
    }
  }

  void keysPressed(int i) {
    if (i == 9) return;
    if (i == 11) {
      if (activeField != 0) {
        _pins[--activeField].clear();
      }
    } else {
      if (activeField != _pins.length) {
        _pins[activeField++].text = zeroKeyPressed(i).toString();
      }
    }
  }
}
