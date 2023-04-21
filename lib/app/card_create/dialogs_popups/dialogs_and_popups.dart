import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geniuspay/util/color_scheme.dart';

Future<String?> initialDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: SvgPicture.asset('assets/dialogs/card-screen-dialog.svg'),
    ),
  );
}

Future<String?> cardView(BuildContext context) {
  return showModalBottomSheet<String>(
    backgroundColor: Colors.transparent,
    context: context,
    isScrollControlled: true,
    builder: (BuildContext ctx) {
      double height = MediaQuery.of(context).size.height;
      final textTheme = Theme.of(context).textTheme;
      return StatefulBuilder(
        builder: (BuildContext context, setState) => Container(
            padding: const EdgeInsets.only(top: 20, left: 10),
            height: height / 2.6,
            decoration: const BoxDecoration(
                color: Color(0xffFFFFFF),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            child: Column(
              children: [
                ListTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: const Color(0xffE0F7FE),
                        borderRadius: BorderRadius.circular(25)),
                    child: SvgPicture.asset(
                      'assets/dialogs/clarity-eye-solid.svg',
                      fit: BoxFit.scaleDown,
                      height: 35,
                    ),
                  ),
                  title: Text(
                    "Show card details",
                    style: textTheme.titleMedium
                        ?.copyWith(color: AppColor.kOnPrimaryTextColor2),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: const Color(0xffE0F7FE),
                        borderRadius: BorderRadius.circular(25)),
                    child: SvgPicture.asset(
                      'assets/dialogs/copy-outlined.svg',
                      fit: BoxFit.scaleDown,
                      height: 35,
                    ),
                  ),
                  title: Text(
                    "Copy card number",
                    style: textTheme.titleMedium
                        ?.copyWith(color: AppColor.kOnPrimaryTextColor2),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: const Color(0xffE0F7FE),
                        borderRadius: BorderRadius.circular(25)),
                    child: SvgPicture.asset(
                      'assets/dialogs/copy-outlined.svg',
                      fit: BoxFit.scaleDown,
                      height: 35,
                    ),
                  ),
                  title: Text(
                    "Copy CVV",
                    style: textTheme.titleMedium
                        ?.copyWith(color: AppColor.kOnPrimaryTextColor2),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: const Color(0xffE0F7FE),
                        borderRadius: BorderRadius.circular(25)),
                    child: SvgPicture.asset(
                      'assets/dialogs/icon-park.svg',
                      fit: BoxFit.scaleDown,
                      height: 35,
                    ),
                  ),
                  title: Text(
                    "Show billing address",
                    style: textTheme.titleMedium
                        ?.copyWith(color: AppColor.kOnPrimaryTextColor2),
                  ),
                )
              ],
            )),
      );
    },
  );
}
