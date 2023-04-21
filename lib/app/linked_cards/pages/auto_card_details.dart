import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geniuspay/app/linked_cards/pages/manual_card_details.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/util/color_scheme.dart';

addCardAuto(context) {
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
              top: 15,
            ),
            height: height / 1.2,
            decoration: const BoxDecoration(
                color: Color(0xBF000000),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                          color: AppColor.kWhiteColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Container(
                        height: height / 4,
                        width: width,
                        padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xff525252),
                            border: Border.all(color: AppColor.kWhiteColor, width: 2)),
                        child: Column(
                          children: const [Text('')],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Text(
                        'Add Card',
                        style: textTheme.titleLarge?.copyWith(color: AppColor.kWhiteColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Text(
                        'Position your debit or credit card in the frame to scan it.',
                        style: textTheme.titleSmall,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(25),
                  child: CustomElevatedButton(
                      color: AppColor.kGoldColor2,
                      borderColor: AppColor.kGoldColor2,
                      onPressed: () {
                        Navigator.pop(context);
                        addCardManually(context);
                      },
                      child: Text(
                        'ENTER CARD DETAILS MANUALLY ',
                        style: textTheme.bodyLarge,
                      )),
                )
              ],
            )),
      );
    },
  );
}
