sealed class AuthEvent {}

final class AuthLoadingEvent extends AuthEvent {}

final class AuthIsAuthenticatedEvent extends AuthEvent {}

final class AuthSignInEvent extends AuthEvent {
  final Map<String, dynamic> data;

  AuthSignInEvent({ required this.data });
}

final class AuthSignUpEvent extends AuthEvent {
  final Map<String, dynamic> data;

  AuthSignUpEvent({ required this.data });
}

final class AuthSignOutEvent extends AuthEvent {}