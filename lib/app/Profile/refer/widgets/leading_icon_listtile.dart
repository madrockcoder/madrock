import 'package:flutter/material.dart';
import 'package:geniuspay/util/color_scheme.dart';

class LeadingIconListTile extends StatelessWidget {
  final Image leadingImage;
  final String content;
  const LeadingIconListTile(this.leadingImage, this.content, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        height: 35,
        width: 35,
        child: leadingImage,
      ),
      title: Text(
        content,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: AppColor.kGreyColor),
      ),
    );
  }
}
