import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDark = false;

  bool get isDark => _isDark;

  Future<void> toggleTheme() async {
    var prefs = await SharedPreferences.getInstance();
    _isDark = !_isDark;
    prefs.setBool('isDark', _isDark);
    notifyListeners();
  }

  Future<void> loadThemePreference() async {
    var prefs = await SharedPreferences.getInstance();
    _isDark = prefs.getBool('isDark') ?? false;
    notifyListeners();
  }
}
