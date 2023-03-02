import 'package:flutter/material.dart';

class AppThemeLight {

  AppThemeLight._();

  static final ThemeData theme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorSchemeSeed: Colors.blue,
  );
}