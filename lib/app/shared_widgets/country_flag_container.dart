import 'package:flutter/material.dart';

class CountryFlagContainer extends StatelessWidget {
  const CountryFlagContainer({Key? key, required this.flag, this.size})
      : super(key: key);
  final String flag;
  final double? size;

  @override
  Widget build(BuildContext context) {
    try {
      return Container(
        height: size ?? 32.0,
        width: size ?? 32.0,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(50.0)),
          image: DecorationImage(
            image: AssetImage(
              'icons/flags/png/${flag.toLowerCase()}.png',
              package: 'country_icons',
            ),
            fit: BoxFit.cover,
          ),
        ),
      );
    } catch (e) {
      return Container(
        height: size ?? 32.0,
        width: size ?? 32.0,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
        ),
      );
    }
  }
}
