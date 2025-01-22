import 'package:doctor_mobile_admin_panel/providers/local_database_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PxLocale extends ChangeNotifier {
  final BuildContext context;

  PxLocale(this.context);

  Locale _locale = const Locale('ar');
  Locale get locale => _locale;

  bool get isEnglish => _locale == const Locale('en');

  Future<void> changeLocale() async {
    if (_locale.languageCode == 'ar') {
      _locale = const Locale('en');
      await context.read<PxLocalDatabase>().saveLanguageToDb('en');
    } else if (_locale.languageCode == 'en') {
      _locale = const Locale('ar');
      await context.read<PxLocalDatabase>().saveLanguageToDb('ar');
    }
    notifyListeners();
  }

  Future<void> setLocaleFromLocalDb() async {
    _locale = Locale(context.read<PxLocalDatabase>().language);
    notifyListeners();
  }
}
