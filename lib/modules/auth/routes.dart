import 'package:flutter/material.dart';
import 'package:md_todo/modules/auth/pages/sign_in_page.dart';
import 'package:md_todo/modules/auth/pages/sign_up_page.dart';
import 'package:md_todo/modules/auth/pages/profile_page.dart';
import 'package:md_todo/modules/auth/pages/onboarding_page.dart';

class AuthRoutes {
  static const AUTH_SIGN_IN = '/auth/sign-in';
  static const AUTH_SIGN_UP = '/auth/sign-up';
  static const AUTH_PROFILE = '/auth/profile';
  static const AUTH_ONBOARDING = '/auth/onboarding';

  static final routes = {
    AUTH_SIGN_IN: (BuildContext context) => const SignInPage(),
    AUTH_SIGN_UP: (BuildContext context) => const SignUpPage(),
    AUTH_PROFILE: (BuildContext context) => const ProfilePage(),
    AUTH_ONBOARDING: (BuildContext context) => const OnboardingPage(),
  };
}