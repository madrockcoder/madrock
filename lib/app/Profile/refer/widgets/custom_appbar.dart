import 'package:flutter/material.dart';
import 'package:geniuspay/app/Profile/refer/widgets/string_constants.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final Widget trailingWidget;
  const CustomAppBar(this.title, this.trailingWidget, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: IconButton(
          icon: Image.asset(
            kBack,
            height: 30,
            width: 25,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      centerTitle: true,
      actions: [trailingWidget],
    );
  }
}
