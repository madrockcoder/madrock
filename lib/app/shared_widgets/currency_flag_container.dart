import 'package:flutter/material.dart';

class CurrencyFlagContainer extends StatelessWidget {
  const CurrencyFlagContainer({Key? key, required this.flag, this.size})
      : super(key: key);
  final String flag;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size ?? 32.0,
      width: size ?? 32.0,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(50.0)),
        image: DecorationImage(
          image: AssetImage(
            'icons/currency/${flag.toLowerCase()}.png',
            package: 'currency_icons',
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
