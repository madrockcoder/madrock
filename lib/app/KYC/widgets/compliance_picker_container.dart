import 'package:flutter/material.dart';
import 'package:geniuspay/app/shared_widgets/custom_container.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../util/color_scheme.dart';

class CompliancePickerContainer extends CustomContainer {
  CompliancePickerContainer({
    Key? key,
    required BuildContext context,
    String? title,
    VoidCallback? onPressed,
  }) : super(
          key: key,
          // maxHeight: 70.0,
          radius: 16.0,
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
          width: double.infinity,
          onPressed: onPressed,
          containerColor: AppColor.kFilledColor,
          borderColor: AppColor.kTextFieldBorderColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // if(addSuffix)
              // if (suffix == null && addSuffix)
              Flexible(
                child: Text(
                  title ?? 'Select range',
                  style: GoogleFonts.lato(
                    textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColor.kTextFieldTextColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0,
                        ),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(
                Icons.expand_more_rounded,
                color: AppColor.kSubtitleTextColor,
              ),
              // if (suffix != null) suffix
            ],
          ),
        );
}
