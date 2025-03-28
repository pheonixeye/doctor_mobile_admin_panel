import 'package:doctor_mobile_admin_panel/providers/px_local_db.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../extensions/theme_mode_ext.dart' as tmx;

class PxTheme extends ChangeNotifier {
  final BuildContext context;
  PxTheme(this.context) {
    setThemeModeFromDb();
  }

  static ThemeMode _mode = ThemeMode.light;
  ThemeMode get mode => _mode;

  Future<void> changeThemeMode() async {
    _mode = _mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await context.read<PxLocalDatabase>().saveThemeToDb(_mode.name);
    notifyListeners();
  }

  void setThemeModeFromDb() {
    context.read<PxLocalDatabase>().fetchThemeFromDb();
    _mode = tmx.fromString(context.read<PxLocalDatabase>().theme);
    notifyListeners();
  }
}
