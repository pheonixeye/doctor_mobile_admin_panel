class AppAssets {
  const AppAssets();

  static const String icon = 'assets/images/logo.png';
  static const String arc = 'assets/images/arc.png';

  static String bg(String theme) {
    return 'assets/images/bg-$theme.jpg';
  }
}
