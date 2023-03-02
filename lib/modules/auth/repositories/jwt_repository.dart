import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:md_todo/shared/helpers/client_helper.dart';

class JWTService {

  Future<String?> _loadToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    
    return prefs.getString(dotenv.get('APP_TOKEN_KEY'));
  }

  Future<bool> _saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    
    return await prefs.setString(dotenv.get('APP_TOKEN_KEY'), token);
  }

  Future<bool> _removeToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    
    return await prefs.remove(dotenv.get('APP_TOKEN_KEY'));
  }

  Future<bool> isAuthenticated() async {
    final String? token = await _loadToken();

    if (token == null || token.isEmpty) {
      return false;
    }

    if (JwtDecoder.isExpired(token)) {
      return false;
    }
    
    return true;
  }

  Future<void> signIn(Map<String, dynamic> data) async {
    final Dio client = await ClientHelper.buildClient();
    
    try {
      final Response response = await client.post('/auth/sign-in', data: data);

      _saveToken(response.data['access_token']);
    } on Exception {
      rethrow;
    }
  }

  Future<void> signUp(Map<String, dynamic> data) async {
    final Dio client = await ClientHelper.buildClient();

    try {
      final Response response = await client.post('/auth/sign-up', data: data);

      _saveToken(response.data['access_token']); 
    } on Exception {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _removeToken();
  }
}