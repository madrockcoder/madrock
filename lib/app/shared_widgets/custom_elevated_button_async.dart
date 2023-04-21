import 'package:flutter/material.dart';
import '../../util/color_scheme.dart';

class CustomElevatedButtonAsync extends StatefulWidget {
  const CustomElevatedButtonAsync({
    Key? key,
    this.onPressed,
    required this.child,
    this.height = 50.0,
    this.width = double.infinity,
    this.radius = 12.0,
    this.color,
    this.disabledColor,
    this.onPrimary,
    this.padding,
    this.borderColor,
    // this.showLoaderScreen = false,
  }) : super(key: key);
  final Future<void> Function()? onPressed;
  final Widget child;
  final double? height;
  final double? width;
  final double radius;
  final Color? color;
  final Color? disabledColor;
  final Color? onPrimary;
  final EdgeInsetsGeometry? padding;
  final Color? borderColor;
  // final bool showLoaderScreen;

  @override
  State<CustomElevatedButtonAsync> createState() =>
      _CustomElevatedButtonAsyncState();
}

class _CustomElevatedButtonAsyncState extends State<CustomElevatedButtonAsync> {
  bool _isLoading = false;

  Widget _getChild(bool isLoading) {
    if (isLoading) {
      return  SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(
          color: widget.color != Colors.white ?  Colors.white : AppColor.kSecondaryColor,
          strokeWidth: 3,
        ),
      );
    } else {
      return widget.child;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return widget.color?.withOpacity(0.5) ??
                    AppColor.kDarkGreenColor.withOpacity(0.5);
              } else if (states.contains(MaterialState.disabled)) {
                return widget.disabledColor ??
                    AppColor.kDisabledContinueButtonColor;
              }
              return widget.color ?? AppColor.kDarkGreenColor;
            },
          ),
          elevation: MaterialStateProperty.all<double>(0.15),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.radius),
                side: widget.borderColor == null
                    ? widget.disabledColor != null
                        ? BorderSide(color: widget.disabledColor!)
                        : const BorderSide(color: Colors.white)
                    : BorderSide(color: widget.borderColor!)),
          ),

          // shape:
        ),
        // style: ElevatedButton.styleFrom(
        //   padding: padding,
        //   elevation: 0.3,
        //   // onSurface: AppColor.kDarkGreenColor,
        //   primary: color ?? AppColor.kDarkGreenColor,
        // onPrimary: onPrimary ?? Colors.white,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.all(Radius.circular(radius)),
        // ),
        // ),
        onPressed: widget.onPressed == null
            ? null
            : () async {
                if (!_isLoading) {
                  setState(() {
                    _isLoading = true;
                  });
                  // if (widget.showLoaderScreen) {
                  //   CustomLoaderScreen.show(context);
                  // }
                  try {
                    await widget.onPressed!();
                  } catch (error) {}
                  // if (widget.showLoaderScreen) {
                  //   WidgetsBinding.instance?.addPostFrameCallback((_) {
                  //     Navigator.pop(context);
                  //   });
                  // }
                  setState(() {
                    _isLoading = false;
                  });
                }
              },
        child: _getChild(_isLoading),
      ),
    );
  }
}
