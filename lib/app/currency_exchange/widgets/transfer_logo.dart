import 'package:flutter/material.dart';

import '../../../util/color_scheme.dart';

class TransferLogo extends StatelessWidget {
  const TransferLogo({ Key? key, required this.icondata }) : super(key: key);
  final IconData icondata;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        width: 100,
        padding: const EdgeInsets.all(4.1),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/circle.png'),
          ),
        ),
        child: Container(
          margin: const EdgeInsets.all(13.87),
          decoration: BoxDecoration(
              color: AppColor.kSecondaryColor,
              borderRadius: BorderRadius.circular(100)),
          child: Icon(
            icondata,
            size: 30,
            color: Colors.white,
          ),
        ));
  }
}