import 'package:flutter/material.dart';

class AppEmptyState extends StatelessWidget {
  final String message;

  const AppEmptyState({
    super.key,
    required this.message,
  });

  const factory AppEmptyState.icon({
    Key? key, 
    required IconData icon,
    required String message,
  }) = _AppEmptyStateWithIcon;

  const factory AppEmptyState.action({
    Key? key, 
    required String message,
    required String label,
    required Function()? onTap
  }) = _AppEmptyStateWithAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message)
    );
  }
}

class _AppEmptyStateWithIcon extends AppEmptyState {
  final IconData icon;

  const _AppEmptyStateWithIcon({
    super.key,
    required this.icon,
    required super.message,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Icon(icon, size: 50.0, color: Theme.of(context).colorScheme.primary,),
          ),
          Text(message),
        ],
      ),
    );
  }
}

class _AppEmptyStateWithAction extends AppEmptyState {
  final String label;
  final Function()? onTap;

  const _AppEmptyStateWithAction({
    super.key,
    required super.message,
    required this.label,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(message),
          ),
          ElevatedButton(
            onPressed: onTap,
            child: Text(label),
          ),
        ],
      ),
    );
  }
}