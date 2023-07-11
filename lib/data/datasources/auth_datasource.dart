import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:md_todo/data/adapters/account_adapter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:md_todo/data/datasources/client_datasource.dart';

import 'package:md_todo/domain/dtos/auth_sign_in_dto.dart';
import 'package:md_todo/domain/dtos/auth_sign_up_dto.dart';
import 'package:md_todo/domain/entities/account_entity.dart';

abstract interface class AuthDataSource {
  Future<bool> isAuthenticated();
  Future<void> signIn(AuthSignInDTO dto);
  Future<void> signUp(AuthSignUpDTO dto);
  Future<void> signOut();
  Future<Account> me();
}

final class AuthDataSourceImpl implements AuthDataSource {
  final ClientDataSource client;

  AuthDataSourceImpl(this.client);

  @override
  Future<bool> isAuthenticated() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString(dotenv.get('APP_TOKEN_KEY'));

    if (token == null || token.isEmpty) {
      return false;
    }

    if (JwtDecoder.isExpired(token)) {
      return false;
    }
    
    return true;
  }

  @override
  Future<void> signIn(AuthSignInDTO dto) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final Response response = await client.post('/auth/sign-in', dto.toRemote());

      await prefs.setString(
        dotenv.get('APP_TOKEN_KEY'), response.data['access_token']
      );
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<void> signUp(AuthSignUpDTO dto) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final Response response = await client.post('/auth/sign-up', dto.toRemote());

      await prefs.setString(
        dotenv.get('APP_TOKEN_KEY'), response.data['access_token']
      );
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    
    await prefs.remove(dotenv.get('APP_TOKEN_KEY'));
  }
  
  @override
  Future<Account> me() async {
    try {
      final Response response = await client.get('/me');

      return AccountAdapater.fromRestAPI(response.data);
    } on Exception {
      rethrow;
    }
  }
}