
import 'package:mobx/mobx.dart';

import 'package:md_todo/modules/auth/models/account.dart';

import 'package:md_todo/modules/auth/repositories/jwt_repository.dart';
import 'package:md_todo/modules/auth/repositories/account_repository.dart';

part 'auth.store.g.dart';

abstract class _AuthStore with Store {
  @observable
  Account? account;

  @action
  Future<bool> isAuthenticated() async {
    return await JWTService().isAuthenticated();
  }

  @action
  Future<void> me() async {
    try {
      account = await AccountRepository().me();
    } on Exception {
      rethrow;
    }
  }

  @action
  Future<void> signIn(Map<String, dynamic> data) async {
    try {
      await JWTService().signIn(data);
      await me();
    } on Exception {
      rethrow;
    }
  }

  @action
  Future<void> signUp(Map<String, dynamic> data) async {
    try {
      await JWTService().signUp(data);
      await me();
    } on Exception {
      rethrow;
    }
  }
  
  @action
  Future<void> signOut() async {
    try {
      await JWTService().signOut();
      account = null;
    } on Exception {
      rethrow;
    }
  }
}

class AuthStore = _AuthStore with _$AuthStore;