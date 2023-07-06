// flutter packages pub run build_runner watch --delete-conflicting-outputs
import 'package:mobx/mobx.dart';

import 'package:md_todo/domain/states/auth_state.dart';
import 'package:md_todo/domain/entities/account_entity.dart';
import 'package:md_todo/domain/repositories/auth_repository.dart';

part 'auth_store.g.dart';

abstract class _AuthStore with Store {
  final AuthRepository _repository;

  _AuthStore(this._repository);

  @observable
  AuthState state = AuthUnauthenticatedState();

  @action
  Future<void> isAuthenticated() async {
    final bool authenticated = await _repository.isAuthenticated();

    if (!authenticated) {
      state = AuthUnauthenticatedState();
    } else {
      final Account account = await _repository.me();
      state = AuthAuthenticatedState(account: account);
    }
  }

  @action
  Future<void> signIn(Map<String, dynamic> data) async {
    state = AuthLoadingState();
    await _repository.signIn(data);
    final Account account = await _repository.me();
    state = AuthAuthenticatedState(account: account);
  }

  @action
  Future<void> signUp(Map<String, dynamic> data) async {
    state = AuthLoadingState();
    await _repository.signUp(data);
    final Account account = await _repository.me();
    state = AuthAuthenticatedState(account: account);
  }
  
  @action
  Future<void> signOut() async {
    state = AuthLoadingState();
    await _repository.signOut();
    state = AuthUnauthenticatedState();
  }
}

class AuthStore = _AuthStore with _$AuthStore;