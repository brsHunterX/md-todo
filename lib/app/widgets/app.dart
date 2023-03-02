import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:md_todo/shared/themes/app_theme_dark.dart';
import 'package:md_todo/shared/themes/app_theme_light.dart';

import 'package:md_todo/app/routes.dart';
import 'package:md_todo/modules/auth/routes.dart';
import 'package:md_todo/modules/tasks/routes.dart';

import 'package:md_todo/modules/auth/stores/auth.store.dart';
import 'package:md_todo/modules/tasks/stores/task.store.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  Widget _buildMaterialApp(ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
    final bool isLocal = (
      dotenv.get('APP_ENV') == 'local' ||
      dotenv.get('APP_ENV') == 'staging' ||
      dotenv.get('APP_ENV') == 'homolog'
    );

    final ThemeData lightTheme = AppThemeLight.theme.copyWith(
      colorScheme: lightDynamic ?? AppThemeLight.theme.colorScheme
    );
    
    final ThemeData darkTheme = AppThemeDark.theme.copyWith(
      colorScheme: darkDynamic ?? AppThemeDark.theme.colorScheme
    );

    return MultiProvider(
      providers: [
        Provider<AuthStore>(create: (_) => AuthStore()),
        Provider<TaskStore>(create: (_) => TaskStore()),
      ],
      child: MaterialApp(
        theme: lightTheme,
        darkTheme: darkTheme,
        title: dotenv.get('APP_NAME'),
        debugShowCheckedModeBanner: isLocal,
        initialRoute: AppRoutes.APP_SPLASH,
        routes: {
          ...AppRoutes.routes,
          ...AuthRoutes.routes,
          ...TaskRoutes.routes,
        },
      )
    );
  }

  Widget _buildDynamicColorsApp() {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return _buildMaterialApp(lightDynamic, darkDynamic);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    // return _buildDynamicColorsApp();
    return _buildMaterialApp(null, null);
  }
}