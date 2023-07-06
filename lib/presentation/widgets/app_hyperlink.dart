import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AppHyperlink extends StatelessWidget {
  const AppHyperlink({
    super.key,
    required this.text,
    required this.linkText,
    required this.onTap,
  });

  final String text;
  final String linkText;
  final Function() onTap;

  TextSpan _buildText(BuildContext context) {
    return TextSpan(
      text: text,
      style: Theme.of(context)
        .textTheme
        .bodyMedium
    );
  }
  
  TextSpan _buildLinkText(BuildContext context) {
    return TextSpan(
      text: linkText,
      style: Theme.of(context)
        .textTheme
        .bodyMedium!
        .copyWith(color: Theme.of(context).colorScheme.primary),
      recognizer: TapGestureRecognizer()
        ..onTap = onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          _buildText(context),
          _buildLinkText(context),
        ]
      )
    );
  }
}