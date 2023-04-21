import 'package:flutter/material.dart';

import '../../../util/color_scheme.dart';

class TransferTitle extends StatelessWidget {
  const TransferTitle({ Key? key, required this.title }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .titleMedium
          ?.copyWith(color: AppColor.kSecondaryColor, fontSize: 25),
    );
  }
}