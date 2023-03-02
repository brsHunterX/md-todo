import 'package:flutter/material.dart';
import 'package:flutter_animate/animate.dart';
import 'package:flutter_animate/effects/effects.dart';

import 'package:md_todo/app/routes.dart';

import 'package:md_todo/modules/auth/routes.dart';
import 'package:md_todo/modules/auth/stores/auth.store.dart';

import 'package:md_todo/app/widgets/app_logo.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final AuthStore _store = AuthStore();

  @override
  void initState() {  
    super.initState();

    Future.delayed(const Duration(seconds: 1)).then((value) {
      _store.isAuthenticated().then((bool isAuthenticated) {
        if (isAuthenticated) {
          Navigator.of(context).pushNamed(AppRoutes.APP_NAVIGATION);
        } else {
          Navigator.of(context).pushNamed(AuthRoutes.AUTH_ONBOARDING);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: const AppLogo(size: 80.0)
          .animate()
          .fadeIn(duration: const Duration(milliseconds: 500))
          .slideY(begin: 0.3, end: 0, duration: const Duration(milliseconds: 500)),
      ),
    );
  }
}
