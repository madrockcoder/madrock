import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../util/color_scheme.dart';

class USPersonTextColumn extends StatelessWidget {
  const USPersonTextColumn(
      {Key? key, required this.title, required this.description})
      : super(key: key);
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.lato(
            textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColor.kOnPrimaryTextColor2),
          ),
        ),
        const SizedBox(height: 12.0),
        Text(
          description,
          style: GoogleFonts.lato(
            textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: AppColor.kPinDesColor,
                ),
          ),
        ),
      ],
    );
  }
}
