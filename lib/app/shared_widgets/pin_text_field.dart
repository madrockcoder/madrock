import 'package:flutter/material.dart';

import '../../util/color_scheme.dart';

enum PINType { setting, verification }

class PINTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextStyle style;
  final Function(String)? onChanged;
  final bool obscureText;
  const PINTextField(
      {required this.controller,
      required this.style,
      this.onChanged,
      this.obscureText = false,
      Key? key})
      : super(key: key);

  @override
  State<PINTextField> createState() => _PINTextFieldState();
}

class _PINTextFieldState extends State<PINTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 56,
      height: 56,
      child: TextField(
        controller: widget.controller,
        style: widget.style,
        keyboardType: TextInputType.none,
        onChanged: (val) {
          if (widget.onChanged != null) {
            widget.onChanged!(val);
          }
        },
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          filled: true,
          contentPadding: const EdgeInsets.all(18),
          border: OutlineInputBorder(
            borderSide:
                const BorderSide(color: AppColor.kSecondaryColor, width: 1),
            borderRadius: BorderRadius.circular(9.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: AppColor.kSecondaryColor, width: 1),
            borderRadius: BorderRadius.circular(9.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: AppColor.kSecondaryColor, width: 1),
            borderRadius: BorderRadius.circular(9.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: AppColor.kSecondaryColor, width: 1),
            borderRadius: BorderRadius.circular(9.0),
          ),
          fillColor: widget.controller.text.isNotEmpty
              ? AppColor.kAccentColor2
              : Colors.white,
        ),
      ),
    );
  }
}
