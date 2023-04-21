import 'package:flutter/material.dart';

class Category {
  final String asset;
  final String text;
  final bool isUnicode;

  Category(this.asset, this.text, {this.isUnicode = false});

  Widget getIcon(double size) {
    return isUnicode
        ? Center(
            child: Text(
            asset,
            style: TextStyle(fontSize: size, fontWeight: FontWeight.w500),
          ))
        : Center(child: Image.asset(asset));
  }
}

List<Category> categoryIcons = [
  Category('🏦', 'Bills', isUnicode: true),
  Category('🍽️', 'Eating out', isUnicode: true),
  Category('🎥', 'Movies', isUnicode: true),
  Category('👪', 'Family', isUnicode: true),
  Category('🍸', 'Drinks', isUnicode: true),
  Category('🎁', 'Gifts', isUnicode: true),
  Category('🛒', 'Groceries', isUnicode: true),
  Category('🏡', 'Rent', isUnicode: true),
  Category('🧘', 'care', isUnicode: true),
  Category('🏘️', 'Home', isUnicode: true),
  Category('🚌', 'Transportation', isUnicode: true),
  Category('🚑', 'Healthcare', isUnicode: true),
  Category('🎓', 'Education', isUnicode: true),
  Category('🛍️', 'Shopping', isUnicode: true),
  Category('💸', 'General', isUnicode: true),
  Category('✈️', 'Travel', isUnicode: true),
];
