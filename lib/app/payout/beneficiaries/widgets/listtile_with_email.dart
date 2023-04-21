import 'package:flutter/material.dart';
import 'package:geniuspay/util/color_scheme.dart';

class ListTileWithEmail extends StatelessWidget {
  final String recipientName;
  final String email;
  final Function() onTap;
  const ListTileWithEmail(
      {Key? key,
      required this.recipientName,
      required this.email,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColor.kScaffoldBackgroundColor,
              radius: 20,
              child: Text(
                recipientName.length >= 2
                    ? (recipientName[0] + recipientName[1]).toUpperCase()
                    : '',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.white),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(recipientName,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
                Text(email,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppColor.kSecondaryColor, fontSize: 12))
              ],
            )
          ],
        ));
  }
}
