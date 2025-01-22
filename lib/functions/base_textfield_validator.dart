import 'package:doctor_mobile_admin_panel/extensions/loc_ext_fns.dart';
import 'package:flutter/material.dart';

String? baseValidator(String? value, {BuildContext? context}) {
  if (value == null || value.isEmpty) {
    return context?.loc.baseValidator;
  }
  return null;
}
