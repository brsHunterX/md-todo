import 'package:md_todo/domain/dtos/auth_sign_in_dto.dart';
import 'package:md_todo/domain/dtos/auth_sign_up_dto.dart';

sealed class AuthEvent {}

final class AuthLoadingEvent extends AuthEvent {}

final class AuthIsAuthenticatedEvent extends AuthEvent {}

final class AuthSignInEvent extends AuthEvent {
  final AuthSignInDTO dto;

  AuthSignInEvent({ required this.dto });
}

final class AuthSignUpEvent extends AuthEvent {
  final AuthSignUpDTO dto;

  AuthSignUpEvent({ required this.dto });
}

final class AuthSignOutEvent extends AuthEvent {}