import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:md_todo/presentation/routes.dart';
import 'package:md_todo/presentation/themes/app_theme_dark.dart';
import 'package:md_todo/presentation/themes/app_theme_light.dart';

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

    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      title: dotenv.get('APP_NAME'),
      debugShowCheckedModeBanner: isLocal,
      initialRoute: Routes.APP_SPLASH,
      routes: { ...Routes.routes },
    );

    // return MultiProvider(
    //   providers: [
    //     Provider<ClientDataSource>(create: (_) => ClientDataSourceImpl()),
    //     Provider<AuthDataSource>(create: (_) => AuthDataSourceImpl(context.read())),
    //     Provider<TaskDataSource>(create: (_) => TaskDataSourceImpl(context.read())),
    //     Provider<AuthRepository>(create: (_) => AuthRepositoryImpl(context.read())),
    //     Provider<TaskRepository>(create: (_) => TaskRepositoryImpl(context.read())),
    //     Provider<AuthBloc>(create: (_) => AuthBloc(context.read())),
    //     Provider<TaskBloc>(create: (_) => TaskBloc(context.read())),
    //   ],
    //   child: MaterialApp(
    //     theme: lightTheme,
    //     darkTheme: darkTheme,
    //     title: dotenv.get('APP_NAME'),
    //     debugShowCheckedModeBanner: isLocal,
    //     initialRoute: Routes.APP_SPLASH,
    //     routes: { ...Routes.routes },
    //   ),
    // );
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
    return _buildDynamicColorsApp();
    // return _buildMaterialApp(null, null);
  }
}