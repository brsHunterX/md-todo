import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:md_todo/app/routes.dart';

import 'package:md_todo/modules/auth/stores/auth.store.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final AuthStore _store = AuthStore();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signUp() async {
    final Map<String, dynamic> data = {
      'first_name': _firstNameController.text,
      'last_name': _lastNameController.text,
      'email': _emailController.text,
      'password': _passwordController.text,
    };
    
    if (_formKey.currentState!.validate()) {
      try {
        _store.signUp(data).then((value) {
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
      title: const Text('Create Account')
    );
  }

  Widget _buildFirstNameTextField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: TextFormField(
        autofocus: true,
        keyboardType: TextInputType.text,
        controller: _firstNameController,
        decoration: const InputDecoration(
          labelText: 'First Name',
          border: OutlineInputBorder(),
          hintText: 'Jhon'
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
  
  Widget _buildLastNameTextField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: _lastNameController,
        decoration: const InputDecoration(
          labelText: 'Last Name',
          border: OutlineInputBorder(),
          hintText: 'Doe'
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

  Widget _buildEmailTextField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: _emailController,
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
        obscureText: true,
        keyboardType: TextInputType.visiblePassword,
        controller: _passwordController,
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
      body: _buildBody()
    );
  }
}
