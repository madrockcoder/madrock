import 'package:flutter/material.dart';

import '../../../../util/color_scheme.dart';

class ExpandableLog extends StatefulWidget {
  const ExpandableLog({
    Key? key,
    required this.title,
    required this.expand,
  }) : super(key: key);
  final String title;
  final ValueChanged<bool> expand;

  @override
  State<ExpandableLog> createState() => _ExpandableLogState();
}

class _ExpandableLogState extends State<ExpandableLog> {
  var _isExpanded = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _expand(null),
      child: Material(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
          height: 40.0,
          width: double.infinity,
          color: AppColor.kAccentColor2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: AppColor.kSecondaryColor),
              ),
              ExpandIcon(
                padding: const EdgeInsets.all(0.0),
                isExpanded: _isExpanded,
                onPressed: _expand,
                color: AppColor.kSecondaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _expand(bool? val) {
    setState(() {
      _isExpanded = !_isExpanded;
    });
    widget.expand(_isExpanded);
  }
}
