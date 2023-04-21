import 'package:flutter/material.dart';

import 'package:geniuspay/util/color_scheme.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    Key? key,
    required this.onTap,
    required this.isLoading,
  }) : super(key: key);
  final VoidCallback? onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        height: 50.0,
        width: 50.0,
        decoration: BoxDecoration(
          color: onTap == null
              ? AppColor.kAccentColorVariant
              : AppColor.kAccentColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: isLoading
            ? const Center(
                child: SizedBox(
                  height: 25.0,
                  width: 25.0,
                  child: CircularProgressIndicator.adaptive(
                      backgroundColor: Colors.white),
                ),
              )
            : Icon(Icons.arrow_forward,
                color: onTap == null
                    ? AppColor.kDisableButtonIconColor
                    : Colors.white),
      ),
    );
  }
}
