import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../util/color_scheme.dart';

class TransactionFormItem extends StatelessWidget {
  const TransactionFormItem(
      {Key? key, required this.title, required this.content})
      : super(key: key);

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: AppColor.kSecondaryColor),
        ),
        const Gap(10),
        Expanded(
            child: Text(
          content,
          textAlign: TextAlign.right,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
        ))
      ],
    );
  }
}
