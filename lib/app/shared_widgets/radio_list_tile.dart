import 'package:flutter/material.dart';
import 'package:geniuspay/app/shared_widgets/custom_radiobutton.dart';

class CustomRadioListTile extends StatefulWidget {
  final Widget title;
  final Widget? subtitle;
  final int? groupValue;
  final int tileValue;
  final Function(int value) onTap;
  final Widget? leading;
  final bool miniTile;
  const CustomRadioListTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.groupValue,
    required this.onTap,
    required this.leading,
    required this.tileValue, this.miniTile = false,
  }) : super(key: key);

  @override
  State<CustomRadioListTile> createState() => _CustomRadioListTileState();
}

class _CustomRadioListTileState extends State<CustomRadioListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        widget.onTap(widget.tileValue);
      },
      visualDensity: widget.miniTile?const VisualDensity(vertical: -4):null,
      leading: widget.leading,
      title: widget.title,
      subtitle: widget.subtitle,
      trailing: CustomRadioButton(
          tileValue: widget.tileValue,
          groupValue: widget.groupValue,
          onChanged: (val) {
            widget.onTap(widget.tileValue);
          }),
    );
  }
}
