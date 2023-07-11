import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart' as ffv;

class AppTextFormField extends StatelessWidget {
  final bool autofocus;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final FormFieldValidator<String>? validator;

  const AppTextFormField({
    super.key,
    this.autofocus = false,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    required this.controller,
    this.labelText,
    this.hintText,
    this.validator,
  });

  const factory AppTextFormField.name({
    final Key? key,
    final bool autofocus,
    required TextEditingController controller,
    final String? labelText,
    final String? hintText,
  }) = _AppTextFormFieldName;
  
  const factory AppTextFormField.email({
    final Key? key,
    final bool autofocus,
    required TextEditingController controller,
    final String? labelText,
    final String? hintText,
  }) = _AppTextFormFieldEmail;
  
  const factory AppTextFormField.password({
    final Key? key,
    final bool autofocus,
    required TextEditingController controller,
    final String? labelText,
    final String? hintText,
  }) = _AppTextFormFieldPassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus,
      obscureText: obscureText,
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
      validator: validator,
    );
  }
}

class _AppTextFormFieldName extends AppTextFormField {
  const _AppTextFormFieldName({
    super.key,
    super.autofocus,
    required super.controller,
    super.labelText = 'Fullname',
    super.hintText = 'Jhon Doe',
  }) : super(
    obscureText: false,
    keyboardType: TextInputType.text,
  );

  @override
  FormFieldValidator<String>? get validator => ffv.MultiValidator([  
    ffv.RequiredValidator(errorText: '$labelText is required'),
  ]);
}

class _AppTextFormFieldEmail extends AppTextFormField {
  const _AppTextFormFieldEmail({
    super.key,
    super.autofocus,
    required super.controller,
    super.labelText = 'Email',
    super.hintText = 'jhon_doe@gmail.com',
  }) : super(
    obscureText: false,
    keyboardType: TextInputType.emailAddress,
  );

  @override
  FormFieldValidator<String>? get validator => ffv.MultiValidator([  
    ffv.RequiredValidator(errorText: '$labelText is required'),  
    ffv.EmailValidator(errorText: 'Enter a valid email address'),
  ]);
}

class _AppTextFormFieldPassword extends AppTextFormField {
  const _AppTextFormFieldPassword({
    super.key,
    super.autofocus,
    required super.controller,
    super.labelText = 'Password',
    super.hintText = 'Type your password.',
  }) : super(
    obscureText: true,
    keyboardType: TextInputType.visiblePassword,
  );

  @override
  FormFieldValidator<String>? get validator => ffv.MultiValidator([  
    ffv.RequiredValidator(errorText: '$labelText is required'),  
    ffv.MinLengthValidator(8, errorText: 'Password must be at least 8 digits long'),  
  ]);
}