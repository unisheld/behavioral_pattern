import 'package:behavioral_pattern/theme/factory/cupertino_factory.dart';
import 'package:behavioral_pattern/theme/factory/custom_factory.dart';
import 'package:behavioral_pattern/theme/factory/material_factory.dart';
import 'package:behavioral_pattern/theme/factory/ui_factory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum AppTheme { material, cupertino, custom }

class ThemeNotifier extends ChangeNotifier {
  UIFactory _factory = MaterialFactory();
  AppTheme _theme = AppTheme.material;

  UIFactory get factory => _factory;
  AppTheme get theme => _theme;

  void setTheme(AppTheme theme) {
    if (_theme == theme) return;
    _theme = theme;
    switch (theme) {
      case AppTheme.material:
        _factory = MaterialFactory();
        break;
      case AppTheme.cupertino:
        _factory = CupertinoFactory();
        break;
      case AppTheme.custom:
        _factory = CustomFactory();
        break;
    }
    notifyListeners();
  }

  ThemeData get themeData {
    switch (_theme) {
      case AppTheme.material:
        return ThemeData.light();
      case AppTheme.cupertino:
        return ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.blue,
          cupertinoOverrideTheme: const CupertinoThemeData(
            primaryColor: Colors.blue,
          ),
        );

      case AppTheme.custom:
        return ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.deepPurple,
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
          ),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Colors.white),
          ),
        );
    }
  }
}
