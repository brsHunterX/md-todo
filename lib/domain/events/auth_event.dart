sealed class AuthEvent {}

final class AuthLoadingEvent extends AuthEvent {}

final class AuthIsAuthenticatedEvent extends AuthEvent {}

final class AuthSignInEvent extends AuthEvent {
  final String email;
  final String password;

  AuthSignInEvent({
    required this.email,
    required this.password
  });
}

final class AuthSignUpEvent extends AuthEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  AuthSignUpEvent({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password
  });
}

final class AuthSignOutEvent extends AuthEvent {}