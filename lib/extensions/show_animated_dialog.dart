import 'package:doctor_mobile_admin_panel/utils/util_keys.dart';
import 'package:flutter/material.dart';

Future<T?> showAnimatedDialog<T>({
  required BuildContext context,
  required Widget dialog,
}) {
  return showDialog<T?>(
    context: context,
    builder: (context) => ScaleTransition(
      scale: Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: AnimationController(
            vsync: navigatorKey.currentState!, //TODO:
            duration: Duration(milliseconds: 300),
          ),
          curve: Curves.easeInOut,
        ),
      ),
      child: dialog,
    ),
  );
}
