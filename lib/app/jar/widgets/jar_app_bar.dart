import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geniuspay/util/color_scheme.dart';

class JarAppBar extends StatelessWidget with PreferredSizeWidget {
  const JarAppBar({
    Key? key,
    this.backgroundColor = AppColor.kAccentColor2,
    required this.text,
  }) : super(key: key);

  final Color backgroundColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      title: Text(text, style: textTheme.titleLarge),
      centerTitle: true,
      leading: const BackButton(color: Colors.black),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 30),
          child: SvgPicture.asset('assets/icons/Faq.svg', height: 30),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
