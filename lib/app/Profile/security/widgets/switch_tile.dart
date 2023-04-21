import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geniuspay/util/color_scheme.dart';

class SwitchTile extends StatefulWidget {
  final String title;
  final String? subtitle;
  final bool value;
  final TextStyle? titleStyle;
  final Function(bool val)? onChanged;
  final Color color;
  const SwitchTile(
      {Key? key,
      required this.title,
      this.subtitle,
      required this.value,
      this.titleStyle,
      this.color = AppColor.kSecondaryColor,
      required this.onChanged})
      : super(key: key);

  @override
  State<SwitchTile> createState() => _SwitchTileState();
}

class _SwitchTileState extends State<SwitchTile> {
  late bool value;
  @override
  void initState() {
    setState(() {
      value = widget.value;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(
          widget.title,
          style: widget.titleStyle,
        ),
        subtitle: widget.subtitle == null ? null : Text(widget.subtitle!),
        trailing: CupertinoSwitch(
          activeColor: widget.color,
          value: value,
          onChanged: widget.onChanged == null
              ? null
              : (val) {
                  setState(() {
                    value = val;
                  });
                  widget.onChanged!(val);
                },
        ));
  }
}
