import 'package:flutter/material.dart';
import 'package:geniuspay/app/shared_widgets/textfield_decoration.dart';
import 'package:geniuspay/util/color_scheme.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hintText;
  final String? helperText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final double bottomSpacing;
  final GestureTapCallback? onTap;
  final bool? readOnly;
  final int? maxLines;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final Widget? suffix;
  final Function(Function()) setState;
  final Widget? prefix;
  final bool isDisabled;
  final int? helperMaxLines;
  final bool alignHintTextOnTop;

  const CustomTextField(
      {Key? key,
      required this.controller,
      required this.focusNode,
      required this.hintText,
      this.helperText,
      this.keyboardType,
      this.validator,
      this.bottomSpacing = 12,
      this.onTap,
      this.readOnly,
      this.maxLines,
      this.textInputAction = TextInputAction.next,
      this.suffix,
      this.prefix,
      required this.setState,
      this.isDisabled = false,
      this.helperMaxLines,
      this.alignHintTextOnTop = false,
      this.maxLength})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  TextEditingController get controller => widget.controller;

  FocusNode get focusNode => widget.focusNode;

  String get hintText => widget.hintText;

  String? get helperText => widget.helperText;

  TextInputType? get keyboardType => widget.keyboardType;

  String? Function(String?)? get validator => widget.validator;

  Widget? get suffix => widget.suffix;

  Widget? get prefix => widget.prefix;

  bool get isDisabled => widget.isDisabled;

  int? get helperMaxLines => widget.helperMaxLines;

  bool get centerHintText => widget.alignHintTextOnTop;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.only(bottom: widget.bottomSpacing),
      child: Opacity(
        opacity: isDisabled ? 0.4 : 1,
        child: TextFormField(
          controller: controller,
          textInputAction: widget.textInputAction,
          onTap: isDisabled ? () {} : widget.onTap,
          readOnly: isDisabled ? true : (widget.readOnly ?? false),
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          style: textTheme.bodyMedium?.copyWith(fontSize: 12),
          decoration: TextFieldDecoration(
            focusNode: focusNode,
            hintText: hintText,
            centerHintText: centerHintText,
            suffix: suffix,
            prefix: prefix,
            context: context,
            helperMaxLines: helperMaxLines ?? 2,
            helperTextStyle: textTheme.bodyMedium
                ?.copyWith(color: AppColor.kSecondaryColor, fontSize: 12),
            helperText: helperText,
            controller: controller,
          ).inputDecoration(),
          focusNode: focusNode,
          onChanged: (val) {
            widget.setState(() {});
          },
          keyboardType: keyboardType,
          validator: validator,
        ),
      ),
    );
  }
}
