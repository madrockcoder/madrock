import 'package:flutter/material.dart';

Size displaySize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double displayWidth(BuildContext context) {
  return displaySize(context).width;
}

double displayHeight(BuildContext context) {
  return displaySize(context).height;
}
