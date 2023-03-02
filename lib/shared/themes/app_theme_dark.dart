import 'package:flutter/material.dart';

class AppThemeDark {

  AppThemeDark._();

  static final ThemeData theme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorSchemeSeed: Colors.blue,
  );
}