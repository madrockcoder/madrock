import 'package:flutter/material.dart';

class CustomBeneficiaryListTile extends StatelessWidget {
  final Widget picture;
  final String title;
  final String description;
  final Widget trailingWidget;
  const CustomBeneficiaryListTile(this.title, this.description, this.trailingWidget, this.picture, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        picture,
        const SizedBox(
          width: 12,
        ),
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(
                height: 6,
              ),
              Text(description, style: Theme.of(context).textTheme.bodyMedium)
            ],
          ),
        ),
        const Spacer(),
        trailingWidget
      ],
    );
  }
}
