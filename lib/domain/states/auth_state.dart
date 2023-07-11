import 'package:md_todo/domain/entities/account_entity.dart';

sealed class AuthState {
  final Account? account;
  final String? message;

  AuthState({ required this.account, this.message });
}

final class AuthLoadingState extends AuthState {
  AuthLoadingState({ super.message }) : super(account: null);
}

final class AuthUnauthenticatedState extends AuthState {
  AuthUnauthenticatedState() : super(account: null);
}

final class AuthAuthenticatedState extends AuthState {
  AuthAuthenticatedState({ required super.account});
}

final class AuthSignInFailureState extends AuthState {
  AuthSignInFailureState({ super.message }): super(account: null);
}

final class AuthSignUpFailureState extends AuthState {
  AuthSignUpFailureState({ super.message }): super(account: null);
}

