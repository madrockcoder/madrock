

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../util/color_scheme.dart';

class TransactionContainer extends Row{

  final String image,category, amount;
  final BuildContext context;
   TransactionContainer(this.context, {Key? key, required this.image, required this.category,required this.amount}): super(key: key,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          CircleAvatar(
            child: SvgPicture.asset(image) ,
            backgroundColor: AppColor.kButton2Color,
          ),
          const SizedBox(width: 15,),

          Text(category,
            style: GoogleFonts.lato(
              textStyle:
              Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColor.kPinDesColor,
                fontWeight: FontWeight.normal,
              ),
            ),)
        ],
      ),

      Text(amount,
        textAlign: TextAlign.left,
        style: GoogleFonts.lato(
          textStyle:
          Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w900,
          ),
        ),)
    ]
  );

}