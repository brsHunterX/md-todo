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
      const String failureMsg = 'Unable to sign in. Please check your email and password and try again.';

      try {  
        emit(AuthLoadingState());
        await _repository.signIn(event.dto);
        emit(AuthAuthenticatedState(account: await _repository.me()));
      } on Exception catch (e) {
        emit(AuthSignInFailureState(message: failureMsg));
        emit(AuthUnauthenticatedState());
      }
    });

    on<AuthSignUpEvent>((event, emit) async {
      const String failureMsg = 'Failure to create your account. Please try again.';
      
      try {  
        emit(AuthLoadingState());
        await _repository.signUp(event.dto);
        emit(AuthAuthenticatedState(account: await _repository.me()));
      } on Exception catch (e) {
        emit(AuthSignUpFailureState(message: failureMsg));
        emit(AuthUnauthenticatedState());
      }
    });

    on<AuthSignOutEvent>((event, emit) async {
      emit(AuthLoadingState());
      await _repository.signOut();
      emit(AuthUnauthenticatedState());
    });

    add(AuthIsAuthenticatedEvent());
  }
}