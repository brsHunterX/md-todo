import 'package:md_todo/data/datasources/auth_datasource.dart';
import 'package:md_todo/domain/entities/account_entity.dart';

abstract class AuthRepository {
  Future<bool> isAuthenticated();
  Future<void> signIn(Map<String, dynamic> data);
  Future<void> signUp(Map<String, dynamic> data);
  Future<void> signOut();
  Future<Account> me();
}

class AuthRepositoryImpl implements AuthRepository {

  final AuthDataSource _datasource;

  AuthRepositoryImpl(this._datasource);

  @override
  Future<bool> isAuthenticated() async {
    try {
      return await _datasource.isAuthenticated();
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<void> signIn(Map<String, dynamic> data) async {
    try {
      return await _datasource.signIn(data);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<void> signUp(Map<String, dynamic> data) async {
    try {
      return await _datasource.signUp(data);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      return await _datasource.signOut();
    } on Exception {
      rethrow;
    }
  }
  
  @override
  Future<Account> me() async {
    try {
      return await _datasource.me();
    } on Exception {
      rethrow;
    }
  }
}