import 'package:flutter/material.dart';

mixin SharedFunctions {
  bool validateAndSaveForm(GlobalKey<FormState> formKey) {
    final form = formKey.currentState!;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
