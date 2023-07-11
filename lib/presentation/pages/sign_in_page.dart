import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:md_todo/domain/blocs/auth_bloc.dart';
import 'package:md_todo/domain/dtos/auth_sign_in_dto.dart';
import 'package:md_todo/domain/events/auth_event.dart';
import 'package:md_todo/domain/states/auth_state.dart';

import 'package:md_todo/presentation/routes.dart';
import 'package:md_todo/presentation/widgets/app_snackbar.dart';
import 'package:md_todo/presentation/widgets/app_text_form_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final AuthBloc _bloc = GetIt.instance<AuthBloc>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _stateListen(BuildContext context, AuthState state) {
    if (state is AuthAuthenticatedState) {
      Navigator.of(context).pushNamedAndRemoveUntil(Routes.APP_NAVIGATION, (route) => false);
    }
    
    if (state is AuthSignInFailureState) {
      ScaffoldMessenger.of(context).showSnackBar(
        AppSnackBar.error(content: Text(state.message ?? '')),
      );
    }
  }

  void _signIn() async {
    if (_formKey.currentState!.validate()) {
      _bloc.add(AuthSignInEvent(dto: AuthSignInDTO(
        email: _emailController.text,
        password: _passwordController.text,
      )));
    }
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Sign In')
    );
  }

  Widget _buildEmailTextField() {   
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: AppTextFormField.email(
        autofocus: true,
        controller: _emailController,
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: AppTextFormField.password(
        controller: _passwordController,
      ),
    );
  }

  Widget _buildButtonSignIn() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _signIn,
        child: const Text('Sign in with email')
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildEmailTextField(),
          _buildPasswordTextField(),
          _buildButtonSignIn(),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: _buildForm()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocListener(
        bloc: _bloc,
        listener: _stateListen,
        child: _buildBody()
      ),
    );
  }
}
