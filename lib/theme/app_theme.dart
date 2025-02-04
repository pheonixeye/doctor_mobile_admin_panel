import 'package:flutter/material.dart';

class AppTheme {
  static CardTheme cardTheme = CardTheme(
    elevation: 6,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );

  static ListTileThemeData listTileTheme = ListTileThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    titleAlignment: ListTileTitleAlignment.top,
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.w700,
    ),
  );

  static AppBarTheme appBarTheme(ColorScheme colorScheme) => AppBarTheme(
        elevation: 8,
        color: colorScheme.primaryContainer,
      );

  static final inputDecorationTheme = InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );

  static ThemeData theme({
    required ColorScheme colorScheme,
    TextTheme textTheme = const TextTheme(),
  }) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: textTheme,
      cardTheme: cardTheme,
      listTileTheme: listTileTheme,
      appBarTheme: appBarTheme(colorScheme),
      fontFamily: 'Cairo',
      package: '/assets/fonts/cairo.ttf',
      inputDecorationTheme: inputDecorationTheme,
    );
  }

  static final secondaryOrangeColor =
      Colors.orange.shade500.withValues(alpha: 0.9);
}
