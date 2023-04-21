import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/text_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.label,
    required this.hint,
    this.icon,
    this.radius,
    this.height,
    this.width,
    this.suffixIcon,
    this.obscureText = false,
    this.autofocus = false,
    this.validator,
    this.controller,
    this.onSaved,
    this.onChanged,
    this.keyboardType,
    this.filled = true,
    this.enabled,
    this.border,
    this.hasBorder = true,
    this.focusedBorder,
    this.enabledBorder,
    this.disabledBorder,
    this.contentPadding,
    this.textAlign = TextAlign.start,
    this.style,
    this.prefixIconConstraints,
    this.validationColor = Colors.transparent,
    this.fillColor,
    this.fieldFocusNode,
    this.prefixIcon,
    this.hintStyle,
    this.inputFormatters,
    this.removePadding = false,
    this.readOnly = false,
    this.maxLength,
    this.onTap, this.maxLines = 1,
  }) : super(key: key);
  final String? label;
  final String hint;
  final Widget? icon;
  final double? radius;
  final double? height;
  final double? width;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? obscureText;
  final bool? autofocus;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final bool? filled;
  final bool? enabled;
  final FocusNode? fieldFocusNode;
  final bool hasBorder;
  final InputBorder? border;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final InputBorder? disabledBorder;
  final EdgeInsetsGeometry? contentPadding;
  final TextAlign? textAlign;
  final TextStyle? style;
  final BoxConstraints? prefixIconConstraints;
  final Color? fillColor;
  final Color validationColor;
  final TextStyle? hintStyle;
  final bool removePadding;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  final GestureTapCallback? onTap;
  final int maxLines;
  final int? maxLength;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding:
          removePadding ? EdgeInsets.zero : const EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
        color: fillColor ?? Colors.transparent,
        borderRadius: BorderRadius.circular(radius ?? 8),
        border: Border.all(color: validationColor),
      ),
      child: Row(
        children: [
          if (prefixIcon != null) prefixIcon!,
          Expanded(
            child: TextFormField(
              controller: controller,
              validator: validator,
              textAlign: textAlign!,
              focusNode: fieldFocusNode,
              readOnly: readOnly,
              onTap: onTap,
              maxLength: maxLength,
              maxLines: maxLines,
              cursorColor: Theme.of(context).colorScheme.secondary,
              style: style ??
                  Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0,
                      ),
              obscureText: obscureText!,
              keyboardType: keyboardType,
              autofocus: autofocus!,
              onChanged: onChanged,
              onSaved: onSaved,
              // onSubmitted: onSaved,
              inputFormatters: inputFormatters,
              enabled: enabled,
              decoration: InputDecoration(
                prefixIconConstraints: prefixIconConstraints,
                contentPadding: contentPadding,
                //     const EdgeInsets.symmetric(horizontal: 20.21, vertical: 23.0),
                // filled: filled,
                // fillColor: fillColor ?? AppColor.kFilledColor,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                // enabledBorder: enabledBorder ??
                //     border ??
                //     OutlineInputBorder(
                //       borderRadius: BorderRadius.all(
                //         Radius.circular(radius ?? 16.0),
                //       ),
                //       borderSide: BorderSide(
                //           color: hasBorder
                //               ? AppColor.kTextFieldBorderColor
                //               : Colors.transparent),
                //     ),

                // border: border ??
                //     OutlineInputBorder(
                //       borderRadius: BorderRadius.all(
                //         Radius.circular(radius ?? 16.0),
                //       ),
                //       borderSide: BorderSide.none,
                //     ),
                // errorBorder: OutlineInputBorder(
                //   borderRadius: const BorderRadius.all(
                //     Radius.circular(16.0),
                //   ),
                //   borderSide: BorderSide(color: Theme.of(context).errorColor),
                // ),
                // enabledBorder:
                label: label != null
                    ? Text(label!, style: formLabelTextStyle)
                    : null,
                // labelText: label,
                iconColor: AppColor.kSubtitleTextColor,
                counterText: '',
                hintText: hint,
                hintStyle: hintStyle ??
                    GoogleFonts.lato(
                      textStyle:
                          Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: AppColor.kDisabledTextFieldTextColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 14.0,
                              ),
                    ),
                suffixIcon: suffixIcon,
                // enabledBorder: OutlineInputBorder(
                //   borderRadius: const BorderRadius.all(
                //     Radius.circular(10.0),
                //   ),
                // borderSide:
                //     BorderSide(color: Theme.of(context).colorScheme.secondary),
                // ),
                // disabledBorder: disabledBorder,
                // focusedBorder: focusedBorder ??
                //     OutlineInputBorder(
                //       borderRadius: BorderRadius.all(
                //         Radius.circular(radius ?? 16.0),
                //       ),
                //       borderSide: const BorderSide(color: AppColor.kSurfaceColor),
                //     ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
