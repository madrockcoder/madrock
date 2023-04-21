import 'package:flutter/material.dart';
import 'package:geniuspay/util/color_scheme.dart';
// import 'package:geniuspay/constants/color_scheme.dart';
// import 'package:geniuspay/constants/style_constants.dart';

class AddNewRecipient extends StatelessWidget {
  final String title;
  const AddNewRecipient({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          backgroundColor: AppColor.kAccentColor2,
          radius: 20,
          child: Icon(
            Icons.add,
            size: 25,
            color: Colors.black,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(title,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.w600))
      ],
    );
  }
}
