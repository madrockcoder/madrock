import 'package:flutter/material.dart';

class HomePageDesignModel {
  final Color backgroundColor;
  final String title;
  final String subtitle;
  final String asset;
  final String buttonText;
  final double imageHorizontalPadding;
  final double imageTopSpacing;

  HomePageDesignModel(
      {required this.backgroundColor,
      required this.title,
      required this.imageTopSpacing,
      required this.imageHorizontalPadding,
      required this.subtitle,
      required this.asset,
      required this.buttonText});
}
