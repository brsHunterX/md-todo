import 'package:md_todo/domain/entities/account_entity.dart';

sealed class AuthState {
  final Account? account;
  AuthState({ required this.account });
}

final class AuthLoadingState extends AuthState {
  AuthLoadingState() : super(account: null);
}

final class AuthUnauthenticatedState extends AuthState {
  AuthUnauthenticatedState() : super(account: null);
}

final class AuthAuthenticatedState extends AuthState {
  AuthAuthenticatedState({required super.account});
}