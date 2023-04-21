import 'package:flutter/material.dart';
import 'package:geniuspay/util/color_scheme.dart';
// import 'package:geniuspay/constants/color_scheme.dart';
// import 'package:geniuspay/constants/style_constants.dart';

class EditDeleteModalSheet extends StatefulWidget {
  const EditDeleteModalSheet({Key? key}) : super(key: key);

  @override
  State<EditDeleteModalSheet> createState() => _EditDeleteModalSheetState();
}

class _EditDeleteModalSheetState extends State<EditDeleteModalSheet> {
  bool _isEditSelected = false;
  bool _isDeleteSelected = false;
  bool _isSendMoneySelected = false;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
      child: Container(
        height: 235,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _getTile('Edit', (bool? value) {
                setState(() {
                  _isEditSelected = value!;
                });
              }, _isEditSelected),
              const SizedBox(
                height: 10,
              ),
              _getTile('Delete', (bool? value) {
                setState(() {
                  _isDeleteSelected = value!;
                });
              }, _isDeleteSelected),
              const SizedBox(
                height: 10,
              ),
              _getTile('Send money', (bool? value) {
                setState(() {
                  _isSendMoneySelected = value!;
                });
              }, _isSendMoneySelected),
            ],
          ),
        ),
      ),
    );
  }

  Row _getTile(String label, Function(bool?)? onChanged, bool? value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Checkbox(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            autofocus: false,
            checkColor: Colors.white,
            activeColor: AppColor.kSecondaryColor,
            value: value,
            onChanged: onChanged)
      ],
    );
  }
}
