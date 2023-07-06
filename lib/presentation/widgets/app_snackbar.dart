import 'package:flutter/material.dart';

class AppSnackBar extends SnackBar {
  const AppSnackBar({super.key, required super.content});
  
  const factory AppSnackBar.error({
    Key? key,
    required Widget content,
  }) = _AppSnackBarError;

  Widget build(BuildContext context) {
    return SnackBar(
      content: content,
      backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
    );
  }
}

class _AppSnackBarError extends AppSnackBar {
  const _AppSnackBarError({super.key, required super.content});

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: content,
      backgroundColor: Theme.of(context).colorScheme.onErrorContainer,
    );
  }
}