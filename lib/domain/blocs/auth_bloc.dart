import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:md_todo/domain/events/auth_event.dart';
import 'package:md_todo/domain/states/auth_state.dart';
import 'package:md_todo/domain/repositories/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;
  
  AuthBloc(this._repository) : super(AuthUnauthenticatedState()) {
    on<AuthIsAuthenticatedEvent>((event, emit) async {
      emit(AuthLoadingState());
      final bool authenticated = await _repository.isAuthenticated();

      if (!authenticated) {
        emit(AuthUnauthenticatedState());
      } else {
        emit(AuthAuthenticatedState(account: await _repository.me()));
      }
    });

    on<AuthSignInEvent>((event, emit) async {
      emit(AuthLoadingState());
      await _repository.signIn({
        'email': event.email,
        'password': event.password
      });
      emit(AuthAuthenticatedState(account: await _repository.me()));
    });

    on<AuthSignUpEvent>((event, emit) async {
      emit(AuthLoadingState());
      await _repository.signUp({
        'firstName': event.firstName,
        'lastName': event.lastName,
        'email': event.email,
        'password': event.password
      });
      emit(AuthAuthenticatedState(account: await _repository.me()));
    });

    on<AuthSignOutEvent>((event, emit) async {
      emit(AuthLoadingState());
      await _repository.signOut();
      emit(AuthUnauthenticatedState());
    });
  }
}