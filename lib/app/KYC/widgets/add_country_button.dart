import 'package:flutter/material.dart';
import 'package:geniuspay/app/shared_widgets/grouper_container.dart';
import 'package:geniuspay/app/shared_widgets/icon_container.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../util/color_scheme.dart';

class AddCountryButton extends GrouperContainer {
  AddCountryButton({
    Key? key,
    required BuildContext context,
    required VoidCallback? onTap,
  }) : super(
          key: key,
          context: context,
          padding: const EdgeInsets.all(24.0),
          onTap: onTap,
          child: Row(
            children: [
              IconContainer(
                padding: 10.0,
                icon: const Icon(
                  Icons.add,
                  color: AppColor.kSwitchActiveColor,
                  size: 16.0,
                ),
              ),
              const SizedBox(width: 12.0),
              Text(
                'Add Country',
                style: GoogleFonts.lato(
                  textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColor.kPinDesColor,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        );
}
