import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/shared_widgets/radio_list_tile.dart';

class DropDownOptions extends StatefulWidget {
  final int? initialChecked;
  final List<String> items;
  final String heading;

  const DropDownOptions(
      {Key? key,
        this.initialChecked,
        required this.items,
        required this.heading})
      : super(key: key);

  @override
  State<DropDownOptions> createState() => _DropDownOptionsState();
}

class _DropDownOptionsState extends State<DropDownOptions> {
  int? _isChecked;

  @override
  void initState() {
    _isChecked = widget.initialChecked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Gap(33),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                const Spacer(),
                Text(widget.heading,
                    style: textTheme.displayLarge
                        ?.copyWith(fontSize: 16, fontWeight: FontWeight.w700)),
                const Spacer(),
              ],
            )),
        const Gap(16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.items.length,
            itemBuilder: (context, index) => CustomRadioListTile(
              groupValue: _isChecked,
              title: Text(widget.items[index]),
              tileValue: index,
              subtitle: null,
              onTap: (int value) {
                setState(() => _isChecked = value);
                Navigator.pop(context, index);
              },
              leading: null,
            ),
          ),
        ),
      ],
    );
  }
}