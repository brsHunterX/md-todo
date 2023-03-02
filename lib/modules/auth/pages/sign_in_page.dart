import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:md_todo/app/routes.dart';

import 'package:md_todo/modules/auth/stores/auth.store.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final AuthStore _store = AuthStore();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _signIn() async {
    final Map<String, dynamic> data = {
      'email': _emailController.text,
      'password': _passwordController.text,
    };

    if (_formKey.currentState!.validate()) {
      try {
        _store.signIn(data).then((value) {
          Navigator.of(context).pushNamed(AppRoutes.APP_NAVIGATION);
        });
      } on DioError catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.response!.data['message']),
            backgroundColor: Theme.of(context).colorScheme.onErrorContainer,
          ),
        );
      }
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
      child: TextFormField(
        controller: _emailController,
        autofocus: true,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          labelText: 'Email',
          border: OutlineInputBorder(),
          hintText: 'jhon_doe@gmail.com'
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: TextFormField(
        controller: _passwordController,
        obscureText: true,
        keyboardType: TextInputType.visiblePassword,
        decoration: const InputDecoration(
          labelText: 'Password',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
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
      body: _buildBody(),
    );
  }
}
