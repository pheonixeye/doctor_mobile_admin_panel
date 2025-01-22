import 'package:flutter/material.dart';

class PxLocale extends ChangeNotifier {
  Locale _locale = const Locale('en');
  Locale get locale => _locale;

  void setLocale() {
    if (lang == 'en') {
      _locale = const Locale('en');
      notifyListeners();
    } else if (lang == 'ar') {
      _locale = const Locale('ar');
      notifyListeners();
    }
  }

  void changeLocale() {
    if (_lang == 'ar') {
      _lang = 'en';
      _locale = const Locale('en');
      notifyListeners();
    } else if (_lang == 'en') {
      _lang = 'ar';
      _locale = const Locale('ar');
      notifyListeners();
    }
  }

  String? _lang;
  String? get lang => _lang;

  void setLang(String? val) {
    _lang = val;
  }

  bool get isEnglish => _locale == const Locale('en');
}
