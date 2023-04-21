import 'package:flutter/material.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomKeyboard extends StatelessWidget {
  final Widget? customButton;
  final Function(int pressedKey) onKeypressed;
  const CustomKeyboard(
      {Key? key, this.customButton, required this.onKeypressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 13.5,
        mainAxisSpacing: .5,
        childAspectRatio: 1.5,
      ),
      itemCount: 12,
      itemBuilder: (_, i) {
        if (i == 9) {
          return customButton ?? Container();
        } else {
          return InkWell(
            onTap: () {
              onKeypressed(i);
            },
            child: SizedBox(
              height: 30.0,
              width: 30.0,
              child: Center(
                child: i == 11
                    ? const Icon(
                        Icons.arrow_back_ios,
                        size: 24.0,
                        color: AppColor.kOnPrimaryTextColor2,
                      )
                    : Text(
                        i == 10 ? '0' : (i == 9 ? '' : '${i + 1}'),
                        style: GoogleFonts.poppins(
                          textStyle: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(
                                  color: AppColor.kOnPrimaryTextColor2,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 30),
                        ),
                      ),
              ),
            ),
          );
        }
      },
    );
  }
}
