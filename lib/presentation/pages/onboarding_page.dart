import 'package:flutter/material.dart';

import 'package:md_todo/presentation/routes.dart';
import 'package:md_todo/presentation/widgets/app_logo.dart';
import 'package:md_todo/presentation/widgets/app_hyperlink.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  Widget _buildLogo() {
    return const Align(
      alignment: Alignment.centerLeft,
      child: AppLogo(size: 50.0),
    );
  }

  Widget _buildDisplayText() {
    return Text(
      'Welcome',
      style: Theme.of(context).textTheme.displaySmall!.copyWith(
        color: Theme.of(context).colorScheme.primary
      )
    );
  }

  Widget _buildSubtitleText() {
    return Text(
      'Create and organize your tasks quickly and easily.',
      style: Theme.of(context).textTheme.titleMedium,
    );
  }

  Widget _buildWelcomeText() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 48.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDisplayText(),
          _buildSubtitleText(),
        ],
      ),
    );
  }

  Widget _buildEmailSignUpButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ElevatedButton(
        child: const Text('Sign in with email'),
        onPressed: () => Navigator.of(context).pushNamed(Routes.AUTH_SIGN_IN),
      ),
    );
  }

  Widget _buildSignUpLink() {
    return AppHyperlink(
      text: 'Didn\'t have an account? ',
      linkText: 'Sign up',
      onTap: () => Navigator.of(context).pushNamed(Routes.AUTH_SIGN_UP)
    );
  }

  Widget _buildForm() {
    return Column(
      children: [
        _buildWelcomeText(),
        _buildEmailSignUpButton(),
      ],
    );
  }

  Widget _buildBody() {
    return Container(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildLogo(),
          _buildForm(),
          _buildSignUpLink(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _buildBody()),
    );
  }
}
