import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class SettingsService {
  static final SettingsService _instance = SettingsService._internal();

  factory SettingsService() => _instance;

  SettingsService._internal();

  Future<String> language() async {
    String? userLanguage;
    String defaultLanguage = 'pt';

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/language.json');
    if (await file.exists()) {
      userLanguage = await file.readAsString();
    }

    return userLanguage ?? defaultLanguage;
  }

  Future<ThemeMode> themeMode() async {
    String? themeName;
    ThemeMode? userTheme;
    ThemeMode defaultTheme = ThemeMode.system;

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/theme.json');
    if (await file.exists()) {
      themeName = await file.readAsString();
    }

    if (themeName != null) {
      userTheme = themeName == 'dark' ? ThemeMode.dark : ThemeMode.light;
    }

    return userTheme ?? defaultTheme;
  }

  Future<void> updateThemeMode(ThemeMode theme) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/theme.json');
    await file.writeAsString(theme.toString().split('.').last);
  }

  Future<void> updateLanguageMode(String localization) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/language.json');
    await file.writeAsString(localization);
  }
}
