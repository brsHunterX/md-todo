import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:md_todo/presentation/routes.dart';
import 'package:md_todo/domain/services/locator_service.dart';
import 'package:md_todo/domain/stores/auth_store.dart';
import 'package:md_todo/domain/states/auth_state.dart';
import 'package:md_todo/presentation/widgets/app_logo.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final AuthStore _store = LocatorService.locator<AuthStore>();

  @override
  void initState() {  
    super.initState();

    Future.delayed(const Duration(seconds: 1)).then((value) {
      _store.isAuthenticated().then((value) {
        if (_store.state is AuthUnauthenticatedState) {
          Navigator.of(context).pushNamed(Routes.AUTH_ONBOARDING);
        } else if (_store.state is AuthAuthenticatedState) {
          Navigator.of(context).pushNamed(Routes.APP_NAVIGATION);
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
