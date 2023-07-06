import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:md_todo/domain/blocs/auth_bloc.dart';
import 'package:md_todo/domain/states/auth_state.dart';
import 'package:md_todo/domain/services/locator_service.dart';

import 'package:md_todo/presentation/routes.dart';
import 'package:md_todo/presentation/widgets/app_logo.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final AuthBloc _bloc = LocatorService.locator<AuthBloc>();

  @override
  void initState() {  
    super.initState();

    Future.delayed(const Duration(seconds: 1)).then((value) {
      if (_bloc.state is AuthUnauthenticatedState) {
        Navigator.of(context).pushNamedAndRemoveUntil(Routes.AUTH_ONBOARDING, (route) => false);
      }
      
      if (_bloc.state is AuthAuthenticatedState) {
        Navigator.of(context).pushNamedAndRemoveUntil(Routes.APP_NAVIGATION, (route) => false);
      }
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
