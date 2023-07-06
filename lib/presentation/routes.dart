import 'package:flutter/material.dart';
import 'package:md_todo/presentation/pages/splash_page.dart';
import 'package:md_todo/presentation/pages/navigation_page.dart';
import 'package:md_todo/presentation/pages/onboarding_page.dart';
import 'package:md_todo/presentation/pages/sign_in_page.dart';
import 'package:md_todo/presentation/pages/sign_up_page.dart';
import 'package:md_todo/presentation/pages/profile_page.dart';
import 'package:md_todo/presentation/pages/task_create_page.dart';
import 'package:md_todo/presentation/pages/task_list_page.dart';

class Routes {
  static const APP_SPLASH = '/';
  static const APP_NAVIGATION = '/navigation';
  static const AUTH_ONBOARDING = '/onboarding';
  static const AUTH_SIGN_IN = '/sign-in';
  static const AUTH_SIGN_UP = '/sign-up';
  static const AUTH_PROFILE = '/profile';
  static const TASK_LIST = '/tasks/list';
  static const TASK_CREATE = '/tasks/create';

  static final routes = {
    APP_SPLASH: (BuildContext context) => const SplashPage(),
    APP_NAVIGATION: (BuildContext context) => const NavigationPage(),
    AUTH_ONBOARDING: (BuildContext context) => const OnboardingPage(),
    AUTH_SIGN_IN: (BuildContext context) => const SignInPage(),
    AUTH_SIGN_UP: (BuildContext context) => const SignUpPage(),
    AUTH_PROFILE: (BuildContext context) => const ProfilePage(),
    TASK_LIST: (BuildContext context) => const TaskListPage(),
    TASK_CREATE: (BuildContext context) => const TaskCreatePage(),
  };
}