import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../util/color_scheme.dart';

class QuestionTile extends StatelessWidget {
  const QuestionTile({Key? key, required this.question}) : super(key: key);
  final String question;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            question,
            style: GoogleFonts.lato(
              textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColor.kOnPrimaryTextColor2,
                  fontWeight: FontWeight.w400),
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
          ),
        ],
      ),
    );
  }
}
