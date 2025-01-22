import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme();

  static final _lightTheme = ThemeData()
    ..copyWith(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
    );

  static get light => _lightTheme;

  static final _darkTheme = _lightTheme
    ..copyWith(
      brightness: Brightness.dark,
    );
  static get dark => _darkTheme;
}
