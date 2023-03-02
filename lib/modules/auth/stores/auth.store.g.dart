// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthStore on _AuthStore, Store {
  late final _$accountAtom = Atom(name: '_AuthStore.account', context: context);

  @override
  Account? get account {
    _$accountAtom.reportRead();
    return super.account;
  }

  @override
  set account(Account? value) {
    _$accountAtom.reportWrite(value, super.account, () {
      super.account = value;
    });
  }

  late final _$isAuthenticatedAsyncAction =
      AsyncAction('_AuthStore.isAuthenticated', context: context);

  @override
  Future<bool> isAuthenticated() {
    return _$isAuthenticatedAsyncAction.run(() => super.isAuthenticated());
  }

  late final _$meAsyncAction = AsyncAction('_AuthStore.me', context: context);

  @override
  Future<void> me() {
    return _$meAsyncAction.run(() => super.me());
  }

  late final _$signInAsyncAction =
      AsyncAction('_AuthStore.signIn', context: context);

  @override
  Future<void> signIn(Map<String, dynamic> data) {
    return _$signInAsyncAction.run(() => super.signIn(data));
  }

  late final _$signUpAsyncAction =
      AsyncAction('_AuthStore.signUp', context: context);

  @override
  Future<void> signUp(Map<String, dynamic> data) {
    return _$signUpAsyncAction.run(() => super.signUp(data));
  }

  late final _$signOutAsyncAction =
      AsyncAction('_AuthStore.signOut', context: context);

  @override
  Future<void> signOut() {
    return _$signOutAsyncAction.run(() => super.signOut());
  }

  @override
  String toString() {
    return '''
account: ${account}
    ''';
  }
}
