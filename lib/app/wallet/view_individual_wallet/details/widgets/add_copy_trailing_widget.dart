import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/util/color_scheme.dart';

class AddCopyTrailingWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function() onTap;

  const AddCopyTrailingWidget(
      {Key? key,
      required this.title,
      required this.onTap,
      required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColor.kSecondaryColor,
              ),
            ),
            Text(subtitle, style: textTheme.bodyMedium)
          ],
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            Clipboard.setData(ClipboardData(text: "$title: $subtitle"));
            PopupDialogs(context).informationMessage('Copied to clipboard');
          },
          child: SvgPicture.asset(
            "assets/icons/copy.svg",
            width: 16,
            height: 16,
          ),
        ),
        const Gap(7)
      ],
    );
  }
}
