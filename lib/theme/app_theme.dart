// import 'package:flutter/material.dart';

// class AppTheme {
//   static CardTheme cardTheme = CardTheme(
//     elevation: 6,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(8),
//     ),
//   );

//   static ListTileThemeData listTileTheme = ListTileThemeData(
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(8),
//     ),
//     titleAlignment: ListTileTitleAlignment.top,
//     titleTextStyle: TextStyle(
//       fontWeight: FontWeight.w700,
//     ),
//   );

//   static AppBarTheme appBarTheme(ColorScheme colorScheme) => AppBarTheme(
//         elevation: 8,
//         color: colorScheme.primaryContainer,
//       );

//   static final inputDecorationTheme = InputDecorationTheme(
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(8),
//     ),
//   );

//   static ThemeData theme({
//     required ColorScheme colorScheme,
//     TextTheme textTheme = const TextTheme(),
//   }) {
//     return ThemeData(
//       useMaterial3: true,
//       colorScheme: colorScheme,
//       textTheme: textTheme,
//       cardTheme: cardTheme,
//       listTileTheme: listTileTheme,
//       appBarTheme: appBarTheme(colorScheme),
//       fontFamily: 'Cairo',
//       package: '/assets/fonts/cairo.ttf',
//       inputDecorationTheme: inputDecorationTheme,
//     );
//   }

//   static final secondaryOrangeColor =
//       Colors.orange.shade500.withValues(alpha: 0.9);
// }

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// The [AppTheme] defines light and dark themes for the app.
///
/// Theme setup for FlexColorScheme package v8.
/// Use same major flex_color_scheme package version. If you use a
/// lower minor version, some properties may not be supported.
/// In that case, remove them after copying this theme to your
/// app or upgrade package to version 8.1.1.
///
/// Use in [MaterialApp] like this:
///
/// MaterialApp(
///   theme: AppTheme.light,
///   darkTheme: AppTheme.dark,
/// );
abstract final class AppTheme {
  // The defined light theme.
  static ThemeData light = FlexThemeData.light(
    colors: const FlexSchemeColor(
      primary: Color(0xFF1145A4),
      primaryContainer: Color(0xFFADC7F7),
      primaryLightRef: Color(0xFF1145A4),
      secondary: Color(0xFFB61D1D),
      secondaryContainer: Color(0xFFEDA0A0),
      secondaryLightRef: Color(0xFFB61D1D),
      tertiary: Color(0xFF376BCA),
      tertiaryContainer: Color(0xFFCFDCF2),
      tertiaryLightRef: Color(0xFF376BCA),
      appBarColor: Color(0xFFCFDCF2),
      error: Color(0xFFB00020),
      errorContainer: Color(0xFFFCD9DF),
    ),
    surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
    blendLevel: 20,
    appBarStyle: FlexAppBarStyle.background,
    bottomAppBarElevation: 1.0,
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      blendOnLevel: 20,
      blendOnColors: true,
      useM2StyleDividerInM3: true,
      thickBorderWidth: 2.0,
      elevatedButtonSchemeColor: SchemeColor.onPrimaryContainer,
      elevatedButtonSecondarySchemeColor: SchemeColor.primaryContainer,
      outlinedButtonOutlineSchemeColor: SchemeColor.primary,
      toggleButtonsBorderSchemeColor: SchemeColor.primary,
      segmentedButtonSchemeColor: SchemeColor.primary,
      segmentedButtonBorderSchemeColor: SchemeColor.primary,
      unselectedToggleIsColored: true,
      sliderValueTinted: true,
      inputDecoratorSchemeColor: SchemeColor.primary,
      inputDecoratorIsFilled: true,
      inputDecoratorBackgroundAlpha: 15,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      inputDecoratorRadius: 10.0,
      inputDecoratorPrefixIconSchemeColor: SchemeColor.primary,
      chipRadius: 10.0,
      popupMenuRadius: 6.0,
      popupMenuElevation: 6.0,
      alignedDropdown: true,
      appBarScrolledUnderElevation: 8.0,
      drawerWidth: 280.0,
      drawerIndicatorSchemeColor: SchemeColor.primary,
      bottomNavigationBarMutedUnselectedLabel: false,
      bottomNavigationBarMutedUnselectedIcon: false,
      menuRadius: 6.0,
      menuElevation: 6.0,
      menuBarRadius: 0.0,
      menuBarElevation: 1.0,
      searchBarElevation: 1.0,
      searchViewElevation: 1.0,
      searchUseGlobalShape: true,
      navigationBarSelectedLabelSchemeColor: SchemeColor.primary,
      navigationBarSelectedIconSchemeColor: SchemeColor.onPrimary,
      navigationBarIndicatorSchemeColor: SchemeColor.primary,
      navigationBarElevation: 2.0,
      navigationBarHeight: 70.0,
      navigationRailSelectedLabelSchemeColor: SchemeColor.primary,
      navigationRailSelectedIconSchemeColor: SchemeColor.onPrimary,
      navigationRailUseIndicator: true,
      navigationRailIndicatorSchemeColor: SchemeColor.primary,
      navigationRailIndicatorOpacity: 1.00,
      navigationRailLabelType: NavigationRailLabelType.all,
    ),
    keyColors: const FlexKeyColors(
      useTertiary: true,
      keepPrimary: true,
      keepTertiary: true,
    ),
    tones: FlexSchemeVariant.chroma.tones(Brightness.light),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
    swapLegacyOnMaterial3: true,
    fontFamily: 'Cairo',
    package: '/assets/fonts/cairo.ttf',
  );
  // The defined dark theme.
  static ThemeData dark = FlexThemeData.dark(
    colors: const FlexSchemeColor(
      primary: Color(0xFFC5D8F9),
      primaryContainer: Color(0xFF587DBF),
      primaryLightRef: Color(0xFF1145A4),
      secondary: Color(0xFFF2BCBC),
      secondaryContainer: Color(0xFFCC6161),
      secondaryLightRef: Color(0xFFB61D1D),
      tertiary: Color(0xFFDEE6F6),
      tertiaryContainer: Color(0xFF7397DA),
      tertiaryLightRef: Color(0xFF376BCA),
      appBarColor: Color(0xFFDEE6F6),
      error: Color(0x00000000),
      errorContainer: Color(0x00000000),
    ),
    surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
    blendLevel: 30,
    appBarStyle: FlexAppBarStyle.background,
    bottomAppBarElevation: 2.0,
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      blendOnLevel: 40,
      blendOnColors: true,
      useM2StyleDividerInM3: true,
      thickBorderWidth: 2.0,
      elevatedButtonSchemeColor: SchemeColor.onPrimaryContainer,
      elevatedButtonSecondarySchemeColor: SchemeColor.primaryContainer,
      outlinedButtonOutlineSchemeColor: SchemeColor.primary,
      toggleButtonsBorderSchemeColor: SchemeColor.primary,
      segmentedButtonSchemeColor: SchemeColor.primary,
      segmentedButtonBorderSchemeColor: SchemeColor.primary,
      unselectedToggleIsColored: true,
      sliderValueTinted: true,
      inputDecoratorSchemeColor: SchemeColor.primary,
      inputDecoratorIsFilled: true,
      inputDecoratorBackgroundAlpha: 22,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      inputDecoratorRadius: 10.0,
      chipRadius: 10.0,
      popupMenuRadius: 6.0,
      popupMenuElevation: 6.0,
      alignedDropdown: true,
      drawerWidth: 280.0,
      drawerIndicatorSchemeColor: SchemeColor.primary,
      bottomNavigationBarMutedUnselectedLabel: false,
      bottomNavigationBarMutedUnselectedIcon: false,
      menuRadius: 6.0,
      menuElevation: 6.0,
      menuBarRadius: 0.0,
      menuBarElevation: 1.0,
      searchBarElevation: 1.0,
      searchViewElevation: 1.0,
      searchUseGlobalShape: true,
      navigationBarSelectedLabelSchemeColor: SchemeColor.primary,
      navigationBarSelectedIconSchemeColor: SchemeColor.onPrimary,
      navigationBarIndicatorSchemeColor: SchemeColor.primary,
      navigationBarElevation: 2.0,
      navigationBarHeight: 70.0,
      navigationRailSelectedLabelSchemeColor: SchemeColor.primary,
      navigationRailSelectedIconSchemeColor: SchemeColor.onPrimary,
      navigationRailUseIndicator: true,
      navigationRailIndicatorSchemeColor: SchemeColor.primary,
      navigationRailIndicatorOpacity: 1.00,
      navigationRailLabelType: NavigationRailLabelType.all,
    ),
    keyColors: const FlexKeyColors(
      useTertiary: true,
      keepPrimary: true,
    ),
    tones: FlexSchemeVariant.chroma.tones(Brightness.dark),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
    swapLegacyOnMaterial3: true,
    fontFamily: 'Cairo',
    package: '/assets/fonts/cairo.ttf',
  );
}
