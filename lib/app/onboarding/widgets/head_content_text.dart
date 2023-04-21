


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../util/color_scheme.dart';

class HeadContentText extends Column{
  final String head,content;
  final BuildContext context;
  final Color?  contentTextColor;
  HeadContentText(this.context,{Key? key, required this.head,required this.content, this.contentTextColor, }):super(key: key,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(head,
        style: GoogleFonts.lato(
          textStyle:
          Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColor.kPinDesColor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      const SizedBox(height: 5,),

      Text(
        content,
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(
              fontWeight: FontWeight.w800,
             color: contentTextColor ?? Colors.black
          )
      )
    ]
  );


}