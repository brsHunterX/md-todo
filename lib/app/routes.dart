import 'package:flutter/material.dart';

import 'package:md_todo/app/pages/splash_page.dart';
import 'package:md_todo/app/pages/navigation_page.dart';

class AppRoutes {
  static const APP_SPLASH = '/';
  static const APP_NAVIGATION = '/navigation';

  static final routes = {
    APP_SPLASH: (BuildContext context) => const SplashPage(),
    APP_NAVIGATION: (BuildContext context) => const NavigationPage(),
  };
}