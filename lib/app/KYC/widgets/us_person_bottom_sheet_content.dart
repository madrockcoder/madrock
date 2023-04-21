import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../util/app_bar_back_button.dart';
import '../../../../../../util/color_scheme.dart';
import 'us_person_text_column.dart';

class USPersonBottomSheetContent extends StatelessWidget {
  const USPersonBottomSheetContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 17.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppBarBackButton(
                context: context,
                onTap: () => Navigator.of(context).pop(),
              ),
              Text(
                'Who is a US Person?',
                style: GoogleFonts.lato(
                  textStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColor.kOnPrimaryTextColor2),
                ),
              ),
              const SizedBox(width: 30.0),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        const USPersonTextColumn(
          title: 'United States IRS Definition of US Person',
          description:
              'All United States tax laws and regulations apply to every US Person whether he/she is working in the United States or in a foreign Country. When it comes to your international tax obligations, it\'s important to understand exactly how ‘US Person\' is defined by the IRS and what it means to you. Failure to understand your tax responsibilities as a US Person can result in hefty penalties associated with your US expat tax liability.',
        ),
        const SizedBox(height: 32.0),
        const USPersonTextColumn(
          title: 'United States Citizens Born Outside of the United States',
          description:
              'If you were born outside of the United States and have dual citizenship with the US  and the foreign Country in which you were born you have a different set of options - especially if you\'ve never lived in the United States. It\'s important to realize, however, that - until you exercise those options - you are still considered a US Person for tax reporting purposes, and you must meet all your US tax obligations. If you wish to voluntary terminate your US Citizenship to avoid being responsible for US taxes, you have the right to do so.',
        ),
      ],
    );
  }
}
