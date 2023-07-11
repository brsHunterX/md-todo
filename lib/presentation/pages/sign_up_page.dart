import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:md_todo/domain/blocs/auth_bloc.dart';
import 'package:md_todo/domain/dtos/auth_sign_up_dto.dart';
import 'package:md_todo/domain/events/auth_event.dart';
import 'package:md_todo/domain/states/auth_state.dart';

import 'package:md_todo/presentation/routes.dart';
import 'package:md_todo/presentation/widgets/app_snackbar.dart';
import 'package:md_todo/presentation/widgets/app_text_form_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final AuthBloc _bloc = GetIt.instance<AuthBloc>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _stateListen(BuildContext context, AuthState state) {
    if (state is AuthAuthenticatedState) {
      Navigator.of(context).pushNamed(Routes.APP_NAVIGATION);
    }
    
    if (state is AuthSignInFailureState) {
      ScaffoldMessenger.of(context).showSnackBar(
        AppSnackBar.error(content: Text(state.message ?? '')),
      );
    }
  }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      _bloc.add(AuthSignUpEvent(dto: AuthSignUpDTO(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      )));
    }
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Create Account')
    );
  }

  Widget _buildFirstNameTextField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: AppTextFormField.name(
        controller: _firstNameController,
        labelText: 'First Name',
        hintText: 'Jhon',
      ),
    );
  }
  
  Widget _buildLastNameTextField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: AppTextFormField.name(
        controller: _lastNameController,
        labelText: 'Last Name',
        hintText: 'Doe',
      ),
    );
  }

  Widget _buildEmailTextField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: AppTextFormField.email(
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

  Widget _buildButtonSignUp() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _signUp,
        child: const Text('Create account')
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          _buildFirstNameTextField(),
          _buildLastNameTextField(),
          _buildEmailTextField(),
          _buildPasswordTextField(),
          _buildButtonSignUp()
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
        child: _buildBody(),
      ),
    );
  }
}
