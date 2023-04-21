import 'package:flutter/material.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';

class ModalSheetTemplate extends StatelessWidget {
  final Widget child;
  final String title;
  const ModalSheetTemplate({Key? key, required this.child, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.75,
        padding: const EdgeInsets.all(22),
        child: Scaffold(
            backgroundColor: Colors.grey[50],
            appBar: AppBar(
              backgroundColor: Colors.grey[50],
              leading: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(title),
              actions: const [HelpIconButton()],
            ),
            body: child));
  }
}
