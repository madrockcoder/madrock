import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/card_create/dialogs_popups/dialogs_and_popups.dart';
import 'package:geniuspay/app/shared_widgets/add_icon_button.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:google_fonts/google_fonts.dart';

//Variables for this screen
bool cancelCard = false;
List<String> dropDownList = [
  'I have lost my card',
  'My card has been stolen',
  'Other'
];
TextEditingController cancelCardController = TextEditingController();

// String selectedReason = 'I have lost my card';
//
class CancelCard extends StatefulWidget {
  const CancelCard({Key? key}) : super(key: key);

  @override
  State<CancelCard> createState() => _CancelCardState();
}

class _CancelCardState extends State<CancelCard> {
  String maskAccountId(String accountId) {
    /** Condition will only executes if accountId is *not* undefined, null, empty, false or 0*/
    final accountIdLength = accountId.length;
    final maskedLength = accountIdLength - 4;
    /** Modify the length as per your wish */
    var newString = accountId;
    for (var i = 0; i < accountIdLength; i++) {
      if (i < maskedLength) {
        newString = newString.replaceFirst(accountId[i], '*');
      }
    }

    return newString;

    /**Will handle if no string is passed */
  }

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
        title: Container(
          margin: const EdgeInsets.only(right: 30),
          child: Center(
            child: Text(
              'Your Cards',
              style: textTheme.titleLarge
                  ?.copyWith(color: AppColor.kOnPrimaryTextColor),
            ),
          ),
        ),
        actions: const [AddIconButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 38, bottom: 35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Container(
                    height: 189,
                    width: MediaQuery.of(context).size.width + 65,
                    decoration: BoxDecoration(
                      color: AppColor.kGoldColor2,
                      borderRadius: BorderRadius.circular(9),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: const Offset(2, 5),
                            spreadRadius: 2,
                            blurRadius: 10)
                      ],
                    ),
                    child: Stack(
                      fit: StackFit.passthrough,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Transform.translate(
                            offset: const Offset(-10, -10),
                            child: InkWell(
                              onTap: () {
                                cardView(context);
                              },
                              child: Container(
                                height: 31,
                                width: 31,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black),
                                child: const Center(
                                  child: Icon(Icons.visibility_outlined,
                                      size: 26, color: AppColor.kWhiteColor),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 24.0, top: 11),
                            child: Image.asset('assets/backgrounds/chip.png',
                                height: 52, width: 34),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(right: 24.0, top: 11),
                            child: Image.asset(
                                'assets/backgrounds/master_card.png',
                                height: 54,
                                width: 46),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(right: 24.0, top: 11),
                            child: Image.asset('assets/backgrounds/cloud.png',
                                height: 54, width: 46),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 24.0, bottom: 11),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(maskAccountId('99999999 9999 9999'),
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                                const Gap(11),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'EXPIRY DATE',
                                          style: GoogleFonts.spaceMono(
                                              fontSize: 10,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          '12/2026',
                                          style: GoogleFonts.spaceMono(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Gap(30),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'CVV',
                                          style: GoogleFonts.spaceMono(
                                              fontSize: 10,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          '***',
                                          style: GoogleFonts.spaceMono(
                                              fontSize: 8,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 12),
                        child: ListTile(
                            leading: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: const Color(0xff008AA7),
                                  borderRadius: BorderRadius.circular(25)),
                              child: SvgPicture.asset(
                                'assets/icons/cancel-card.svg',
                                fit: BoxFit.scaleDown,
                                height: 30,
                              ),
                            ),
                            title: Text(
                              "Cancel Card",
                              style: textTheme.titleMedium?.copyWith(
                                  color: AppColor.kOnPrimaryTextColor2),
                            ),
                            subtitle: Text(
                              'Manage spending amounts',
                              style: textTheme.titleSmall?.copyWith(
                                  color: AppColor.kOnPrimaryTextColor3),
                            ),
                            trailing: CupertinoSwitch(
                              value: cancelCard,
                              onChanged: (value) {
                                setState(() {
                                  cancelCard = value;
                                });
                              },
                              activeColor: const Color(0xff008AA7),
                              trackColor: const Color(0xffE0F7FE),
                            )),
                      ),
                      InkWell(
                        onTap: () {
                          cancelCardDropDown(context, setState);
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xff008AA7),
                                ),
                                borderRadius: BorderRadius.circular(10),
                                color: cancelCardController.text.isEmpty
                                    ? Colors.transparent
                                    : const Color(0xffE0F7FE)),
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            margin: const EdgeInsets.only(
                                top: 25, left: 9, right: 9),
                            height: 60,
                            width: width,
                            child: TextFormField(
                              controller: cancelCardController,
                              enabled: false,
                              style: textTheme.headlineMedium?.copyWith(
                                  color: AppColor.kOnPrimaryTextColor),
                              decoration: InputDecoration(
                                suffix: Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: SvgPicture.asset(
                                    'assets/icons/Arrow - Down 2.svg',
                                    width: 12.0,
                                    height: 12.0,
                                  ),
                                ),
                                labelText: 'Reason for canceling the card',
                                counterText: '',
                                border: InputBorder.none,
                                labelStyle: textTheme.bodyMedium?.copyWith(
                                    color: AppColor.kOnPrimaryTextColor3),
                              ),
                            )),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: CustomElevatedButton(
                child: Text(
                  'SAVE',
                  style: cancelCardController.text.isNotEmpty
                      ? Theme.of(context).textTheme.bodyLarge
                      : Theme.of(context).textTheme.bodyMedium,
                ),
                onPressed: () {
                  if (cancelCardController.text.isNotEmpty) {
                    cardCancelDialog(context);
                  }
                },
                color: cancelCardController.text.isNotEmpty
                    ? AppColor.kGoldColor2
                    : AppColor.kAccentColor2,
                radius: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<String?> cancelCardDropDown(BuildContext context, mainSetState) {
  return showModalBottomSheet<String>(
    backgroundColor: Colors.transparent,
    context: context,
    isScrollControlled: true,
    builder: (BuildContext ctx) {
      final textTheme = Theme.of(context).textTheme;
      return StatefulBuilder(
        builder: (BuildContext context, setState) => Container(
          padding: const EdgeInsets.only(top: 20, left: 10),
          height: dropDownList.length * 70,
          decoration: const BoxDecoration(
              color: Color(0xffFFFFFF),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40))),
          child: ListView.builder(
              itemCount: dropDownList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: () {
                    cancelCardController.text = dropDownList[index];
                    mainSetState(() {});
                    Navigator.pop(context);
                  },
                  title: Text(
                    dropDownList[index],
                    style: textTheme.titleMedium
                        ?.copyWith(color: AppColor.kOnPrimaryTextColor2),
                  ),
                  trailing: cancelCardController.text == dropDownList[index]
                      ? IgnorePointer(
                          child: Container(
                            margin: const EdgeInsets.only(right: 12.5),
                            child: const Icon(
                              Icons.check_circle,
                              size: 22,
                              color: Color(0xff008AA7),
                            ),
                          ),
                        )
                      : IgnorePointer(
                          child: Radio(
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => const Color(0xff008AA7)),
                              value: false,
                              groupValue: '',
                              activeColor: const Color(0xff008AA7),
                              onChanged: (value) {}),
                        ),
                );
              }),

          // child: Column(
          //   children: [
          //     ListTile(
          //       leading: Container(
          //         height: 50,
          //         width: 50,
          //         decoration: BoxDecoration(color: Color(0xffE0F7FE), borderRadius: BorderRadius.circular(25)),
          //         child: SvgPicture.asset(
          //           'assets/dialogs/clarity-eye-solid.svg',
          //           fit: BoxFit.scaleDown,
          //           height: 35,
          //         ),
          //       ),
          //       title: Text(
          //         "Show card details",
          //         style: textTheme.bodyText1?.copyWith(color: AppColor.kOnPrimaryTextColor2),
          //       ),
          //     ),
          //   ],
          // )
        ),
      );
    },
  );
}

Future cardCancelDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: SvgPicture.asset('assets/dialogs/card-cancel-dialog.svg'),
    ),
  );
}
