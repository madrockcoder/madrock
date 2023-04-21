import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geniuspay/app/shared_widgets/custom_container.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:google_fonts/google_fonts.dart';

class ReasonsContainer extends CustomContainer {
  ReasonsContainer({
    Key? key,
    required String iconImage,
    required String text,
    required bool isSelected,
    required BuildContext context,
    required VoidCallback onPressed,
  }) : super(
          key: key,
          radius: 16.0,
          onPressed: onPressed,
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
          borderColor: AppColor.kBorderColor,
          containerColor:
              isSelected ? AppColor.kSurfaceColorVariant : Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    iconImage,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    text,
                    style: isSelected
                        ? GoogleFonts.lato(
                            textStyle: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: Colors.white),
                          )
                        : GoogleFonts.lato(
                            textStyle: Theme.of(context).textTheme.bodyLarge),
                  ),
                ],
              ),
            ],
          ),
        );
}
