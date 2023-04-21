import 'package:flutter/material.dart';
import 'package:geniuspay/app/shared_widgets/custom_list_tile.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../util/color_scheme.dart';

class BottomSheetContentListTile extends CustomListTile {
  BottomSheetContentListTile({
    Key? key,
    required BuildContext context,
    required String title,
    required VoidCallback? onTap,
  }) : super(
          key: key,
          onTap: onTap,
          title: Text(
            title,
            style: GoogleFonts.lato(
              textStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColor.kOnPrimaryTextColor2),
            ),
            // textAlign: TextAlign.center,
          ),
        );
}
