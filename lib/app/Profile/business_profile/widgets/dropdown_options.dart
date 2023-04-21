import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/shared_widgets/custom_divider.dart';
import 'package:geniuspay/app/shared_widgets/custom_text_field.dart';
import 'package:geniuspay/app/shared_widgets/radio_list_tile.dart';
import 'package:geniuspay/util/color_scheme.dart';

class DropDownOptions extends StatefulWidget {
  final int initialChecked;
  final List<String> items;
  final String heading;

  const DropDownOptions(
      {Key? key,
      required this.initialChecked,
      required this.items,
      required this.heading})
      : super(key: key);

  @override
  State<DropDownOptions> createState() => _DropDownOptionsState();
}

class _DropDownOptionsState extends State<DropDownOptions> {
  int? _isChecked = 0;
  late List<String> items;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _isChecked = widget.initialChecked;
    items = widget.items;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Gap(33),
        // Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 24),
        //     child: Row(
        //       children: [
        //         const Spacer(),
        //         Text(widget.heading,
        //             style: textTheme.headline1
        //                 ?.copyWith(fontSize: 16, fontWeight: FontWeight.w700)),
        //         const Spacer(),
        //       ],
        //     )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: CustomTextField(
            controller: _searchController,
            height: 40,
            radius: 9,
            style: textTheme.bodyMedium,
            contentPadding: const EdgeInsets.only(bottom: 10),
            validationColor: AppColor.kSecondaryColor,
            onChanged: (searchTerm) {
              if (_searchController.text.isNotEmpty) {
                items = widget.items
                    .where((e) => e
                        .toLowerCase()
                        .contains(searchTerm.trim().toLowerCase()))
                    .toList();
              } else {
                items = widget.items;
              }
              setState(() {});
            },
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: SvgPicture.asset(
                'assets/images/search.svg',
                color: AppColor.kSecondaryColor,
              ),
            ),
            // label: 'Search',
            hint: 'Search',
          ),
        ),
        const Gap(16),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ListView.separated(
              itemCount: items.length,
              separatorBuilder: (context, index) => const CustomDivider(
                  sizedBoxHeight: 0, color: AppColor.kAccentColor2),
              itemBuilder: (context, index) => CustomRadioListTile(
                groupValue: _isChecked,
                miniTile: true,
                title: Text(items[index]),
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
        ),
      ],
    );
  }
}
