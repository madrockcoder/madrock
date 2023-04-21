import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/util/color_scheme.dart';

//Variables for pin reset screen
TextEditingController oldPin = TextEditingController();
TextEditingController newPin = TextEditingController();
TextEditingController confirmNewPin = TextEditingController();
//

class ChangePin extends StatefulWidget {
  const ChangePin({Key? key}) : super(key: key);

  @override
  State<ChangePin> createState() => _ChangePinState();
}

class _ChangePinState extends State<ChangePin> {
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
            'PIN Reset',
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
      body: Center(
        child: Container(
          padding:
              const EdgeInsets.only(top: 13, right: 24, left: 24, bottom: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children: [
                Text(
                    'Create your new PIN. This PIN can be used to withdraw cash at the ATM, make POS payment and online transactions.',
                    style: textTheme.bodyLarge
                        ?.copyWith(color: AppColor.kOnPrimaryTextColor)),
                Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xff008AA7),
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: oldPin.text.isEmpty
                          ? Colors.transparent
                          : const Color(0xffE0F7FE),
                    ),
                    padding: const EdgeInsets.only(left: 20),
                    margin: const EdgeInsets.only(top: 32),
                    child: TextFormField(
                      maxLength: 4,
                      controller: oldPin,
                      onChanged: (value) {
                        setState(() {});
                      },
                      obscureText: true,
                      obscuringCharacter: '*',
                      decoration: InputDecoration(
                        labelText: 'Enter old PIN',
                        counterText: '',
                        border: InputBorder.none,
                        labelStyle: textTheme.bodyMedium
                            ?.copyWith(color: AppColor.kOnPrimaryTextColor3),
                      ),
                    )),
                Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xff008AA7),
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: newPin.text.isEmpty
                          ? Colors.transparent
                          : const Color(0xffE0F7FE),
                    ),
                    padding: const EdgeInsets.only(left: 20),
                    margin: const EdgeInsets.only(top: 20),
                    child: TextFormField(
                      maxLength: 4,
                      controller: newPin,
                      onChanged: (value) {
                        setState(() {});
                      },
                      obscureText: true,
                      obscuringCharacter: '*',
                      decoration: InputDecoration(
                        labelText: 'Enter new PIN',
                        counterText: '',
                        border: InputBorder.none,
                        labelStyle: textTheme.bodyMedium
                            ?.copyWith(color: AppColor.kOnPrimaryTextColor3),
                      ),
                    )),
                Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xff008AA7),
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: confirmNewPin.text.isEmpty
                          ? Colors.transparent
                          : const Color(0xffE0F7FE),
                    ),
                    padding: const EdgeInsets.only(left: 20),
                    margin: const EdgeInsets.only(top: 20),
                    child: TextFormField(
                      maxLength: 4,
                      controller: confirmNewPin,
                      onChanged: (value) {
                        setState(() {});
                      },
                      obscureText: true,
                      obscuringCharacter: '*',
                      decoration: InputDecoration(
                        labelText: 'Confirm new PIN',
                        counterText: '',
                        border: InputBorder.none,
                        labelStyle: textTheme.bodyMedium
                            ?.copyWith(color: AppColor.kOnPrimaryTextColor3),
                      ),
                    ))
              ]),
              CustomElevatedButton(
                child: Text(
                  'RESET PIN',
                  style: oldPin.text.length == 4 &&
                          newPin.text.length == 4 &&
                          confirmNewPin.text.length == 4
                      ? Theme.of(context).textTheme.bodyLarge
                      : Theme.of(context).textTheme.bodyMedium,
                ),
                onPressed: () {
                  if (oldPin.text.length == 4 &&
                      newPin.text.length == 4 &&
                      confirmNewPin.text.length == 4) {
                    // Navigator.pushNamed(context, AppRouter.chooseGenioCard);
                    pinChangesSuccessDialog(context);
                  }
                },
                color: oldPin.text.length == 4 &&
                        newPin.text.length == 4 &&
                        confirmNewPin.text.length == 4
                    ? AppColor.kGoldColor2
                    : AppColor.kAccentColor2,
                radius: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future pinChangesSuccessDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: SvgPicture.asset('assets/dialogs/pin-changed.svg'),
    ),
  );
}
